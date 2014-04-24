using UnityEngine;
using System.Collections;
using TestFramework;
using ThresholdFinding;

// TODO Make sure it works with gaze tracking.
// TODO Test on groupmates
// TODO Pilot test on passerby

public class ExperimentConductor : MonoBehaviour {

	public string experimentName;
	public ThresholdFinderComponent thresholdFinder;
	public TestFramework.TestFramework testFramework;
	public CSF csfGenerator;
	public Shader csfUser; // Must have _CSF and _MainTex texture properties
	public FocusProvider.Source focusSource;
	public bool debugToggleEffectOnV = false;
	public bool debugShowHalfvalueCSF = false;
	public bool debugDrawCSFOnly = false;

	private Experiment experiment;

	private enum State { SendToDemographics, SendToCalibration, ShowIntro, StartTrials, EndTrials };
	private State state = State.SendToDemographics;
	private enum IntroState { ShowingTrue, ShowingFalse, ShowingExplanation };
	private IntroState introState = IntroState.ShowingTrue;
	
	private const int flashTime = 30; // Frames
	private int flashTimeLeft = 0; // 
	private string flashMessage = "";

	private string trueButtonDescription = "green"; // A description of how the 'true' button appears to the user.
	private string falseButtonDescription = "red";

	private Rect messageRect, rightButtonRect, leftButtonRect;

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

	private Material _showHalfCSF = null;
	private Material showHalfCSF
	{
		get 
		{
			if(_showHalfCSF == null)
			{
				_showHalfCSF = new Material(Shader.Find("Custom/DrawCircle"));
			}
			return _showHalfCSF;
		}
	}

	Texture2D whiteTex = null;
	Texture2D blackTex = null;
	//Texture2D flashScreenTexture = null;

