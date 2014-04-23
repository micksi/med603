using UnityEngine;
using System.Collections;
using System;

public class ExperimentIntro : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI()
	{
		float w = Width (0.8f);
		float h = Height (0.6f);

		GUI.Button(new Rect((Width() - w) / 2, (Height() - h) / 2, w, h), "Hello!");
	}

	public float Width(float p)
	{
		if(p < 0.0f || p > 1.0f)
		{
			throw new InvalidOperationException("p must be a percentage");
		}
		return p * Width();
	}

	public float Height(float p)
	{
		if(p < 0.0f || p > 1.0f)
		{
			throw new InvalidOperationException("p must be a percentage");
		}
		return p * Height();
	}

	public float Width()
	{
		return Screen.width;
	}

	public float Height()
	{
		return Screen.height;
	}

}
