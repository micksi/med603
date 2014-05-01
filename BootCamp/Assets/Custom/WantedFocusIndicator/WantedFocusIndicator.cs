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
	public Vector2 centre;

	private Material material = null;
	private Color currentColour;

	private Vector2 lerpTarget;
	private bool lerping = false;
	private float lerpDuration;
	private float lerpTimeLeft;

	// Use this for initialization
	void Start () {
		material = new Material(circleShader);//Shader.Find("Custom/DrawFocus"));
		currentColour = NormalColour;
	}

	public void LerpTo(Vector2 target, float durationSeconds)
	{
		print("Lerp from " + centre + " to " + target + " in " + durationSeconds + " s.");
		this.lerpTarget = target;
		this.lerpDuration = this.lerpTimeLeft = durationSeconds;
		lerping = true;
	}

	void Update()
	{
		if(lerpTimeLeft > 0)
		{
			lerpTimeLeft -= Time.deltaTime;
		}
		else if(lerping)
		{
			lerping = false;
			centre = lerpTarget;
		}
	}

	private Vector2 Lerp()
	{
		return Vector2.Lerp(centre, lerpTarget, 1 - (lerpTimeLeft / lerpDuration));
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		//Vector2 centre = FocusProvider.GetScreenCentre();
		Vector2 position = lerping ? Lerp() : centre;

		material.SetColor("_Colour", currentColour);
		material.SetFloat("_Radius", Radius);
		material.SetFloat("_Thickness", Thickness);
		material.SetFloat("_X", position.x);
		material.SetFloat("_Y", position.y);

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