Shader "Custom/ContrastCyclesShader" {
	Properties {
		
	}
	SubShader {
		Pass
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }      
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

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
				float pi = 3.14159;
				float dist = distance(float2(0.5, 0.5), input.uvcoords.xy);
				float maxDist = length(float2(0.5, 0.5));
				float normalizedDist = dist / maxDist;

				float a = 0.5/64.0f;
				float offset = 0.5;
				float mult = 250;
				float x = 1 - normalizedDist;

				//float f = mult * log(x);
				float f = mult;
				float val = a * sin(2*pi*f*x) + offset;

				return float4(val, val, val, val);
			}

			ENDCG	
		}
		
	} 
	FallBack "Diffuse"
}
