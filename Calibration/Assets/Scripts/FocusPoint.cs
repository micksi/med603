using UnityEngine;
using System;
using System.Collections;

public class OffsetRecordedEventArgs : EventArgs
{
	public readonly FocusOffsetRecord Record;
	public OffsetRecordedEventArgs(FocusOffsetRecord r)
	{
		Record = r;
	}
}

public class FocusPoint : MonoBehaviour
{
	public Vector2 Position;
	public Vector2 Inset;

	private FocusOffsetRecord record = null;

	private Camera _cam;
	private Camera cam
	{
		get
		{
			if(_cam == null)
				_cam = Camera.main;
			return _cam;
		}
	}

	public EventHandler<OffsetRecordedEventArgs> OffsetRecordedEvent;

	public Sprite ActiveSprite;
	public Sprite InactiveSprite;

	public bool Active
	{
		set
		{
			if(value)
			{
				GetComponent<SpriteRenderer>().sprite = ActiveSprite;
			}
			else
			{
				GetComponent<SpriteRenderer>().sprite = InactiveSprite;
			}
		}
		get { return (GetComponent<SpriteRenderer>().sprite == ActiveSprite); }
	}

	public void Awake()
	{
		Active = false;
	}

	public void StartRecordingOffset(FocusProvider.Source source)
	{
		StartCoroutine(RecordOffset(source));
	}

	public IEnumerator RecordOffset(FocusProvider.Source source)
	{
		if(record != null)
			throw new InvalidOperationException("Offset have already been recorded.");

		record = new FocusOffsetRecord(this);

		float startTime = Time.time;
		float duration = 1.0f;
		record = new FocusOffsetRecord(this.ScreenPosition);
		do
		{
			Vector2 offset = this.GetFocusOffset(FocusProvider.GetFocusPosition(source));
			record.ReportOffset(offset);

			yield return true;
		} while (Time.time - startTime < duration);

		if(OffsetRecordedEvent != null)
			OffsetRecordedEvent(this, new OffsetRecordedEventArgs(record));
	}

	/// <param name="gazePos"> Gaze position in screen coordinates</param>
	/// <returns>Vector2 offset from focuspoint to focus position in screen coordinates</returns>
	public Vector2 GetFocusOffset(Vector2 gazePos)
	{
		return gazePos - ScreenPosition;
	}

	public Vector2 ScreenPosition
	{
		get { return ((Vector2)cam.WorldToScreenPoint(transform.position)); }
	}

	public Sprite sprite
	{
		get { return GetComponent<SpriteRenderer>().sprite; }
	}

	public Bounds bounds
	{
		get { return sprite.bounds; }
	}

}