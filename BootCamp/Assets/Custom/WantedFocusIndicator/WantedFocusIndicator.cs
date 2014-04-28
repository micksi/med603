using UnityEngine;
using System.Collections;

public class WantedFocusIndicator : MonoBehaviour {

	private Material material;

	public Color Colour = new Color(0.5f, 0.5f, 0.5f, 1f);
	public float Radius = 6f;
	public float Thickness = 1f;
	public float CentreX = 0;
	public float CentreY = 0;

	// Use this for initialization
	void Start () {
		material = new Material(Shader.Find("Custom/DrawFocus"));
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Vector2 centre = FocusProvider.GetScreenCentre();
		CentreX = centre.x;
		CentreY = centre.y;

		material.SetColor("_Colour", Colour);
		material.SetFloat("_Radius", Radius);
		material.SetFloat("_Thickness", Thickness);
		material.SetFloat("_X", CentreX);
		material.SetFloat("_Y", CentreY);

		Graphics.Blit(source, dest, material);
	}
}