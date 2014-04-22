using UnityEngine;
using System.Collections;

public class ExperimentConductor : MonoBehaviour {

	public ThresholdFinderComponent thresholdFinder;
	public CSF csfGenerator;
	public Shader csfUser;
	public FocusProvider.Source focusSource;
	public bool debug = false;

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

	private Material _debugMaterial = null;
	private Material debugMaterial
	{
		get 
		{
			if(_debugMaterial == null)
			{
				_debugMaterial = new Material(Shader.Find("Custom/DrawCircle"));
			}
			return _debugMaterial;
		}
	}

	public void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		// Update FocusProvider to use the latest source
		FocusProvider.source = focusSource;

		// Why??
		source.anisoLevel = 0;	

		// Obtain CSF map and send it to material
		csfGenerator.halfResolutionEccentricity = (float)thresholdFinder.Stimulus;
		RenderTexture csf = RenderTexture.GetTemporary(source.width, source.height);
		csfGenerator.GetContrastSensitivityMap(source, csf);
		
		if(debug)
		{
			debugMaterial.SetTexture("_CSF", csf);
			debugMaterial.SetFloat("_Threshold", 0.5f);
			Graphics.Blit(source, dest, debugMaterial);
		}
		else
		{
			material.SetTexture("_CSF", csf);
			Graphics.Blit(source, dest, material, 1); // Debugging - show CSF
		}
		
		// Apply effect & csf
		//Graphics.Blit(source, dest, material, 0); // AA algorithm
		//Graphics.Blit(source, dest, material, 1); // Debugging - show CSF
		
		// Clean up
		RenderTexture.ReleaseTemporary(csf);
	}
}
