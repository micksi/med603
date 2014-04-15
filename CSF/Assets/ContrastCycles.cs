using UnityEngine;
using System.Collections;

public class ContrastCycles : MonoBehaviour {

	private Material m_Material;
	public Shader shader = null;

	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material(shader);
				m_Material.hideFlags = HideFlags.DontSave;
			}
			return m_Material;
		}
	}

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		// Vector2 focus = FocusProvider.GetFocusPosition();
		
		// material.SetFloat("_FocusX", focus.x);
		// material.SetFloat("_FocusY", focus.y);
		
		// material.SetFloat("_HalfResolutionEccentricity", halfResolutionEccentricity);
		
		// material.SetFloat("_ScreenWidth", cam.pixelWidth);
		// material.SetFloat("_ScreenHeight", cam.pixelHeight);
		// material.SetFloat("_DPI", DPI);
		
		
		
		Graphics.Blit(source, dest, material);
	}
}
