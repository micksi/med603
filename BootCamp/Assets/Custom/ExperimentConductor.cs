﻿using UnityEngine;
using System.Collections;
using System;
using System.IO;
using TestFramework;
using ThresholdFinding;

// TODO Test on groupmates
// TODO Pilot test on passerby

public class ExperimentConductor : MonoBehaviour {

	// Main inspector elements
	public string experimentName;
	public Shader csfUser; // Must have _CSF and _MainTex texture properties
	public Shader antialiasingShader;
	public Shader pixelationShader;
	public bool debugToggleEffectOnV = false;
	public bool debugShowHalfvalueCSF = false;
	public bool debugDrawCSFOnly = false;

	private Experiment experiment;
	private ThresholdFinderComponent thresholdFinderComponent;
	private TestFramework.TestFramework testFramework;
	private CSF csfGenerator;
	private WantedFocusIndicator wantedFocusIndicator;
	private Vector2 wantedFocusPosition;
	private GazeLogger gazeLogger = null;

	// States
	private enum State { SendToDemographics, SendToFilm, SendToCalibration, ShowIntro, GatheringObservations, EndTrials };
	private enum IntroState { ShowingTrue, ShowingFalse, ShowingCSF, ShowingExplanation, ShowingMarker };
	private enum ObservationState { Flashing, UserObserving, AwaitingAnswer, Resting };
	private State state = State.SendToDemographics;
	private IntroState introState = IntroState.ShowingTrue;
	private ObservationState observationState = ObservationState.Flashing;

	// Flash properties
	private double flashDuration;
	private double flashDurationForRests;
	private double flashTimeLeft = 0.0;

	// WantedFocusIndicator properties
	private float wantedFocusIndicatorLerpDuration;
	private float wantedFocusIndicatorColourFeedbackDuration;

	// Observation properties
	private double userObservationDuration;
	private double userObservationTimeLeft = 0.0; // Seconds
	private string restMessage = "";

	private float demonstrationHalfEccentricity;
	private float demonstrationJitterStrength;

	// GUI texts
	private string guiTextAwaitingAnswer;
	private string guiTextShowingTrue;
	private string guiTextShowingFalse;
	private string guiTextShowingCSF;
	private string guiTextShowingExplanation;
	private int guiFontSize;

	// Button descriptions
	private string trueButtonDescription; // A description of how the 'true' button appears to the user.
	private string falseButtonDescription;
	private string trueButtonWithColour;
	private string falseButtonWithColour;

	// GUI layout
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

	private Vector2 _demoPositionNormalized;
	private Vector2 demoPosition
	{
		get
		{
			Vector2 screenSize = FocusProvider.GetScreenResolution();
			return new Vector2(_demoPositionNormalized.x * screenSize.x, _demoPositionNormalized.y * screenSize.y);
		}

		set
		{
			_demoPositionNormalized = value;
		}
	}

