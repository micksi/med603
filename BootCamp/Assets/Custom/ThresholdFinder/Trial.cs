using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	public abstract class Trial
	{
		
		private List<KeyValuePair<double, bool>> observations = new List<KeyValuePair<double, bool>>();
		public readonly Range Range;

		public double Min {get { return Range.Min; }}
		public double Max {get { return Range.Max; }}
		
		public Trial(Range range)	
		{
			this.Range = range;
		}

		public abstract bool Failed
		{
			get;
		}


		public virtual bool Finished
		{
			get;
			protected set;
		}

		public virtual List<KeyValuePair<double, bool>> GetObservations()
		{
			return observations;
		}

		public virtual string GetObservationsAsString(string del=",")
		{
			StringBuilder sb = new StringBuilder();
			foreach(var pair in observations)
			{
				sb.Append(pair.Key)
					.Append(del)
					.Append(pair.Value ? "1" : "-1")
					.Append(Environment.NewLine);
			}
			return sb.ToString();
		}

		public virtual void WriteObservationsToFile(string fileName)
		{
			string content = "Stimulus, Value" + Environment.NewLine;
			content = content + GetObservationsAsString();
			System.IO.File.WriteAllText(fileName, content, Encoding.ASCII);
		}

		protected virtual void RecordObservation(double stimulus, bool value)
		{
			observations.Add(new KeyValuePair<double, bool>(stimulus, value));
		}

		public virtual bool ReportObservation(double stimulus, bool value)
		{
			if(Finished)
			{
				throw new InvalidOperationException("Please don't report observations when the trial is finished.");
			}
			
			if(Failed)
			{
				throw new InvalidOperationException("Please don't report observations when the trial has failed.");
			}

			return false; // Because it has to return something, and nobody cares what it is.
		}

		public abstract double Stimulus {get;}
		public abstract double ResultingThreshold {get;}
	}
	
}