	void Start()
	{
		whiteTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);
 		blackTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);
 		//flashScreenTexture = new Texture2D(1, 1, TextureFormat.ARGB32, false);

		// set the pixel values
		whiteTex.SetPixel(0, 0, Color.white);
		blackTex.SetPixel(0, 0, Color.black);
		//flashScreenTexture.SetPixel(0, 0,Color.black);// new Color(0.275f, 0.235f, 0.157f, 1f)); // Average of all scene pixels :)
 
		// Apply all SetPixel calls
		whiteTex.Apply();
		blackTex.Apply();
		//flashScreenTexture.Apply();

		// Set up GUI Rects
		int buffer = 10;
		messageRect = new Rect( Screen.width / 3, Screen.height / 3, Screen.width / 3, Screen.height / 3);
		leftButtonRect  = new Rect( Screen.width / 3, 5 * Screen.height / 6 + buffer, Screen.width / 6 - buffer/2, Screen.height / 6 );
		rightButtonRect = new Rect( Screen.width / 2 + buffer / 2, 5 * Screen.height / 6 + buffer, Screen.width / 6 - buffer/2, Screen.height / 6 );

		// 
		thresholdFinder.ReportObservationEvent += OnReportObservationEvent;
		thresholdFinder.Finder.FinishedEvent += OnFinishedThresholdFindingEvent;
			/*(object sender, ReportObservationEventArgs args) =>
			{
				flashTimeLeft = flashTime;
			};*/

		experiment = new Experiment(experimentName, testFramework, thresholdFinder);
		experiment.Begin();		
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		if(flashTimeLeft > 0)
		{
			flashTimeLeft--;
			Graphics.Blit(blackTex, dest);
			return;
		}

		// TODO Decide: Should end show black, white, or normal, or affected?

		// Update FocusProvider to use the latest source
		FocusProvider.source = focusSource;

		// Obtain CSF map and send it to material
		csfGenerator.halfResolutionEccentricity = (float)thresholdFinder.Stimulus;
		RenderTexture csf = RenderTexture.GetTemporary(source.width, source.height);
		csfGenerator.GetContrastSensitivityMap(source, csf);
		material.SetTexture("_CSF", csf);

		if(state == State.ShowIntro)
		{	
			if(introState == IntroState.ShowingFalse) 
			{
				material.SetTexture("_CSF", blackTex);
			}
			else // Show true state by default  //if(introState == IntroState.ShowingTrue)
			{
				material.SetTexture("_CSF", whiteTex);
			}
		}
		else if (state != State.StartTrials)
		{
			// Show true state by default unless experiment is really running
			material.SetTexture("_CSF", whiteTex);
		}
		/*if(debugToggleEffectOnV)
		{	
			if(Input.GetKey("v"))
			{
				material.SetTexture("_CSF", whiteTex);
				print("AA on");
			}
			else //if(Input.GetKey("b"))
			{
				material.SetTexture("_CSF", blackTex);
				print("AA off");
			}
			Graphics.Blit(source, dest, material);
		}
		else if(debugShowHalfvalueCSF)
		{
			RenderTexture temp = RenderTexture.GetTemporary(source.width, source.height);
			showHalfCSF.SetTexture("_CSF", csf);
			showHalfCSF.SetFloat("_Threshold", 0.5f);
			Graphics.Blit(source, temp, material);
			Graphics.Blit(temp, dest, showHalfCSF);
			RenderTexture.ReleaseTemporary(temp);
		}
		else if(debugDrawCSFOnly)
		{
			Graphics.Blit(csf, dest);
		}
		else
		{*/
			// Apply effect according to CSF
			
		//}
		
		Graphics.Blit(source, dest, material);

		// Clean up
		RenderTexture.ReleaseTemporary(csf);
	}

	void OnGUI()
	{
		if(flashTimeLeft > 0)
		{
			GUI.Label(messageRect, flashMessage);
			return;
		}

		switch(state)
		{
			case State.SendToDemographics:
				if(GUI.Button(messageRect, "Click here to start with a questionnaire!"))
				{
					state = State.SendToCalibration;
					uint participantNumber = experiment.ActiveParticipant.Id; // TODO get proper participant number
					Application.OpenURL("https://docs.google.com/forms/d/1-5mbG7bUA0DbApVJEbzrx8IDEuFlJvgUA4pccmDkvy4/viewform?entry.1375030606=" + participantNumber);
				}
				break;
			case State.SendToCalibration:
				if(GUI.Button(messageRect, "Click here when the gaze tracker has been calibrated to 5/5!"))
				{
					state = State.ShowIntro;
				}
				break;
			case State.ShowIntro:
				HandleIntro();
				break;
			case State.StartTrials:
				break;
			case State.EndTrials:
				GUI.Label(messageRect, "Thank you for your participation! You may now approach the test conductor for a short interview.");
				break;
		}
	}

	private void HandleIntro()
	{
		switch(introState)
		{
			case IntroState.ShowingTrue:
				GUI.Label(messageRect, "This is how the screen should appear to you."
						+ " When it looks like this, press the " + trueButtonDescription + " button.");
			
				if(GUI.Button(rightButtonRect, "Click here to move on."))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
			case IntroState.ShowingFalse:
				GUI.Label(messageRect, "This is how the screen should NOT appear to you."
						+ " When it looks like this, press the " + falseButtonDescription + " button.");
			
				if(GUI.Button(rightButtonRect, "Click here to move on."))
				{
					introState = IntroState.ShowingExplanation;
				}
				if(GUI.Button(leftButtonRect, "Click here to go back."))
				{
					introState = IntroState.ShowingTrue;
				}
				break;
			case IntroState.ShowingExplanation:
				GUI.Label(messageRect, 
					"In the following few minutes, you must use the " + trueButtonDescription + " and " 
					+ falseButtonDescription + " buttons to indicate whether the screen looks like it should " 
					+ "or not, respectively. Feel free to take the time you need.\n"
					+ "The screen will blink for a short duration when you have pressed one of the buttons."
				);

				if(GUI.Button(rightButtonRect, "Click here to start the test!"))
				{
					state = State.StartTrials;
					StartScreenFlash("Starting experiment...", 60);
				}
				if(GUI.Button(leftButtonRect, "Click here to go back."))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
		}
	}

	private void OnReportObservationEvent(object source, ReportObservationEventArgs args)
	{
		// Flash screen
		StartScreenFlash("You reported " + args.Observation);
	}

	private void OnFinishedThresholdFindingEvent(object source, FinishedEventArgs args)
	{
		print("ExperimentConductor.OnFinishedThresholdFindingEvent: Finished finding a threshold.");
		state = State.EndTrials;
	}

	private void StartScreenFlash(string displayText, int noOfFrames = flashTime)
	{
		flashTimeLeft = noOfFrames;
		flashMessage = displayText;
	}
}
