using System;
using System.Collections.Generic;
using UnityEngine;

namespace ThresholdFinding
{
	

	public class AlternatingTrialsStrategy : ITrialStrategy
	{

		private ITrialFactory factory;
		private int count;

		public AlternatingTrialsStrategy(ITrialFactory factory, int count)
		{
			this.factory = factory;
			this.count = count;
		}

		public Trial[] GenerateTrials()
		{
			Trial[] trials = new Trial[count];
			for(int i = 0; i < count; i++)
			{
				trials[i] = factory.NewTrial((i % 2 == 0));
			}
			return trials;
		}

	}
}