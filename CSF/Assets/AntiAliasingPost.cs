using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
[RequireComponent(typeof (Camera))]
[AddComponentMenu ("Image Effects/Other/Antialiasing")]
public class AntiAliasingPost : MonoBehaviour  { // TODO Add interface here
	public enum AAMode 
	{
		FXAA2,
		FXAA3Console,		
		FXAA1PresetA,
		FXAA1PresetB,
		NFAA,
		SSAA,
		DLAA
	};

	public AAMode mode = AAMode.FXAA3Console;

	public bool showGeneratedNormals = false;
	public float offsetScale = 0.2f;
	public float blurRadius = 18.0f;

	public float edgeThresholdMin = 0.05f;
	public float edgeThreshold = 0.2f;
	public float edgeSharpness  = 4.0f;
		
	public bool dlaaSharp = false;

	public  Shader		ssaaShader;
	private Material 	ssaa;
	public  Shader 		dlaaShader;
	private Material 	dlaa;
	public  Shader 		nfaaShader;
	private Material 	nfaa;	
	public  Shader 		shaderFXAAPreset2;
	private Material 	materialFXAAPreset2;
	public  Shader 		shaderFXAAPreset3;
	private Material 	materialFXAAPreset3;
	public  Shader 		shaderFXAAII;
	private Material 	materialFXAAII;
	public  Shader 		shaderFXAAIII;
	private Material 	materialFXAAIII;
		
	void Start()
	{
		ssaaShader = Shader.Find("Hidden/SSAA");
		dlaaShader = Shader.Find("Hidden/DLAA");
		nfaaShader = Shader.Find("Hidden/NFAA");
		shaderFXAAPreset2 = Shader.Find("Hidden/FXAA Preset 2");
		shaderFXAAPreset3 = Shader.Find("Hidden/FXAA Preset 3");
		shaderFXAAII = Shader.Find("Hidden/FXAA II");
		shaderFXAAIII = Shader.Find("Hidden/FXAA III (Console)");
	}

	public Material CurrentAAMaterial() 
	{
		Material returnValue = null;

		switch(mode) {
			case AAMode.FXAA3Console:
				returnValue = materialFXAAIII;
				break;
			case AAMode.FXAA2:
				returnValue = materialFXAAII;
				break;
			case AAMode.FXAA1PresetA:
				returnValue = materialFXAAPreset2;
				break;
			case AAMode.FXAA1PresetB:
				returnValue = materialFXAAPreset3;
				break;
			case AAMode.NFAA:
				returnValue = nfaa;
				break;
			case AAMode.SSAA:
				returnValue = ssaa;
				break;
			case AAMode.DLAA:
				returnValue = dlaa;
				break;	
			default:
				returnValue = null;
				break;
			}
			
		return returnValue;
	}

	public bool CheckResources() {
		//CheckSupport (false);
		
		materialFXAAPreset2 = new Material(shaderFXAAPreset2); // preset was materialFXAAPreset2
		materialFXAAPreset3 = new Material(shaderFXAAPreset3); // preset was materialFXAAPreset3
		materialFXAAII = new Material(shaderFXAAII); // preset was materialFXAAII
		materialFXAAIII = new Material(shaderFXAAIII); // preset was materialFXAAIII
		nfaa = new Material(nfaaShader); // preset was nfaa
		ssaa = new Material(ssaaShader); // preset was ssaa 
		dlaa = new Material(dlaaShader); // preset was dlaa 

        if(!ssaaShader.isSupported) {
            return false;
		}
		
		return true;		            
	}
	
	public Vector2 GetNormalizedMousePosition()
	{
		float mouseX = Input.mousePosition.x / Screen.width;
		float mouseY = Input.mousePosition.y / Screen.height;

		return new Vector2(mouseX, mouseY);
	}
	
	public void OnRenderImage(RenderTexture source, RenderTexture destination) {
		if(CheckResources()==false) {
			Graphics.Blit (source, destination);
			return;
		}

 		// .............................................................................
		// FXAA antialiasing modes .....................................................
		
		if (mode == AAMode.FXAA3Console && (materialFXAAIII != null)) {
			materialFXAAIII.SetFloat("_EdgeThresholdMin", edgeThresholdMin);
			materialFXAAIII.SetFloat("_EdgeThreshold", edgeThreshold);
			materialFXAAIII.SetFloat("_EdgeSharpness", edgeSharpness);		
			
			/*Vector2 focus = FocusProvider.GetNormalizedFocusPosition();
			materialFXAAIII.SetFloat("_CenterX", focus.x);
			materialFXAAIII.SetFloat("_CenterY", focus.y);
			*/
			
            Graphics.Blit (source, destination, materialFXAAIII);
        }        
		else if (mode == AAMode.FXAA1PresetB && (materialFXAAPreset3 != null)) {
            Graphics.Blit (source, destination, materialFXAAPreset3);
        }
        else if(mode == AAMode.FXAA1PresetA && materialFXAAPreset2 != null) {
            source.anisoLevel = 4;
            Graphics.Blit (source, destination, materialFXAAPreset2);
            source.anisoLevel = 0;
        }
        else if(mode == AAMode.FXAA2 && materialFXAAII != null) {
            Graphics.Blit (source, destination, materialFXAAII);
        }
		else if (mode == AAMode.SSAA && ssaa != null) {

		// .............................................................................
		// SSAA antialiasing ...........................................................
			
			Graphics.Blit (source, destination, ssaa);								
		}
		else if (mode == AAMode.DLAA && dlaa != null) {

		// .............................................................................
		// DLAA antialiasing ...........................................................
		
			source.anisoLevel = 0;	
			RenderTexture interim = RenderTexture.GetTemporary (source.width, source.height);
			Graphics.Blit (source, interim, dlaa, 0);			
			Graphics.Blit (interim, destination, dlaa, dlaaSharp ? 2 : 1);
			RenderTexture.ReleaseTemporary (interim);					
		}
		else if (mode == AAMode.NFAA && nfaa != null) {

		// .............................................................................
		// nfaa antialiasing ..............................................
			
			source.anisoLevel = 0;	
		
			nfaa.SetFloat("_OffsetScale", offsetScale);
			nfaa.SetFloat("_BlurRadius", blurRadius);
				
			Graphics.Blit (source, destination, nfaa, showGeneratedNormals ? 1 : 0);					
		}
		else {
			// none of the AA is supported, fallback to a simple blit
			Graphics.Blit (source, destination);
		}
	}
}