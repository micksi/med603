using UnityEngine;
using System.Collections;
using System;
using System.IO;
using TestFramework;
using ThresholdFinding;

// TODO Maybe instruct user on the visual feedback?

// TODO Test on groupmates
// TODO Pilot test on passerby

public class ExperimentConductor : MonoBehaviour {

	public string experimentName;
	public Shader csfUser; // Must have _CSF and _MainTex texture properties
	public FocusProvider.Source focusSource;
	public bool debugToggleEffectOnV = false;
	public bool debugShowHalfvalueCSF = false;
	public bool debugDrawCSFOnly = false;

	private Experiment experiment;
	private ThresholdFinderComponent thresholdFinderComponent;
	private TestFramework.TestFramework testFramework;
	private CSF csfGenerator;
	private WantedFocusIndicator wantedFocusIndicator;

	private enum State { SendToDemographics, SendToCalibration, ShowIntro, RunningTrials, PausingBetweenTrials, EndTrials };
	private State state = State.SendToDemographics;//ShowIntro; //SendToCalibration;//SendToDemographics;
	private enum IntroState { ShowingTrue, ShowingFalse, ShowingExplanation, ShowingMarker };
	private IntroState introState = IntroState.ShowingTrue;
	
	private const double flashTimeSeconds = 0.7;
	private const double flashTimeBetweenTrialsSeconds = 15; // TODO Argue for 15 seconds break
	private double flashTimeLeft = 0.0;
	private bool isFlashingScreen = false;
	private string flashMessage = "";

	private Texture2D whiteTex = null;
	private Texture2D blackTex = null;
	private GazeLogger gazeLogger = null;

	private string trueButtonDescription = "green"; // A description of how the 'true' button appears to the user.
	private string falseButtonDescription = "red";

	private Rect messageRect;

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

	private Material _showRequiredAttentionSpot = null;
	private Material showRequiredAttentionSpot
	{
		get 
		{
			if(_showRequiredAttentionSpot == null)
			{
				_showRequiredAttentionSpot = new Material(Shader.Find("Custom/DrawFocus"));
			}
			return _showRequiredAttentionSpot;
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

		// Set up GUI Rect
		messageRect = new Rect( Screen.width / 3, Screen.height / 3, Screen.width / 3, Screen.height / 3);

		// Set up listeners
		thresholdFinderComponent = GetComponent<ThresholdFinderComponent>();
		thresholdFinderComponent.ReportObservationEvent += OnReportObservationEvent;
		thresholdFinderComponent.Finder.FinishedEvent += OnFinishedThresholdFindingEvent;
		thresholdFinderComponent.Finder.FinishedTrial += OnFinishedTrialEvent;

		testFramework = GetComponent<TestFramework.TestFramework>();

		experiment = new Experiment(experimentName, testFramework, thresholdFinderComponent);
		experiment.Begin();		

		gazeLogger = new GazeLogger(experiment, thresholdFinderComponent.Finder, 0.1); // TODO decide logging frequency
		gazeLogger.ReferenceLocation = FocusProvider.GetScreenCentre();

		wantedFocusIndicator = GetComponent<WantedFocusIndicator>();
		wantedFocusIndicator.enabled = false;

		csfGenerator = GetComponent<CSF>();
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
				if(isFlashingScreen == false) // Only accept input when no flashing is taking place
				{
					SendInputToTFC();
				}
				break;
			case State.ShowIntro:
				HandleIntroInput();
				break;
			case State.PausingBetweenTrials:
				flashMessage = String.Format("Rest your eyes a bit.\r\n"
					+ "{0} seconds till next trial.\r\n"
					+ "You are {1} percent through.\r\n"
					+ "Please look at the marker when the next trial starts.", 
					((int)flashTimeLeft + 1),
					(thresholdFinderComponent.Finder.GetProgress() * 100.0).ToString("F1"));


				/*"Rest your eyes a bit.\r\n"
					+ ((int)flashTimeLeft + 1) + " seconds till next trial.\r\n"
					+ "You are " + (thresholdFinderComponent.Finder.GetProgress
					+ "Please look at the marker when the next trial starts.";
				*/break;
		}

		CheckDebugInput();
		gazeLogger.Update();
	}

