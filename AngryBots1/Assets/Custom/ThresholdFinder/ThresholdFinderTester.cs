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
			const float min = 15.0f, max = 35.0f, step = 0.5f;
			const int trials = 2;
			const int reversals = 9;

			ITrialFactory factory = new InterleavedStaircaseTrialFactory(min, max, step, reversals);
			// ITrialFactory factory = new ConstantStepTrialFactory(min, max, step);
			// ITrialFactory factory = new StaircaseTrialFactory(min, max, step, reversals);
			ITrialStrategy strategy = new AlternatingTrialsStrategy(factory, trials);
			ThresholdFinder finder = new ThresholdFinder(strategy);

			const float realThresh = 25.0f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			// simulate
			while(finder.Finished == false)
			{
				float stimulus = finder.NextStimulus;
				bool observation = subject.ObserveStimulus(stimulus);
				//Debug.Log("Observer observed " + observation + " at stimulus " + stimulus + 
				//	" in " + ((finder.CurrentTrial as ConstantStepTrial).ascending ? "ascending" : "descending") + " trial");
				finder.ReportObservation(stimulus, observation);
			}

			// Print results
			float threshold = finder.GetThreshold();
			Debug.Log("Threshold: " + threshold);

			float[] thresholds = finder.GetThresholds();
			StringBuilder sb = new StringBuilder();
			for(int i = 0; i < thresholds.Length; i++)
			{
				sb.Append(thresholds[i]).Append(", ");
			}
			Debug.Log("Thresholds:\n" + sb.ToString());

		}

		public static void TestConstantStepTrial()
		{
			const float min = 0.0f, max = 100.0f, step = 3.0f;
			ConstantStepTrial trial = new ConstantStepTrial(false, min, max, step);

			const float realThresh = 40.0f, sensitivity = 1.0f;
			Observer subject = new Observer(realThresh, sensitivity, min, max);

			float s = 0;
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
			private float actualThreshold, sensitivity, min, max;

			public Observer(float actualThreshold, float sensitivity, float min, float max)
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

			public bool ObserveStimulus(float stimulus)
			{
				float normalizedThreshold = actualThreshold / (max + min);
				float normalizedStimulus = stimulus / (max + min);
				float distance = normalizedStimulus - normalizedThreshold;

				Func<float, float> sigmoid = x => 1 / (1 + Mathf.Exp(-6*x));
				float chance = sigmoid(distance * 6);
				
				Debug.Log("Chance of detection: " + chance);

				float rand = UnityEngine.Random.Range(0f, 0.99999f);
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

			/*public bool ObserveStimulus(float stimuli)
			{
				float distance = stimuli - actualThreshold;
				float maxDistance = (max - actualThreshold);
				float safeDistancePercent = 0.4f;
				float safeDistance = safeDistancePercent * maxDistance;

				if(distance < 0)
				{
					return false;
				}
				if(distance > safeDistance)
				{
					return true;
				}

				float distanceNormalized = distance / (maxDistance - safeDistance);
				
				float chance = Mathf.Pow(distanceNormalized, 0.08f);
				chance *= sensitivity;
				//Debug.Log("Chance of detection at stimuli " + stimuli + ": " + chance);
				float rand = UnityEngine.Random.Range(0.0f, 1.0f);
				if(rand <= chance)
				{
					return true;
				}
				return false;
			}*/
		}

	}
}