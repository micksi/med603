﻿using UnityEngine;
using System.Collections;

// Shows and wraps a neat modifiable circle at the centre of the screen.
// Can easily be generalized to centre the circle elsewhere.
public class WantedFocusIndicator : MonoBehaviour {

	public Color Colour = new Color(0.5f, 0.5f, 0.5f, 1f);
	public float Radius = 6f;
	public float Thickness = 1f;
	public Shader circleShader;

	private Material material = null;

	// Use this for initialization
	void Start () {
		material = new Material(circleShader);//Shader.Find("Custom/DrawFocus"));
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Vector2 centre = FocusProvider.GetScreenCentre();

		material.SetColor("_Colour", Colour);
		material.SetFloat("_Radius", Radius);
		material.SetFloat("_Thickness", Thickness);
		material.SetFloat("_X", centre.x);
		material.SetFloat("_Y", centre.y);

		Graphics.Blit(source, dest, material);
	}
}