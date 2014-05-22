using UnityEngine;
using System.Collections;
using System;
using System.Text;
using System.IO;
using ThresholdFinding;
using TestFramework;

// Logs gaze position data as TIMESTAMP,X,Y
public class GazeLogger
{
	private ThresholdFinder finder = null;
	private Experiment experiment = null;
	private string path;
	private bool logging = false;

	private StringBuilder textBuffer = null;
	private StringBuilder headerText = null;
	private const int linesBeforeFlush = 500;

	private string folderPath;

	private MonoBehaviour component;

	public GazeLogger(MonoBehaviour component, string folderPath)
	{
		this.component = component;
		this.experiment = experiment;
		this.finder = finder;
        this.path = Path.Combine(folderPath, "Gazelog " + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + ".csv");
        Debug.Log("Creating gazelogger with path " +   this.path);
	}

	public void Begin()
	{
		if(logging == true)
		{
			throw new InvalidOperationException("Can't begin logging when logging already happens");
		}

		logging = true;
		
		GazeWrap gazeWrap = Camera.main.GetComponent<GazeWrap>();
		gazeWrap.GazeUpdate += OnGazeUpdate;
		Debug.Log("Subscribing gazelogger");
	}

	public void Pause()
	{
		if(logging == false)
		{
			throw new InvalidOperationException("Can't pause logging when logging is already paused");
		}

		Flush();
		logging = false;

		GazeWrap gazeWrap = Camera.main.GetComponent<GazeWrap>();
		gazeWrap.GazeUpdate -= OnGazeUpdate;
		Debug.Log("Unsubscribing gazelogger");
	}

	public void OnGazeUpdate(object sender, GazeUpdateEventArgs args)
	{
		Log(args.Position);
	}

	public void Log(Vector3 position)
	{
		Write(DateTime.Now.ToString("HH-mm-ss-fffffff"), position.x, position.y);
	}

	private void Flush()
	{
		if(File.Exists(path) == false)
		{
			GenerateHeader();
			System.IO.File.AppendAllText(path,headerText.ToString());
		}

		if(textBuffer == null)
		{
			Debug.Log("Tried to flush; nothing to flush.");
			return;
		}

		Debug.Log("Flushinig gazelogger to " + path);
		System.IO.File.AppendAllText(path,textBuffer.ToString());
		textBuffer = null;
	}

	// Does the actual writing of data to the provided path
	private void WriteLine(string arg)
	{
		if(textBuffer == null)
		{
			int capacity = linesBeforeFlush * (arg.Length + 1);
			textBuffer = new StringBuilder(capacity, capacity);
		}

		if(textBuffer.Length + arg.Length >= textBuffer.MaxCapacity)
		{
			Flush();
			WriteLine(arg);
			return;
		}

		textBuffer.Append(arg)
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

	private void GenerateHeader()
	{
		headerText = new StringBuilder(300);
		// Generate header
		headerText.Append("Gaze tracking data for MED603 experiment 2")
			.Append(Environment.NewLine);
		headerText.Append("Current resolution is " + FocusProvider.GetScreenResolution())
			.Append(Environment.NewLine);
		headerText.Append("Timestamp is in HH-mm-ss-fffffff")
			.Append(Environment.NewLine);
		headerText.Append("------------------------------")
			.Append(Environment.NewLine);
		
		headerText.Append("Timestamp,x,y")
			.Append(Environment.NewLine);
	}
}
