using UnityEngine;
using System.Collections;

public class ExperimentConductor : MonoBehaviour {

	public ThresholdFinderComponent thresholdFinder;
	public CSF csfGenerator;
	public Shader csfUser;
	public FocusProvider.Source focusSource;
	public bool debugToggleEffectOnV = false;
	public bool debugShowHalfvalueCSF = false;
	public bool debugDrawCSFOnly = false;

	private Material _material = null;
	private Material material
	{
		get 
		{
			if(_material == null)
			{
				_material = new Material(csfUser);
			}
			return _material;
		}
	}

	private Material _showHalfCSF = null;
	private Material showHalfCSF
	{
		get 
		{
			if(_showHalfCSF == null)
			{
				_showHalfCSF = new Material(Shader.Find("Custom/DrawCircle"));
			}
			return _showHalfCSF;
		}
	}

	Texture2D whiteDebug = null;
	Texture2D blackDebug = null;

	void Start()
	{
		whiteDebug = new Texture2D(1, 1, TextureFormat.ARGB32, false);
 		blackDebug = new Texture2D(1, 1, TextureFormat.ARGB32, false);
		
		// set the pixel values
		whiteDebug.SetPixel(0, 0, Color.white);
		blackDebug.SetPixel(0, 0, Color.black);
 
		// Apply all SetPixel calls
		whiteDebug.Apply();
		blackDebug.Apply();
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		// Update FocusProvider to use the latest source
		FocusProvider.source = focusSource;

		// Why??
		//source.anisoLevel = 0;	

		// Obtain CSF map and send it to material
		csfGenerator.halfResolutionEccentricity = (float)thresholdFinder.Stimulus;
		RenderTexture csf = RenderTexture.GetTemporary(source.width, source.height);
		csfGenerator.GetContrastSensitivityMap(source, csf);
		material.SetTexture("_CSF", csf);

		if(debugToggleEffectOnV)
		{	
			if(Input.GetKey("v"))
			{
				material.SetTexture("_CSF", whiteDebug);
				print("AA on");
			}
			else //if(Input.GetKey("b"))
			{
				material.SetTexture("_CSF", blackDebug);
				print("AA off");
			}
			Graphics.Blit(source, dest, material);
		}
		else if(debugShowHalfvalueCSF)
		{
			RenderTexture temp = RenderTexture.GetTemporary(source.width, source.height);
			showHalfCSF.SetTexture("_CSF", csf);
			showHalfCSF.SetFloat("_Threshold", 0.5f);
			Graphics.Blit(source, temp, material);
			Graphics.Blit(temp, dest, showHalfCSF);
			RenderTexture.ReleaseTemporary(temp);
		}
		else if(debugDrawCSFOnly)
		{
			Graphics.Blit(csf, dest);
		}
		else
		{
			// Apply effect according to CSF
			Graphics.Blit(source, dest, material);
		}
		
		
		// Clean up
		RenderTexture.ReleaseTemporary(csf);
	}
}
