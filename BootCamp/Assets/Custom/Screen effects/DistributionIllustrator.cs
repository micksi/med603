using UnityEngine;
using System.Collections;

// TODO Use a gaussian distribution instead
public class DistributionIllustrator : MonoBehaviour {

	public uint framesPerUpdate = 0; // 0 gives no updates
	public KeyCode keyToUpdate = KeyCode.Space; // Press this key to force an update
	public uint numberOfSamples = 3000; // How many samples should be taken of your distribution

	private uint framesSinceLastUpdate = 0;
	private Texture2D texture;
	private Color[] black;

	// Use this for initialization
	void Start () {
		texture = new Texture2D((int)FocusProvider.GetScreenResolution().x, (int)FocusProvider.GetScreenResolution().y);
		black = new Color[texture.width * texture.height];
		for(int i = 0; i < black.Length; i++) { black[i] = Color.black; }
	}
	
	// Update is called once per frame
	void Update () {
		if(framesPerUpdate > 0)
		{
			if(++framesSinceLastUpdate >= framesPerUpdate)
			{
				UpdateTexture();
				framesSinceLastUpdate = framesPerUpdate;
			}
		}

		if(Input.GetKeyDown(keyToUpdate))
		{
			UpdateTexture();
		}
	}

	private void UpdateTexture()
	{
		print("Update tex");
		texture.SetPixels( black, 0); // TODO is this working?

		for(int i = 0; i < numberOfSamples; i++)
		{
			Vector2 hit = MyDistributionGenerator();
			texture.SetPixel((int)hit.x, (int)hit.y, Color.white);
		}

		texture.Apply();
	}

	private Vector2 MyDistributionGenerator()
	{
		// Use uniform
		Vector2 output = FocusProvider.GetScreenResolution();
		
		// Uniform
		output.x *= UnityEngine.Random.value;
		output.y *= UnityEngine.Random.value;

		// Central limit technique
		//output.x *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/6f;
		//output.y *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/6f;

		return output;
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		print("On render");
		Graphics.Blit(texture, dest);
	}
}
