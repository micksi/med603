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

	float GetIntensity(float3 p)
	{
		return dot(float3(0.33, 0.33, 0.33), p);
	}

	v2f vert( appdata_img v ) 
	{
		v2f o;
		o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

		float2 uv = v.texcoord.xy;
		o.uv.xy = uv;

		return o;
	}

	half4 frag (v2f i) : COLOR 
	{		 		
		float x = _X * _MainTex_TexelSize.x;
		float y = _Y * _MainTex_TexelSize.y;
		float4 origin = tex2D(_MainTex, i.uv);

		float aspect = _MainTex_TexelSize.x / _MainTex_TexelSize.y;

		float h = (i.uv.x - x);
		float v = (i.uv.y - y) * aspect; // Ensuring aspect ratio independence

		float l = length(float2(h,v));

		if(_MainTex_TexelSize.x * (_Radius - _Thickness) < l 
			&& l < _MainTex_TexelSize.x * _Radius)
		{
			return float4(lerp(origin.xyz, _Colour.xyz, _Colour.a), 1);
		}

		return origin;
	}

	half4 cross (v2f i) : COLOR 
	{		 		
		float x = _X * _MainTex_TexelSize.x;
		float y = _Y * _MainTex_TexelSize.y;
		float4 origin = tex2D(_MainTex, i.uv);

		float aspect = _MainTex_TexelSize.x / _MainTex_TexelSize.y;

		float3 differenceVector = origin.xyz - _Colour.xyz;
		float difference = length(differenceVector);
		float similarity = 1 - difference;

		float h = (i.uv.x - x) / _MainTex_TexelSize.x;
		float v = (i.uv.y - y) / _MainTex_TexelSize.y;

		if( abs(h) < _Radius && abs(v) < _Thickness ||
			abs(v) < _Radius && abs(h) < _Thickness)
		{
			return float4(lerp(origin.xyz, (1 + similarity) * _Colour.xyz, _Colour.a), 1);
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
			#pragma fragment cross
			#pragma target 3.0

			ENDCG
		}
	}

	Fallback off
}