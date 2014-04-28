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
		string filename = currenTrial + " at " + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + " gazelog.txt";
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
		if(FocusProvider.source != FocusProvider.Source.Gaze)
		{
			// If you're testing without gaze tracking, you can comment the following line out.
			//throw new InvalidOperationException("Won't log gaze, as you're not using gaze as focus source.");
		}

		Vector2 logPosition = FocusProvider.GetFocusPosition();
		logPosition -= ReferenceLocation;

		Write(DateTime.Now.ToString("HH-mm-ss-fffffff"), logPosition.x, logPosition.y);
		//string content = System.String.Format("{0},{1},{2}\n", DateTime.Now.ToString("HH-mm-ss-fffffff"), logPosition.x, logPosition.y);
		//System.IO.File.AppendAllText(targetpath, content);
	}

	// Does the actual writing of data to the provided path
	private void Write(string arg1, float arg2, float arg3)
	{
		string content = arg1 + arg2 + arg3;
		System.IO.File.AppendAllText(path, content);
	}

	private void OnFinishedTrialEvent(object source, FinishedTrialArgs args)
	{
		// Start over in a new file, in order to match the structure of the other logs
		UpdatePath(); 
	}
}
