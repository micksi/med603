using UnityEngine;
using System.Collections;
using System;

// Logs gaze position data as TIMESTAMP,X,Y
public class GazeLogger : MonoBehaviour {

	private bool logging = false;
	private bool usingDiff = false;
	private double logIntervalSeconds;
	private string targetpath;
	private Vector2 gazeTarget;

	private double timeToNextLog = 0.0;

	// Will start logging gaze position to the specified file at the specified interval.
	public void BeginLogging(string targetpath, double logIntervalSeconds)
	{
		print("Starting gaze logging to " + targetpath + " every " + logIntervalSeconds + " seconds.");
		this.targetpath = targetpath;
		this.logIntervalSeconds = logIntervalSeconds;
		logging = true;
		usingDiff = false;
	}

	// Log the difference between gaze position and desired position.
	public void BeginLoggingDiff(string targetpath, double logIntervalSeconds, Vector2 gazeTarget)
	{
		BeginLogging(targetpath, logIntervalSeconds);
		this.gazeTarget = gazeTarget;
		usingDiff = true;
	}

	public void EndLogging()
	{
		logging = false;
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
				// Reset counter
				timeToNextLog = logIntervalSeconds;
				Log();
			}
		}
	}

	// Does the actual writing of data to the provided path
	private void Log()
	{	
		if(FocusProvider.source != FocusProvider.Source.Gaze)
		{
			// If you're testing without gaze tracking, you can comment the following line out.
			throw new InvalidOperationException("Won't log gaze, as you're not using gaze as focus source.");
		}

		Vector2 logPosition = FocusProvider.GetFocusPosition();
		if(usingDiff)
		{
			logPosition -= gazeTarget;
		}

		string content = System.String.Format("{0},{1},{2}\n", DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff"), logPosition.x, logPosition.y);
		System.IO.File.AppendAllText(targetpath, content);
	}
}
