using System;
using System.Collections.Generic;

namespace ThresholdFinding
{	

	// TODO: Rewrite to use Range and indicies in the range instead
	public class ConstantStepTrial : Trial
	{
		public bool ascending {get; protected set;} // Should this be public?
		protected double currentStimulus
		{
			get
			{
				return Range.GetValue(index);
			}
		}

		private int index;

		protected double step
		{
			get
			{
				return Range.Step;
			}
		}

		public ConstantStepTrial(bool ascending, Range range) : base(range)
		{
			this.ascending = ascending;
			this.index = (ascending) ? 0 : range.Resolution;
		}


		public override bool ReportObservation(double stimulus, bool value)
		{
			base.ReportObservation(stimulus, value);
			RecordObservation(stimulus, value);
			if(ascending)
			{
				Finished = value;
			}
			else
			{
				Finished = !value;
			}
			return Finished;
		}

		public override double ResultingThreshold
		{
			get
			{
				if(Finished == false)
				{
					throw new InvalidOperationException("Cannot get resulting threshold before trial is done");
				}
				else
				{
					return GetObservations()[GetObservations().Count - 1].Key;
				}
			}
		}

		public override double Stimulus
		{
			get
			{
				// check state
				if(Failed)
				{
					throw new InvalidOperationException(
						"Trials is exhausted and thus failed. currentStimulus: " + currentStimulus
					);
				}
				else if(Finished)
				{
					throw new InvalidOperationException("Trials is done");	
				}

				double result = currentStimulus;
				if(ascending == true)
				{
					index++;
				}
				else
				{
					index--;
				}


				return result;
			}
		}

		public override bool Failed
		{
			get
			{
				if(index < 0 || index > Range.Resolution)
				{
					return true;
				}
				return false;
			}
		}

		public override string ToString()
		{
			return this.GetType().Name + String.Format(" with Min = {0}, Max = {1}, direction = {2}",
				Min, Max, (ascending ? "Ascending" : "Descending")
			);
		}
	}
}