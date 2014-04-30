using UnityEngine;
using System.Collections;

// Shows and wraps a neat modifiable circle at the centre of the screen.
// Can easily be generalized to centre the circle elsewhere.
public class WantedFocusIndicator : MonoBehaviour {

	public Color NormalColour = new Color(0.5f, 0.5f, 0.5f, 1f);
	public Color PositiveColour = new Color(0.0f, 0.812f, 0.0f, 1f); // Equal perceived brightness by Thorbjørn
	public Color NegativeColour = new Color(1.0f, 0.0f, 0.0f, 1f);
	public float Radius = 6f;
	public float Thickness = 1f;
	public Shader circleShader;

	private Material material = null;
	private Color currentColour;

	// Use this for initialization
	void Start () {
		material = new Material(circleShader);//Shader.Find("Custom/DrawFocus"));
		currentColour = NormalColour;
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Vector2 centre = FocusProvider.GetScreenCentre();

		material.SetColor("_Colour", currentColour);
		material.SetFloat("_Radius", Radius);
		material.SetFloat("_Thickness", Thickness);
		material.SetFloat("_X", centre.x);
		material.SetFloat("_Y", centre.y);

		Graphics.Blit(source, dest, material);
	}

	public void SetPositive()
	{
		currentColour = PositiveColour;
	}

	public void SetNegative()
	{
		currentColour = NegativeColour;
	}

	public void SetNormal()
	{
		currentColour = NormalColour;
	}
}