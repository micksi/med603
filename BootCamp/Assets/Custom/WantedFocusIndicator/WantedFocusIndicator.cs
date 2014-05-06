using UnityEngine;
using System.Collections;

// Shows and wraps a neat modifiable circle at the centre of the screen.
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

	private float abnormalColourDuration;
	private bool isAbnormal = false;

	public bool lerpRandomly = false;


	// Use this for initialization
	void Start () {
		material = new Material(circleShader);
		currentColour = NormalColour;
	}

	public void LerpTo(Vector2 target, float durationSeconds)
	{
		//print("Lerp from " + centre + " to " + target + " in " + durationSeconds + " s.");
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

		if(isAbnormal)
		{
			abnormalColourDuration -= Time.deltaTime;
			if(abnormalColourDuration <= 0f)
			{
				isAbnormal = false;
				SetNormal();
			}
		}

		if(lerpRandomly && (lerping == false))
		{
			LerpTo(CustomRandom.GenerateEdgeThirdPoint(), Random.Range(1f, 3f));
		}
	}

	private Vector2 Lerp()
	{
		return Vector2.Lerp(centre, lerpTarget, 1 - (lerpTimeLeft / lerpDuration));
	}

	private Vector2 SmoothLerp()
	{
		float linearProgress = 1 - (lerpTimeLeft / lerpDuration);
		float smoothProgress = (float)(0.5 * Mathf.Cos((1 - linearProgress)*Mathf.PI) + 0.5);
		return Vector2.Lerp(centre, lerpTarget, smoothProgress);
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Vector2 position = lerping ? SmoothLerp() : centre;

		material.SetColor("_Colour", currentColour);
		material.SetFloat("_Radius", Radius);
		material.SetFloat("_Thickness", Thickness);
		material.SetFloat("_X", position.x);
		material.SetFloat("_Y", position.y);

		Graphics.Blit(source, dest, material);
	}

	public void SetPositive(float durationSeconds)
	{
		currentColour = PositiveColour;
		GoAbnormal(durationSeconds);
	}

	public void SetNegative(float durationSeconds)
	{
		currentColour = NegativeColour;
		GoAbnormal(durationSeconds);
	}

	public void SetNormal()
	{
		currentColour = NormalColour;
	}

	private void GoAbnormal(float durationSeconds)
	{
		abnormalColourDuration = durationSeconds;
		isAbnormal = true;
	}
}