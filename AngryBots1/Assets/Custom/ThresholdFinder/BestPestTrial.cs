using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	// TODO: Cache stimulus values for better performance
	// TODO: Test thoroughly
	// TODO: Pull out data for comparison in matlab
	public class BestPestTrial : Trial
	{

		public bool StartAscending {get; private set;}
		private int counter;
		private double[] stimRange;
		private double[] probsBuffer;

		public BestPestTrial(bool ascending, Range range, int counter)
		 : base(range)
		{
			this.StartAscending = ascending;
			this.counter = counter;
			this.stimRange = Range.ToArray();
			this.probsBuffer = new double[stimRange.Length];
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

		public override double Stimulus
		{
			get
			{
				double result = BestPest.CalculateStimulus(ref probsBuffer, stimRange, GetObservations());
				return result;
			}
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