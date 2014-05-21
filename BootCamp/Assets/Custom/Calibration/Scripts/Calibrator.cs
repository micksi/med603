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

	private UI ui;

	void Start()
	{
		cam = Camera.main;
		ui = new UI(this);
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
		if(focusPoints == null || ui.ShowInstructions)
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
		else if(ui.Loading == null)
		{
			if(Input.GetKeyDown(ReportKey))
			{
				ui.Loading = Application.LoadLevelAsync("Experiment2");
				ui.ShowLoading = true;
			}
			Vector2 offset = Interpolate.Bilinear(GetFocusPosition(), GetReferencePoints(records), offsets);
			Vector2 offsetPos = GetFocusPosition() - offset;
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

	private void OnGUI()
	{
		ui.Draw();
	}

	public class UI
	{

		public bool ShowInstructions = true;
		public bool ShowLoading = false;
		private Calibrator calibrator;
		public AsyncOperation Loading = null;

		public UI(Calibrator calibrator)
		{
			this.calibrator = calibrator;
		}

		public void Draw()
		{
			if(ShowInstructions)
			{
				string instructions = String.Format(
@"Welcome to the eyetracker calibration procedure.
Please look at the green marker.
When you have focused on it, press '{0}'.
Keep focusing for a second, and the next marker will be highlighted.
Focus on that, and repeat the steps until no marker is highlighted.
Press '{0}' once again to proceed.
Click here to start the procedure.", calibrator.ReportKey);

				if(GUI.Button(CenteredRect(.5f, .5f), instructions))
				{
					Debug.Log("Clicked!");
					ShowInstructions = false;
				}
				
			}
			else if(ShowLoading && Loading != null && Loading.isDone == false)
			{
				GUI.Button(CenteredRect(.2f, .2f), "Loading next procedure...");
			}
		}

		public float Width(float r) { return Screen.width * r; }
		public float Height(float r) { return Screen.height * r; }

		public Rect CenteredRect(float w, float h)
		{
			return new Rect(Width(.5f) - Width(w/2f), Height(.5f) - Height(h/2f), Width(w), Height(h));
		}
	}
}


