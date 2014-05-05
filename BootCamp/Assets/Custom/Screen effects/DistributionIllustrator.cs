using UnityEngine;
using System.Collections;

// TODO Use a gaussian distribution instead
public class DistributionIllustrator : MonoBehaviour {

	public enum State { Uniform, CentralLimit6, CentralLimit12, BoxMullerBasic, Gaussian, Circular, CustomThingy };
	public State state = State.Gaussian;
	public bool circular = true;
	public int centralCount = 5;

	public uint framesPerUpdate = 0; // 0 gives no updates
	public KeyCode keyToUpdate = KeyCode.Space; // Press this key to force an update
	public KeyCode keyToAddOne = KeyCode.X; // Press this key to force an update
	public KeyCode keyToClear = KeyCode.C; // Press this key to force an update

	public uint numberOfSamples = 2000; // How many samples should be taken of your distribution

	private uint framesSinceLastUpdate = 0;
	private Texture2D texture;
	private Color[] black;

	// For gaussian
	private bool gaussianHasSpare = false;
	private float gaussRand1, gaussRand2;

	// Use this for initialization
	void Start () {
		texture = new Texture2D((int)FocusProvider.GetScreenResolution().x, (int)FocusProvider.GetScreenResolution().y);
		black = new Color[texture.width * texture.height];
		for(int i = 0; i < black.Length; i++) { black[i] = Color.black; }

		//CustomRandom.InitiateGauss();

		//int count = 9000;
		//System.Text.StringBuilder sb = new System.Text.StringBuilder(7 * count);

		//for(int i = 0; i < count; i++)
		//	sb.Append(CentralLimit(3).ToString("0.000") + "\n");

		//System.IO.File.WriteAllText("/Users/Thorbjorn/Desktop/tamp.csv",sb.ToString());



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
		if(Input.GetKeyDown(keyToAddOne))
		{
			Vector2 hit = MyDistributionGenerator(); //Circle((float)(i)/numberOfSamples);
			print("Hit at " + hit);
			texture.SetPixel((int)hit.x, (int)hit.y, Color.white);
			texture.Apply();
		}
		if(Input.GetKeyDown(keyToClear))
		{
			texture.SetPixels( black, 0);
			texture.Apply();
		}
	}

	private Vector2 CentralLimitV(int count)
	{
		return new Vector2(CentralLimit(count), CentralLimit(count));
	}

	private float CentralLimit(int count)
	{
		double v = 0.0;

		for(int i = 0; i < count; i++)
		{
			v += Random.Range(-1f,1f);
		}

		v /= count;

		return (float)v;
	}

	private void UpdateTexture()
	{
		texture.SetPixels( black, 0);

		for(int i = 0; i < numberOfSamples; i++)
		{
			Vector2 hit = MyDistributionGenerator(); //Circle((float)(i)/numberOfSamples);
			texture.SetPixel((int)hit.x, (int)hit.y, Color.white);
		}

		texture.Apply();
	}

	private Vector2 Circle(float progress)
	{
		float radius = 10;
		float angle = progress * Mathf.PI * 2;
		Vector2 myVector = new Vector2(Mathf.Cos(angle), Mathf.Sin(angle));

		return ToCenteredScreenSpace(myVector, radius);
		//return radius * (new Vector2(Mathf.Cos(angle), Mathf.Sin(angle))) + centre;
	}

	private Vector2 ToCenteredScreenSpace(Vector2 position, float scale)
	{
		Vector2 centre = 0.5f * FocusProvider.GetScreenResolution();
		return centre + scale * position;
	}

	private float LinearFalloff(float progress)
	{
		return 0;
	}

	// May overflow edge of screen
	private Vector2 ConvertToCenteredScreenSpace(Vector2 p, bool aspectIndependent)
	{
		Vector2 screenRes = FocusProvider.GetScreenResolution();

		float aspect = aspectIndependent ? screenRes.x / screenRes.y : 1f;
		float rangeX =          screenRes.x / 2;
		float rangeY = aspect * screenRes.y / 2;

		return (new Vector2(rangeX * p.x, rangeY * p.y)) + screenRes / 2;
	}

	private bool IsInsideScreenArea(Vector2 point)
	{
		if(point.x < 0 || point.y < 0)
			return false;

		Vector2 screenRes = FocusProvider.GetScreenResolution();
		if(point.x >= screenRes.x || point.y > screenRes.y)
			return false;

		return true;
	}

