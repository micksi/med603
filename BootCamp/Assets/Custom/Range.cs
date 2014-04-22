using System;

namespace ThresholdFinding
{
	// TODO: Attempt optimisations in order to avoid unnecessary overhead
	public class Range
	{
		public readonly double Min, Max;
		public readonly int Resolution;


		public Range(double min, double max, int resolution = 10)
		{
			Min = min;
			Max = max;
			Resolution = resolution;
		}

		public void ToArray(ref double[] arr)
		{
			if(arr.Length != Resolution)
			{
				throw new InvalidOperationException("Supplied array length is not the same as Resolution");
			}
			double interval = Max - Min;
			double step = interval / (double) Resolution;
			for(int i = 0; i < Resolution; i++)
			{
				arr[i] = Min + i * step;
			}
			arr[Resolution - 1] = Max;
		}

		public double[] ToArray()
		{
			double[] arr = new double[Resolution];
			ToArray(ref arr);
			return arr;
		}

		public double Middle
		{
			get
			{
				return Min + Scale / 2;
			}
		}

		public double GetValue(int index)
		{
			if(index > Resolution || index < 0)
			{
				throw new InvalidOperationException("Cannot get value outside range");
			}
			if(index == 0)
			{
				return Min;
			}
			if(index == Resolution)
			{
				return Max;
			}
			return Min + index * Step;
		}

		public double Step
		{
			get
			{
				return Scale / (double) Resolution;
			}
		}

		public double Scale
		{
			get
			{
				return (Max - Min);
			}
		}

	}
}