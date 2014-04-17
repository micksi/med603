using System;
using System.Text;
using System.Collections.Generic;
using UnityEngine;

namespace ThresholdFinding
{

	public class InterleavedStaircaseTrial : Trial
	{
		private StaircaseTrial[] trials;

		private bool startAscending;
		private int maxReversals;

		private double step
		{
			get
			{
				return Range.Step;
			}
		}
		private int index = 0;

		// TODO: Child trials are failing. Investigate if the right observations are reported, and how
		//       to keep the index in sync across observations.,

		public InterleavedStaircaseTrial(bool startAscending, Range range, int maxReversals)
		 : base(range)
		{
			this.startAscending = startAscending;			
			this.maxReversals = maxReversals;

			this.trials = new StaircaseTrial[2];

			this.trials[Convert.ToInt32(startAscending)] = 
				new StaircaseTrial(true, range, maxReversals);
			this.trials[Convert.ToInt32(!startAscending)] = 			
				new StaircaseTrial(false, range, maxReversals);

			trials[0].ReverseEvent += OnStaircaseReverse;
			trials[1].ReverseEvent += OnStaircaseReverse;
		}


		public override bool ReportObservation(double stimulus, bool value)
		{
			bool result = this.trials[index].ReportObservation(stimulus, value);
			return Finished;
		}

		private void OnStaircaseReverse(object sender, ReverseEventArgs args)
		{

		}

		public override bool Finished
		{
			get
			{
				return (trials[0].Finished && trials[1].Finished);
			}
		}

		public override List<KeyValuePair<double, bool>> GetObservations()
		{
			var first = trials[0].GetObservations();
			var second = trials[1].GetObservations();
			List<KeyValuePair<double, bool>> result =
				new List<KeyValuePair<double, bool>>(first.Count + second.Count);

			foreach(var pair in first)
			{
				result.Add(pair);
			}
			foreach(var pair in second)
			{
				result.Add(pair);
			}

			return result;
		}

		public override double NextStimulus 
		{
			get
			{
				SwitchIndex();
				if(trials[index].Finished)
				{
					SwitchIndex();
				}
				double result = trials[index].NextStimulus;
				return result;
			}
		}

		// TODO: Return results as string like so:
		// Trial, Stimulus, Value
		// A, 100, 1
		// D, 0, 0
		// etc.
		public override string GetObservationsAsString(string del=",")
		{
			var observations = new List<KeyValuePair<double, bool>>[2]
			{
				trials[0].GetObservations(),
				trials[1].GetObservations()
			};

			StringBuilder sb = new StringBuilder();

			int length = Math.Max(observations[0].Count, observations[1].Count);

			for(int i = 0; i < length; i++)
			{
				for(int j = 0; j < 2; j++)
				{
					var t = trials[j];
					var o = observations[j];
					if(i < o.Count)
					{
						sb.Append(t.startAscending ? 1 : 0)
						  .Append(del)
						  .Append(o[i].Key)
						  .Append(del)
						  .Append(Convert.ToInt32(o[i].Value))
						  .Append(Environment.NewLine);
					}
				}
			}

			return sb.ToString();
		}

		public override void WriteObservationsToFile(string fileName)
		{
			string content = "StartAscending, Stimulus, Value" + Environment.NewLine;
			content = content + GetObservationsAsString();
			System.IO.File.WriteAllText(fileName, content, Encoding.ASCII);
		}

		private void SwitchIndex()
		{
			this.index = (this.index + 1) % 2;
		}

		public override bool Failed
		{
			get
			{
				return (trials[0].Failed || trials[1].Failed);
			}
		}

		public override double ResultingThreshold 
		{
			get
			{
				return (trials[0].ResultingThreshold + trials[1].ResultingThreshold) / 2;
			}
		}


	}

}