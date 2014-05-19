using UnityEngine;
using System.Collections;
using System;

public class Calibrator : MonoBehaviour
{

	private FocusPoint[] focusPoints;

	private int index = 0;
	public KeyCode ReportKey;

	public FocusProvider.Source Source;

	public EventHandler<EventArgs> FinishedEvent;

	private Camera cam;

	private FocusOffsetRecord[] records;
	private Vector2[] offsets;

	private enum Place {TL, TM, TR, ML, MM, MR, BL, BM, BR};
	private CalibrationRect[] rects = new CalibrationRect[4];

	void Start()
	{
		cam = Camera.main;
		GameObject[] fps = GameObject.FindGameObjectsWithTag("FocusPoint");

		if(fps.Length < 1)
		{
			throw new InvalidOperationException("No FocusPoints found!");
		}

		records = new FocusOffsetRecord[fps.Length];
		offsets = new Vector2[fps.Length];
		focusPoints = new FocusPoint[fps.Length];
		for(int i = 0; i < fps.Length; i++)
		{
			focusPoints[i] = fps[i].GetComponent<FocusPoint>();
			focusPoints[i].OffsetRecordedEvent += (sender, args) =>
			{
				CurrentFocusPoint.Active = false;

				records[index] = args.Record;
				offsets[index] = args.Record.Offset;

				if(index == focusPoints.Length - 1) // Finishing
				{
					if(FinishedEvent != null)
						FinishedEvent(this, new EventArgs());
					index++;
				}	
				else
				{
					index++;
					CurrentFocusPoint.Active = true;
				}

				print("Offset: " + args.Record.Offset);
			};
		}

		Array.Sort(focusPoints, (a, b) => {
			return a.gameObject.name.CompareTo(b.gameObject.name);
		});

		rects[0] = new CalibrationRect(
			focusPoints[(int)Place.TL],
			focusPoints[(int)Place.TM],
			focusPoints[(int)Place.ML],
			focusPoints[(int)Place.MM]);

		rects[1] = new CalibrationRect(
			focusPoints[(int)Place.TM],
			focusPoints[(int)Place.TR],
			focusPoints[(int)Place.MM],
			focusPoints[(int)Place.MR]);

		rects[2] = new CalibrationRect(
			focusPoints[(int)Place.ML],
			focusPoints[(int)Place.MM],
			focusPoints[(int)Place.BL],
			focusPoints[(int)Place.BM]);

		rects[3] = new CalibrationRect(
			focusPoints[(int)Place.MM],
			focusPoints[(int)Place.MR],
			focusPoints[(int)Place.BM],
			focusPoints[(int)Place.BR]);


		LayoutFocusPoints();
		CurrentFocusPoint.Active = true;
	}
	
	

	void Update()
	{
		if(focusPoints == null)
			return;

		
		if(false && Finished == false)
		{
			if(Input.GetKeyDown(ReportKey))
			{
				CurrentFocusPoint.StartRecordingOffset(Source);
			}
			Debug.DrawLine(
				cam.ScreenToWorldPoint((Vector3)GetFocusPosition() + Vector3.forward),
				cam.ScreenToWorldPoint((Vector3)CurrentFocusPoint.ScreenPosition + Vector3.forward),
				Color.red);
		}
		else
		{

			foreach(var point in focusPoints)
				point.Active = false;

			Vector2 fp = GetFocusPosition();
			
			if(fp == null) return;

			foreach(var rect in rects)
			{
				if(rect.Contains(fp))
				{
					foreach(var p in rect.Points)
					{
						p.Active = true;
					}
				}
			}
		}

		if(Input.GetKeyDown("d"))
		{
			LayoutFocusPoints();
		}
	}

	private void Correct()
	{
		Vector2 fp = GetFocusPosition();
		Vector2[] refPoints = GetReferencePoints(records, fp);
		Vector2 offset = Interpolate.Bilinear(fp, refPoints, offsets);
		Vector2 offsetPos = fp + offset;
		Debug.DrawLine(
			cam.ScreenToWorldPoint((Vector3)fp) + Vector3.forward,
			cam.ScreenToWorldPoint((Vector3)offsetPos) + Vector3.forward,
			Color.red);
	}

	[Obsolete("Uses lambda method instead")]
	private class DistanceComparer : System.Collections.Generic.IComparer<Vector2>
	{
		public Vector2 pos;
		public DistanceComparer(Vector2 pos)
		{
			this.pos = pos;
		}

		public int Compare(Vector2 a, Vector2 b)
		{
			float adist = Vector2.Distance(a, pos);
			float bdist = Vector2.Distance(b, pos);
			return adist.CompareTo(bdist);
		}
	}

	private Vector2[] GetReferencePoints(FocusOffsetRecord[] records, Vector2 pos)
	{
		Vector2[] result = new Vector2[records.Length];
		for(int i = 0; i < records.Length; i++)
		{
			result[i] = records[i].ReferencePoint;
		}
		// Array.Sort(result, new DistanceComparer(pos));
		Array.Sort(result, (a, b) =>
			{
				float adist = Vector2.Distance(a, pos);
				float bdist = Vector2.Distance(b, pos);
				return adist.CompareTo(bdist);		
			}
		);
		return result;
	}

	

	public FocusPoint CurrentFocusPoint
	{
		get { return focusPoints[index]; }
	}

	public bool Finished
	{
		get { return (index >= focusPoints.Length); }
	}

	public void LayoutFocusPoints()
	{
		foreach(var fp in focusPoints)
		{
			
			Vector3 pos = new Vector3(fp.Position.x, fp.Position.y, 1); // z = 0 makes them invisible
			Vector3 worldPos = cam.ViewportToWorldPoint(pos);
			Vector3 worldOffset = Vector3.Scale(fp.sprite.bounds.size, ((Vector3)(fp.Inset)));

			print("worldPos: " + worldPos + ", worldOffset: " + worldOffset);

			fp.transform.position =  worldPos + worldOffset;

		}
	}

	public Vector2 GetFocusPosition()
	{
		switch(Source)
		{
			case FocusProvider.Source.Mouse:
				return FocusProvider.GetMousePosition();
			case FocusProvider.Source.ScreenCentre:
				return FocusProvider.GetScreenCentre();
			case FocusProvider.Source.Gaze:
				return FocusProvider.GetGazePosition();
			default:
				return new Vector2(-1, -1);
		}
	}
}