	void Start()
	{
		flashDuration = Double.Parse(ConfigReader.GetValueOf("flashDuration"));
		flashDurationForRests = Double.Parse(ConfigReader.GetValueOf("flashDurationForRests"));
		wantedFocusIndicatorLerpDuration = 
			Single.Parse(ConfigReader.GetValueOf("wantedFocusIndicatorLerpDuration"));
		wantedFocusIndicatorColourFeedbackDuration = 
			Single.Parse(ConfigReader.GetValueOf("wantedFocusIndicatorColourFeedbackDuration"));
		userObservationDuration = Double.Parse(ConfigReader.GetValueOf("userObservationDuration"));
		boxExtension = Int32.Parse(ConfigReader.GetValueOf("boxExtension"));

		trueButtonDescription = ConfigReader.GetValueOf("trueButtonDescription");
		falseButtonDescription = ConfigReader.GetValueOf("falseButtonDescription");
		trueButtonWithColour =  "<color=" + trueButtonDescription + ">" + trueButtonDescription + "</color>";
 		falseButtonWithColour =  "<color=" + falseButtonDescription + ">" + falseButtonDescription + "</color>";

 		guiFontSize = Int32.Parse(ConfigReader.GetValueOf("fontSize"));

 		demonstrationHalfEccentricity = Single.Parse(ConfigReader.GetValueOf("demonstrationHalfEccentricity"));
		float demonstrationNormalizedX = Single.Parse(ConfigReader.GetValueOf("demonstrationNormalizedX"));
		float demonstrationNormalizedY = Single.Parse(ConfigReader.GetValueOf("demonstrationNormalizedY"));
		demoPosition = new Vector2(demonstrationNormalizedX, demonstrationNormalizedY);
		demonstrationJitterStrength = Single.Parse(ConfigReader.GetValueOf("demonstrationJitterStrength"));

		string mode = ConfigReader.GetValueOf("mode");
		string on = "ON";
		string off = "OFF";
		bool flip = false;
		Debug.Log("mode: " + mode);
		switch(mode)
		{
			case "pixelation":
				csfUser = pixelationShader;
				flip = true;
				break;
			case "antialiasing":
				csfUser = antialiasingShader;
				flip = false;
				break;
			default:
				throw new InvalidOperationException("Cannot understand 'mode' value in config file: " + mode);
		}
		experimentName += " " + mode;
		guiTextAwaitingAnswer =
			"Please press the " 
			+ (flip ? falseButtonWithColour : trueButtonWithColour)
			+ " keyboard button if it looked like " + mode + ", or the " 
			+ (flip ? trueButtonWithColour : falseButtonWithColour)
			+ " keyboard button if it did not.\r\n"
			+ "Take care to keep your eyes on the marker.";
		guiTextShowingTrue =
			"This is an example with " + mode + " turned " +  (flip ? off : on) 
			+ ".\n"
			+ "When you think the picture looks like this during the test, press the " 
			+ trueButtonWithColour + " keyboard button.";
		guiTextShowingFalse =
			"This is an extreme example with " + mode + " turned " +  (flip ? on : off) 
			+ ".\n"
			+ "When you think the picture looks like this during the test, press the " 
			+ falseButtonWithColour + " keyboard button.";
		guiTextShowingCSF =
			"This is an example with " + mode + " applied to the picture as it"
			+ " may be during the test.\n"
			+ "You will be looking at the centre of the effect, marked by the"
			+ " crosshair.\n"
			+ "If you perceive any pixelation at all during the test, press the " // Yes, I know, I hardcoded it. Damn. -TB 
			+ falseButtonWithColour + " keyboard button.";
		guiTextShowingExplanation =
			"You will be shown the picture for " + userObservationDuration
			+ " seconds at a time, followed by a dark screen."
			+ " Once the screen is dark, use the " 
			+ (flip ? falseButtonWithColour : trueButtonWithColour)
			+ " and " 
			+ (flip ? trueButtonWithColour : falseButtonWithColour)
			+ " keyboard buttons to indicate whether the screen was"
			+ " subject to " + mode + " or not.";


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
		thresholdFinderComponent.ReportObservationEvent += OnReportObservationEvent;
		thresholdFinderComponent.Finder.FinishedEvent += OnFinishedThresholdFindingEvent;
		thresholdFinderComponent.Finder.FinishedTrialEvent += OnFinishedTrialEvent;

		testFramework = GetComponent<TestFramework.TestFramework>();

		experiment = new Experiment(experimentName, testFramework, thresholdFinderComponent);
		experiment.Begin();

		gazeLogger = new GazeLogger(this, experiment, thresholdFinderComponent.Finder);
		gazeLogger.ReferenceLocation = FocusProvider.GetScreenCentre();

		wantedFocusIndicator = GetComponent<WantedFocusIndicator>();
		wantedFocusIndicator.enabled = false;
		wantedFocusIndicator.centre = FocusProvider.GetScreenCentre();

		csfGenerator = GetComponent<CSF>();
	}


	void Update()
	{

		switch(state)
		{
			case State.ShowIntro:
				//HandleIntroInput(); //This is old, used to hand key events when switching in intro sequence.
				break;
			case State.GatheringObservations:
				Screen.showCursor = false;
				switch(observationState)
				{
					case ObservationState.Flashing:
						flashTimeLeft -= Time.deltaTime;
						if(flashTimeLeft < 0.0)
						{
							observationState = ObservationState.UserObserving;
							OnScreenFlashEnd();
						}
						break;
					case ObservationState.UserObserving:
						if(userObservationTimeLeft > 0)
						{
							userObservationTimeLeft -= Time.deltaTime;
						}
						else
						{
							OnUserObservingEnd();
						}
						break;
					case ObservationState.Resting:
						if(flashTimeLeft > 0)
						{
							flashTimeLeft -= Time.deltaTime;
							restMessage = String.Format("Rest your eyes a bit.\r\n"
							+ "{0} seconds till next trial.\r\n"
							+ "You are {1} percent through.\r\n"
							+ "Please look at the marker when the next trial starts.", 
							((int)flashTimeLeft + 1),
							(thresholdFinderComponent.Finder.GetProgress() * 100.0).ToString("F1"));
						}
						else
						{
							StartUserObserving();
						}						
						break;
					case ObservationState.AwaitingAnswer:
						SendInputToTFC();
						break;
				}
				break;
		}

		CheckDebugInput();
	}

