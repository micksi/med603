Shader "Custom/DrawFocus" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Radius ("Radius in pixels", Float) = 6
		_Thickness ("Circle thickness in pixels", Float) = 1
		_Colour ("Colour", Color) = (0.5, 0.5, 0.5, 1)
		_X ("Centre X", Float) = 0
		_Y ("Centre Y", Float) = 0
	}

	CGINCLUDE

	#include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	uniform float4 _MainTex_TexelSize;
	uniform float _Radius;
	uniform float _Thickness;
	uniform float4 _Colour;
	float _X;
	float _Y;

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

	// TODO for some reason not compatible with Windows??
	// Testing...
	half4 frag (v2f i) : COLOR 
	{		 		
		float x = _X * _MainTex_TexelSize.x;
		float y = _Y * _MainTex_TexelSize.y;
		float4 origin = tex2D(_MainTex, i.uv);

		float aspect = _MainTex_TexelSize.x / _MainTex_TexelSize.y;

		float h = (i.uv.x - x);
		float v = (i.uv.y - y) * aspect; // Ensuring aspect ratio independence

		float l = length(float2(h,v));

		return origin * float4(0.5, 0.5, 1.5, 1);

		if(_MainTex_TexelSize.x * (_Radius - _Thickness) < l 
			&& l < _MainTex_TexelSize.x * _Radius)
		{
			return float4(lerp(origin.xyz, _Colour.xyz, _Colour.a), 1);
		}

		return origin;
	}

	ENDCG	

	SubShader {
		Pass {
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma glsl

			ENDCG
		}
	}

	Fallback off
}