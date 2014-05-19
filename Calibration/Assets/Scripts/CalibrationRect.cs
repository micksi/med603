using UnityEngine;

public class CalibrationRect
{

	public FocusPoint[] Points;

	/// <summary>
	/// a ----- b
	/// |       |
	/// |       |
	/// c ----- d
	/// </summary>
	public CalibrationRect(FocusPoint a, FocusPoint b, FocusPoint c, FocusPoint d)
	{
		Points = new FocusPoint[4];
		Points[0] = a;
		Points[1] = b;
		Points[2] = c;
		Points[3] = d;
		
	}

	public Vector2 A { get { return Points[0].ScreenPosition; }}
	public Vector2 B { get { return Points[1].ScreenPosition; }}
	public Vector2 C { get { return Points[2].ScreenPosition; }}
	public Vector2 D { get { return Points[3].ScreenPosition; }}

	public FocusPoint TL { get { return Points[0]; }}
	public FocusPoint TR { get { return Points[1]; }}
	public FocusPoint BL { get { return Points[2]; }}
	public FocusPoint BR { get { return Points[3]; }}

	/// <param name="p"> Screen position </param>
	public bool Contains(Vector2 p)
	{
		return
		(
			p.x >= A.x &&
			p.x < B.x &&
			p.y >= C.y &&
			p.y < A.y
		);
	}
}