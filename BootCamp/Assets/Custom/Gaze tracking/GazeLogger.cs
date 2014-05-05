using UnityEngine;
using System.Collections;
using System;
using System.Text;
using System.IO;
using ThresholdFinding;
using TestFramework;

// Logs gaze position data as TIMESTAMP,X,Y, REF_X, REF_Y
// TODO: Get rid of mutable state plx
public class GazeLogger
{

	private ThresholdFinder finder = null;
	private Experiment experiment = null;
	private string path;
	private bool logging = false;

	private FocusProvider.Source gazeSource = FocusProvider.Source.Gaze;

	private StringBuilder sb = null;
	private StringBuilder sbHeader = null;
	private const int linesBeforeFlush = 500;

	// Logged in the beginning of each new file for future reference - this
	// is where the user is supposed to be looking.
	public Vector2 ReferenceLocation = new Vector2(0f, 0f);

	private MonoBehaviour component;

	public GazeLogger(MonoBehaviour component, Experiment experiment, ThresholdFinder finder)
	{
		this.component = component;
		this.experiment = experiment;
		this.finder = finder;

		this.finder.FinishedTrial += OnFinishedTrialEvent;
	}

	public GazeLogger(MonoBehaviour component, Experiment experiment, ThresholdFinder finder, 
		Vector2 referenceLocation)
		: this(component, experiment, finder)
	{
		this.ReferenceLocation = referenceLocation;
	}

	public void Begin()
	{
		if(logging == true)
		{
			throw new InvalidOperationException("Can't begin logging when logging already happens");
		}

		logging = true;
		
		if(gazeSource == FocusProvider.Source.Gaze)
		{
			GazeWrap gazeWrap = Camera.main.GetComponent<GazeWrap>();
			gazeWrap.GazeUpdate += OnGazeUpdate;
		}
	}

	public void Pause()
	{
		if(logging == false)
		{
			throw new InvalidOperationException("Can't pause logging when logging is already paused");
		}

		Flush();
		logging = false;

		if(gazeSource == FocusProvider.Source.Gaze)
		{
			GazeWrap gazeWrap = Camera.main.GetComponent<GazeWrap>();
			gazeWrap.GazeUpdate -= OnGazeUpdate;
		}
	}

	public void OnGazeUpdate(object sender, GazeUpdateEventArgs args)
	{
		Log(args.Position);
	}

	public void Log(Vector3 position)
	{
		Write(DateTime.Now.ToString("HH-mm-ss-fffffff"), position.x, position.y);
	}

	public void UpdatePath()
	{
		string folderPath = experiment.ActiveParticipant.FolderPath;
		Trial currenTrial = finder.CurrentTrial;
		string filename = currenTrial + " at " + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + " gazelog.csv";
		path = Path.Combine(folderPath, filename);
	}

	private void Flush()
	{
		if(File.Exists(path) == false)
		{
			GenerateHeader();
			System.IO.File.AppendAllText(path,sbHeader.ToString());
		}

		if(sb == null)
		{
			Debug.Log("Tried to flush; nothing to flush.");
			return;
		}

		System.IO.File.AppendAllText(path,sb.ToString());
		sb = null;
		// Debug.Log("Flushed...");
	}

	// Does the actual writing of data to the provided path
	private void WriteLine(string arg)
	{
		if(sb == null)
		{
			int capacity = linesBeforeFlush * (arg.Length + 1);
			// Debug.Log("Capacity: " + capacity);
			sb = new StringBuilder(capacity, capacity);
		}

		//Debug.Log("Length: " + sb.Length + ", MaxCapacity: " + sb.MaxCapacity);
		if(sb.Length + arg.Length >= sb.MaxCapacity)
		{
			Flush();
			WriteLine(arg);
			return;
		}

		sb.Append(arg)
			.Append(Environment.NewLine);
	}

	private void Write(string arg1, string arg2, string arg3)
	{
		string content = arg1 + "," + arg2 + "," + arg3 + "," + 
			ReferenceLocation.x + "," + ReferenceLocation.y;
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
		int headerLength = 300; // header is 229 constant characters + newlines + variable strings
		sbHeader = new StringBuilder(headerLength);
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
		
		sbHeader.Append("Timestamp,x,y,ref_x,ref_y")
			.Append(Environment.NewLine);
		//print ("header: " + DateTime.Now);
	}
}
