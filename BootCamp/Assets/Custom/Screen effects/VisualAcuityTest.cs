using UnityEngine;
using System.Collections;

public class VisualAcuityTest : MonoBehaviour {

	public Shader visualAcuityTestShader = null;	

	//[Range(0.01, 30.0)]
	public float halfResolutionEccentricity = 2.3f;

	private static Camera _cam = null;
	private static Camera cam
	{
		get { if(_cam == null) _cam = Camera.main; return _cam; }
	}

	static Material m_Material = null;
	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material(visualAcuityTestShader);
				m_Material.hideFlags = HideFlags.DontSave;
			}
			return m_Material;
		} 
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		Vector2 focus = FocusProvider.GetFocusPosition();

		material.SetFloat("_FocusX", focus.x);
		material.SetFloat("_FocusY", focus.y);

		material.SetFloat("_HalfResolutionEccentricity", halfResolutionEccentricity);

		material.SetFloat("_ScreenWidth", cam.pixelWidth);
		material.SetFloat("_ScreenHeight", cam.pixelHeight);


		
		Graphics.Blit(source, dest, material);
	}
}