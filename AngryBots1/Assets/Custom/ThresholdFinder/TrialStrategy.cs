using System;
using System.Collections.Generic;

namespace Stimulus
{
	public interface ITrialStrategy
	{
		bool ReportObservation(bool value);
		bool IsFinished();
		void GetObservations(out float[] stimuli, out bool[] values);
		void GetThresholds(out float[] thresholds);
		float GetNextStimulus();
		Trial GetCurrentTrial();
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

		public bool ReportObservation(bool value)
		{	
			bool result = trials[index].ReportObservation(value);
			return result;
		}

		public float GetNextStimulus()
		{
			Trial trial = trials[index];
			if(trial.IsDone())
			{
				trial = trials[++index];
			}
			return trial.GetNextStimulus();
		}

		public Trial GetCurrentTrial()
		{
			return trials[index];
		}

		public bool IsFinished() 
		{
			if(index >= trials.Length | (index == trials.Length - 1 && trials[index].IsDone()))
			{
				return true;
			}
			return false;
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
				if(trial.IsDone() == false)
				{
					throw new InvalidOperationException("Trying to get threshold before all trials are done");
				}
				if(trial.IsFailed() == true)
				{
					throw new InvalidOperationException(
						String.Format(
							"Trying to get threshold from an exhausted (failed) trial.\nIndex: {0}",
							index
						)
					);
				}
				thresholds[i] = trial.GetResultingThreshold();
			}
		}
	}
}