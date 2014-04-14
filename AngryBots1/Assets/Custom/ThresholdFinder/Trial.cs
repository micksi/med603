using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	public abstract class Trial
	{
		public double Min {get; protected set;}
		public double Max {get; protected set;}
		
		private List<KeyValuePair<double, bool>> observations = new List<KeyValuePair<double, bool>>();


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
					.Append(Convert.ToInt32(pair.Value))
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

		protected void RecordObservation(double stimulus, bool value)
		{
			observations.Add(new KeyValuePair<double, bool>(stimulus, value));
		}

		public abstract bool ReportObservation(double stimulus, bool value);
		public abstract double NextStimulus {get;}
		public abstract double ResultingThreshold {get;}
	}
	
}