using System;
using System.Collections.Generic;

namespace ThresholdFinding
{
	public class ConstantStepTrial : Trial
	{
		public bool ascending {get; protected set;}
		protected float currentStimulus {get; set;}
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

				if(ascending == true)
				{
					currentStimulus += step;	
				}
				else
				{
					currentStimulus -= step;
				}

				float result = currentStimulus;

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