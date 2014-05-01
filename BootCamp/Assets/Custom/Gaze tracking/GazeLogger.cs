using UnityEngine;
using System.Collections;
using System;
using System.Text;
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
	private double timeToNextLog = 0.0167; //~60hz
	private double minSizeBeforeFlush = 1800; //about every 1 second

	private double timeBetweenFlush = 0;

	private FocusProvider.Source gazeSource = FocusProvider.Source.Mouse;// Gaze; FIXME Debugging lab's windows machine. Set to not use gaze tracker.

	private StringBuilder sb = new StringBuilder();
	private StringBuilder sbHeader;

	// Logged in the beginning of each new file for future reference - this
	// is where the user is supposed to be looking.
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
		Flush();
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
	public void FixedUpdate () {
		if(logging)
		{
			if(timeToNextLog > 0)
			{
				timeToNextLog -= Time.deltaTime;
			}
			else
			{
				WriteToBuffer();

				// Reset counter
				timeToNextLog = logIntervalSeconds;
			}

			timeBetweenFlush += Time.deltaTime;
			if(sb.Length > minSizeBeforeFlush)
			{
				//print ("sb length: " + sb.Length + " Gathered in: " + timeBetweenFlush + " secounds.");
				timeBetweenFlush = 0;
				Flush();
			}
		}
	}

	private void WriteToBuffer()
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

		Write(DateTime.Now.ToString("HH-mm-ss-fffffff"), logPosition.x, logPosition.y);
	}

	private void Flush()
	{
		if(File.Exists(path) == false)
		{
			GenerateHeader();
			System.IO.File.AppendAllText(path,sbHeader.ToString());
		}

		System.IO.File.AppendAllText(path,sb.ToString());
		sb = new StringBuilder();
	}

	// Does the actual writing of data to the provided path
	private void WriteLine(string arg)
	{
		sb.Append(arg)
			.Append(Environment.NewLine);
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
		Flush();
		UpdatePath(); 
	}

	private void GenerateHeader()
	{
		sbHeader = new StringBuilder();
		// Generate header
		sbHeader.Append("Gaze tracking data for MED603 experiment 1")
			.Append(Environment.NewLine);
		sbHeader.Append("User is supposed to look at coordinates " + ReferenceLocation.ToString())
		          .Append(Environment.NewLine);
		sbHeader.Append("Current resolution is " + FocusProvider.GetScreenResolution())
			.Append(Environment.NewLine);
		sbHeader.Append("Using " + gazeSource + " as gaze data source.")
			.Append(Environment.NewLine);
		sbHeader.Append("Timestamp is in HH-mm-ss-fffffff")
			.Append(Environment.NewLine);
		sbHeader.Append("------------------------------")
			.Append(Environment.NewLine);
		
		sbHeader.Append("Timestamp,x,y")
			.Append(Environment.NewLine);
		//print ("header: " + DateTime.Now);
	}
}
