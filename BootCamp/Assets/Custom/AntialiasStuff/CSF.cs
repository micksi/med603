using UnityEngine;
using System.Collections;
using System;

public class CSF : MonoBehaviour {
	
	public Shader CSFShader = null;   
	public float halfResolutionEccentricity = 2.3f;

	[HideInInspector]
	public Vector2 centre = new Vector2(0,0);
	
	private static Camera _cam = null;
	private static Camera cam
	{
		get { if(_cam == null) _cam = Camera.main; return _cam; }
	}

	public float screenDiag;
	private float DPI;
	private float userDistance;
	
	static Material m_Material = null;
	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material(CSFShader);
				m_Material.hideFlags = HideFlags.DontSave;
			}
			return m_Material;
		}
	}

	void Awake()
	{
		screenDiag = Single.Parse(ConfigReader.GetValueOf("screenDiag"));
		userDistance = Single.Parse(ConfigReader.GetValueOf("userDistance"));
		DPI = GetDPI();
	}
	
	private float GetDPI()
	{
		// Calculate DPI based on the current resolution
		Resolution currentResolution =  Screen.currentResolution;

		int w = currentResolution.width;
		int h = currentResolution.height;

		return new Vector2(w, h).magnitude / screenDiag;
	}

	public void GetContrastSensitivityMap(RenderTexture source, RenderTexture dest)
	{
		material.SetFloat("_FocusX", centre.x);
		material.SetFloat("_FocusY", centre.y);
		
		material.SetFloat("_HalfResolutionEccentricity", halfResolutionEccentricity);
		
		material.SetFloat("_ScreenWidth", cam.pixelWidth);
		material.SetFloat("_ScreenHeight", cam.pixelHeight);
		material.SetFloat("_DPI", DPI);
		material.SetFloat("_UserDistance", userDistance);
		
		Graphics.Blit(source, dest, material);
	}
}