using System;
using System.Collections.Generic;


namespace ThresholdFinding
{
	public interface IObservationsProvider
	{
		List<KeyValuePair<double, bool>> GetObservations();
		void ReportObservation(double stimulus, bool obs);
		double GetProbabilityOfObservation(double stimulus);
		double GetObservationsAt(double stimulus);
		double GetFiftyPercentEstimation();
	}

	public class MemoryObservationsProvider
	{

		public readonly double Min, Max;
		private List<KeyValuePair<double, bool>> observations;
		public readonly int Resolution;

		public MemoryObservationsProvider(double min, double max, int res=100)
		{
			Min = min;
			Max = max;
			Resolution = res;
			observations = new List<KeyValuePair<double, bool>>();
		}

		public List<KeyValuePair<double, bool>> GetObservations()
		{
			throw new NotImplementedException();
		}

		public void ReportObservation(double stimulus, bool obs)
		{
			observations.Add(new KeyValuePair<double, bool>(stimulus, obs));
		}

		public double GetProbabilityOfPositive(double stimulus)
		{
			var obs = GetObservations();
			if(obs.Count < 1)
			{
				return 1.0 / Resolution;
			}
			double result = 1.0;
			foreach(var pair in obs)
			{
				double r = pair.Value ? 1.0 : -1.0;
				double m = pair.Key;
				double x = stimulus;
				result *= Math.Pow((1.0 + Math.Exp(-r * (m - x))), -1);
			}
			return result;
		}

		public double GetObservationsAt(double stimulus)
		{
			throw new NotImplementedException();
		}

		public double GetStimulus(int index)
		{
			Range range = GetRange();
			return (range.Min + index * ((range.Max - range.Min) / Resolution));
		}

		public double GetFiftyPercentEstimation()
		{
			

			double[] probabilities = new double[Resolution];
			Range range = GetRange();
			for(int i = 0; i < Resolution; i++)
			{
				
				probabilities[i] = GetProbabilityOfPositive(GetStimulus(i));
			}

			// get max value
			int maxIndex = 0;
			for(int i = 0; i < Resolution; i++)
			{
				if(probabilities[i] > probabilities[maxIndex])
					maxIndex = i;
			}
			return range.Min + ((range.Max - range.Min) / Resolution) * maxIndex;
		}

		public Range GetRange()
		{
			return new Range(Min, Max);
		}


	}


}