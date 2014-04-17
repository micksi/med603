using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	public class BestPestTrial : Trial
	{

		public bool StartAscending {get; private set;}
		private int counter = 0;
		private IObservationsProvider observationsProvider;

		public BestPestTrial(bool ascending, double min, double max, int res, IObservationsProvider op)
		 : base(new Range(min, max, res))
		{
			this.StartAscending = ascending;
			
			this.observationsProvider = op;
		}

		public override bool Failed
		{
			get
			{
				throw new NotImplementedException();
			}
		}

		public override bool ReportObservation(double stimulus, bool value)
		{
			observationsProvider.ReportObservation(stimulus, value);
			return true;
		}

		public override double NextStimulus
		{
			get
			{
				double result;
				if(counter == 0)
				{
					result = (Max - Min) / 2;
				}
				else
				{
					result = observationsProvider.GetFiftyPercentEstimation();
				}

				counter++;
				return result;
			}
		}

		private List<KeyValuePair<double, bool>> GetAllObservations()
		{
			return observationsProvider.GetObservations();
		}

		private bool[] GetAllObservationsAtStimulus(double stimulus)
		{
			List<KeyValuePair<double, bool>> observations = GetAllObservations();
			List<bool> result = new List<bool>();
			foreach(KeyValuePair<double, bool> pair in observations)
			{
				if(pair.Key == stimulus)
				{
					result.Add(pair.Value);
				}
			}
			return result.ToArray();
		}

		private double GetProbabilityOfPositiveAtStimulus(double stimulus)
		{
			throw new NotImplementedException();
		}

		public override double ResultingThreshold 
		{
			get
			{
				throw new NotImplementedException();
			}
		}
	}
	
}