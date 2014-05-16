using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class FocusOffsetRecord
{
	public readonly Vector2 ReferencePoint;
	private List<Vector2> offsets;

	private Vector2 offset;
	private bool cached = false;
	public Vector2 Offset
	{
		get
		{
			if(cached == false)
				offset = CalcOffset();
			cached = true;
			return offset;
		}
	}

	public FocusOffsetRecord(FocusPoint fp) : this(fp.ScreenPosition)
	{

	}

	public FocusOffsetRecord(Vector2 reference)
	{
		ReferencePoint = reference;
		offsets = new List<Vector2>();
	}

	public void ReportOffset(Vector2 o)
	{
		offsets.Add(o);
	}

	public Vector2 CalcOffset()
	{
		Vector2 result = new Vector2(0.0f, 0.0f);
		foreach(var o in offsets)
		{
			result = result + o;
		}

		result = result / offsets.Count;
		return result;
	}

}