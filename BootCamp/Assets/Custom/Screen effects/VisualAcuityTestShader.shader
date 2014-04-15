Shader "Custom/VisualAcuityTestShader" {
	Properties
	{
		_MainTex ("", any) = "" {} 
		_FocusX ("Focus X", Float) = 0
		_FocusY ("Focus Y", Float) = 0

		_ScreenWidth("Screen width", Float) = 200
		_ScreenHeight("Screen height", Float) = 200

		_MinimumContrastThresholdReciprocal("Minimum contrast threshold, reciprocal (1 / CT_0)", Float) = 64
		_SpatialFrequencyDecayConstant("Spatial frequency decay constant (a)", Float) = 0.106
		_HalfResolutionEccentricity("Half-resolution eccentricity (e_2)", Float) = 2.3 // In degrees. Our variable.

		_UserDistance("User distance in cm", Float) = 70
		_DPCM("Dots per centimeter - screen resolution", Float) = 279 // dpcm = 110 dpi * 2.54 cm/i
		_DPI("Dots per inch - screen resolution", Float) = 110

	}
 
	CGINCLUDE 
	#include "UnityCG.cginc"

	sampler2D _MainTex;
	float _FocusX;
	float _FocusY;
	float _ScreenWidth;
	float _ScreenHeight;

	float _MinimumContrastThresholdReciprocal;
	float _SpatialFrequencyDecayConstant;
	float _HalfResolutionEccentricity;

	float _UserDistance;
	float _DPCM;
	float _DPI;

	struct VertexInput
	{
		float4 position : POSITION;
		float4 uvcoords : TEXCOORD0;
	};
	
	struct FragmentInput
	{
		float4 sv_position : SV_POSITION;
		float4 uvcoords : TEXCOORD1;
	};

	// receives eccentricity IN DEGREES
	float contrastSensitivity(float eccentricity)
	{
		float nominator = _HalfResolutionEccentricity 
			* log(_MinimumContrastThresholdReciprocal); // e_2 * ln(1/CT_0)
		float denominator = _SpatialFrequencyDecayConstant 
			* (eccentricity + _HalfResolutionEccentricity); // a(e(x,y) + e_2)

		return nominator / denominator;
	}

	// receives eccentricity IN DEGREES
	float getResolvableCyclesPerDegreeAt(float angleInDegrees)
	{
		float nominator = _HalfResolutionEccentricity 
			* log(_MinimumContrastThresholdReciprocal); // e_2 * ln(1/CT_0)
		float denominator = _SpatialFrequencyDecayConstant 
			* (angleInDegrees + _HalfResolutionEccentricity); // a(e(x,y) + e_2)

		return nominator / denominator;
	}

	float pixel2cm(float pixels)
	{
		return (pixels / _DPI) * 2.54f;
	}

	float cm2pixel(float cm)
	{
		return (cm * _DPI) / 2.54f;
	}

	// returns eccentricity IN DEGREES
	float eccentricity(float distanceInPixels)
	{
		float quotient = pixel2cm(distanceInPixels) / _UserDistance;
		float rads = atan(quotient);
		return degrees(rads);
	}

	// Converts a number of pixels on screen to number of degrees in
	// user FOV. Assumes user is _UserDistance cm away, and that user
	// view direction is exactly perpendicular to one end of the 
	// line being converted.
	float pixel2degree(float pixels)
	{
		float quotient = pixel2cm(pixels) / _UserDistance;
		float rads = atan(quotient);
		return degrees(rads);
	}

	float degree2pixel(float angle)
	{
		float cm = tan( radians(angle) ) * _UserDistance;
		return cm2pixel(cm);
	}

	float csf(FragmentInput input)
	{
		float2 pixelPos = float2(input.uvcoords.x * _ScreenWidth, input.uvcoords.y * _ScreenHeight);
		float distanceFromMouseInPixels = distance(float2(_FocusX, _FocusY), pixelPos);

/*e*/	float visualEccentricity = pixel2degree(distanceFromMouseInPixels);

		float maxEccentricity = eccentricity(length(float2(1440.0, 900.0)));

		float maxCyclesPerDeg = contrastSensitivity(0.0);
		float minCyclesPerDegOnScreen = contrastSensitivity(maxEccentricity);


		float cyclesPerDeg = contrastSensitivity(visualEccentricity);

		float cyclesInterval = maxCyclesPerDeg - minCyclesPerDegOnScreen;
		return (cyclesPerDeg / maxCyclesPerDeg);
	}

	float cyclesPerDeg2visualAcuity(float cyclesPerDeg)
	{
		return 1;
	}

	float csf2(FragmentInput input)
	{
		float2 pixelPos = float2(input.uvcoords.x * _ScreenWidth, 
								 input.uvcoords.y * _ScreenHeight);
		float distanceFromMouseInPixels = distance(float2(_FocusX, _FocusY), pixelPos);

		float maxCyclesPerDegForScreen = degree2pixel(1.0f); // About 53 c/d on Thorbjørn's screen (110 DPI)

/*e*/	float fragmentEccentricityDeg = pixel2degree(distanceFromMouseInPixels);
		float fragmentCyclesPerDeg = getResolvableCyclesPerDegreeAt(fragmentEccentricityDeg);
	
		if(fragmentCyclesPerDeg > maxCyclesPerDegForScreen)
		{
			return 1;
		}

		return fragmentCyclesPerDeg / maxCyclesPerDegForScreen;

		// TODO map fragmentCyclesPerDeg to some arbitrary [0;1] value, and return that.
	}


	// Simple passthrough vert
	FragmentInput vert(VertexInput input)
	{
		FragmentInput output;
		output.sv_position = mul(UNITY_MATRIX_MVP, input.position);
		output.uvcoords = input.uvcoords;
		return output;
	}
	
	float4 frag(FragmentInput input) : COLOR
	{
		float4 output = float4(0,0,0,0);
		float4 colour = tex2D(_MainTex, input.uvcoords.xy);
		
		float luminance = Luminance(colour.rgb);		
		float4 grey = float4(luminance, luminance, luminance, colour.a);

		// TEMP
		float c =csf2(input);
		return float4(c, c, c, 1);

		return csf2(input) * colour;//output;
	}

	ENDCG

	SubShader {
		 Pass {
			  ZTest Always Cull Off ZWrite Off
			  Fog { Mode off }      

			  CGPROGRAM
			  #pragma target 3.0
			  #pragma fragmentoption ARB_precision_hint_fastest
			  #pragma vertex vert
			  #pragma fragment frag
			  ENDCG
		  }
	}
	FallBack "Diffuse"
}