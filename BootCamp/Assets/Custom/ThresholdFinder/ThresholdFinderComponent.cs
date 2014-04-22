using System;
using System.Collections.Generic;
using UnityEngine;
using ThresholdFinding;

public class ThresholdFinderComponent : MonoBehaviour
{

	public enum TrialType {ConstantStep, Staircase, InterleavedStaircase, BestPEST};
	public enum StrategyType {Alternating};

	public TrialType trialType = TrialType.ConstantStep;
	public StrategyType strategyType = StrategyType.Alternating;

	public double min = 0.0f;
	public double max = 1.0f;
	public int resolution = 10;
	public int trials = 2;
	public int StairCase_reversals = 9; // Only used with trials of type Staircase and InterleavedStaircase
	public double BestPEST_steepness = 2.0; // Only used with BestPEST
	public int BestPEST_Stimuli = 10; // Only used with BestPEST

	public string positiveKey = "y";
	public string negativeKey = "n";

	public double Stimulus
	{
		get;
		private set;
	}

	[HideInInspector]
	public ThresholdFinder Finder
	{
		get;
		private set;
	}

	public void Awake()
	{
		ITrialFactory factory = null;
		Range range = new Range(min, max, resolution);
		switch(trialType)
		{
			case TrialType.InterleavedStaircase:
				factory = new InterleavedStaircaseTrialFactory(range, StairCase_reversals);
				break;
			case TrialType.ConstantStep:
				factory = new ConstantStepTrialFactory(range);
				break;
			case TrialType.Staircase:
				factory = new StaircaseTrialFactory(range, StairCase_reversals);
				break;
			case TrialType.BestPEST:
				factory = new BestPestTrialFactory(range, BestPEST_steepness, BestPEST_Stimuli);
				break;
			default:
				factory = new ConstantStepTrialFactory(range);
				break;
		}
		// Alternating is the only strategy thus far
		ITrialStrategy strategy = new AlternatingTrialsStrategy(factory, trials);
		Finder = new ThresholdFinder(strategy);
		Finder.FinishedEvent += OnFinished;
	}

	private void OnFinished(object sender, FinishedEventArgs args)
	{
		Finder.SaveObservationsToDisk();
		Debug.Log("Experiment finished!");
	}

	public void Start()
	{
		Stimulus = Finder.Stimulus;
	}

	public void Update()
	{
		if(Finder.Finished)
		{
			return;
		}

		if(Input.GetKeyDown(positiveKey))
		{
			ReportObservation(Stimulus, true);
		}
		else if(Input.GetKeyDown(negativeKey))
		{
			ReportObservation(Stimulus, false);
		}
		
	}

	private void ReportObservation(double stimulus, bool observation)
	{
		Finder.ReportObservation(stimulus, observation);
		if(Finder.Finished == false)
			Stimulus = Finder.Stimulus;
		Debug.Log(observation + " was observed at stimulus " + stimulus);
		Debug.Log("Next stimulus is " + Stimulus);
	}

}