using UnityEngine;
using System.Collections;

public class CSF : MonoBehaviour {
	
	public Shader CSFShader = null;   
	
	//[Range(0.01, 30.0)]
	public float halfResolutionEccentricity = 2.3f;
	
	private static Camera _cam = null;
	private static Camera cam
	{
		get { if(_cam == null) _cam = Camera.main; return _cam; }
	}

	public float screenDiag = 15.4f; // TBs laptop  15.6f; // Adams laptop
	private float DPI;
	
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
		Resolution[] resolutions = Screen.resolutions;
		Resolution highestResolution = resolutions[resolutions.Length - 1];

		int w = highestResolution.width;
		int h = highestResolution.height;
		DPI = GetDPI(w, h, screenDiag);
	}
	
	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		GetContrastSensitivityMap(source, dest);
		/*Vector2 focus = FocusProvider.GetFocusPosition();
		
		material.SetFloat("_FocusX", focus.x);
		material.SetFloat("_FocusY", focus.y);
		
		material.SetFloat("_HalfResolutionEccentricity", halfResolutionEccentricity);
		
		material.SetFloat("_ScreenWidth", cam.pixelWidth);
		material.SetFloat("_ScreenHeight", cam.pixelHeight);
		material.SetFloat("_DPI", DPI);
		
		Graphics.Blit(source, dest, material);*/
	}
	
	private float GetDPI(float w, float h, float diag)
	{
		return new Vector2(w, h).magnitude / diag;
	}

	public void GetContrastSensitivityMap(RenderTexture source, RenderTexture dest)
	{
		Vector2 focus = FocusProvider.GetFocusPosition();

		material.SetFloat("_FocusX", focus.x);
		material.SetFloat("_FocusY", focus.y);
		
		material.SetFloat("_HalfResolutionEccentricity", halfResolutionEccentricity);
		
		material.SetFloat("_ScreenWidth", cam.pixelWidth);
		material.SetFloat("_ScreenHeight", cam.pixelHeight);
		material.SetFloat("_DPI", DPI);
		
		Graphics.Blit(source, dest, material);
	}
}