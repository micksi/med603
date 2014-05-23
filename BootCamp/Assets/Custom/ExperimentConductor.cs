using UnityEngine;
using System.Collections;
using System;
using System.IO;
using TestFramework;
using ThresholdFinding;

public class ExperimentConductor : MonoBehaviour {

	ObjectiveController obScript;

	public GUISkin font;
	public Texture bs;

	// Main inspector elements
	public string experimentName;
	public Shader csfUser; // Must have _CSF and _MainTex texture properties
	public Shader antialiasingShader;
	public Shader pixelationShader;
	public float halfResolutionEccentricity = 26.32f;
	//public bool showCursor = true;

	private Experiment experiment;
	private ThresholdFinderComponent thresholdFinderComponent;
	private TestFramework.TestFramework testFramework;
	private CSF csfGenerator;
	private GazeLogger gazeLogger = null;

	// States
	public enum State { SendToCalibration, GameInstructions, ReadyForTesting, PlayingGame, EndTrials };
	public State state = State.SendToCalibration;

	private Rect messageRect;
	private Rect mouseRectLeft;
	private Rect mouseRectRight;
	private Rect boxRect;
	private int boxExtension;

	private Texture2D whiteTex = null;
	private Texture2D blackTex = null;

	private Material _material = null;
	private Material material
	{
		get 
		{
			if(_material == null)
			{
				_material = new Material(csfUser);
			}
			return _material;
		}
	}

	void Freeze()
	{
        obScript.Freeze();
	}
	
	void Unfreeze()
	{
        obScript.Unfreeze();
	}

	void Start()
	{  		
		boxExtension = Int32.Parse(ConfigReader.GetValueOf("boxExtension"));

		string mode = ConfigReader.GetValueOf("mode");

		Debug.Log("mode: " + mode);
		switch(mode)
		{
			case "pixelation":
				csfUser = pixelationShader;
				break;
			case "antialiasing":
				csfUser = antialiasingShader;
				break;
			default:
				throw new InvalidOperationException("Cannot understand 'mode' value in config file: " + mode);
		}
		experimentName += " " + mode;

		whiteTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);
 		blackTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);

		// set the pixel values
		whiteTex.SetPixel(0, 0, Color.white);
		blackTex.SetPixel(0, 0, Color.black);
 
		// Apply all SetPixel calls
		whiteTex.Apply();
		blackTex.Apply();

		// Set up GUI Rect
		messageRect = new Rect( Screen.width / 3, Screen.height / 3, Screen.width / 3, Screen.height / 3);
		mouseRectLeft = new Rect( Screen.width / 3, ((Screen.height / 3)*2)+boxExtension, Screen.width / 10, Screen.height / 10);
		mouseRectRight = new Rect( ((Screen.width / 3)*2)-(Screen.width / 10), ((Screen.height / 3)*2)+boxExtension, Screen.width / 10, Screen.height / 10);
		boxRect = new Rect( Screen.width / 3 - boxExtension, Screen.height / 3 - boxExtension, Screen.width / 3 + boxExtension*2, Screen.height / 3 + boxExtension*2);

		// Set up listeners
		thresholdFinderComponent = GetComponent<ThresholdFinderComponent>();

		testFramework = GetComponent<TestFramework.TestFramework>();

		experiment = new Experiment(experimentName, testFramework, thresholdFinderComponent);
		experiment.Begin();

		gazeLogger = new GazeLogger(this, experiment.ActiveParticipant.FolderPath);

		obScript = transform.parent.GetComponent<ObjectiveController>();
        obScript.enabled = false;
        obScript.logger = new SimpleLogger(Path.Combine(experiment.ActiveParticipant.FolderPath, "ActionLog.csv"));
        Freeze();

		csfGenerator = GetComponent<CSF>();
	}


	void Update()
	{
		//print ("State: " + state);
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		RenderTexture csf = null;

		switch(state)
		{
			case State.PlayingGame:
				// !! UNCOMMENT TO START PIXELATION !! //
				csfGenerator.halfResolutionEccentricity = halfResolutionEccentricity;
				csfGenerator.centre = FocusProvider.GetGazePosition();
				csf = RenderTexture.GetTemporary(source.width, source.height);
				csfGenerator.GetContrastSensitivityMap(source, csf);
				material.SetTexture("_CSF", csf);
				break;
			default:
				material.SetTexture("_CSF", whiteTex);
				break;
		}

		// Draw effect
		Graphics.Blit(source, dest, material); 

		// Clean up
		if(csf != null)
		{
			RenderTexture.ReleaseTemporary(csf);
		}
	}

	void OnGUI()
	{
		GUI.skin = font;
		font.label.fontSize = 24;
		font.button.fontSize = 24;

		switch(state)
		{
			case State.SendToCalibration:
				if(GUI.Button(messageRect, "Click here when the gaze tracker has been calibrated to 5/5!"))
				{
					state = State.GameInstructions;
				}
				break;
			case State.GameInstructions:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect,"Your mission in the game is to move to different checkpoints. " + 
			          "\nAt each checkpoint, you will be presented with information about the next checkpoint." +
			          "\nThe descriptions will both include text instructions and a visual representation of the path you must follow.");
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					state = State.SendToCalibration;
				}
				if(GUI.Button(mouseRectRight,"Next"))
				{
					state = State.ReadyForTesting;
				}
				break;

			case State.ReadyForTesting:
				GUI.DrawTexture(new Rect(0,0,Screen.width, Screen.height),bs);
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect ,"Please keep your eyes on the screen. \nWhen you are ready, press the \"START\" button to start the game \n\nEnjoy!");
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					state = State.GameInstructions;
				}
				if(GUI.Button(mouseRectRight,"START"))
				{
					gazeLogger.Begin();
					state = State.PlayingGame;
					Unfreeze();
				}
				break;

			case State.PlayingGame:
				if(obScript.enabled == false)
				{
					obScript.enabled = true;
				}
				break;
			
			case State.EndTrials:
				GUI.DrawTexture(new Rect(0,0,Screen.width, Screen.height),bs);
				GUI.Box(boxRect, " ");
				if(GUI.Button(messageRect, "No more objectives!\n Thank you for participating.\n\nPlease click here to start the questionnaire!"))
				{
					state = State.SendToCalibration;
					uint participantNumber = experiment.ActiveParticipant.Id;
					Application.OpenURL("https://docs.google.com/forms/d/1Mg9WF5vQzBSCZIw4ooT1K5NcNmyO6SHNcmgIZUI_pF4/viewform?entry.1204578343=" + participantNumber);
				}
                obScript.Freeze();
				break;
		}
	}

	void OnApplicationQuit()
	{
        
		gazeLogger.Pause();
	}
}
