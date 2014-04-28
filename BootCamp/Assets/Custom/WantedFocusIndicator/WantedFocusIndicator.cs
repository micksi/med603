using UnityEngine;
using System.Collections;

// As of now, hardcoded to use screen centre
public class WantedFocusIndicator : MonoBehaviour {

	private Material material;

	public Color Colour = new Color(0.5f, 0.5f, 0.5f, 1f);
	public float Radius = 6f;
	public float Thickness = 1f;

	// Use this for initialization
	void Start () {
		material = new Material(Shader.Find("Custom/DrawFocus"));
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