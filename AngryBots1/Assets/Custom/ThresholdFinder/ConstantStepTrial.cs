using System;
using System.Collections.Generic;

namespace ThresholdFinding
{
	public class ConstantStepTrial : Trial
	{
		protected bool ascending;

		protected float step;


		public ConstantStepTrial(bool ascending, float min, float max, float step)
		{
			this.ascending = ascending;
			this.Min = min;
			this.Max = max;
			this.step = step;
			this.currentStimulus = (ascending == true) ? min : max;
		}

		public override bool ReportObservation(float stimulus, bool value)
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

		public override float ResultingThreshold
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

		public override float NextStimulus
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

				float result = currentStimulus;

				if(ascending == true)
				{
					currentStimulus += step;	
				}
				else
				{
					currentStimulus -= step;
				}
				return result;
			}
		}

		public override string ToString()
		{
			return String.Format("Trial with Min: {0}, Max: {1}, direction: {2}",
				Min, Max, (ascending ? "Ascending" : "Descending")
			);
		}
	}
}