	private void CheckDebugInput()
	{

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

		// Consider whether effect should be full-on or -off regardless of CSF
		if(state == State.ShowIntro)
		{	
			if(introState == IntroState.ShowingFalse) 
			{
				material.SetTexture("_CSF", blackTex);
			}
			else // Show true state by default
			{
				material.SetTexture("_CSF", whiteTex);
			}
		}
		else if (state != State.RunningTrials)
		{
			// Show true state by default, unless experiment is really running
			material.SetTexture("_CSF", whiteTex);
		}

		// Debugging purposes - not to be used by testers
		if(Input.GetKey(KeyCode.Alpha0))
		{
			// Use gaze for CSF
			FocusProvider.source = FocusProvider.Source.Gaze;
			csfGenerator.GetContrastSensitivityMap(source, csf);
			material.SetTexture("_CSF", csf);
		}	
		else if(Input.GetKey(KeyCode.Alpha1))
		{
			// Use white CSF
			material.SetTexture("_CSF", whiteTex);
		}
		else if(Input.GetKey(KeyCode.Alpha2))
		{
			// Use black CSF
			material.SetTexture("_CSF", blackTex);
		}

		// Draw effect
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
			case State.PausingBetweenTrials:
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
						+ " button."
						+ " For now, press the " + trueButtonDescription + " button to go on.");
				break;
			case IntroState.ShowingFalse:
				GUI.Label(messageRect, "This is how the screen should NOT appear to you."
						+ " When it looks like this during the test, press the " + falseButtonDescription 
						+ " button."
						+ " For now, press the " + trueButtonDescription + " button to go on,"
						+ " or the " + falseButtonDescription + " button to go back.");
				break;
			case IntroState.ShowingExplanation:
				GUI.Label(messageRect, 
					"In the following few minutes, you must use the " + trueButtonDescription + " and " 
					+ falseButtonDescription + " buttons to indicate whether the screen looks like it should " 
					+ "or not, respectively. Feel free to take the time you need.\n"
					+ "Note that you must look at the marker in the centre of the screen, not anywhere else."
					+ " The marker is shown on the next screen.\n"
					+ "The screen will blink for a short duration when you have pressed one of the buttons."
					+ "\nPress the " + trueButtonDescription + " button to see the marker, or the "
					+ falseButtonDescription + " button to go back."
				);
				break;
			case IntroState.ShowingMarker:
				GUI.Label(messageRect, 
					"This is the marker, indicating where you must look during the test. Please stick to it!"
					+ "\nIt will turn green when you respond that the scene looks like it should, and"
					+ " red when you respond that the scene doesn't look like it should."
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
					introState = IntroState.ShowingMarker;
					wantedFocusIndicator.enabled = true;
				}
				if(Input.GetKeyDown(thresholdFinderComponent.negativeKey))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
			case IntroState.ShowingMarker:
				if(Input.GetKeyDown(thresholdFinderComponent.positiveKey))
				{
					StartTrials();
				}
				if(Input.GetKeyDown(thresholdFinderComponent.negativeKey))
				{
					introState = IntroState.ShowingExplanation;
					wantedFocusIndicator.enabled = false;
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
		StartScreenFlash(""); // Do not write anything; it is disturbing and keeps the user from the spot they're supposed to look at.

		state = State.RunningTrials;
		gazeLogger.UpdatePath();
		gazeLogger.Begin();
		wantedFocusIndicator.enabled = true;
	}

	private void OnEndScreenFlash()
	{
		isFlashingScreen = false;
		if(state != State.EndTrials)
			state = State.RunningTrials;
		gazeLogger.Begin();
		wantedFocusIndicator.SetNormal();
	}

	private void OnReportObservationEvent(object source, ReportObservationEventArgs args)
	{
		// Pause gaze logging
		gazeLogger.Pause();

		// Set marker colour
		if(args.Observation)
		{
			wantedFocusIndicator.SetPositive();
		}
		else
		{
			wantedFocusIndicator.SetNegative();
		}	

		// Flash screen	
		StartScreenFlash(""); 
	}

	private void OnFinishedThresholdFindingEvent(object source, FinishedEventArgs args)
	{
		gazeLogger.Pause(); // Just to be sure.
		wantedFocusIndicator.enabled = false;
		state = State.EndTrials;
	}

	private void OnFinishedTrialEvent(object source, FinishedTrialArgs args)
	{
		gazeLogger.Pause();
		state = State.PausingBetweenTrials;
		StartScreenFlash("TRIAL ENDED", flashTimeBetweenTrialsSeconds);
	}

	private void StartScreenFlash(string displayText, double duration = flashTimeSeconds)
	{
		flashTimeLeft = duration;
		flashMessage = displayText;
		isFlashingScreen = true;
	}
}
