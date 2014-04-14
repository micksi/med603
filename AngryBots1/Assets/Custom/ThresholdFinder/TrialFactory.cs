namespace ThresholdFinding
{
	public interface ITrialFactory
	{
		Trial NewTrial(bool ascending);
	}

	public class ConstantStepTrialFactory : ITrialFactory
	{	

		private double min, max, step;

		public ConstantStepTrialFactory(double min, double max, double step)
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

		private double min, max, step;
		private int reversals;

		public StaircaseTrialFactory(double min, double max, double step, int reversals)
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

	public class InterleavedStaircaseTrialFactory : ITrialFactory
	{
		private double min, max, step;
		private int reversals;

		public InterleavedStaircaseTrialFactory(double min, double max, double step, int reversals)
		{
			this.min = min;
			this.max = max;
			this.step = step;
			this.reversals = reversals;
		}
		
		public Trial NewTrial(bool ascending)
		{
			return new InterleavedStaircaseTrial(ascending, min, max, step, reversals);
		}	
	}
}