	private void CheckDebugInput()
	{
		if(Input.GetKeyDown(KeyCode.Alpha5))
		{
			wantedFocusIndicator.LerpTo(FocusProvider.GetMousePosition(), 2f);
		}
		else if(Input.GetKeyDown(KeyCode.Alpha6))
		{
			state = State.ShowIntro;
		}
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		RenderTexture csf = null;

		switch(state)
		{
			case State.GatheringObservations:
				switch(observationState)
				{
					case ObservationState.UserObserving:
						csfGenerator.halfResolutionEccentricity = (float)thresholdFinderComponent.Stimulus;
						csfGenerator.centre = wantedFocusPosition;
						csf = RenderTexture.GetTemporary(source.width, source.height);
						csfGenerator.GetContrastSensitivityMap(source, csf);
						material.SetTexture("_CSF", csf);
						break;
					default:
						Graphics.Blit(blackTex, dest); // Black screen for the other 3 states
						return;
				}
				break;
			case State.ShowIntro:
				switch(introState)
				{
					case IntroState.ShowingFalse:
						material.SetTexture("_CSF", blackTex);
						break;
					case IntroState.ShowingCSF:
						Vector2 screenSize = FocusProvider.GetScreenResolution();
						csfGenerator.halfResolutionEccentricity = demonstrationHalfEccentricity;
						csfGenerator.centre = demoPosition;
						csf = RenderTexture.GetTemporary(source.width, source.height);
						csfGenerator.GetContrastSensitivityMap(source, csf);
						material.SetTexture("_CSF", csf);

						wantedFocusIndicator.centre = demoPosition + Jitter(demonstrationJitterStrength);
						break;
					default: // Including ShowingTrue
						material.SetTexture("_CSF", whiteTex);
						break;
				}
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
 		GUI.skin.button.fontSize = guiFontSize;
 		GUI.skin.label.fontSize = guiFontSize;
 		GUI.skin.button.wordWrap = true;
 		GUI.skin.label.wordWrap = true;

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
			/*case State.SendToFilm:
				if(GUI.Button(messageRect, "Click here when you have seen the introductory film."))
				{
					state = State.SendToCalibration;
				}
				break;*/
			case State.SendToCalibration:
				if(GUI.Button(messageRect, "Click here when the gaze tracker has been calibrated to 5/5!"))
				{
					state = State.ShowIntro;
				}
				break;
			case State.ShowIntro:
				HandleIntroGUI();
				break;
			case State.GatheringObservations:
				HandleObservationGUI();
				break;
			case State.EndTrials:
				GUI.Label(messageRect, "Thank you for your participation! You may now approach the test conductor for a short interview.");
				break;
		}
	}

	private void HandleObservationGUI()
	{
		switch(observationState)
		{
			case ObservationState.Flashing:
				GUI.Label(messageRect, "");
				break;
			case ObservationState.UserObserving:
				break;
			case ObservationState.Resting:
				GUI.Label(messageRect, restMessage);
				break;
			case ObservationState.AwaitingAnswer:
				GUI.Label(messageRect, guiTextAwaitingAnswer);
				SendInputToTFC();
				break;
		}
	}