	private Vector2 MyDistributionGenerator()
	{

		Vector2 raw;
		Vector2 screenSpace;
		do
		{
			raw = CentralLimitV(8);
			screenSpace = ConvertToCenteredScreenSpace(raw, true);
		}
		while(IsInsideScreenArea(screenSpace) == false);

		return screenSpace;


		// Use uniform
		/*Vector2 screenRes = FocusProvider.GetScreenResolution();
		Vector2 output = screenRes;

		float aspect = screenRes.x / screenRes.y;
		float rangeX =          screenRes.x / 2;
		float rangeY = aspect * screenRes.y / 2; // To make it circular regardless of aspect ratio
		do
		{
			output = CentralLimitV(8);
			output.x *= rangeX;
			output.y *= rangeY;
		}
		while(Mathf.Abs(output.x) > screenRes.x / 2 || Mathf.Abs(output.y) > screenRes.y / 2);
		
		return output + screenRes / 2;*/


/*
		float xraw = CustomRandom.Uniform2GaussianStep(Random.value);
		float yraw = CustomRandom.Uniform2GaussianStep(Random.value);



		//xraw = (Random.value > 0.5f) ? xraw : -xraw;
		//yraw = (Random.value > 0.5f) ? yraw : -yraw;

		return new Vector2(screenRes.x / 2 * xraw, screenRes.y / 2 * yraw) + 0.5f * screenRes;
		//return ToCenteredScreenSpace(new Vector2(xraw, yraw), 300);
		/*
		switch(state)
		{
			case State.Uniform:
				//output.x *= UnityEngine.Random.value;
				//output.y *= UnityEngine.Random.value;
				break;
			case State.CentralLimit6:
				output.x *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/6f;
				output.y *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/6f;
				break;
			case State.CentralLimit12:
				output.x *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value +
									UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/12f;
				output.y *= (float)(UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value +
									UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value + UnityEngine.Random.value)/12f;
				break;
			case State.BoxMullerBasic:
				Vector2 bm = BoxMullerTransform();
				output.x *= (bm.x + 1) / 2;
				output.y *= (bm.y + 1) / 2;
				break;
			case State.Gaussian:
				output.x *= (GenerateGaussianNoise());// + 1) / 2;
				output.y = (GenerateGaussianNoise());// + 1) / 2;
				output = ToCenteredScreenSpace(output, 40);
				break;
			case State.Circular:
				output = Apply(screenRes, 0.25f * Circular());
				break;
			case State.CustomThingy:
				Vector2 c = CustomThingy();
				output.x = ( (c.x + 1) / 2) * output.x;
				output.y = ( (c.y + 1) / 2) * output.y;
				break;
		}	

		if(circular)
		{
			float ratio = screenRes.x / screenRes.y;
			output.y = (output.y - screenRes.y / 2) * ratio + screenRes.y;
		}

		return output;*/
	}

	private Vector2 CustomThingy()
	{
		float r = Mathf.PI * 2f * Random.value;
		return Random.value * (new Vector2(Mathf.Cos(r), Mathf.Sin(r)));
	}

	private Vector2 FromMinus1_1To0_1Range(Vector2 v)
	{
		v.x = (v.x + 1) * 0.5f;
		v.y = (v.y + 1) * 0.5f;

		return v;
	}

	private Vector2 Apply(Vector2 dimensions, Vector2 pointMinus1_1)
	{
		pointMinus1_1.x = (pointMinus1_1.x * dimensions.x/2) + dimensions.x/2;
		pointMinus1_1.y = (pointMinus1_1.y * dimensions.y/2) + dimensions.y/2;

		return pointMinus1_1;
	}

	private Vector2 Circular()
	{
		Vector2 output = Random.insideUnitCircle.normalized;
		return output;
	}

	private Vector2 BoxMullerTransform()
	{
		// Basic form from http://en.wikipedia.org/wiki/Box_Muller_transform#Basic_form
		float U1 = Random.value;
		float U2 = Random.value;

		float Z0 = Mathf.Sqrt(-2 * Mathf.Log(U1)) * Mathf.Cos(2 * Mathf.PI * U2);
		float Z1 = Mathf.Sqrt(-2 * Mathf.Log(U1)) * Mathf.Sin(2 * Mathf.PI * U2);

		return new Vector2(Z0, Z1);
	}

	private float GenerateGaussianNoise()
	{	 
		float output;
		if(gaussianHasSpare)
		{
			gaussianHasSpare = false;
			output = Mathf.Sqrt(gaussRand1) * Mathf.Sin(gaussRand2);
		}
	 	else
		{	gaussianHasSpare = true;
		 
			gaussRand1 = Random.value;
			if(gaussRand1 < System.Single.Epsilon) gaussRand1 = System.Single.Epsilon;
			gaussRand1 = -2 * Mathf.Log(gaussRand1);
			gaussRand2 = Random.value * Mathf.PI * 2;
		 
			output = Mathf.Sqrt(gaussRand1) * Mathf.Cos(gaussRand2);
		}

		return output;
	}


	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Graphics.Blit(texture, dest);
	}
}
