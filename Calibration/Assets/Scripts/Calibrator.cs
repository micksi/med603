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

	void Start()
	{
		cam = Camera.main;
		GameObject[] fps = GameObject.FindGameObjectsWithTag("FocusPoint");

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

		if(focusPoints.Length < 1)
		{
			throw new InvalidOperationException("No FocusPoints found!");
		}

		LayoutFocusPoints();
		CurrentFocusPoint.Active = true;
	}
	
	void Update()
	{
		if(focusPoints == null)
			return;

		
		if(Finished == false)
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
			Vector2 offset = Interpolate.Bilinear(GetFocusPosition(), GetReferencePoints(records), offsets);
			Vector2 offsetPos = GetFocusPosition() + offset;
			Debug.DrawLine(
				cam.ScreenToWorldPoint((Vector3)GetFocusPosition()) + Vector3.forward,
				cam.ScreenToWorldPoint((Vector3)offsetPos) + Vector3.forward,
				Color.red);
		}

		if(Input.GetKeyDown("d"))
		{
			LayoutFocusPoints();
		}
	}

	private Vector2[] GetReferencePoints(FocusOffsetRecord[] records)
	{
		Vector2[] result = new Vector2[records.Length];
		for(int i = 0; i < records.Length; i++)
		{
			result[i] = records[i].ReferencePoint;
		}
		return result;
	}

	

	public FocusPoint CurrentFocusPoint
	{
		get
		{
			return focusPoints[index];
		}
	}

	public bool Finished
	{
		get
		{
			return (index >= focusPoints.Length);
		}
	}

	public void LayoutFocusPoints()
	{
		foreach(var fp in focusPoints)
		{
			
			Vector3 pos = new Vector3(fp.Position.x, fp.Position.y, 1); // z = 0 makes them invisible
			Vector3 worldPos = cam.ViewportToWorldPoint(pos);
			Vector3 worldOffset = Vector3.Scale(fp.sprite.bounds.size, ((Vector3)(fp.Offset)));

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
