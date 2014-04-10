namespace ThresholdFinding
{
	public interface ITrialFactory
	{
		Trial NewTrial(bool ascending);
	}

	public class ConstantStepTrialFactory : ITrialFactory
	{	

		private float min, max, step;

		public ConstantStepTrialFactory(float min, float max, float step)
		{
			this.min = min;
			this.max = max;
			this.step = step;
		}

		public Trial NewTrial(bool ascending)
		{
			return new ConstantStepTrial(ascending, min, max, step);
		}
	}

	public class StaircaseTrialFactory : ITrialFactory
	{	

		private float min, max, step;
		private int reversals;

		public StaircaseTrialFactory(float min, float max, float step, int reversals)
		{
			this.min = min;
			this.max = max;
			this.step = step;
			this.reversals = reversals;
		}
		
		public Trial NewTrial(bool ascending)
		{
			return new StaircaseTrial(ascending, min, max, step, reversals);
		}
	}
}