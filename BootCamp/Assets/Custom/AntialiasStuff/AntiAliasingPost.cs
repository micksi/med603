using UnityEngine;
using System.Collections;

//[ExecuteInEditMode]
//[AddComponentMenu ("Image Effects/Other/Antialiasing")]
public class AntiAliasingPost : MonoBehaviour, IApplyCSF  
{
	// TODO Actually use CSF

	public  Shader dlaaShader;
	public ThresholdFinderComponent tfc;

	private Material dlaa;
	private RenderTexture csf = null;
	
	public void SetCSF(RenderTexture csf)
	{
		this.csf = csf;
	}

	public void ApplyEffect(RenderTexture source, RenderTexture dest)
	{
		if(dlaa == null)
		{
			dlaaShader = Shader.Find("Custom/OurDLAA");
			dlaa = new Material(dlaaShader);
		}

		source.anisoLevel = 0;	
		if(csf != null)
		{
			dlaa.SetTexture("_CSF", csf);
		}
		//Graphics.Blit(source, dest, dlaa, 0); // Use AA algorithm
		Graphics.Blit(source, dest, dlaa, 1); // Use debug colour algorithm

	}
}