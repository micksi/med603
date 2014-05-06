using UnityEngine;
using System.Collections;

// Generates random values from custom distributions
public static class CustomRandom {

	private static Vector2 CentralLimitV(int count)
	{
		return new Vector2(CentralLimit(count), CentralLimit(count));
	}

	private static float CentralLimit(int count)
	{
		double v = 0.0;

		for(int i = 0; i < count; i++)
		{
			v += Random.Range(-1f,1f);
		}

		v /= count;

		return (float)v;
	}
	
	public static bool IsInsideScreenArea(Vector2 point)
	{
		if(point.x < 0 || point.y < 0)
			return false;

		Vector2 screenRes = FocusProvider.GetScreenResolution();
		if(point.x >= screenRes.x || point.y > screenRes.y)
			return false;

		return true;
	}

	public static Vector2 GenerateScreenPoint()
	{
		Vector2 raw;
		Vector2 screenSpace;
		do
		{
			raw = CentralLimitV(8);
			screenSpace = ConvertToCenteredScreenSpace(raw, true);
		}
		while(IsInsideScreenArea(screenSpace) == false);

		return screenSpace;
	}

	public static Vector2 GenerateEdgeThirdPoint()
	{
		Vector2 screenSize = FocusProvider.GetScreenResolution();
		float x;
		float y;

		if(Random.value > 0.5)
		{
			x = Random.Range(0f, screenSize.x/3);
		}
		else
		{
			x = Random.Range(2 * screenSize.x/3, screenSize.x);
		}

		if(Random.value > 0.5)
		{
			y = Random.Range(0f, screenSize.y/3);
		}
		else
		{
			y = Random.Range(2 * screenSize.y/3, screenSize.y);
		}

		return new Vector2(x,y);
	}

	// May overflow edge of screen
	// Assumes p.x, p.y are in range [-1;1]
	private static Vector2 ConvertToCenteredScreenSpace(Vector2 p, bool aspectIndependent)
	{
		Vector2 screenRes = FocusProvider.GetScreenResolution();

		float aspect = aspectIndependent ? screenRes.x / screenRes.y : 1f;
		float rangeX =          screenRes.x / 2;
		float rangeY = aspect * screenRes.y / 2;

		return (new Vector2(rangeX * p.x, rangeY * p.y)) + screenRes / 2;
	}
}
