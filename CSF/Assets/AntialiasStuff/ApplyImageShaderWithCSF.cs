using UnityEngine;
using System.Collections;

//[ExecuteInEditMode]
//[AddComponentMenu("Image Effects/Blur/Blur")]
public class ApplyImageShaderWithCSF : MonoBehaviour {

	public CSF csfProvider;
	public AntiAliasingPost csfUser;

	//private RenderTexture csf = null;

	void OnRenderImage(RenderTexture source, RenderTexture dest)
	{
	/*	if(csf == null || csf.width != dest.width || csf.height != dest.height)
		{
			csf = new RenderTexture(source.width, source.height, 0);
		}
	*/	// Get CSF
		RenderTexture csf = RenderTexture.GetTemporary(source.width, source.height);
		csfProvider.GetContrastSensitivityMap(source, csf);

		// Send CSF to csfUser
		csfUser.SetCSF(csf);

		// Render with CSFUser
		csfUser.ApplyEffect(source, dest);
		RenderTexture.ReleaseTemporary(csf);
	}
}