	private void HandleIntroGUI()
	{
		switch(introState)
		{
			case IntroState.ShowingTrue:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect, guiTextShowingTrue);
				break;
			case IntroState.ShowingFalse:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect, guiTextShowingFalse);
				break;
			case IntroState.ShowingCSF:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect, guiTextShowingCSF);
				break;
			case IntroState.ShowingExplanation:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect, guiTextShowingExplanation);
				break;
			case IntroState.ShowingMarker:
				GUI.Box(boxRect, " ");
				GUI.Label(messageRect, 
			          "This is the marker, indicating where you must look during the test. PLEASE KEEP YOUR VISUAL FOCUS AT IT.\n"
					+ "It will change position every time you answer."
					+ "\nPress 'Next' when you are ready to start the test, or"
					+ " 'Back' if you want see the previous information."
				);
				break;
		}
		HandleIntroInput();
	}

	private void HandleIntroInput()
	{
		switch(introState)
		{
			case IntroState.ShowingTrue:
				if(GUI.Button(mouseRectRight,"Next"))
				{
					introState = IntroState.ShowingFalse;
				}
				break;
			case IntroState.ShowingFalse:
				if(GUI.Button(mouseRectRight,"Next"))
				{
					introState = IntroState.ShowingCSF;
					wantedFocusIndicator.enabled = true;
					wantedFocusIndicator.centre = demoPosition;
				}
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					introState = IntroState.ShowingTrue;
				}
				break;
			case IntroState.ShowingCSF:
				if(GUI.Button(mouseRectRight,"Next"))
				{
					introState = IntroState.ShowingExplanation;
					wantedFocusIndicator.enabled = false;
				}
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					introState = IntroState.ShowingFalse;
					wantedFocusIndicator.enabled = false;
				}
				break;
			case IntroState.ShowingExplanation:
				if(GUI.Button(mouseRectRight,"Next"))
				{
					Debug.Log("Going to IntroState.ShowingMarker");
					introState = IntroState.ShowingMarker;
					wantedFocusIndicator.enabled = true;
					wantedFocusIndicator.SetPositive(2f);
					wantedFocusIndicator.lerpRandomly = true;
				}
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					Debug.Log("Going back to IntroState.ShowingCSF");
					introState = IntroState.ShowingCSF;
					wantedFocusIndicator.enabled = true;
					wantedFocusIndicator.centre = demoPosition;
				}
				break;
			case IntroState.ShowingMarker:
				if(GUI.Button(mouseRectRight,"Start test"))
				{
					Debug.Log("Going to start the test");
					wantedFocusIndicator.lerpRandomly = false;
					StartTrials();
				}
				if(GUI.Button(mouseRectLeft,"Back"))
				{
					Debug.Log("Going back to IntroState.ShowingExplanation");
					introState = IntroState.ShowingExplanation;
					wantedFocusIndicator.enabled = false;
					wantedFocusIndicator.lerpRandomly = true;
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
		state = State.GatheringObservations;

		gazeLogger.UpdatePath();
		wantedFocusIndicator.enabled = true;

		UpdateWantedFocusPosition();
		observationState = ObservationState.Flashing;
		StartScreenFlash(flashDuration);
	}

	private void StartScreenFlash(double duration)
	{
		flashTimeLeft = duration;
	}

	private void OnScreenFlashEnd()
	{
		if(state == State.GatheringObservations)
		{
			StartUserObserving();
		}
	}

	private void StartUserObserving()
	{
		gazeLogger.Begin();

		observationState = ObservationState.UserObserving;
		userObservationTimeLeft = userObservationDuration;
	}

	private void OnUserObservingEnd()
	{
		observationState = ObservationState.AwaitingAnswer;
	}

	private void UpdateWantedFocusPosition()
	{
		Vector2 newPos = GenerateNewWantedFocusPosition();
		SetWantedFocusPosition(newPos);
	}

	private void SetWantedFocusPosition(Vector2 position)
	{
		wantedFocusPosition = position;
		wantedFocusIndicator.LerpTo(position, wantedFocusIndicatorLerpDuration);
		gazeLogger.ReferenceLocation = position;
	}

	private Vector2 GenerateNewWantedFocusPosition()
	{
		return CustomRandom.GenerateScreenPoint();
	}

	private void OnReportObservationEvent(object source, ReportObservationEventArgs args)
	{
		print("Reported observation");

		// Pause gaze logging
		gazeLogger.Pause();

		// Set marker colour
		if(args.Observation)
		{
			wantedFocusIndicator.SetPositive(wantedFocusIndicatorColourFeedbackDuration);
		}
		else
		{
			wantedFocusIndicator.SetNegative(wantedFocusIndicatorColourFeedbackDuration);
		}	

		// Flash screen	and move marker
		observationState = ObservationState.Flashing;
		StartScreenFlash(flashDuration); 
		UpdateWantedFocusPosition();
	}

	private void OnFinishedThresholdFindingEvent(object source, FinishedEventArgs args)
	{
		wantedFocusIndicator.enabled = false;
		state = State.EndTrials;
	}

	private void OnFinishedTrialEvent(object source, FinishedTrialEventArgs args)
	{
		print("Finished trial and flashTimeLeft is " + flashTimeLeft);
		observationState = ObservationState.Resting;
		StartScreenFlash(flashDurationForRests);
	}

	void OnApplicationQuit()
	{
		gazeLogger.Pause();
	}

	private Vector2 Jitter(float maxMagnitude)
	{
		return UnityEngine.Random.insideUnitCircle * maxMagnitude;
	}
}
