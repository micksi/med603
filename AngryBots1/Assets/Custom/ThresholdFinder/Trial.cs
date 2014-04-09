using System;
using System.Collections.Generic;

namespace Stimulus
{
	public abstract class Trial
	{
		public float min {get; protected set;}
		public float max {get; protected set;}
		protected float currentStimulus {get; set;}
		protected bool done = false;
		private List<KeyValuePair<float, bool>> observations = new List<KeyValuePair<float, bool>>();


		public bool IsFailed()
		{
			if(currentStimulus > max || currentStimulus < min)
			{
				return true;
			}
			return false;
		}


		public bool IsDone()
		{
			return done;
		}

		public List<KeyValuePair<float, bool>> GetObservations()
		{
			return observations;
		}

		protected void RecordObservation(float stimulus, bool value)
		{
			observations.Add(new KeyValuePair<float, bool>(stimulus, value));
		}

		public abstract bool ReportObservation(bool value);
		public abstract float GetNextStimulus();
		public abstract float GetResultingThreshold();
	}

	public class ConstantStepTrial : Trial
	{
		public readonly bool ascending;

		private float step;


		public ConstantStepTrial(bool ascending, float min, float max, float step)
		{
			this.ascending = ascending;
			this.min = min;
			this.max = max;
			this.step = step;
			this.currentStimulus = (ascending == true) ? min : max;
		}

		public override bool ReportObservation(bool value)
		{
			RecordObservation(currentStimulus, value);
			if(ascending)
			{
				done = value;
			}
			else
			{
				done = !value;
			}
			return done;
		}

		public override float GetResultingThreshold()
		{
			if(IsDone() == false)
			{
				throw new InvalidOperationException("Cannot get resulting threshold before trial is done");
			}
			else
			{
				return currentStimulus;
			}
		}

		public override float GetNextStimulus()
		{
			// check state
			if(IsFailed())
			{
				throw new InvalidOperationException(
					"Trials is exhausted and thus failed. currentStimulus: " + currentStimulus
				);
			}
			else if(IsDone())
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
			return currentStimulus;
		}
	}
}