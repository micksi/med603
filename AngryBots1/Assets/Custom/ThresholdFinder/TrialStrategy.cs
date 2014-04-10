using System;
using System.Collections.Generic;
using UnityEngine;

namespace ThresholdFinding
{
	public interface ITrialStrategy
	{
		bool ReportObservation(float stimulus, bool value);
		bool Finished {get;}
		void GetObservations(out float[] stimuli, out bool[] values);
		void GetThresholds(out float[] thresholds);
		float NextStimulus {get;}
		Trial CurrentTrial {get;}
	}

	public class AlternatingTrialsStrategy : ITrialStrategy
	{

		private Trial[] trials;
		private int index;

		public AlternatingTrialsStrategy(int nTrials, float min, float max, float step)
		{
			// If nTrials is an odd number, throw an ArgumentException. 
			if ((nTrials & 1) == 1)
			{
				throw new ArgumentException("Number must be even", "nTrials");
			}
			index = 0;
			trials = new ConstantStepTrial[nTrials];
			for(int i = 0; i < nTrials; i++)
			{	
				// alternate between directions
				bool direction = ((i & 1) == 1);
				trials[i] = new ConstantStepTrial(direction, min, max, step);
			}
		}

		public bool ReportObservation(float stimulus, bool value)
		{	
			bool result = trials[index].ReportObservation(stimulus, value);
			if(result == true)
			{
				Debug.Log(trials[index].ToString() + " finished at stimulus " + stimulus);
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

		public Trial CurrentTrial
		{
			get { return trials[index]; }
		}

		public bool Finished 
		{
			get
			{
				if(index >= trials.Length | (index == trials.Length - 1 && trials[index].Finished))
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
	}
}