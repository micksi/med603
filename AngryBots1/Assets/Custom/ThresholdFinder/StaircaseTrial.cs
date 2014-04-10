using System;
using System.Collections.Generic;
using UnityEngine;

namespace ThresholdFinding
{

	internal class StaircaseTrial : ConstantStepTrial
	{

		private int maxReversals;
		private int reversals = 0;
		private bool startAscending;

		public StaircaseTrial(bool ascending, float min, float max, float step, int maxReversals)
		: base(ascending, min, max, step)
		{
			this.maxReversals = maxReversals;
			this.startAscending = ascending;
		}

		public override bool ReportObservation(float stimulus, bool value)
		{
			RecordObservation(stimulus, value);
			if(value == ascending)
			{
				// reverse
				this.ascending = !this.ascending;
				this.reversals++;
				Debug.Log(this.ToString() + " is reversing at stimulus " + stimulus + ". Reversal number " + reversals);

				if(reversals >= maxReversals)
				{
					Finished = true;
				}
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
					return GetMeanThreshold();
				}
			}
		}

		private float GetMeanThreshold()
		{
			List<KeyValuePair<float, bool>> observations = GetObservations();
			float mean = 0;
			bool previous = !startAscending;
			foreach(KeyValuePair<float, bool> pair in observations)
			{
				if(pair.Value != previous)
				{
					mean += pair.Key;
				}
			}
			return mean / maxReversals;
		}


		public override string ToString()
		{
			return String.Format("Staircase trial with Min: {0}, Max: {1}, startDirection: {2}",
				Min, Max, (startAscending ? "Ascending" : "Descending")
			);
		}

	}

	/*
	internal class StaircaseTrial
	{
		#region attributes

		private float step;
		private bool ascending;
		private float currentStimulus;

		#endregion

		#region properties

		public float NextStimulus
		{
			get
			{
				float result = currentStimulus;
				if(ascending)
				{
					currentStimulus += step;
				}
				else
				{
					currentStimulus -= step;
				}
			}
		}

		public float ResultingThreshold {get;}
		
		#endregion

		#region constructors

		public ParallelTrial(bool initiallyAcending, float min, float max, float step)
		{
			this.Min = min;
			this.Max = max;
			this.step = step;
			this.ascending = initiallyAcending;
			this.currentStimulus = ascending ? min : max;
		}

		
		#endregion

		#region methods

		public bool ReportObservation(float stimulus, bool value)
		{
			
		}
		
		#endregion

	}
	*/
}