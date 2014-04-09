using System;
using System.Collections.Generic;

namespace Stimulus
{
	/*

	TODO: Seems to be working, but needs more rigorous testing
	TODO: Use generics to abstract away float type
	TODO: Find and clean up useless methods
	TODO: Change some methods to be properties instead
	TODO: Get initial stimulus as well (max or min)
	TODO: Use parameter stimulus for reporting observation
	TODO: Document eeeeeverryything
	*/
	public class ThresholdFinder
	{
		private ITrialStrategy strategy;

		public ThresholdFinder(ITrialStrategy strategy)
		{
			this.strategy = strategy;
		}

		public float GetNextStimulus()
		{
			return strategy.GetNextStimulus();
		}

		public Trial GetCurrentTrial()
		{
			return strategy.GetCurrentTrial();
		}

		public bool ReportObservation(float stimulus, bool observation)
		{
			return strategy.ReportObservation(observation);
		}

		public bool IsFinished()
		{
			return strategy.IsFinished();
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
}