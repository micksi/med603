using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	// TODO: Cache stimulus values for better performance
	// TODO: Test thoroughly
	// TODO: Pull out data for comparison in matlab
	// TODO: We are not getting the results we want. Double check calculations in matlab
	public class BestPestTrial : Trial
	{

		public bool StartAscending {get; private set;}
		private int counter;
		private double[] stimRange;
		private double[] probsBuffer;
		private readonly double steepness;
		

		public BestPestTrial(bool ascending, Range range, double steepness, int nStimuli)
		 : base(range)
		{
			this.StartAscending = ascending;
			this.steepness = steepness;
			this.counter = nStimuli;
			this.stimRange = Range.ToArray();
			this.probsBuffer = new double[stimRange.Length];
			Initialize();
		}

		/// Initialize bestPEST algorithm with predefined values
		private void Initialize()
		{
			RecordObservation(Range.Min, false);
			RecordObservation(Range.Max, true);
		}

		public override bool Failed
		{
			get
			{
				if(Stimulus < Range.Min || Stimulus > Range.Max)
				{
					return true;
				}
				return false;
			}
		}

		public override bool ReportObservation(double stimulus, bool value)
		{
			RecordObservation(stimulus, value);
			counter--;
			if(counter < 0)
			{
				Finished = true;
			}
			return Finished;
		}

		// Same as base, but skip first two (initialisation observations)
		public override string GetObservationsAsString(string del=",")
		{
			StringBuilder sb = new StringBuilder();
			int counter = 2;
			foreach(var pair in GetObservations())
			{
				if(counter > 0)
				{
					counter--;
					continue;
				}
				sb.Append(pair.Key)
					.Append(del)
					.Append(pair.Value ? "1" : "-1")
					.Append(Environment.NewLine);
			}
			return sb.ToString();
		}

		public override double Stimulus
		{
			get
			{
				double result = BestPest.CalculateStimulus(
					ref probsBuffer,
					stimRange,
					GetObservations(),
					Range.Min,
					Range.Scale,
					steepness
				);
				return result;
			}
		}


		public override double ResultingThreshold 
		{
			get
			{
				if(Finished == false)
				{
					throw new InvalidOperationException("Trial is not finished.");
				}
				if(Failed)
				{
					throw new InvalidOperationException(
						"Trial failed and no resulting threshold was thus achieved");
				}
				return Stimulus;
			}
		}

		public override string ToString()
		{
			return this.GetType().Name;
		}
	}
	
}