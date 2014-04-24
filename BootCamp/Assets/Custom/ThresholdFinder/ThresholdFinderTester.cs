using System;
using System.Text;
using UnityEngine;

namespace ThresholdFinding
{
	public class ThresholdFinderTester : MonoBehaviour
	{

		void Start()
		{
			//ThresholdFinderTester.Run();
			ThresholdFinderTester.TestBestPest();
			// ThresholdFinderTester.TestConstantStepTrial();
		}

		public static void Run()
		{
			const double min = 0.0, max = 1.0;
			const int trials = 2, resolution = 20;
			const int reversals = 9;
			const double steepness = 2.0; // for bestPEST;
			const int nStimuli = 10; // for bestPEST;
			Range range = new Range(min, max, resolution);
			// ITrialFactory factory = new InterleavedStaircaseTrialFactory(range, reversals);
			// ITrialFactory factory = new ConstantStepTrialFactory(range);
			// ITrialFactory factory = new StaircaseTrialFactory(range, reversals);
			ITrialFactory factory = new BestPestTrialFactory(range, steepness, nStimuli);
			ITrialStrategy strategy = new AlternatingTrialsStrategy(factory, trials);
			ThresholdFinder finder = new ThresholdFinder(strategy);

			const double realThresh = 0.5f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			// simulate
			while(finder.Finished == false)
			{
				double stimulus = finder.Stimulus;
				bool observation = subject.ObserveStimulus(stimulus);
				//Debug.Log("Observer observed " + observation + " at stimulus " + stimulus + 
				//	" in " + ((finder.CurrentTrial as ConstantStepTrial).ascending ? "ascending" : "descending") + " trial");
				finder.ReportObservation(stimulus, observation);
			}

			// Print results
			double threshold = finder.GetThreshold();
			Debug.Log("Threshold: " + threshold);

			double[] thresholds = finder.GetThresholds();
			StringBuilder sb = new StringBuilder();
			for(int i = 0; i < thresholds.Length; i++)
			{
				sb.Append(thresholds[i]).Append(", ");
			}
			Debug.Log("Thresholds:\n" + sb.ToString());
			finder.SaveObservationsToDisk(finder.GetDefaultOutputDirectory());

		}

		public static void TestBestPest()
		{
			const int len = 10;
			bool[] r = new bool[len] { true, false, true, false, true, true, false, false, true, false };
			const double steepness = 2.0;


			Range range = new Range(0.0, 1.0, 20);
			ITrialFactory factory = new BestPestTrialFactory(range, steepness, len);
			ITrialStrategy strategy = new AlternatingTrialsStrategy(factory, 1);
			ThresholdFinder finder = new ThresholdFinder(strategy);

			for(int i = 0; i < len && finder.Finished == false; i++)
			{
				double s = finder.Stimulus;
				finder.ReportObservation(s, r[i]);
			}
			finder.SaveObservationsToDisk(finder.GetDefaultOutputDirectory());
		}

		public static void TestConstantStepTrial()
		{
			const double min = 0.0f, max = 100.0f;
			const int resolution = 10;
			ConstantStepTrial trial = new ConstantStepTrial(false, new Range(min, max, resolution));

			const double realThresh = 40.0f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			double s = 0;
			while(trial.Finished == false)
			{
				s = trial.Stimulus;
				bool v = subject.ObserveStimulus(s);
				trial.ReportObservation(s, v);
			}
			Debug.Log("Stimulus: " + s);
		}

		private class Observer
		{
			private double actualThreshold, sensitivity, min, max;

			public Observer(double actualThreshold, double sensitivity, double min, double max)
			{
				this.actualThreshold = actualThreshold;
				this.sensitivity = sensitivity;
				this.min = min;
				this.max = max;
				if(sensitivity <= 0.0f)
				{
					throw new ArgumentException("Sensitivity must be above 0");
				}
			}

			public bool ObserveStimulus(double stimulus)
			{
				double normalizedThreshold = actualThreshold / (max + min);
				double normalizedStimulus = stimulus / (max + min);
				double distance = normalizedStimulus - normalizedThreshold;

				Func<double, double> sigmoid = x => 1 / (1 + Math.Exp(-6*x));
				double chance = sigmoid(distance * 6);
				
				Debug.Log("Chance of detection: " + chance);

				double rand = UnityEngine.Random.Range(0f, 0.99999f);
				bool result = (rand < chance);
				Debug.Log("Observer perceived " + result + " at stimulus " + stimulus);
				return result;

			}

			
		}

	}
}