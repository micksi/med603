
//
// modified and adapted DLAA code based on Dmitry Andreev's
// Directionally Localized Anti-Aliasing (DLAA)
//
// as seen in "The Force Unleashed 2"
//
// Hideously stolen and adapted by Thorbjørn

Shader "Custom/OurDLAA" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_CSF ("CSF map - determining amount", 2D) = "white" {}
	}

	CGINCLUDE
// Upgrade NOTE: excluded shader from DX11, Xbox360, OpenGL ES 2.0 because it uses unsized arrays
#pragma exclude_renderers d3d11 xbox360 gles

	#include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	uniform sampler2D _CSF;
	uniform float4 _MainTex_TexelSize;

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

	float4 edgeDetectAndBlur(  float2 texCoord )
	{
		float lambda = 3.0f;
		float epsilon = 0.1f;
		float4 original;
		float4 csf = tex2D(_CSF, texCoord);

		//
		// Short Edges
		//

		float4 center, left_01, right_01, top_01, bottom_01;

		// sample 5x5 cross    
		LD( center,      0,   0 )
		LD( left_01,  -1.5,   0 )
		LD( right_01,  1.5,   0 )
		LD( top_01,      0,-1.5 )
		LD( bottom_01,   0, 1.5 )

		original = center;

		float4 w_h = 2.0f * ( left_01 + right_01 );
		float4 w_v = 2.0f * ( top_01 + bottom_01 );


		// Softer (5-pixel wide high-pass)
		float4 edge_h = abs( w_h - 4.0f * center ) / 4.0f;
		float4 edge_v = abs( w_v - 4.0f * center ) / 4.0f;


		float4 blurred_h = ( w_h + 2.0f * center ) / 6.0f;
		float4 blurred_v = ( w_v + 2.0f * center ) / 6.0f;

		float edge_h_lum = GetIntensity( edge_h.xyz );
		float edge_v_lum = GetIntensity( edge_v.xyz );
		float blurred_h_lum = GetIntensity( blurred_h.xyz );
		float blurred_v_lum = GetIntensity( blurred_v.xyz );

		float edge_mask_h = saturate( ( lambda * edge_h_lum - epsilon ) / blurred_v_lum );
		float edge_mask_v = saturate( ( lambda * edge_v_lum - epsilon ) / blurred_h_lum );

		float4 clr = center;
		clr = lerp( clr, blurred_h, edge_mask_v);
		clr = lerp( clr, blurred_v, edge_mask_h); // blurrier version

		//
		// Long Edges
		//

		float4 h0, h1, h2, h3, h4, h5, h6, h7;
		float4 v0, v1, v2, v3, v4, v5, v6, v7;

		// sample 16x16 cross (sparse-sample on X360, incremental kernel update on SPUs)
		LD( h0,  1.5, 0) LD( h1,  3.5, 0) LD( h2,  5.5, 0) LD( h3,  7.5, 0) 
		LD( h4, -1.5,0 ) LD( h5, -3.5,0 ) LD( h6, -5.5,0 ) LD( h7, -7.5,0 )
		LD( v0, 0, 1.5 ) LD( v1, 0, 3.5 ) LD( v2, 0, 5.5 ) LD( v3, 0, 7.5 ) 
		LD( v4, 0,-1.5 ) LD( v5, 0,-3.5 ) LD( v6, 0,-5.5 ) LD( v7, 0,-7.5 )

		float long_edge_mask_h = ( h0.a + h1.a + h2.a + h3.a + h4.a + h5.a + h6.a + h7.a ) / 8.0f;
		float long_edge_mask_v = ( v0.a + v1.a + v2.a + v3.a + v4.a + v5.a + v6.a + v7.a ) / 8.0f;

		long_edge_mask_h = saturate( long_edge_mask_h * 2.0f - 1.0f );
		long_edge_mask_v = saturate( long_edge_mask_v * 2.0f - 1.0f );

		float4 left, right, top, bottom;

		LD( left,  -1,  0 )
		LD( right,  1,  0 )
		LD( top,    0, -1 )
		LD( bottom, 0,  1 )

		if ( long_edge_mask_h > 0 || long_edge_mask_v > 0 ) // faster but less resistant to noise (TFU2 X360)
		//if ( abs( long_edge_mask_h - long_edge_mask_v ) > 0.2f ) // resistant to noise (TFU2 SPUs)
		{
			float4 long_blurred_h = ( h0 + h1 + h2 + h3 + h4 + h5 + h6 + h7 ) / 8.0f;
			float4 long_blurred_v = ( v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7 ) / 8.0f;

			float lb_h_lum   = GetIntensity( long_blurred_h.xyz );
			float lb_v_lum   = GetIntensity( long_blurred_v.xyz );

			float center_lum = GetIntensity( center.xyz );
			float left_lum   = GetIntensity( left.xyz );
			float right_lum  = GetIntensity( right.xyz );
			float top_lum    = GetIntensity( top.xyz );
			float bottom_lum = GetIntensity( bottom.xyz );

			float4 clr_v = center;
			float4 clr_h = center;

			// we had to hack this because DIV by 0 gives some artefacts on different platforms
			float hx = center_lum == top_lum ? 0.0 : saturate( 0 + ( lb_h_lum - top_lum    ) / ( center_lum - top_lum    ) );
			float hy = center_lum == bottom_lum ? 0.0 : saturate( 1 + ( lb_h_lum - center_lum ) / ( center_lum - bottom_lum ) );
			float vx = center_lum == left_lum ? 0.0 : saturate( 0 + ( lb_v_lum - left_lum   ) / ( center_lum - left_lum   ) );
			float vy = center_lum == right_lum ? 0.0 : saturate( 1 + ( lb_v_lum - center_lum ) / ( center_lum - right_lum  ) );

			float4 vhxy = float4( vx, vy, hx, hy );
			//vhxy = vhxy == float4( 0, 0, 0, 0 ) ? float4( 1, 1, 1, 1 ) : vhxy;

			clr_v = lerp( left  , clr_v, vhxy.x );
			clr_v = lerp( right , clr_v, vhxy.y );
			clr_h = lerp( top   , clr_h, vhxy.z );
			clr_h = lerp( bottom, clr_h, vhxy.w );

			clr = lerp( clr, clr_v, long_edge_mask_v );
			clr = lerp( clr, clr_h, long_edge_mask_h );
		}

		// use CSF value to determine how much AA effect is applied
		return lerp(original, clr, csf);
	}	

	// TB playing around. Not needed for the project.
	float4 medianBlur5(  float2 texCoord )
	{
		//float4 center, left, right, top, bottom;

		float4 samples0, samples1, samples2, samples3, samples4;

		// sample 5x5 cross    
		LD( samples0,      0,   0 )
		LD( samples1,  -1.5,   0 )
		LD( samples2,  1.5,   0 )
		LD( samples3,      0,-1.5 )
		LD( samples4,   0, 1.5 )

		int hi = 0, nhi, m;
		float a, b;
		float4 medianVal = samples0;

		a = GetIntensity(medianVal);
		b = GetIntensity(samples1);
		if(a < b) { hi = 1; medianVal = samples1; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples2);
		if(a < b) { hi = 2; medianVal = samples2; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples3);
		if(a < b) { hi = 3; medianVal = samples3; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples4);
		if(a < b) { hi = 4; medianVal = samples4; };

		nhi = (hi == 0) ? 1 : 0;
		a = GetIntensity(medianVal);
		b = GetIntensity(samples1);
		if(a < b && hi != 1) { nhi = 1; medianVal = samples1; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples2);
		if(a < b && hi != 2) { nhi = 2; medianVal = samples2; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples3);
		if(a < b && hi != 3) { nhi = 3; medianVal = samples3; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples4);
		if(a < b && hi != 4) { nhi = 4; medianVal = samples4; };

		m = (hi == 0 || nhi == 0) ? ((hi == 1 || nhi == 1) ? 2 : 1 ) : 0;

		a = GetIntensity(medianVal);
		b = GetIntensity(samples1);
		if(a < b && hi != 1 && nhi != 1) { m = 1; medianVal = samples1; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples2);
		if(a < b && hi != 2 && nhi != 2) { m = 2; medianVal = samples2; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples3);
		if(a < b && hi != 3 && nhi != 3) { m = 3; medianVal = samples3; };
		a = GetIntensity(medianVal);
		b = GetIntensity(samples4);
		if(a < b && hi != 4 && nhi != 4) { m = 4; medianVal = samples4; };

		return medianVal;//float4(1, 1, 1, 1);//samples[(m == 0 ? 0 : (m == 1 ? 1 : (m == 2 ? 2 : (m == 3 ? 3 : 4)))];
	}

	// TB playing around. Not needed for the project.
	float4 max5(float2 texCoord, float radius)
	{
		float4 samples0, samples1, samples2, samples3, samples4;

		// sample 5x5 cross    
		LD( samples0,      0,   0 )
		LD( samples1,  -radius,   0 )
		LD( samples2,  radius,   0 )
		LD( samples3,      0,-radius )
		LD( samples4,   0, radius )

		float a, b;
		float4 maxVal = samples0;

		a = GetIntensity(maxVal);
		b = GetIntensity(samples1);
		if(a < b) { maxVal = samples1; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples2);
		if(a < b) { maxVal = samples2; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples3);
		if(a < b) { maxVal = samples3; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples4);
		if(a < b) { maxVal = samples4; };

		return maxVal;
	}

	// TB playing around. Not needed for the project.
	float4 max9(float2 texCoord, float radius)
	{
		float4 samples0, samples1, samples2, samples3, samples4,
			   samples5, samples6, samples7, samples8;

		// sample 3x3
		LD( samples0,      0,   0 )
		LD( samples1,  -radius,   0 )
		LD( samples2,  radius,   0 )
		LD( samples3,      0,-radius )
		LD( samples4,   0, radius )
		LD( samples5,  -radius,  radius )
		LD( samples6,  -radius, -radius )
		LD( samples7,   radius, -radius )
		LD( samples8,   radius,  radius )

		float a, b;
		float4 maxVal = samples0;

		a = GetIntensity(maxVal);
		b = GetIntensity(samples1);
		if(a < b) { maxVal = samples1; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples2);
		if(a < b) { maxVal = samples2; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples3);
		if(a < b) { maxVal = samples3; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples4);
		if(a < b) { maxVal = samples4; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples5);
		if(a < b) { maxVal = samples5; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples6);
		if(a < b) { maxVal = samples6; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples7);
		if(a < b) { maxVal = samples7; };
		a = GetIntensity(maxVal);
		b = GetIntensity(samples8);
		if(a < b) { maxVal = samples8; };

		return maxVal;
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
		//return maxn( i.uv, 1.5 );    
		//return medianBlur5( i.uv );
		return edgeDetectAndBlur( i.uv );
	}

	float4 showCSF( v2f i ) : COLOR
	{
		float4 edgeColour = float4(1,0.5,0.4,1);
		float4 csf = tex2D(_CSF, i.uv);
		float4 main = tex2D( _MainTex, i.uv);

		return lerp(edgeColour, main, csf);
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

		// Debugging pass - shows CSF as coloured overlay. Doesn't apply AA.
		Pass {
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment showCSF
			#pragma target 3.0
			#pragma exclude_renderers d3d11_9x
			#pragma glsl

			ENDCG
		}
	}

	Fallback off
}