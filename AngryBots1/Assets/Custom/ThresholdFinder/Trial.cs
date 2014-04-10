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
	
}