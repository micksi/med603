﻿using UnityEngine;
using System.Collections;

//[ExecuteInEditMode]
[RequireComponent(typeof (Camera))]
//[AddComponentMenu ("Image Effects/Other/Antialiasing")]
public class AntiAliasingPost : MonoBehaviour, IApplyCSF  
{
	// TODO 
	// TODO Actually use CSF



	public  Shader dlaaShader;

	[Range(1,4)]
	public int quality = 1;

	private Material dlaa;
	private RenderTexture csf = null;
	
	public void OnRenderImage(RenderTexture source, RenderTexture destination) 
	{
		ApplyEffect(source, destination);
	}

	public void SetCSF(RenderTexture csf)
	{
		if(csf)
		{
			RenderTexture.ReleaseTemporary(csf);
		}
		this.csf = csf;
	}

	public void ApplyEffect(RenderTexture source, RenderTexture dest)
	{
		if(dlaa == null)
		{
			dlaaShader = Shader.Find("Custom/DLAA");
			dlaa = new Material(dlaaShader);
		}
		//dlaa.SetFloat("_OffsetSize", tempOffset);
		//dlaa.SetFloat("_QualityLevel", quality);

		source.anisoLevel = 0;	

		switch(quality)
		{
			case 1:
				// Pass through
				Graphics.Blit (source, dest);
				break;
			case 2:
				Graphics.Blit (source, dest, dlaa, 0); // Add first level AA		
				break;
			case 3:
				RenderTexture interim = RenderTexture.GetTemporary (source.width, source.height);
				Graphics.Blit (source, interim, dlaa, 0); // Add first level AA		
				Graphics.Blit (interim, dest, dlaa, 1); // Add second level AA
				RenderTexture.active = dest;
				RenderTexture.ReleaseTemporary (interim);
				break;
			case 4:
				RenderTexture interim1  = RenderTexture.GetTemporary (source.width, source.height);
				RenderTexture interim2 = RenderTexture.GetTemporary (source.width, source.height);
				Graphics.Blit (source, interim1, dlaa, 0); // Add first level AA		
				Graphics.Blit (interim1, interim2, dlaa, 1); // Add second level AA
				Graphics.Blit (interim2, dest, dlaa, 2); // Add third level AA
				RenderTexture.active = dest;
				RenderTexture.ReleaseTemporary (interim1);
				RenderTexture.ReleaseTemporary (interim2);
				break;
		}
				RenderTexture.active = dest;

	}
}