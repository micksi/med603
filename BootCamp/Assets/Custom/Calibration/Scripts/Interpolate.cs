using UnityEngine;

public static class Interpolate
{	
	/// <param name="points">
	/// Array must be in anti-clockwise order BR, TR, TL, BL
	/// </param>
	public static Vector2 Bilinear(Vector2 p, Vector2[] points, Vector2[] values)
	{
		const int BR = 0;
		const int TR = 1;
		const int TL = 2;
		const int BL = 3;
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