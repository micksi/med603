using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
//[AddComponentMenu("Image Effects/Blur/Blur")]
public class ApplyImageShaderWithCSF : MonoBehaviour {

	public CSF csfProvider;
	public AntiAliasingPost csfUser;
	public FocusProvider.Source focusSource;
	public bool showCSF = false;


	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
		FocusProvider.source = focusSource;

		if(showCSF)
		{
			csfProvider.GetContrastSensitivityMap(source, dest);
			return;
		}

		// Get CSF
		RenderTexture csf = RenderTexture.GetTemporary(source.width, source.height);
		csfProvider.GetContrastSensitivityMap(source, csf);

		// Send CSF to csfUser
		csfUser.SetCSF(csf);

		// Render with CSFUser
		csfUser.ApplyEffect(source, dest);
		RenderTexture.ReleaseTemporary(csf);
	}
}