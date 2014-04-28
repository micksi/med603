using UnityEngine;
using System.Collections;
using System;
using System.IO;
using TestFramework;
using ThresholdFinding;

// TODO provide gazelogger with a participant-dependent folder path (in StartTrials())
// TODO Mark wanted user gaze position
// TODO Save gaze data per trial
// TODO decide logging frequency

// TODO Test on groupmates
// TODO Pilot test on passerby

/*
 * NOTE
 * By trying really hard to not log gaze data while screen is flashing,
 * the code has become quite opaque. Sorry about that.
 * Please do ask if something is not making sense!
 * TW
 */

public class ExperimentConductor : MonoBehaviour {

	public string experimentName;
	public ThresholdFinderComponent thresholdFinderComponent;
	public TestFramework.TestFramework testFramework;
	public CSF csfGenerator;
	public Shader csfUser; // Must have _CSF and _MainTex texture properties
	public FocusProvider.Source focusSource;
	public bool debugToggleEffectOnV = false;
	public bool debugShowHalfvalueCSF = false;
	public bool debugDrawCSFOnly = false;

	private Experiment experiment;

	private enum State { SendToDemographics, SendToCalibration, ShowIntro, RunningTrials, EndTrials };
	private State state = State.ShowIntro;//SendToDemographics;
	private enum IntroState { ShowingTrue, ShowingFalse, ShowingExplanation };
	private IntroState introState = IntroState.ShowingTrue;
	
	private const double flashTimeSeconds = 0.7;
	private double flashTimeLeft = 0.0;
	private bool isFlashingScreen = false;
	private string flashMessage = "";

	private Texture2D whiteTex = null;
	private Texture2D blackTex = null;
	private GazeLogger gazeLogger = null;

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

	void Start()
	{
		whiteTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);
 		blackTex = new Texture2D(1, 1, TextureFormat.ARGB32, false);

		// set the pixel values
		whiteTex.SetPixel(0, 0, Color.white);
		blackTex.SetPixel(0, 0, Color.black);
 
		// Apply all SetPixel calls
		whiteTex.Apply();
		blackTex.Apply();

		// Set up GUI Rects
		int buffer = 10;
		messageRect = new Rect( Screen.width / 3, Screen.height / 3, Screen.width / 3, Screen.height / 3);
		leftButtonRect  = new Rect( Screen.width / 3, 5 * Screen.height / 6 + buffer, Screen.width / 6 - buffer/2, Screen.height / 6 );
		rightButtonRect = new Rect( Screen.width / 2 + buffer / 2, 5 * Screen.height / 6 + buffer, Screen.width / 6 - buffer/2, Screen.height / 6 );

		thresholdFinderComponent.ReportObservationEvent += OnReportObservationEvent;
		thresholdFinderComponent.Finder.FinishedEvent += OnFinishedThresholdFindingEvent;
		thresholdFinderComponent.Finder.FinishedTrial += OnFinishedTrialEvent;

		experiment = new Experiment(experimentName, testFramework, thresholdFinderComponent);
		experiment.Begin();		

