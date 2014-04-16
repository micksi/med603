using System;
using System.Collections.Generic;

namespace ThresholdFinding
{	

	// TODO: Rewrite to use Range and indicies in the range instead
	public class ConstantStepTrial : Trial
	{
		public bool ascending {get; protected set;} // Should this be public?
		protected double currentStimulus {get; set;}
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
			this.currentStimulus = (ascending == true) ? min : max;
		}

		public ConstantStepTrial(bool ascending, double min, double max, double step)
		  : base(new Range(min, max, (int)((max - min) / step)))
		{
			this.ascending = ascending;
			
			this.currentStimulus = (ascending == true) ? min : max;
		}

		public override bool ReportObservation(double stimulus, bool value)
		{
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

		public override double NextStimulus
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

				if(ascending == true)
				{
					currentStimulus += step;	
				}
				else
				{
					currentStimulus -= step;
				}

				double result = currentStimulus;

				return result;
			}
		}

		public override bool Failed
		{
			get
			{
				if(currentStimulus > Max || currentStimulus < Min)
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