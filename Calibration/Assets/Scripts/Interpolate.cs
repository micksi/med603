using UnityEngine;

public static class Interpolate
{	
	/// <param name="points">
	/// Array must be in anti-clockwise order BR, TR, TL, BL
	/// </param>
	public static Vector2 Bilinear(Vector2 p, Vector2[] points, Vector2[] values)
	{
		int BR, TR, TL, BL;
		BR = TR = TL = BL = -1;
		for(int i = 0; i < 4; i++)
		{
			Vector2 q = points[i];
			if(q.x >= p.x) // To the right of point
			{
				if(q.y >= p.y) // Above point
					TR = i;
				else // below point
					BR = i;
			}
			else // left of point
			{
				if(q.y >= p.y) // Above point
					TL = i;
				else // below point
					BL = i;
			}
		}
		if(BR == -1 || TR == -1 || TL == -1 || BL == -1)
			throw new System.InvalidOperationException("Points not ordered properly");

		float x = p.x,
		      y = p.y,
			  x1 = points[TL].x,
			  x2 = points[TR].x,
			  y1 = points[BL].y,
			  y2 = points[TL].y;

		Vector2 f_R1 = ((x2 - x) / (x2 - x1)) * values[BL] + ((x - x1) / (x2 - x1)) * values[BR];
		Vector2 f_R2 = ((x2 - x) / (x2 - x1)) * values[TL] + ((x - x1) / (x2 - x1)) * values[TR];
		Vector2 f_P = ((y2 - y) / (y2 - y1)) * f_R1 + ((y - y1) / (y2 - y1)) * f_R2;

		return f_P;
	}
}