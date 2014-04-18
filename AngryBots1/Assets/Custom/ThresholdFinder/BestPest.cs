using System;
using System.Collections.Generic;

namespace ThresholdFinding
{

	public static class BestPest
	{

		public static double Logistic(double stim, bool obs, double meas, double B = 1.0, double S = 1.0)
		{
			return Logistic(stim, obs ? 1.0 : -1.0, meas, B, S);
		}

		public static double Logistic(double stim, double obs, double meas, double B = 1.0, double S = 1.0)
		{
			double exponent = obs * (meas - stim) * 4 * B * Math.Pow(S, -1.0);
			return Math.Pow(1 + Math.Exp(exponent), -1.0);
		}

		public static int CalculateNextIndex(ref double[] probs,
			double[] stims, List<KeyValuePair<double, bool>> samples)
		{
			if(samples.Count < 1)
			{
				return stims.Length / 2;
			}
			int maxIndex = 0;
			double maxProb = 0.0;

			for(int j = 0; j < probs.Length; j++)
			{
				double stim = stims[j];
				double prob = 0.0;
				foreach(var sample in samples)
				{
					prob += Math.Log(Logistic(stim, sample.Value, sample.Key));
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

		public static int CalculateNextIndex(double[] stims, List<KeyValuePair<double, bool>> samples)
		{
			double[] probs = new double[stims.Length];
			return CalculateNextIndex(ref probs, stims, samples);
		}

		public static double CalculateStimulus(ref double[] probs, double[] stims, List<KeyValuePair<double, bool>> samples)
		{
			int i = CalculateNextIndex(ref probs, stims, samples);
			return stims[i];
		}

		public static double CalculateStimulus(double[] stims, List<KeyValuePair<double, bool>> samples)
		{
			double[] probs = new double[stims.Length];
			return CalculateStimulus(ref probs, stims, samples);
		}

	}

}