		gazeLogger = new GazeLogger(experiment, thresholdFinderComponent.Finder, 0.1); // TODO decide logging frequency
	}

	void Update()
	{
		if(isFlashingScreen)
		{
			flashTimeLeft -= Time.deltaTime;
			if(flashTimeLeft < 0.0)
			{
				OnEndScreenFlash();
			}
		}	

		switch(state)
		{
			case State.RunningTrials:
				if(flashTimeLeft <= 0.0) // Only accept input when no flashing is taking place
					SendInputToTFC();
				break;
			case State.ShowIntro:
				HandleIntroInput();
				break;
		}

		gazeLogger.Update();
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		if(isFlashingScreen)
		{
			Graphics.Blit(blackTex, dest);
			return;
		}

		// Update FocusProvider to use the latest source
		FocusProvider.source = focusSource;

		// Obtain CSF map and send it to material
		csfGenerator.halfResolutionEccentricity = (float)thresholdFinderComponent.Stimulus;
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
		else if (state != State.RunningTrials)
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
		if(isFlashingScreen)
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
					uint participantNumber = experiment.ActiveParticipant.Id;
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
				HandleIntroGUI();
				break;
			case State.RunningTrials:
				break;
			case State.EndTrials:
				GUI.Label(messageRect, "Thank you for your participation! You may now approach the test conductor for a short interview.");
				break;
		}
	}

	private void HandleIntroGUI()
	{
		switch(introState)
		{
			case IntroState.ShowingTrue:
				GUI.Label(messageRect, "This is how the screen should appear to you."
						+ " When it looks like this during the test, press the " + trueButtonDescription 
						+ " button. For now, press the " + trueButtonDescription + " button to go on.");
				break;
			case IntroState.ShowingFalse:
				GUI.Label(messageRect, "This is how the screen should NOT appear to you."
						+ " When it looks like this during the test, press the " + falseButtonDescription 
						+ " button. For now, press the " + trueButtonDescription + " button to go on,"
						+ " or the " + falseButtonDescription + " button to go back.");
				break;
			case IntroState.ShowingExplanation:
				GUI.Label(messageRect, 
					"In the following few minutes, you must use the " + trueButtonDescription + " and " 
					+ falseButtonDescription + " buttons to indicate whether the screen looks like it should " 
					+ "or not, respectively. Feel free to take the time you need.\n"
					+ "The screen will blink for a short duration when you have pressed one of the buttons."
					+ "\nPress the " + trueButtonDescription + " button to start the test, or the "
					+ falseButtonDescription + " button to go back."
				);
				break;
		}
	}

	private void HandleIntroInput()
	{
		switch(introState)
		{
			case IntroState.ShowingTrue:
				if(Input.GetKeyDown(thresholdFinderComponent.positiveKey))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
			case IntroState.ShowingFalse:
				if(Input.GetKeyDown(thresholdFinderComponent.positiveKey))
				{
					introState = IntroState.ShowingExplanation;
				}
				if(Input.GetKeyDown(thresholdFinderComponent.negativeKey))
				{
					introState = IntroState.ShowingTrue;
				}
				break;
			case IntroState.ShowingExplanation:
				if(Input.GetKeyDown(thresholdFinderComponent.positiveKey))
				{
					StartTrials();
				}
				if(Input.GetKeyDown(thresholdFinderComponent.negativeKey))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
		}
	}

	private void SendInputToTFC()
	{
		if(Input.GetKeyDown(thresholdFinderComponent.positiveKey))
		{
			thresholdFinderComponent.AddObservation(true);
		}
		else if(Input.GetKeyDown(thresholdFinderComponent.negativeKey))
		{
			thresholdFinderComponent.AddObservation(false);
		}
	}

	private void StartTrials()
	{
		StartScreenFlash("Starting experiment...", 3);
		state = State.RunningTrials;
		gazeLogger.UpdatePath();
		gazeLogger.Begin();
	}

	private void OnEndScreenFlash()
	{
		isFlashingScreen = false;
		gazeLogger.Begin();
	}

	private void OnReportObservationEvent(object source, ReportObservationEventArgs args)
	{
		// Pause gaze logging
		gazeLogger.Pause();

		// Flash screen	
		StartScreenFlash("You reported that what you saw looked " + (args.Observation ? "like it should." : "wrong."));
	}

	private void OnFinishedThresholdFindingEvent(object source, FinishedEventArgs args)
	{
		print("ExperimentConductor.OnFinishedThresholdFindingEvent: Finished finding a threshold.");
		gazeLogger.Pause(); // Just to be sure.
		state = State.EndTrials;
	}

	private void OnFinishedTrialEvent(object source, FinishedTrialArgs args)
	{
		
	}

	private void StartScreenFlash(string displayText, double noOfFrames = flashTimeSeconds)
	{
		flashTimeLeft = noOfFrames;
		flashMessage = displayText;
		isFlashingScreen = true;
	}
}
