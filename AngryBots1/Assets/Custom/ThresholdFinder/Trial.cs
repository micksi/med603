using System;
using System.Collections.Generic;
using System.Text;

namespace ThresholdFinding
{

	public abstract class Trial
	{
		public float Min {get; protected set;}
		public float Max {get; protected set;}
		
		private List<KeyValuePair<float, bool>> observations = new List<KeyValuePair<float, bool>>();


		public abstract bool Failed
		{
			get;
		}


		public virtual bool Finished
		{
			get;
			protected set;
		}

		public virtual List<KeyValuePair<float, bool>> GetObservations()
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

		protected void RecordObservation(float stimulus, bool value)
		{
			observations.Add(new KeyValuePair<float, bool>(stimulus, value));
		}

		public abstract bool ReportObservation(float stimulus, bool value);
		public abstract float NextStimulus {get;}
		public abstract float ResultingThreshold {get;}
	}
	
}