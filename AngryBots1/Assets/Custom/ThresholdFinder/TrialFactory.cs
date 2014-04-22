namespace ThresholdFinding
{
	public interface ITrialFactory
	{
		Trial NewTrial(bool ascending);
	}

	public abstract class TrialFactory : ITrialFactory
	{
		protected readonly Range range;

		public TrialFactory(Range range)
		{
			this.range = range;
		}

		public abstract Trial NewTrial(bool ascending);
	}

	public class ConstantStepTrialFactory : TrialFactory
	{	


		public ConstantStepTrialFactory(Range range) : base(range)
		{
			
		}

		public override Trial NewTrial(bool ascending)
		{
			return new ConstantStepTrial(ascending, range);
		}
	}

	public class StaircaseTrialFactory : TrialFactory
	{	

		private int reversals;

		public StaircaseTrialFactory(Range range, int reversals) : base(range)
		{
			this.reversals = reversals;
		}
		
		public override Trial NewTrial(bool ascending)
		{
			return new StaircaseTrial(ascending, range, reversals);
		}
	}

	public class InterleavedStaircaseTrialFactory : TrialFactory
	{
		private int reversals;

		public InterleavedStaircaseTrialFactory(Range range, int reversals) : base(range)
		{
			this.reversals = reversals;
		}
		
		public override Trial NewTrial(bool ascending)
		{
			return new InterleavedStaircaseTrial(ascending, range, reversals);
		}	
	}

	public class BestPestTrialFactory : TrialFactory
	{

		private readonly int nStimuli;
		private readonly double steepness;

		public BestPestTrialFactory(Range range, double steepness, int nStimuli) : base(range)
		{
			this.nStimuli = nStimuli;
			this.steepness = steepness;
		}

		public override Trial NewTrial(bool ascending)
		{
			return new BestPestTrial(ascending, range, steepness, nStimuli);
		}	
	}
}