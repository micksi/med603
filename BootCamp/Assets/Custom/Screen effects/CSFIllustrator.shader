Shader "Custom/PixelationPost" {
	Properties
	{
		_MainTex ("Base frame", 2D) = "white" {} 
		_CSF ( "CSF", 2D) = "black" {}
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
	
	float4 csfDarken(v2f i) : COLOR
	{
		float4 csf = tex2D(_CSF, i.uv);
		return csf * tex2D(_MainTex, i.uv);
	}
	ENDCG

	SubShader {
		 Pass {
			  ZTest Always Cull Off ZWrite Off
			  Fog { Mode off }      

			  CGPROGRAM
			  #pragma vertex vert
			  #pragma fragment csfDarken
			  ENDCG
		  }
	}
	FallBack off
}