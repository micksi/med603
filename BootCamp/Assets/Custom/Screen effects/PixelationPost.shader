Shader "Custom/PixelationPost" {
	Properties
	{
		_MainTex ("Base frame", 2D) = "white" {} 
		_CSF ( "CSF", 2D) = "black" {}
		_DownsampleAt0 ("Downsample level for CSF value of 0", Float) = 16 // Should probably be lower
	}

	CGINCLUDE
	#include "UnityCG.cginc"	
	uniform sampler2D _MainTex;
	uniform sampler2D _CSF;
	uniform float4 _MainTex_TexelSize;
	uniform float _DownsampleAt0;

	float GetIntensity( float3 col )
	{
		return dot( col, float3( 0.33f, 0.33f, 0.33f ) );
	}
	
	struct v2f 
	{
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	v2f vert( appdata_img v ) 
	{
		v2f o;
		o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

		float2 uv = v.texcoord.xy;
		o.uv.xy = uv;

		return o;
	}
	
	float4 downsampleFrag(v2f i) : COLOR
	{
		float4 csf = tex2D(_CSF, i.uv);

		// Effect is greatest when csf is black i.e. 0
		float intensity = GetIntensity(csf.xyz);
		float effectSize = 1 - intensity;

		// Downsampling value interpolated from 0 to max by effect size
		int downsampling = floor(1.0f / sqrt(intensity));
		
		float2 texcoord = i.uv.xy // pixel position
			- fmod(i.uv.xy, downsampling * _MainTex_TexelSize.xy) // quantize to nearest downsampled step
			+ 0.5 * downsampling * _MainTex_TexelSize.xy; // Compensate right so that we sample centre of downsampled pixel

		return tex2D(_MainTex, texcoord);
	}
	ENDCG

	SubShader {
		 Pass {
			  ZTest Always Cull Off ZWrite Off
			  Fog { Mode off }      

			  CGPROGRAM
			  #pragma vertex vert
			  #pragma fragment downsampleFrag
			  ENDCG
		  }
	}
	FallBack off
}