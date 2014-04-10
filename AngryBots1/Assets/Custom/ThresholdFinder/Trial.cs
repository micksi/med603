using System;
using System.Collections.Generic;

namespace ThresholdFinding
{
	public abstract class Trial
	{
		public float Min {get; protected set;}
		public float Max {get; protected set;}
		protected float currentStimulus {get; set;}
		private List<KeyValuePair<float, bool>> observations = new List<KeyValuePair<float, bool>>();


		public bool Failed
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


		public bool Finished
		{
			get;
			protected set;
		}

		public List<KeyValuePair<float, bool>> GetObservations()
		{
			return observations;
		}

		protected void RecordObservation(float stimulus, bool value)
		{
			observations.Add(new KeyValuePair<float, bool>(stimulus, value));
		}

		public abstract bool ReportObservation(float stimulus, bool value);
		public abstract float NextStimulus {get;}
		public abstract float ResultingThreshold {get;}
	}

	public class ConstantStepTrial : Trial
	{
		public readonly bool ascending;

		private float step;


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