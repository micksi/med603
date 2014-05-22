using UnityEngine;
using System.Collections;

// Shows and wraps a neat modifiable circle at the centre of the screen.
// Can easily be generalized to centre the circle elsewhere.
public class GazePositionIndicator : MonoBehaviour {

	public Color Colour = new Color(1f, 1f, 0f, 1f);
	public float Radius = 30f;
	public float Thickness = 10f;
	public Shader circleShader;

	private Material material = null;
	private Color currentColour;

	private bool on = false;

	// Use this for initialization
	void Start () {
		material = new Material(circleShader);//Shader.Find("Custom/DrawFocus"));
	}

	void Update()
	{
		if(Input.GetKey(KeyCode.O))
		{
			on = true;
			print ("O down!");
		}
		else
		{
			on = false;
		}
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		if (on) {
			Vector2 centre = FocusProvider.GetGazePosition ();
			material.SetFloat ("_Radius", Radius);
			material.SetColor ("_Colour", Colour);
			material.SetFloat ("_Thickness", Thickness);
			material.SetFloat ("_X", centre.x);
			material.SetFloat ("_Y", centre.y);
		} 
		else 
		{
			material.SetFloat("_Radius", 0);
		}

		Graphics.Blit(source, dest, material);
	}
}