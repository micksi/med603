using System;
using System.Collections.Generic;
using UnityEngine;

namespace ThresholdFinding
{

	internal class StaircaseTrial : ConstantStepTrial
	{

		private int maxReversals;
		private int reversals = 0;
		public bool startAscending {get; private set;}
		public event EventHandler<ReverseEventArgs> ReverseEvent;

		public StaircaseTrial(bool ascending, Range range, int maxReversals)
		: base(ascending, range)
		{
			this.maxReversals = maxReversals;
			this.startAscending = ascending;
		}

		public override bool ReportObservation(double stimulus, bool value)
		{
			RecordObservation(stimulus, value);
			if(value == ascending)
			{
				// reverse
				ascending = !ascending;
				reversals++;
				if(ReverseEvent != null)
				{
					ReverseEvent(this, new ReverseEventArgs(ascending, reversals));
				}
				Debug.Log(ToString() + " is reversing at stimulus " + stimulus + ". Reversal number " + reversals);

				if(reversals >= maxReversals)
				{
					Finished = true;
				}
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
					return GetMeanThreshold();
				}
			}
		}

		private double GetMeanThreshold()
		{
			List<KeyValuePair<double, bool>> observations = GetObservations();
			double mean = 0;
			bool previous = !startAscending;
			foreach(KeyValuePair<double, bool> pair in observations)
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
			return String.Format("{0} with Min = {1}, Max = {2}, startDirection = {3}",
				GetType().Name, Min, Max, (startAscending ? "Ascending" : "Descending")
			);
		}

	}

	internal class ReverseEventArgs : EventArgs
	{
		public readonly bool ToAscending;
		public readonly int Iteration;
		public ReverseEventArgs(bool toAscending, int iteration)
		{
			this.ToAscending = toAscending;
			this.Iteration = iteration;
		}
	}

	/*
	internal class StaircaseTrial
	{
		#region attributes

		private double step;
		private bool ascending;
		private double currentStimulus;

		#endregion

		#region properties

		public double NextStimulus
		{
			get
			{
				double result = currentStimulus;
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

		public double ResultingThreshold {get;}
		
		#endregion

		#region constructors

		public ParallelTrial(bool initiallyAcending, double min, double max, double step)
		{
			this.Min = min;
			this.Max = max;
			this.step = step;
			this.ascending = initiallyAcending;
			this.currentStimulus = ascending ? min : max;
		}

		
		#endregion

		#region methods

		public bool ReportObservation(double stimulus, bool value)
		{
			
		}
		
		#endregion

	}
	*/
}