using System;
using System.Collections.Generic;

namespace ThresholdFinding
{

	public static class BestPest
	{

		public static double ProbabilityOf50Percent(double stim, bool obs, double meas,
			double E, double S, double B)
		{
			return ProbabilityOf50Percent(stim, obs ? 1.0 : -1.0, meas, E, S, B);
		}


		public static double ProbabilityOf50Percent(double stim, double obs, double meas,
			double E, double S, double B)
		{
			double exponent = -obs * (meas - stim) * 4 * B * Math.Pow(S, -1.0);
			return E + S * Math.Pow(1 + Math.Exp(exponent), -1.0);	
		}

		public static int CalculateNextIndex(ref double[] probs,
			double[] stims, List<KeyValuePair<double, bool>> samples, double E, double S, double B)
		{
			if(samples.Count < 1)
			{
				return stims.Length / 2;
			}
			int maxIndex = 0;
			double maxProb = Double.NegativeInfinity;

			for(int j = 0; j < probs.Length; j++)
			{
				double stim = stims[j];
				double prob = 0.0;
				foreach(var sample in samples)
				{
					prob += Math.Log(ProbabilityOf50Percent(stim, sample.Value, sample.Key, E, S, B));
				}
				probs[j] = prob;
				// save max index
				if(prob > maxProb)
				{
					maxIndex = j;
					maxProb = prob;
				}
			}
			return maxIndex;
		}

		public static int CalculateNextIndex(Range range,
			List<KeyValuePair<double, bool>> samples, double B)
		{
			return CalculateNextIndex(range.ToArray(), samples, range.Min, range.Scale, B);
		}

		public static double CalculateStimulus(Range range, List<KeyValuePair<double, bool>> samples, double B)
		{
			int i = CalculateNextIndex(range, samples, B);
			return range.ToArray()[i];
		}

		public static int CalculateNextIndex(double[] stims, List<KeyValuePair<double, bool>> samples,
			double E, double S, double B)
		{
			double[] probs = new double[stims.Length];
			return CalculateNextIndex(ref probs, stims, samples, E, S, B);
		}

		public static double CalculateStimulus(ref double[] probs, double[] stims,
			List<KeyValuePair<double, bool>> samples, double E, double S, double B)
		{
			int i = CalculateNextIndex(ref probs, stims, samples, E, S, B);
			return stims[i];
		}

		public static double CalculateStimulus(double[] stims, List<KeyValuePair<double, bool>> samples,
			double E, double S, double B)
		{
			double[] probs = new double[stims.Length];
			return CalculateStimulus(ref probs, stims, samples, E, S, B);
		}

	}

}