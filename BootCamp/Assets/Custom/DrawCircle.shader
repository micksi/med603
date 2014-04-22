
//
// modified and adapted DLAA code based on Dmitry Andreev's
// Directionally Localized Anti-Aliasing (DLAA)
//
// as seen in "The Force Unleashed 2"
//
// Hideously stolen and adapted by Thorbjørn

Shader "Custom/DrawCircle" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_CSF ("CSF map - determining amount", 2D) = "white" {}
		_LowCSColour("The colour to apply when below threshold", Color) = (0,0,1,1)
		_Threshold("Threshold", Float) = 0.5
		_Delta("Delta", Float) = 0.005
	}

	CGINCLUDE
// Upgrade NOTE: excluded shader from DX11, Xbox360, OpenGL ES 2.0 because it uses unsized arrays
#pragma exclude_renderers d3d11 xbox360 gles

	#include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	uniform sampler2D _CSF;
	uniform float4 _MainTex_TexelSize;
	uniform float4 _LowCSColour;
	uniform float _Threshold;
	uniform float _Delta;

	struct v2f 
	{
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	#define LD( o, dx, dy ) o = tex2D( _MainTex, texCoord + float2( dx, dy ) * _MainTex_TexelSize.xy );

	float GetIntensity( float3 col )
	{
		return dot( col, float3( 0.33f, 0.33f, 0.33f ) );
	}	

	float4 ApplyThreshold(  float2 texCoord )
	{
		LD(float4 original, 0, 0)
		float4 csf = tex2D(_CSF, texCoord);
		float intensity = GetIntensity(csf);

		if( _Threshold - _Delta < intensity && intensity < _Threshold)
		{
			return _LowCSColour;
		}
		else
		{
			return original;
		}
	}

	v2f vert( appdata_img v ) 
	{
		v2f o;
		o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

		float2 uv = v.texcoord.xy;
		o.uv.xy = uv;

		return o;
	}

	half4 antialias (v2f i) : COLOR 
	{		 	
		return ApplyThreshold( i.uv );
	}

	ENDCG	

	SubShader {

		// Applies AA.
		Pass {
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment antialias
			#pragma target 3.0
			#pragma exclude_renderers d3d11_9x
			#pragma glsl

			ENDCG
		}
	}

	Fallback off
}