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
	TODO: Create more implementations in order to figure out if the interface is OK
	TODO: Examine if current factory pattern is necessary and/or could be optimised
	*/

	public class ThresholdFinder
	{
		protected Trial[] trials;
		protected int index = 0;

		public ThresholdFinder(ITrialStrategy strategy)
		{
			trials = strategy.GenerateTrials();
		}

		public bool ReportObservation(float stimulus, bool value)
		{	
			bool result = trials[index].ReportObservation(stimulus, value);
			if(result == true)
			{
				Debug.Log(trials[index].ToString() + " finished at stimulus " + stimulus);
				SaveObservationsToDisk(trials[index]);
			}
			return result;
		}

		public float NextStimulus
		{
			get
			{
				Trial trial = trials[index];
				if(trial.Finished)
				{
					trial = trials[++index];
				}
				return trial.NextStimulus;
			}
		}

		private void SaveObservationsToDisk(Trial trial)
		{
			string dataPath = Application.dataPath;
			dataPath = dataPath.Replace("Assets", "");

			if(Application.platform == RuntimePlatform.WindowsPlayer ||
			   Application.platform == RuntimePlatform.WindowsEditor)
			{
				dataPath = dataPath.Replace('/', '\\');
			}

			string path = Path.Combine(dataPath, "Observations");
			path = Path.Combine(path, trial + " at " + DateTime.UtcNow.ToString("yyyy-MM-dd_HH-mm-ss-fffffff") + ".txt");

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
				if(index >= trials.Length || (index == trials.Length - 1 && trials[index].Finished))
				{
					return true;
				}
				return false;
			}
		}

		public void GetObservations(out float[] stimuli, out bool[] values)
		{	
			List<float> stimuliList = new List<float>();
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

		public void GetThresholds(out float[] thresholds)
		{
			thresholds = new float[trials.Length];
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

		public float[] GetThresholds()
		{
			float[] thresholds;
			GetThresholds(out thresholds);
			return thresholds;
		}

		public float GetThreshold()
		{
			float[] thresholds = GetThresholds();
			float sum = 0;
			for(int i = 0; i < thresholds.Length; i++)
			{
				sum += thresholds[i];
			}
			return sum / thresholds.Length;
		}
	}

	/*
	public class ThresholdFinder
	{
		private ITrialStrategy strategy;

		public ThresholdFinder(ITrialStrategy strategy)
		{
			this.strategy = strategy;
		}

		public float NextStimulus
		{
			get {return strategy.NextStimulus;}
		}

		public Trial CurrentTrial
		{
			get { return strategy.CurrentTrial; }
		}

		public bool ReportObservation(float stimulus, bool observation)
		{
			return strategy.ReportObservation(stimulus, observation);
		}

		public bool Finished
		{
			get { return strategy.Finished; }
		}

		public void GetObservations(out float[] stimuli, out bool[] values)
		{
			strategy.GetObservations(out stimuli, out values);
		}

		public float[] GetThresholds()
		{
			float[] result;
			strategy.GetThresholds(out result);
			return result;
		}

		public float GetThreshold()
		{
			float[] thresholds = GetThresholds();
			float sum = 0;
			for(int i = 0; i < thresholds.Length; i++)
			{
				sum += thresholds[i];
			}
			return sum / thresholds.Length;
		}

	}
	*/
}