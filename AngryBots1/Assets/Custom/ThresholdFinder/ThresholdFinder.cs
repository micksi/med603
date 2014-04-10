using System;
using System.Collections.Generic;

namespace ThresholdFinding
{
	/*

	TODO: Seems to be working, but needs more rigorous testing
	TODO: Use generics to abstract away float type
	TODO: Find and clean up useless methods
	DONE: Change some methods to be properties instead
	DONE: Get initial stimulus as well (max or min)
	DONE: Use parameter stimulus for reporting observation
	TODO: Document eeeeeverryything
	*/

	/// Is this class really useful, as it primarily just proxies methods to the strategy?
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
}