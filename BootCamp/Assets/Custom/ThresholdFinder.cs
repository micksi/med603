using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace ThresholdFinding
{
	/*
	TODO: Seems to be working, but needs more rigorous testing
	TODO: Find and clean up useless methods (if any)
	TODO: Document eeeeeverryything
	TODO: Make sure that the new refactoring to use Ranges did not cause any problems
	TODO: Create more implementations in order to figure out if the interface is OK
	TODO: Finish implementing and testing BestPestTrial along with ObservationsProvider (maybe)
	*/

	public class ThresholdFinder
	{
		protected Trial[] trials;
		protected int index = 0;
		private bool finished = false;
		public event EventHandler<FinishedEventArgs> FinishedEvent;

		public ThresholdFinder(ITrialStrategy strategy)
		{
			trials = strategy.GenerateTrials();
		}

		public bool ReportObservation(double stimulus, bool value)
		{	
			bool result = trials[index].ReportObservation(stimulus, value);
			if(result == true)
			{
				Debug.Log(trials[index].ToString() + " finished at stimulus " + stimulus);
				//SaveObservationsToDisk(trials[index]);
			}
			return result;
		}

		public double Stimulus
		{
			get
			{
				Trial trial = trials[index];
				if(trial.Finished)
				{
					trial = trials[++index];
				}
				return trial.Stimulus;
			}
		}

		public void SaveObservationsToDisk()
		{
			for(int i = 0; i < trials.Length; i++)
			{
				SaveObservationsToDisk(trials[i]);
			}
		}

		public string GetOutputDirectory()
		{
			string dataPath = Application.dataPath;
			dataPath = dataPath.Replace("Assets", ""); // Go up one level

			if(Application.platform == RuntimePlatform.WindowsPlayer ||
			   Application.platform == RuntimePlatform.WindowsEditor)
			{
				dataPath = dataPath.Replace('/', '\\');
			}

			string path = Path.Combine(dataPath, "Observations");
			return path;
		}

		private void SaveObservationsToDisk(Trial trial)
		{
			string path = GetOutputDirectory();
			path = Path.Combine(path, trial + " at " + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + ".txt");

			if(Directory.Exists(Path.GetDirectoryName(path)) == false)
			{
				Directory.CreateDirectory(Path.GetDirectoryName(path));
			}

			Debug.Log("Saving observations to file: " + path);
			trial.WriteObservationsToFile(path);
		}

		public Trial CurrentTrial
		{
			get { return trials[index]; }
		}

		public bool Finished 
		{
			get
			{
				if(finished == true)
				{
					return finished;
				}

				if(index >= trials.Length || (index == trials.Length - 1 && trials[index].Finished))
				{
					if(finished == false)
					{
						if(FinishedEvent != null)
						{
							FinishedEvent(this, new FinishedEventArgs());
						}
					}
					finished = true;
					return true;
				}
				return false;
			}
		}

		public void GetObservations(out double[] stimuli, out bool[] values)
		{	
			List<double> stimuliList = new List<double>();
			List<bool> valueList = new List<bool>();

			// Concatenate all oversations from different trials
			for(int i = 0; i < trials.Length; i++)
			{
				foreach (var observation in trials[i].GetObservations())
				{
					stimuliList.Add(observation.Key);
					valueList.Add(observation.Value);
				}
			}
			stimuli = stimuliList.ToArray();
			values = valueList.ToArray();

		}

		public void GetThresholds(out double[] thresholds)
		{
			thresholds = new double[trials.Length];
			for(int i = 0; i < trials.Length; i++)
			{
				Trial trial = trials[i];
				if(trial.Finished == false)
				{
					throw new InvalidOperationException("Trying to get threshold before all trials are done");
				}
				if(trial.Failed == true)
				{
					throw new InvalidOperationException(
						String.Format(
							"Trying to get threshold from an exhausted (failed) trial.\nIndex: {0}",
							index
						)
					);
				}
				thresholds[i] = trial.ResultingThreshold;
			}
		}

		public double[] GetThresholds()
		{
			double[] thresholds;
			GetThresholds(out thresholds);
			return thresholds;
		}

		public double GetThreshold()
		{
			double[] thresholds = GetThresholds();
			double sum = 0;
			for(int i = 0; i < thresholds.Length; i++)
			{
				sum += thresholds[i];
			}
			return sum / thresholds.Length;
		}
	}

	public class FinishedEventArgs : EventArgs
	{

	}
}