using System;
using System.Text;
using UnityEngine;

namespace ThresholdFinding
{
	public class ThresholdFinderTester : MonoBehaviour
	{

		void Start()
		{
			ThresholdFinderTester.Run();
			//ThresholdFinderTester.TestConstantStepTrial();
		}

		public static void Run()
		{
			const double min = 15.0f, max = 35.0f, step = 0.5f;
			const int trials = 2;
			const int reversals = 9;

			ITrialFactory factory = new InterleavedStaircaseTrialFactory(min, max, step, reversals);
			// ITrialFactory factory = new ConstantStepTrialFactory(min, max, step);
			// ITrialFactory factory = new StaircaseTrialFactory(min, max, step, reversals);
			ITrialStrategy strategy = new AlternatingTrialsStrategy(factory, trials);
			ThresholdFinder finder = new ThresholdFinder(strategy);

			const double realThresh = 25.0f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			// simulate
			while(finder.Finished == false)
			{
				double stimulus = finder.NextStimulus;
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
			finder.SaveObservationsToDisk();

		}

		public static void TestConstantStepTrial()
		{
			const double min = 0.0f, max = 100.0f, step = 3.0f;
			ConstantStepTrial trial = new ConstantStepTrial(false, min, max, step);

			const double realThresh = 40.0f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			double s = 0;
			while(trial.Finished == false)
			{
				s = trial.NextStimulus;
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

				// if(distance >= 0.0)
				// {
				// 	return true;
				// }
				// else
				// {
				// 	return false;
				// }
			}

			/*public bool ObserveStimulus(double stimuli)
			{
				double distance = stimuli - actualThreshold;
				double maxDistance = (max - actualThreshold);
				double safeDistancePercent = 0.4f;
				double safeDistance = safeDistancePercent * maxDistance;

				if(distance < 0)
				{
					return false;
				}
				if(distance > safeDistance)
				{
					return true;
				}

				double distanceNormalized = distance / (maxDistance - safeDistance);
				
				double chance = Mathf.Pow(distanceNormalized, 0.08f);
				chance *= sensitivity;
				//Debug.Log("Chance of detection at stimuli " + stimuli + ": " + chance);
				double rand = UnityEngine.Random.Range(0.0f, 1.0f);
				if(rand <= chance)
				{
					return true;
				}
				return false;
			}*/
		}

	}
}