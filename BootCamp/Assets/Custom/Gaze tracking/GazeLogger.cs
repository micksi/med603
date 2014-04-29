using UnityEngine;
using System.Collections;
using System;
using System.IO;
using ThresholdFinding;
using TestFramework;

// Logs gaze position data as TIMESTAMP,X,Y
public class GazeLogger : MonoBehaviour {

	private ThresholdFinder finder = null;
	private Experiment experiment = null;
	private string path;
	private bool logging = false;
	private double logIntervalSeconds;
	private double timeToNextLog = 0.0;

	private FocusProvider.Source gazeSource = FocusProvider.Source.ScreenCentre;// Gaze; FIXME Debugging lab's windows machine. Set to not use gaze tracker.

	// Logged in the beginning of each new file for future reference - this
	// is where the user is supposed to be looking
	public Vector2 ReferenceLocation = new Vector2(0f, 0f); 

	public GazeLogger(Experiment experiment, ThresholdFinder finder, 
		double logIntervalSeconds)
	{
		this.experiment = experiment;
		this.finder = finder;
		this.logIntervalSeconds = logIntervalSeconds;

		this.finder.FinishedTrial += OnFinishedTrialEvent;
	}

	public GazeLogger(Experiment experiment, ThresholdFinder finder, 
		double logIntervalSeconds, Vector2 referenceLocation)
		: this(experiment, finder, logIntervalSeconds)
	{
		this.ReferenceLocation = referenceLocation;
	}

	public void Begin()
	{
		logging = true;
	}

	public void Pause()
	{
		logging = false;
		timeToNextLog = 0.0;
	}

	public void UpdatePath()
	{
		string folderPath = experiment.ActiveParticipant.FolderPath;
		Trial currenTrial = finder.CurrentTrial;
		string filename = currenTrial + " at " + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + " gazelog.csv";
		path = Path.Combine(folderPath, filename);
	}
	
	// Update is called from the class that owns this instance
	// unless you attach it as a component somewhere.
	public void Update () {
		if(logging)
		{
			if(timeToNextLog > 0)
			{
				timeToNextLog -= Time.deltaTime;
			}
			else
			{
				LogGaze();

				// Reset counter
				timeToNextLog = logIntervalSeconds;
			}
		}
	}

	private void LogGaze()
	{
		Vector2 logPosition = new Vector2(0f, 0f);
		switch(gazeSource)
		{
			case FocusProvider.Source.Gaze:
				logPosition = FocusProvider.GetGazePosition();
				break;
			case FocusProvider.Source.Mouse:
				logPosition = FocusProvider.GetMousePosition();
				break;
			case FocusProvider.Source.ScreenCentre:
				logPosition = FocusProvider.GetScreenCentre();
				break;
		}

		FocusProvider.GetGazePosition();

		if(File.Exists(path) == false)
		{
			// Generate header
			WriteLine("Gaze tracking data for MED603 experiment 1");
			WriteLine("User is supposed to look at coordinates " + ReferenceLocation.ToString());
			WriteLine("Using " + gazeSource + " as gaze data source.");
			WriteLine("Timestamp is in HH-mm-ss-fffffff");
			WriteLine("------------------------------");

			Write("Timestamp", "x", "y");
		}

		Write(DateTime.Now.ToString("HH-mm-ss-fffffff"), logPosition.x, logPosition.y);
	}

	// Does the actual writing of data to the provided path
	private void WriteLine(string arg)
	{
		System.IO.File.AppendAllText(path, arg + "\n");
	}

	private void Write(string arg1, string arg2, string arg3)
	{
		string content = arg1 + "," + arg2 + "," + arg3;
		WriteLine(content);
	}

	private void Write(string arg1, float arg2, float arg3)
	{
		Write(arg1, arg2.ToString(), arg3.ToString());
	}

	private void OnFinishedTrialEvent(object source, FinishedTrialArgs args)
	{
		// Start over in a new file, in order to match the structure of the other logs
		UpdatePath(); 
	}
}
