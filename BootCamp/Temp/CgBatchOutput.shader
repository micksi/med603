﻿Shader "Custom/Bumped specular" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_SpecularColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
		_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
		_ReflectColor ("Reflection Color", Color) = (0.05,0.05,0.05,0.5)
		_MainTex ("Base (RGB) RefStrGloss (A)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "" { TexGen CubeReflect }
		_BumpMap ("Normalmap", 2D) = "bump" {}
	}

	#LINE 24


	// Pixel lighting
	SubShader {
		Tags { "RenderType" = "Opaque" }
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 12
//   opengl - ALU: 32 to 95
//   d3d9 - ALU: 33 to 98
//   d3d11 - ALU: 30 to 81, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 59 ALU
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[5].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R3.xyz, R2, c[22].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R2.xyz, vertex.attrib[14].w, R1;
MOV R0, c[14];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 R0.y, R2, c[5];
DP3 R0.w, -R3, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[22].w;
DP3 R0.y, R2, c[6];
DP3 R0.w, -R3, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[22].w;
DP3 R0.y, R2, c[7];
DP3 R0.w, -R3, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
DP3 result.texcoord[4].y, R2, R1;
DP3 result.texcoord[6].y, R2, R3;
MUL result.texcoord[3], R0, c[22].w;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
DP3 result.texcoord[6].z, vertex.normal, R3;
DP3 result.texcoord[6].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 59 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 62 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c24.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add o6.xyz, r0, r1
mov r0.w, c24.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c21.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c21.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
mul o4, r0, c21.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 10 vars
Vector 112 [_MainTex_ST] 4
Vector 128 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 67 instructions, 5 temp regs, 0 temp arrays:
// ALU 54 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlbipjmdfiokncdnngdnmadgmfkilfflgabaaaaaabealaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daajaaaaeaaaabaaemacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaia
ebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaa
adaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaf
icaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaeaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaa
dgaaaaagbcaabaaaaeaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
aeaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaai
pccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaag
bcaabaaaacaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaa
ckiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaa
aoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaa
aeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaahaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
ahaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaahaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  shlight_3 = tmpvar_29;
  tmpvar_9 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_27).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 c_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_16;
  tmpvar_16 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_15) * 2.0);
  c_14.xyz = tmpvar_16;
  c_14.w = 0.0;
  c_1.w = c_14.w;
  c_1.xyz = (c_14.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  shlight_3 = tmpvar_29;
  tmpvar_9 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_27).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_11;
  normal_11.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_11.z = sqrt((1.0 - clamp (dot (normal_11.xy, normal_11.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, normal_11);
  tmpvar_12.y = dot (tmpvar_4, normal_11);
  tmpvar_12.z = dot (tmpvar_5, normal_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 c_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (normal_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_16;
  tmpvar_16 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_15) * 2.0);
  c_14.xyz = tmpvar_16;
  c_14.w = 0.0;
  c_1.w = c_14.w;
  c_1.xyz = (c_14.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 453
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 430
v2f_surf vert_surf( in appdata_full v ) {
    #line 432
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 436
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 440
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 444
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 448
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 453
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 453
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 457
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    #line 461
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 465
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 469
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 473
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[15].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[15].w;
DP3 R0.y, R1, c[7];
DP3 R0.w, -R2, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3], R0, c[15].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 33 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c13.w
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 160 used size, 11 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 42 instructions, 4 temp regs, 0 temp arrays:
// ALU 30 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhemaommambjieipghbplofjpebdhhjfnabaaaaaajmahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaadaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaa
akiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
dgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaa
bkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_3, tmpvar_10);
  tmpvar_11.y = dot (tmpvar_4, tmpvar_10);
  tmpvar_11.z = dot (tmpvar_5, tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 - (2.0 * (dot (tmpvar_11, tmpvar_2) * tmpvar_11)));
  c_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_12).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 normal_10;
  normal_10.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_10.z = sqrt((1.0 - clamp (dot (normal_10.xy, normal_10.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_3, normal_10);
  tmpvar_11.y = dot (tmpvar_4, normal_10);
  tmpvar_11.z = dot (tmpvar_5, normal_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 - (2.0 * (dot (tmpvar_11, tmpvar_2) * tmpvar_11)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  c_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz * ((8.0 * tmpvar_13.w) * tmpvar_13.xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_12).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 426
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 448
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 429
v2f_surf vert_surf( in appdata_full v ) {
    #line 431
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 435
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 439
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 443
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 426
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 448
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 449
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 452
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    #line 456
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 460
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 464
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 468
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 472
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MUL R1.xyz, vertex.attrib[14].w, R0;
MAD R2.xyz, R2, c[15].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[15].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[15].w;
DP3 R0.y, R1, c[7];
DP3 R0.w, -R2, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
DP3 result.texcoord[5].y, R1, R2;
MUL result.texcoord[3], R0, c[15].w;
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.xyz, c12
mov r1.w, c17.x
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mul r1.xyz, v1.w, r0
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o6.y, r1, r2
mul o4, r0, c13.w
dp3 o6.z, v2, r2
dp3 o6.x, v1, r2
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 160 // 160 used size, 11 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 45 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednodcaiabpghnfoobcaklagdbcodbpbdmabaaaaaabeaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceiagaaaaeaaaabaajcabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
ajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaacaaaaaaaoaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaaeaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
aeaaaaaaakiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaa
aeaaaaaabkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaacaaaaaaaoaaaaaa
baaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaa
ckiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaacaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
agaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaacaaaaaabeaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaabaaaaaahbccabaaa
agaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (tmpvar_12 * (((_World2Object * tmpvar_22).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = _SpecularColor.x;
  tmpvar_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_3, tmpvar_12);
  tmpvar_14.y = dot (tmpvar_4, tmpvar_12);
  tmpvar_14.z = dot (tmpvar_5, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 - (2.0 * (dot (tmpvar_14, tmpvar_2) * tmpvar_14)));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD5);
  mediump vec4 tmpvar_17;
  mediump vec3 viewDir_18;
  viewDir_18 = tmpvar_16;
  highp float nh_19;
  mat3 tmpvar_20;
  tmpvar_20[0].x = 0.816497;
  tmpvar_20[0].y = -0.408248;
  tmpvar_20[0].z = -0.408248;
  tmpvar_20[1].x = 0.0;
  tmpvar_20[1].y = 0.707107;
  tmpvar_20[1].z = -0.707107;
  tmpvar_20[2].x = 0.57735;
  tmpvar_20[2].y = 0.57735;
  tmpvar_20[2].z = 0.57735;
  mediump vec3 normal_21;
  normal_21 = tmpvar_12;
  mediump vec3 scalePerBasisVector_22;
  mediump vec3 lm_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_22 = tmpvar_25;
  lm_23 = (lm_23 * dot (clamp ((tmpvar_20 * normal_21), 0.0, 1.0), scalePerBasisVector_22));
  vec3 v_26;
  v_26.x = tmpvar_20[0].x;
  v_26.y = tmpvar_20[1].x;
  v_26.z = tmpvar_20[2].x;
  vec3 v_27;
  v_27.x = tmpvar_20[0].y;
  v_27.y = tmpvar_20[1].y;
  v_27.z = tmpvar_20[2].y;
  vec3 v_28;
  v_28.x = tmpvar_20[0].z;
  v_28.y = tmpvar_20[1].z;
  v_28.z = tmpvar_20[2].z;
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_12, normalize((normalize((((scalePerBasisVector_22.x * v_26) + (scalePerBasisVector_22.y * v_27)) + (scalePerBasisVector_22.z * v_28))) + viewDir_18))));
  nh_19 = tmpvar_29;
  mediump float arg1_30;
  arg1_30 = (tmpvar_10 * 128.0);
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = lm_23;
  tmpvar_31.w = pow (nh_19, arg1_30);
  tmpvar_17 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_11.xyz * tmpvar_17.xyz);
  c_1.xyz = tmpvar_32;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_15).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (tmpvar_12 * (((_World2Object * tmpvar_22).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_12;
  normal_12.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  highp float tmpvar_13;
  tmpvar_13 = _SpecularColor.x;
  tmpvar_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_3, normal_12);
  tmpvar_14.y = dot (tmpvar_4, normal_12);
  tmpvar_14.z = dot (tmpvar_5, normal_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 - (2.0 * (dot (tmpvar_14, tmpvar_2) * tmpvar_14)));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_LightmapInd, xlv_TEXCOORD4);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD5);
  mediump vec4 tmpvar_19;
  mediump vec3 viewDir_20;
  viewDir_20 = tmpvar_18;
  highp float nh_21;
  mat3 tmpvar_22;
  tmpvar_22[0].x = 0.816497;
  tmpvar_22[0].y = -0.408248;
  tmpvar_22[0].z = -0.408248;
  tmpvar_22[1].x = 0.0;
  tmpvar_22[1].y = 0.707107;
  tmpvar_22[1].z = -0.707107;
  tmpvar_22[2].x = 0.57735;
  tmpvar_22[2].y = 0.57735;
  tmpvar_22[2].z = 0.57735;
  mediump vec3 normal_23;
  normal_23 = normal_12;
  mediump vec3 scalePerBasisVector_24;
  mediump vec3 lm_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((8.0 * tmpvar_16.w) * tmpvar_16.xyz);
  lm_25 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_17.w) * tmpvar_17.xyz);
  scalePerBasisVector_24 = tmpvar_27;
  lm_25 = (lm_25 * dot (clamp ((tmpvar_22 * normal_23), 0.0, 1.0), scalePerBasisVector_24));
  vec3 v_28;
  v_28.x = tmpvar_22[0].x;
  v_28.y = tmpvar_22[1].x;
  v_28.z = tmpvar_22[2].x;
  vec3 v_29;
  v_29.x = tmpvar_22[0].y;
  v_29.y = tmpvar_22[1].y;
  v_29.z = tmpvar_22[2].y;
  vec3 v_30;
  v_30.x = tmpvar_22[0].z;
  v_30.y = tmpvar_22[1].z;
  v_30.z = tmpvar_22[2].z;
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, dot (normal_12, normalize((normalize((((scalePerBasisVector_24.x * v_28) + (scalePerBasisVector_24.y * v_29)) + (scalePerBasisVector_24.z * v_30))) + viewDir_20))));
  nh_21 = tmpvar_31;
  mediump float arg1_32;
  arg1_32 = (tmpvar_10 * 128.0);
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = lm_25;
  tmpvar_33.w = pow (nh_21, arg1_32);
  tmpvar_19 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_11.xyz * tmpvar_19.xyz);
  c_1.xyz = tmpvar_34;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_15).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 453
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 430
v2f_surf vert_surf( in appdata_full v ) {
    #line 432
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 436
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 440
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 444
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 449
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 453
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 453
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 457
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    #line 461
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 465
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 469
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 473
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    c.xyz += specColor;
    c.xyz += (o.Albedo * lm);
    #line 477
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 64 ALU
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[5].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R3.xyz, R2, c[23].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R2.xyz, vertex.attrib[14].w, R1;
MOV R0, c[15];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 R0.y, R2, c[5];
DP3 R0.w, -R3, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[23].w;
DP3 R0.y, R2, c[6];
DP3 R0.w, -R3, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[23].w;
DP3 R0.y, R2, c[7];
DP3 R0.w, -R3, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3], R0, c[23].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[4].y, R2, R1;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[6].y, R2, R3;
DP3 result.texcoord[6].z, vertex.normal, R3;
DP3 result.texcoord[6].x, vertex.attrib[14], R3;
ADD result.texcoord[7].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[7].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 64 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_3_0
; 67 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c26.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add o6.xyz, r0, r1
mov r0.w, c26.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c23.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c23.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c23.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c13.x
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 72 instructions, 6 temp regs, 0 temp arrays:
// ALU 57 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedanmoidhdmcmffjkdkegmiolohbeljcoiabaaaaaamealaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmiajaaaaeaaaabaa
hcacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
acaaaaaafgafbaiaebaaaaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaallcaabaaaacaaaaaaegiicaaaadaaaaaaaoaaaaaa
kgakbaiaebaaaaaaabaaaaaaegaibaaaacaaaaaadgaaaaaficaabaaaadaaaaaa
akaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaafaaaaaaakiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaafaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
afaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaa
aeaaaaaaegacbaaaafaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaafaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
afaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaadaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaaficaabaaaadaaaaaabkaabaaaacaaaaaadgaaaaagbcaabaaa
afaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaafaaaaaabkiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaafaaaaaabkiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaabaaaaaah
bcaabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaafaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaadaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaadaaaaaa
ckiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaackiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaa
acaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaa
egakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
afaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaiaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  shlight_3 = tmpvar_29;
  tmpvar_9 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_27).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp float tmpvar_14;
  mediump float lightShadowDataX_15;
  highp float dist_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((dist_16 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_15);
  tmpvar_14 = tmpvar_19;
  lowp vec4 c_20;
  lowp float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_22;
  tmpvar_22 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_21) * (tmpvar_14 * 2.0));
  c_20.xyz = tmpvar_22;
  c_20.w = 0.0;
  c_1.w = c_20.w;
  c_1.xyz = (c_20.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_12;
  tmpvar_12[0] = _Object2World[0].xyz;
  tmpvar_12[1] = _Object2World[1].xyz;
  tmpvar_12[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_glesVertex.xyz - ((_World2Object * tmpvar_11).xyz * unity_Scale.w)));
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_14 = tmpvar_1.xyz;
  tmpvar_15 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14.x;
  tmpvar_16[0].y = tmpvar_15.x;
  tmpvar_16[0].z = tmpvar_2.x;
  tmpvar_16[1].x = tmpvar_14.y;
  tmpvar_16[1].y = tmpvar_15.y;
  tmpvar_16[1].z = tmpvar_2.y;
  tmpvar_16[2].x = tmpvar_14.z;
  tmpvar_16[2].y = tmpvar_15.z;
  tmpvar_16[2].z = tmpvar_2.z;
  vec4 v_17;
  v_17.x = _Object2World[0].x;
  v_17.y = _Object2World[1].x;
  v_17.z = _Object2World[2].x;
  v_17.w = _Object2World[3].x;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_16 * v_17.xyz);
  tmpvar_18.w = tmpvar_13.x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].y;
  v_20.y = _Object2World[1].y;
  v_20.z = _Object2World[2].y;
  v_20.w = _Object2World[3].y;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_16 * v_20.xyz);
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  vec4 v_23;
  v_23.x = _Object2World[0].z;
  v_23.y = _Object2World[1].z;
  v_23.z = _Object2World[2].z;
  v_23.w = _Object2World[3].z;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (tmpvar_16 * v_23.xyz);
  tmpvar_24.w = tmpvar_13.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_24 * unity_Scale.w);
  tmpvar_7 = tmpvar_25;
  mat3 tmpvar_26;
  tmpvar_26[0] = _Object2World[0].xyz;
  tmpvar_26[1] = _Object2World[1].xyz;
  tmpvar_26[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_16 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = (tmpvar_26 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_30;
  mediump vec4 normal_31;
  normal_31 = tmpvar_29;
  highp float vC_32;
  mediump vec3 x3_33;
  mediump vec3 x2_34;
  mediump vec3 x1_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAr, normal_31);
  x1_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAg, normal_31);
  x1_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAb, normal_31);
  x1_35.z = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = (normal_31.xyzz * normal_31.yzzx);
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBr, tmpvar_39);
  x2_34.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBg, tmpvar_39);
  x2_34.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBb, tmpvar_39);
  x2_34.z = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y));
  vC_32 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = (unity_SHC.xyz * vC_32);
  x3_33 = tmpvar_44;
  tmpvar_30 = ((x1_35 + x2_34) + x3_33);
  shlight_3 = tmpvar_30;
  tmpvar_9 = shlight_3;
  highp vec4 o_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_47;
  tmpvar_47.x = tmpvar_46.x;
  tmpvar_47.y = (tmpvar_46.y * _ProjectionParams.x);
  o_45.xy = (tmpvar_47 + tmpvar_46.w);
  o_45.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_16 * (((_World2Object * tmpvar_28).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = o_45;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_11;
  normal_11.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_11.z = sqrt((1.0 - clamp (dot (normal_11.xy, normal_11.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, normal_11);
  tmpvar_12.y = dot (tmpvar_4, normal_11);
  tmpvar_12.z = dot (tmpvar_5, normal_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  lowp vec4 c_15;
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (normal_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_16) * (tmpvar_14.x * 2.0));
  c_15.xyz = tmpvar_17;
  c_15.w = 0.0;
  c_1.w = c_15.w;
  c_1.xyz = (c_15.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 453
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 461
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 465
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 469
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 473
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 477
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 481
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 38 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP4 R1.w, vertex.position, c[4];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[16].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[16].w;
DP3 R0.y, R1, c[7];
DP4 R1.z, vertex.position, c[3];
DP3 R0.w, -R2, c[7];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].y;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3], R0, c[16].w;
MOV R0.x, R2;
MUL R0.y, R2, c[14].x;
ADD result.texcoord[5].xy, R0, R2.z;
MOV result.position, R1;
MOV result.texcoord[5].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 38 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c19.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c15.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c15.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c15.w
dp3 r0.y, r1, c6
dp4 r1.z, v0, c2
dp3 r0.w, -r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c19.y
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c15.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o6.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o6.zw, r1
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 224 used size, 12 vars
Vector 176 [unity_LightmapST] 4
Vector 192 [_MainTex_ST] 4
Vector 208 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 47 instructions, 5 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedninbfdpincnlloobblolmhocbddgncbfabaaaaaaemaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefciaagaaaaeaaaabaakaabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaanaaaaaakgiocaaaaaaaaaaa
anaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegaibaaaacaaaaaadcaaaaal
lcaabaaaabaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaabaaaaaa
egambaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaaeaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaa
akiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaacaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaa
acaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaeaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
acaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
agaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_3, tmpvar_10);
  tmpvar_11.y = dot (tmpvar_4, tmpvar_10);
  tmpvar_11.z = dot (tmpvar_5, tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 - (2.0 * (dot (tmpvar_11, tmpvar_2) * tmpvar_11)));
  lowp float tmpvar_13;
  mediump float lightShadowDataX_14;
  highp float dist_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_14 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((dist_15 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_14);
  tmpvar_13 = tmpvar_18;
  c_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz), vec3((tmpvar_13 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_12).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = o_23;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 normal_10;
  normal_10.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_10.z = sqrt((1.0 - clamp (dot (normal_10.xy, normal_10.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_3, normal_10);
  tmpvar_11.y = dot (tmpvar_4, normal_10);
  tmpvar_11.z = dot (tmpvar_5, normal_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 - (2.0 * (dot (tmpvar_11, tmpvar_2) * tmpvar_11)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec3 tmpvar_15;
  tmpvar_15 = ((8.0 * tmpvar_14.w) * tmpvar_14.xyz);
  c_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz * max (min (tmpvar_15, ((tmpvar_13.x * 2.0) * tmpvar_14.xyz)), (tmpvar_15 * tmpvar_13.x)));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_12).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 435
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    #line 440
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 444
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 448
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 452
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 435
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 465
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 469
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 473
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 477
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 481
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 40 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MUL R1.xyz, vertex.attrib[14].w, R0;
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[16].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[16].w;
DP3 R0.y, R1, c[7];
DP3 R0.w, -R2, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3], R0, c[16].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[5].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 40 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.xyz, c12
mov r1.w, c19.x
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mul r1.xyz, v1.w, r0
mad r2.xyz, r2, c15.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c15.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c15.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c15.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
dp3 o6.y, r1, r2
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c13.x
dp3 o6.z, v2, r2
dp3 o6.x, v1, r2
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o7.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 224 used size, 12 vars
Vector 176 [unity_LightmapST] 4
Vector 192 [_MainTex_ST] 4
Vector 208 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 50 instructions, 6 temp regs, 0 temp arrays:
// ALU 36 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmkejmhbhnlcjnhiicckdlfmajklkbdhabaaaaaameaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaagaaaaeaaaabaaliabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaaddccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaanaaaaaakgiocaaa
aaaaaaaaanaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaia
ebaaaaaaabaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaallcaabaaaacaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaa
abaaaaaaegaibaaaacaaaaaadgaaaaaficaabaaaadaaaaaaakaabaaaacaaaaaa
diaaaaahhcaabaaaaeaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaeaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaafaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaa
afaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaafaaaaaaakiacaaa
acaaaaaaaoaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaafaaaaaa
baaaaaahecaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaafaaaaaadiaaaaai
pccabaaaacaaaaaaegaobaaaadaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaf
icaabaaaadaaaaaabkaabaaaacaaaaaadgaaaaagbcaabaaaafaaaaaabkiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaafaaaaaabkiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaafaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaa
adaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaabaaaaaahbcaabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaafaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaadaaaaaa
pgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaadaaaaaackiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaadaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaadaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahcccabaaaagaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadcaaaaaldccabaaaafaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (tmpvar_12 * (((_World2Object * tmpvar_22).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = _SpecularColor.x;
  tmpvar_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_3, tmpvar_12);
  tmpvar_14.y = dot (tmpvar_4, tmpvar_12);
  tmpvar_14.z = dot (tmpvar_5, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 - (2.0 * (dot (tmpvar_14, tmpvar_2) * tmpvar_14)));
  lowp float tmpvar_16;
  mediump float lightShadowDataX_17;
  highp float dist_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((dist_18 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_17);
  tmpvar_16 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD5);
  mediump vec4 tmpvar_23;
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_22;
  highp float nh_25;
  mat3 tmpvar_26;
  tmpvar_26[0].x = 0.816497;
  tmpvar_26[0].y = -0.408248;
  tmpvar_26[0].z = -0.408248;
  tmpvar_26[1].x = 0.0;
  tmpvar_26[1].y = 0.707107;
  tmpvar_26[1].z = -0.707107;
  tmpvar_26[2].x = 0.57735;
  tmpvar_26[2].y = 0.57735;
  tmpvar_26[2].z = 0.57735;
  mediump vec3 normal_27;
  normal_27 = tmpvar_12;
  mediump vec3 scalePerBasisVector_28;
  mediump vec3 lm_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_29 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_28 = tmpvar_31;
  lm_29 = (lm_29 * dot (clamp ((tmpvar_26 * normal_27), 0.0, 1.0), scalePerBasisVector_28));
  vec3 v_32;
  v_32.x = tmpvar_26[0].x;
  v_32.y = tmpvar_26[1].x;
  v_32.z = tmpvar_26[2].x;
  vec3 v_33;
  v_33.x = tmpvar_26[0].y;
  v_33.y = tmpvar_26[1].y;
  v_33.z = tmpvar_26[2].y;
  vec3 v_34;
  v_34.x = tmpvar_26[0].z;
  v_34.y = tmpvar_26[1].z;
  v_34.z = tmpvar_26[2].z;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, dot (tmpvar_12, normalize((normalize((((scalePerBasisVector_28.x * v_32) + (scalePerBasisVector_28.y * v_33)) + (scalePerBasisVector_28.z * v_34))) + viewDir_24))));
  nh_25 = tmpvar_35;
  mediump float arg1_36;
  arg1_36 = (tmpvar_10 * 128.0);
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = lm_29;
  tmpvar_37.w = pow (nh_25, arg1_36);
  tmpvar_23 = tmpvar_37;
  lowp vec3 tmpvar_38;
  tmpvar_38 = vec3((tmpvar_16 * 2.0));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_11.xyz * min (tmpvar_23.xyz, tmpvar_38));
  c_1.xyz = tmpvar_39;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_15).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _WorldSpaceCameraPos;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (tmpvar_13 * (((_World2Object * tmpvar_23).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD6 = o_24;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_12;
  normal_12.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_12.z = sqrt((1.0 - clamp (dot (normal_12.xy, normal_12.xy), 0.0, 1.0)));
  highp float tmpvar_13;
  tmpvar_13 = _SpecularColor.x;
  tmpvar_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_3, normal_12);
  tmpvar_14.y = dot (tmpvar_4, normal_12);
  tmpvar_14.z = dot (tmpvar_5, normal_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 - (2.0 * (dot (tmpvar_14, tmpvar_2) * tmpvar_14)));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_LightmapInd, xlv_TEXCOORD4);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD5);
  mediump vec4 tmpvar_20;
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_19;
  highp float nh_22;
  mat3 tmpvar_23;
  tmpvar_23[0].x = 0.816497;
  tmpvar_23[0].y = -0.408248;
  tmpvar_23[0].z = -0.408248;
  tmpvar_23[1].x = 0.0;
  tmpvar_23[1].y = 0.707107;
  tmpvar_23[1].z = -0.707107;
  tmpvar_23[2].x = 0.57735;
  tmpvar_23[2].y = 0.57735;
  tmpvar_23[2].z = 0.57735;
  mediump vec3 normal_24;
  normal_24 = normal_12;
  mediump vec3 scalePerBasisVector_25;
  mediump vec3 lm_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_17.w) * tmpvar_17.xyz);
  lm_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((8.0 * tmpvar_18.w) * tmpvar_18.xyz);
  scalePerBasisVector_25 = tmpvar_28;
  lm_26 = (lm_26 * dot (clamp ((tmpvar_23 * normal_24), 0.0, 1.0), scalePerBasisVector_25));
  vec3 v_29;
  v_29.x = tmpvar_23[0].x;
  v_29.y = tmpvar_23[1].x;
  v_29.z = tmpvar_23[2].x;
  vec3 v_30;
  v_30.x = tmpvar_23[0].y;
  v_30.y = tmpvar_23[1].y;
  v_30.z = tmpvar_23[2].y;
  vec3 v_31;
  v_31.x = tmpvar_23[0].z;
  v_31.y = tmpvar_23[1].z;
  v_31.z = tmpvar_23[2].z;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (normal_12, normalize((normalize((((scalePerBasisVector_25.x * v_29) + (scalePerBasisVector_25.y * v_30)) + (scalePerBasisVector_25.z * v_31))) + viewDir_21))));
  nh_22 = tmpvar_32;
  mediump float arg1_33;
  arg1_33 = (tmpvar_10 * 128.0);
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = lm_26;
  tmpvar_34.w = pow (nh_22, arg1_33);
  tmpvar_20 = tmpvar_34;
  lowp vec3 arg1_35;
  arg1_35 = ((tmpvar_16.x * 2.0) * tmpvar_17.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_11.xyz * max (min (tmpvar_20.xyz, arg1_35), (tmpvar_20.xyz * tmpvar_16.x)));
  c_1.xyz = tmpvar_36;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_15).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 436
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 461
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 453
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 436
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 461
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 465
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 469
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 473
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 477
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 481
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    #line 485
    c.xyz += specColor;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 489
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 90 ALU
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[5].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R3.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R2.xyz, vertex.attrib[14].w, R1;
MOV R0, c[14];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 R0.y, R2, c[5];
DP3 R0.w, -R3, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[30].w;
DP3 R0.y, R2, c[6];
DP3 R0.w, -R3, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[30].w;
DP3 R0.y, R2, c[7];
DP3 R0.w, -R3, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
DP3 result.texcoord[4].y, R2, R1;
DP3 result.texcoord[6].y, R2, R3;
MUL result.texcoord[3], R0, c[30].w;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
DP3 result.texcoord[6].z, vertex.normal, R3;
DP3 result.texcoord[6].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 90 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 93 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add o6.xyz, r0, r1
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c29.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c29.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
mul o4, r0, c29.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 10 vars
Vector 112 [_MainTex_ST] 4
Vector 128 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 91 instructions, 7 temp regs, 0 temp arrays:
// ALU 78 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbiafigdhimkjljnjfmmladoioglnejeabaaaaaageaoaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaamaaaaeaaaabaacaadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
diaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaia
ebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaa
adaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaf
icaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaeaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaa
dgaaaaagbcaabaaaaeaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
aeaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaai
pccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaag
bcaabaaaacaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaa
ckiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaa
aoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaa
aeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaahaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
acaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaabbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
fgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
fgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_26;
  mediump vec3 tmpvar_30;
  mediump vec4 normal_31;
  normal_31 = tmpvar_29;
  highp float vC_32;
  mediump vec3 x3_33;
  mediump vec3 x2_34;
  mediump vec3 x1_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAr, normal_31);
  x1_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAg, normal_31);
  x1_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAb, normal_31);
  x1_35.z = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = (normal_31.xyzz * normal_31.yzzx);
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBr, tmpvar_39);
  x2_34.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBg, tmpvar_39);
  x2_34.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBb, tmpvar_39);
  x2_34.z = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y));
  vC_32 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = (unity_SHC.xyz * vC_32);
  x3_33 = tmpvar_44;
  tmpvar_30 = ((x1_35 + x2_34) + x3_33);
  shlight_3 = tmpvar_30;
  tmpvar_9 = shlight_3;
  highp vec3 tmpvar_45;
  tmpvar_45 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_46;
  tmpvar_46 = (unity_4LightPosX0 - tmpvar_45.x);
  highp vec4 tmpvar_47;
  tmpvar_47 = (unity_4LightPosY0 - tmpvar_45.y);
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosZ0 - tmpvar_45.z);
  highp vec4 tmpvar_49;
  tmpvar_49 = (((tmpvar_46 * tmpvar_46) + (tmpvar_47 * tmpvar_47)) + (tmpvar_48 * tmpvar_48));
  highp vec4 tmpvar_50;
  tmpvar_50 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_46 * tmpvar_26.x) + (tmpvar_47 * tmpvar_26.y)) + (tmpvar_48 * tmpvar_26.z)) * inversesqrt(tmpvar_49))) * (1.0/((1.0 + (tmpvar_49 * unity_4LightAtten0)))));
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_9 + ((((unity_LightColor[0].xyz * tmpvar_50.x) + (unity_LightColor[1].xyz * tmpvar_50.y)) + (unity_LightColor[2].xyz * tmpvar_50.z)) + (unity_LightColor[3].xyz * tmpvar_50.w)));
  tmpvar_9 = tmpvar_51;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_28).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 c_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_16;
  tmpvar_16 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_15) * 2.0);
  c_14.xyz = tmpvar_16;
  c_14.w = 0.0;
  c_1.w = c_14.w;
  c_1.xyz = (c_14.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_26;
  mediump vec3 tmpvar_30;
  mediump vec4 normal_31;
  normal_31 = tmpvar_29;
  highp float vC_32;
  mediump vec3 x3_33;
  mediump vec3 x2_34;
  mediump vec3 x1_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAr, normal_31);
  x1_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAg, normal_31);
  x1_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAb, normal_31);
  x1_35.z = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = (normal_31.xyzz * normal_31.yzzx);
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBr, tmpvar_39);
  x2_34.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBg, tmpvar_39);
  x2_34.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBb, tmpvar_39);
  x2_34.z = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y));
  vC_32 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = (unity_SHC.xyz * vC_32);
  x3_33 = tmpvar_44;
  tmpvar_30 = ((x1_35 + x2_34) + x3_33);
  shlight_3 = tmpvar_30;
  tmpvar_9 = shlight_3;
  highp vec3 tmpvar_45;
  tmpvar_45 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_46;
  tmpvar_46 = (unity_4LightPosX0 - tmpvar_45.x);
  highp vec4 tmpvar_47;
  tmpvar_47 = (unity_4LightPosY0 - tmpvar_45.y);
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosZ0 - tmpvar_45.z);
  highp vec4 tmpvar_49;
  tmpvar_49 = (((tmpvar_46 * tmpvar_46) + (tmpvar_47 * tmpvar_47)) + (tmpvar_48 * tmpvar_48));
  highp vec4 tmpvar_50;
  tmpvar_50 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_46 * tmpvar_26.x) + (tmpvar_47 * tmpvar_26.y)) + (tmpvar_48 * tmpvar_26.z)) * inversesqrt(tmpvar_49))) * (1.0/((1.0 + (tmpvar_49 * unity_4LightAtten0)))));
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_9 + ((((unity_LightColor[0].xyz * tmpvar_50.x) + (unity_LightColor[1].xyz * tmpvar_50.y)) + (unity_LightColor[2].xyz * tmpvar_50.z)) + (unity_LightColor[3].xyz * tmpvar_50.w)));
  tmpvar_9 = tmpvar_51;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_28).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_11;
  normal_11.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_11.z = sqrt((1.0 - clamp (dot (normal_11.xy, normal_11.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, normal_11);
  tmpvar_12.y = dot (tmpvar_4, normal_11);
  tmpvar_12.z = dot (tmpvar_5, normal_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 c_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (normal_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_16;
  tmpvar_16 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_15) * 2.0);
  c_14.xyz = tmpvar_16;
  c_14.w = 0.0;
  c_1.w = c_14.w;
  c_1.xyz = (c_14.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 430
v2f_surf vert_surf( in appdata_full v ) {
    #line 432
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 436
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 440
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 444
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 448
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    #line 453
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 455
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 457
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 461
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 465
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 469
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 473
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 95 ALU
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[5].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R3.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R2.xyz, vertex.attrib[14].w, R1;
MOV R0, c[15];
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 R0.y, R2, c[5];
DP3 R0.w, -R3, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1], R0, c[31].w;
DP3 R0.y, R2, c[6];
DP3 R0.w, -R3, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2], R0, c[31].w;
DP3 R0.y, R2, c[7];
DP3 R0.w, -R3, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3], R0, c[31].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[4].y, R2, R1;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[6].y, R2, R3;
DP3 result.texcoord[6].z, vertex.normal, R3;
DP3 result.texcoord[6].x, vertex.attrib[14], R3;
ADD result.texcoord[7].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[7].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 95 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_3_0
; 98 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add o6.xyz, r0, r1
mov r1.w, c34.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c31.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c31.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c31.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c13.x
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 96 instructions, 8 temp regs, 0 temp arrays:
// ALU 81 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedchppbggbakjmjpcokifeabbepnacgeddabaaaaaabeapaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbianaaaaeaaaabaa
egadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacaiaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
amaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
acaaaaaafgafbaiaebaaaaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaallcaabaaaacaaaaaaegiicaaaadaaaaaaaoaaaaaa
kgakbaiaebaaaaaaabaaaaaaegaibaaaacaaaaaadgaaaaaficaabaaaadaaaaaa
akaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaafaaaaaaakiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaafaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
afaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaa
aeaaaaaaegacbaaaafaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaafaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
afaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaadaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaaficaabaaaadaaaaaabkaabaaaacaaaaaadgaaaaagbcaabaaa
afaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaafaaaaaabkiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaafaaaaaabkiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaabaaaaaah
bcaabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaafaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaadaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaadaaaaaa
ckiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaackiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
acaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaai
hcaabaaaadaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaaeaaaaaafgafbaaaadaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaadaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaa
aeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
adaaaaaaegadbaaaadaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaa
egakbaaaacaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
afaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaeaaaaaaaaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaa
egaobaaaafaaaaaadiaaaaahpcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaaaaaaaajpcaabaaaahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaa
agaabaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
aeaaaaaakgakbaaaacaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaahaaaaaaegaobaaaahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaaf
pcaabaaaafaaaaaaegaobaaaaeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaaeaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaafaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaa
aeaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaiaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_26;
  mediump vec3 tmpvar_30;
  mediump vec4 normal_31;
  normal_31 = tmpvar_29;
  highp float vC_32;
  mediump vec3 x3_33;
  mediump vec3 x2_34;
  mediump vec3 x1_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAr, normal_31);
  x1_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAg, normal_31);
  x1_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAb, normal_31);
  x1_35.z = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = (normal_31.xyzz * normal_31.yzzx);
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBr, tmpvar_39);
  x2_34.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBg, tmpvar_39);
  x2_34.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBb, tmpvar_39);
  x2_34.z = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y));
  vC_32 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = (unity_SHC.xyz * vC_32);
  x3_33 = tmpvar_44;
  tmpvar_30 = ((x1_35 + x2_34) + x3_33);
  shlight_3 = tmpvar_30;
  tmpvar_9 = shlight_3;
  highp vec3 tmpvar_45;
  tmpvar_45 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_46;
  tmpvar_46 = (unity_4LightPosX0 - tmpvar_45.x);
  highp vec4 tmpvar_47;
  tmpvar_47 = (unity_4LightPosY0 - tmpvar_45.y);
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosZ0 - tmpvar_45.z);
  highp vec4 tmpvar_49;
  tmpvar_49 = (((tmpvar_46 * tmpvar_46) + (tmpvar_47 * tmpvar_47)) + (tmpvar_48 * tmpvar_48));
  highp vec4 tmpvar_50;
  tmpvar_50 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_46 * tmpvar_26.x) + (tmpvar_47 * tmpvar_26.y)) + (tmpvar_48 * tmpvar_26.z)) * inversesqrt(tmpvar_49))) * (1.0/((1.0 + (tmpvar_49 * unity_4LightAtten0)))));
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_9 + ((((unity_LightColor[0].xyz * tmpvar_50.x) + (unity_LightColor[1].xyz * tmpvar_50.y)) + (unity_LightColor[2].xyz * tmpvar_50.z)) + (unity_LightColor[3].xyz * tmpvar_50.w)));
  tmpvar_9 = tmpvar_51;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_28).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp float tmpvar_14;
  mediump float lightShadowDataX_15;
  highp float dist_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max (float((dist_16 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_15);
  tmpvar_14 = tmpvar_19;
  lowp vec4 c_20;
  lowp float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_22;
  tmpvar_22 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_21) * (tmpvar_14 * 2.0));
  c_20.xyz = tmpvar_22;
  c_20.w = 0.0;
  c_1.w = c_20.w;
  c_1.xyz = (c_20.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_12;
  tmpvar_12[0] = _Object2World[0].xyz;
  tmpvar_12[1] = _Object2World[1].xyz;
  tmpvar_12[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_glesVertex.xyz - ((_World2Object * tmpvar_11).xyz * unity_Scale.w)));
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_14 = tmpvar_1.xyz;
  tmpvar_15 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14.x;
  tmpvar_16[0].y = tmpvar_15.x;
  tmpvar_16[0].z = tmpvar_2.x;
  tmpvar_16[1].x = tmpvar_14.y;
  tmpvar_16[1].y = tmpvar_15.y;
  tmpvar_16[1].z = tmpvar_2.y;
  tmpvar_16[2].x = tmpvar_14.z;
  tmpvar_16[2].y = tmpvar_15.z;
  tmpvar_16[2].z = tmpvar_2.z;
  vec4 v_17;
  v_17.x = _Object2World[0].x;
  v_17.y = _Object2World[1].x;
  v_17.z = _Object2World[2].x;
  v_17.w = _Object2World[3].x;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_16 * v_17.xyz);
  tmpvar_18.w = tmpvar_13.x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].y;
  v_20.y = _Object2World[1].y;
  v_20.z = _Object2World[2].y;
  v_20.w = _Object2World[3].y;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_16 * v_20.xyz);
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  vec4 v_23;
  v_23.x = _Object2World[0].z;
  v_23.y = _Object2World[1].z;
  v_23.z = _Object2World[2].z;
  v_23.w = _Object2World[3].z;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (tmpvar_16 * v_23.xyz);
  tmpvar_24.w = tmpvar_13.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_24 * unity_Scale.w);
  tmpvar_7 = tmpvar_25;
  mat3 tmpvar_26;
  tmpvar_26[0] = _Object2World[0].xyz;
  tmpvar_26[1] = _Object2World[1].xyz;
  tmpvar_26[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_16 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_27;
  mediump vec3 tmpvar_31;
  mediump vec4 normal_32;
  normal_32 = tmpvar_30;
  highp float vC_33;
  mediump vec3 x3_34;
  mediump vec3 x2_35;
  mediump vec3 x1_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAr, normal_32);
  x1_36.x = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAg, normal_32);
  x1_36.y = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHAb, normal_32);
  x1_36.z = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (normal_32.xyzz * normal_32.yzzx);
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBr, tmpvar_40);
  x2_35.x = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBg, tmpvar_40);
  x2_35.y = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHBb, tmpvar_40);
  x2_35.z = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = ((normal_32.x * normal_32.x) - (normal_32.y * normal_32.y));
  vC_33 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = (unity_SHC.xyz * vC_33);
  x3_34 = tmpvar_45;
  tmpvar_31 = ((x1_36 + x2_35) + x3_34);
  shlight_3 = tmpvar_31;
  tmpvar_9 = shlight_3;
  highp vec3 tmpvar_46;
  tmpvar_46 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_47;
  tmpvar_47 = (unity_4LightPosX0 - tmpvar_46.x);
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosY0 - tmpvar_46.y);
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosZ0 - tmpvar_46.z);
  highp vec4 tmpvar_50;
  tmpvar_50 = (((tmpvar_47 * tmpvar_47) + (tmpvar_48 * tmpvar_48)) + (tmpvar_49 * tmpvar_49));
  highp vec4 tmpvar_51;
  tmpvar_51 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_47 * tmpvar_27.x) + (tmpvar_48 * tmpvar_27.y)) + (tmpvar_49 * tmpvar_27.z)) * inversesqrt(tmpvar_50))) * (1.0/((1.0 + (tmpvar_50 * unity_4LightAtten0)))));
  highp vec3 tmpvar_52;
  tmpvar_52 = (tmpvar_9 + ((((unity_LightColor[0].xyz * tmpvar_51.x) + (unity_LightColor[1].xyz * tmpvar_51.y)) + (unity_LightColor[2].xyz * tmpvar_51.z)) + (unity_LightColor[3].xyz * tmpvar_51.w)));
  tmpvar_9 = tmpvar_52;
  highp vec4 o_53;
  highp vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_55;
  tmpvar_55.x = tmpvar_54.x;
  tmpvar_55.y = (tmpvar_54.y * _ProjectionParams.x);
  o_53.xy = (tmpvar_55 + tmpvar_54.w);
  o_53.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_16 * (((_World2Object * tmpvar_29).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = o_53;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_11;
  normal_11.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_11.z = sqrt((1.0 - clamp (dot (normal_11.xy, normal_11.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, normal_11);
  tmpvar_12.y = dot (tmpvar_4, normal_11);
  tmpvar_12.z = dot (tmpvar_5, normal_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  lowp vec4 c_15;
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (normal_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_16) * (tmpvar_14.x * 2.0));
  c_15.xyz = tmpvar_17;
  c_15.w = 0.0;
  c_1.w = c_15.w;
  c_1.xyz = (c_15.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 465
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 453
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    #line 461
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 465
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 465
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 469
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    #line 473
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 477
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 481
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 485
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  shlight_3 = tmpvar_29;
  tmpvar_9 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_27).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp float shadow_14;
  lowp float tmpvar_15;
  tmpvar_15 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_LightShadowData.x + (tmpvar_15 * (1.0 - _LightShadowData.x)));
  shadow_14 = tmpvar_16;
  lowp vec4 c_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_18) * (shadow_14 * 2.0));
  c_17.xyz = tmpvar_19;
  c_17.w = 0.0;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 453
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 461
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 465
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 469
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 473
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 477
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 481
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_3, tmpvar_10);
  tmpvar_11.y = dot (tmpvar_4, tmpvar_10);
  tmpvar_11.z = dot (tmpvar_5, tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 - (2.0 * (dot (tmpvar_11, tmpvar_2) * tmpvar_11)));
  lowp float shadow_13;
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_13 = tmpvar_15;
  c_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz), vec3((shadow_13 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_12).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 435
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    #line 440
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 444
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 448
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 452
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 435
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 465
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 469
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 473
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 477
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 481
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_glesVertex.xyz - ((_World2Object * tmpvar_7).xyz * unity_Scale.w)));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  vec4 v_13;
  v_13.x = _Object2World[0].x;
  v_13.y = _Object2World[1].x;
  v_13.z = _Object2World[2].x;
  v_13.w = _Object2World[3].x;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_12 * v_13.xyz);
  tmpvar_14.w = tmpvar_9.x;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * unity_Scale.w);
  tmpvar_4 = tmpvar_15;
  vec4 v_16;
  v_16.x = _Object2World[0].y;
  v_16.y = _Object2World[1].y;
  v_16.z = _Object2World[2].y;
  v_16.w = _Object2World[3].y;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_12 * v_16.xyz);
  tmpvar_17.w = tmpvar_9.y;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].z;
  v_19.y = _Object2World[1].z;
  v_19.z = _Object2World[2].z;
  v_19.w = _Object2World[3].z;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_12 * v_19.xyz);
  tmpvar_20.w = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (tmpvar_12 * (((_World2Object * tmpvar_22).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = _SpecularColor.x;
  tmpvar_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_3, tmpvar_12);
  tmpvar_14.y = dot (tmpvar_4, tmpvar_12);
  tmpvar_14.z = dot (tmpvar_5, tmpvar_12);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 - (2.0 * (dot (tmpvar_14, tmpvar_2) * tmpvar_14)));
  lowp float shadow_16;
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_18;
  tmpvar_18 = (_LightShadowData.x + (tmpvar_17 * (1.0 - _LightShadowData.x)));
  shadow_16 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD5);
  mediump vec4 tmpvar_20;
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_19;
  highp float nh_22;
  mat3 tmpvar_23;
  tmpvar_23[0].x = 0.816497;
  tmpvar_23[0].y = -0.408248;
  tmpvar_23[0].z = -0.408248;
  tmpvar_23[1].x = 0.0;
  tmpvar_23[1].y = 0.707107;
  tmpvar_23[1].z = -0.707107;
  tmpvar_23[2].x = 0.57735;
  tmpvar_23[2].y = 0.57735;
  tmpvar_23[2].z = 0.57735;
  mediump vec3 normal_24;
  normal_24 = tmpvar_12;
  mediump vec3 scalePerBasisVector_25;
  mediump vec3 lm_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_25 = tmpvar_28;
  lm_26 = (lm_26 * dot (clamp ((tmpvar_23 * normal_24), 0.0, 1.0), scalePerBasisVector_25));
  vec3 v_29;
  v_29.x = tmpvar_23[0].x;
  v_29.y = tmpvar_23[1].x;
  v_29.z = tmpvar_23[2].x;
  vec3 v_30;
  v_30.x = tmpvar_23[0].y;
  v_30.y = tmpvar_23[1].y;
  v_30.z = tmpvar_23[2].y;
  vec3 v_31;
  v_31.x = tmpvar_23[0].z;
  v_31.y = tmpvar_23[1].z;
  v_31.z = tmpvar_23[2].z;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (tmpvar_12, normalize((normalize((((scalePerBasisVector_25.x * v_29) + (scalePerBasisVector_25.y * v_30)) + (scalePerBasisVector_25.z * v_31))) + viewDir_21))));
  nh_22 = tmpvar_32;
  mediump float arg1_33;
  arg1_33 = (tmpvar_10 * 128.0);
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = lm_26;
  tmpvar_34.w = pow (nh_22, arg1_33);
  tmpvar_20 = tmpvar_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = vec3((shadow_16 * 2.0));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_11.xyz * min (tmpvar_20.xyz, tmpvar_35));
  c_1.xyz = tmpvar_36;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_15).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 436
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 461
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 453
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 436
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 461
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 465
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 469
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 473
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 477
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 481
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    #line 485
    c.xyz += specColor;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 489
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  mat3 tmpvar_25;
  tmpvar_25[0] = _Object2World[0].xyz;
  tmpvar_25[1] = _Object2World[1].xyz;
  tmpvar_25[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_15 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_8 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_26;
  mediump vec3 tmpvar_30;
  mediump vec4 normal_31;
  normal_31 = tmpvar_29;
  highp float vC_32;
  mediump vec3 x3_33;
  mediump vec3 x2_34;
  mediump vec3 x1_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAr, normal_31);
  x1_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAg, normal_31);
  x1_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = dot (unity_SHAb, normal_31);
  x1_35.z = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = (normal_31.xyzz * normal_31.yzzx);
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBr, tmpvar_39);
  x2_34.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBg, tmpvar_39);
  x2_34.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHBb, tmpvar_39);
  x2_34.z = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = ((normal_31.x * normal_31.x) - (normal_31.y * normal_31.y));
  vC_32 = tmpvar_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = (unity_SHC.xyz * vC_32);
  x3_33 = tmpvar_44;
  tmpvar_30 = ((x1_35 + x2_34) + x3_33);
  shlight_3 = tmpvar_30;
  tmpvar_9 = shlight_3;
  highp vec3 tmpvar_45;
  tmpvar_45 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_46;
  tmpvar_46 = (unity_4LightPosX0 - tmpvar_45.x);
  highp vec4 tmpvar_47;
  tmpvar_47 = (unity_4LightPosY0 - tmpvar_45.y);
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosZ0 - tmpvar_45.z);
  highp vec4 tmpvar_49;
  tmpvar_49 = (((tmpvar_46 * tmpvar_46) + (tmpvar_47 * tmpvar_47)) + (tmpvar_48 * tmpvar_48));
  highp vec4 tmpvar_50;
  tmpvar_50 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_46 * tmpvar_26.x) + (tmpvar_47 * tmpvar_26.y)) + (tmpvar_48 * tmpvar_26.z)) * inversesqrt(tmpvar_49))) * (1.0/((1.0 + (tmpvar_49 * unity_4LightAtten0)))));
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_9 + ((((unity_LightColor[0].xyz * tmpvar_50.x) + (unity_LightColor[1].xyz * tmpvar_50.y)) + (unity_LightColor[2].xyz * tmpvar_50.z)) + (unity_LightColor[3].xyz * tmpvar_50.w)));
  tmpvar_9 = tmpvar_51;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = (tmpvar_15 * (((_World2Object * tmpvar_28).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  tmpvar_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12.x = dot (tmpvar_3, tmpvar_11);
  tmpvar_12.y = dot (tmpvar_4, tmpvar_11);
  tmpvar_12.z = dot (tmpvar_5, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 - (2.0 * (dot (tmpvar_12, tmpvar_2) * tmpvar_12)));
  lowp float shadow_14;
  lowp float tmpvar_15;
  tmpvar_15 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_LightShadowData.x + (tmpvar_15 * (1.0 - _LightShadowData.x)));
  shadow_14 = tmpvar_16;
  lowp vec4 c_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_11, xlv_TEXCOORD4));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_10.xyz * _LightColor0.xyz) * tmpvar_18) * (shadow_14 * 2.0));
  c_17.xyz = tmpvar_19;
  c_17.w = 0.0;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_10.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + (textureCube (_Cube, tmpvar_13).xyz * 0.1));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 465
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 449
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 453
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 457
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    #line 461
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
out highp vec4 xlv_TEXCOORD7;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD7 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 407
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec3 viewDir;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 401
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 405
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 437
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 465
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 465
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 469
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    #line 473
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 477
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 481
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 485
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
in highp vec4 xlv_TEXCOORD7;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD7);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 24 to 38, TEX: 3 to 6
//   d3d9 - ALU: 20 to 32, TEX: 3 to 6
//   d3d11 - ALU: 15 to 28, TEX: 3 to 6, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
"3.0-!!ARBfp1.0
# 28 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 2, 1, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].x, -c[3].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[3].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R2.x, R0, fragment.texcoord[1];
DP3 R2.y, R0, fragment.texcoord[2];
DP3 R2.z, R0, fragment.texcoord[3];
MOV R1.x, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[3].w;
MOV R1.y, fragment.texcoord[2].w;
DP3 R0.w, R2, R1;
MUL R3.xyz, R2, R0.w;
DP3 R0.w, R0, fragment.texcoord[4];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R1.xyz, -R3, c[3].x, R1;
TEX R1.xyz, R1, texture[2], CUBE;
MUL R2.xyz, R0, c[0];
MAX R0.w, R0, c[3].z;
MUL R2.xyz, R2, R0.w;
ADD R2.xyz, R2, c[3].z;
MUL R2.xyz, R2, c[3].x;
MUL R1.xyz, R1, c[3].w;
MAD R0.xyz, R0, fragment.texcoord[5], R2;
ADD result.color.xyz, R0, R1;
MOV result.color.w, c[3].z;
END
# 28 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
"ps_3_0
; 25 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c2, 0.10000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r2.x, r0, v1
dp3_pp r2.y, r0, v2
dp3_pp r2.z, r0, v3
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r2, r1
mul r3.xyz, r2, r0.w
dp3_pp r0.w, r0, v4
texld r0.xyz, v0, s0
mad r1.xyz, -r3, c1.x, r1
texld r1.xyz, r1, s2
mul_pp r2.xyz, r0, c0
max_pp r0.w, r0, c1
mul_pp r2.xyz, r2, r0.w
add r2.xyz, r2, c1.w
mul r2.xyz, r2, c1.x
mul r1.xyz, r1, c2.x
mad_pp r0.xyz, r0, v5, r2
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 144 // 32 used size, 10 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
// 26 instructions, 3 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjcfgldcfbmlacjoflmiiadpjdjagbnbgabaaaaaabiafaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmiadaaaaeaaaaaaapcaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
acaaaaaadkbabaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaiaebaaaaaa
aaaaaaaaagajbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaacaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaa
egbcbaaaagaaaaaaegacbaaaaaaaaaaadcaaaaamhccabaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 24 ALU, 4 TEX
PARAM c[2] = { { 8, 2, 1, 0.1 },
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[0].y, -c[0].z;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[0].z;
RSQ R0.x, R0.x;
RCP R1.z, R0.x;
DP3 R0.x, fragment.texcoord[1], R1;
DP3 R0.y, R1, fragment.texcoord[2];
DP3 R0.z, R1, fragment.texcoord[3];
MOV R1.x, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[3].w;
MOV R1.y, fragment.texcoord[2].w;
DP3 R0.w, R0, R1;
MUL R0.xyz, R0, R0.w;
MAD R0.xyz, -R0, c[0].y, R1;
TEX R0.xyz, R0, texture[2], CUBE;
MUL R2.xyz, R0, c[0].w;
TEX R0, fragment.texcoord[4], texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[0].x, R2;
MOV result.color.w, c[1].x;
END
# 24 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [unity_Lightmap] 2D
"ps_3_0
; 20 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c0, 2.00000000, -1.00000000, 1.00000000, 0.10000000
def c1, 8.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, v1, r1
dp3_pp r0.y, r1, v2
dp3_pp r0.z, r1, v3
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r0, r1
mul r0.xyz, r0, r0.w
mad r0.xyz, -r0, c0.x, r1
texld r0.xyz, r0, s2
mul r2.xyz, r0, c0.w
texld r0, v4, s3
texld r1.xyz, v0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r0, c1.x, r2
mov_pp oC0.w, c1.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmhgkhleopmfcgbcamcdnhkanainonpkaabaaaaaakmaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimadaaaa
eaaaaaaaodaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaa
adaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaa
egacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaaf
ccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
afaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 32 ALU, 5 TEX
PARAM c[4] = { { 2, 1, 8, 0.1 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[0].x, -c[0].y;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[0].y;
RSQ R1.z, R0.x;
TEX R0, fragment.texcoord[4], texture[4], 2D;
RCP R1.z, R1.z;
MUL R2.xyz, R0.w, R0;
DP3_SAT R0.z, R1, c[1];
DP3_SAT R0.x, R1, c[3];
DP3_SAT R0.y, R1, c[2];
MUL R2.xyz, R2, R0;
DP3 R0.x, R1, fragment.texcoord[1];
DP3 R0.y, R1, fragment.texcoord[2];
DP3 R0.z, R1, fragment.texcoord[3];
MOV R1.x, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[3].w;
MOV R1.y, fragment.texcoord[2].w;
DP3 R0.w, R0, R1;
DP3 R1.w, R2, c[0].z;
MUL R2.xyz, R0, R0.w;
MAD R1.xyz, -R2, c[0].x, R1;
TEX R2.xyz, R1, texture[2], CUBE;
TEX R0, fragment.texcoord[4], texture[3], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1.w;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R2.xyz, R2, c[0].w;
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[0].z, R2;
MOV result.color.w, c[1];
END
# 32 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_3_0
; 27 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
def c0, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c1, -0.40824828, -0.70710677, 0.57735026, 0.10000000
def c2, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c3, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r1.z, r0.x
texld r0, v4, s4
rcp_pp r1.z, r1.z
mul_pp r2.xyz, r0.w, r0
dp3_pp_sat r0.z, r1, c1
dp3_pp_sat r0.x, r1, c3
dp3_pp_sat r0.y, r1, c2
mul_pp r2.xyz, r2, r0
dp3_pp r0.x, r1, v1
dp3_pp r0.y, r1, v2
dp3_pp r0.z, r1, v3
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r0, r1
dp3_pp r1.w, r2, c0.w
mul r2.xyz, r0, r0.w
mad r1.xyz, -r2, c0.x, r1
texld r2.xyz, r1, s2
texld r0, v4, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.w
texld r1.xyz, v0, s0
mul r2.xyz, r2, c1.w
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r0, c0.w, r2
mov_pp oC0.w, c2
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
// 32 instructions, 4 temp regs, 0 temp arrays:
// ALU 22 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmcjcmcdngkcakfgdohgdkknjenloajokabaaaaaaomafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaeaaaaeaaaaaaacnabaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahccaabaaaacaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
acaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdn
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaafaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaa
apcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaa
igaabaaaabaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaaegacbaaaabaaaaaabacaaaakecaabaaaadaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaafaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 30 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 2, 1, 0, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R0.wyzw, c[3].x, -c[3].y;
MUL R0.xy, R2, R2;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[3].y;
RSQ R0.x, R0.x;
RCP R2.z, R0.x;
DP3 R0.x, R2, fragment.texcoord[1];
DP3 R0.y, R2, fragment.texcoord[2];
DP3 R0.z, R2, fragment.texcoord[3];
MOV R1.x, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[3].w;
MOV R1.y, fragment.texcoord[2].w;
DP3 R0.w, R0, R1;
MUL R0.xyz, R0, R0.w;
MAD R0.xyz, -R0, c[3].x, R1;
DP3 R0.w, R2, fragment.texcoord[4];
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.xyz, R0, texture[2], CUBE;
MUL R2.yzw, R1.xxyz, c[0].xxyz;
MAX R0.w, R0, c[3].z;
MUL R2.yzw, R2, R0.w;
TXP R2.x, fragment.texcoord[7], texture[3], 2D;
MUL R0.w, R2.x, c[3].x;
ADD R2.xyz, R2.yzww, c[3].z;
MUL R2.xyz, R2, R0.w;
MUL R0.xyz, R0, c[3].w;
MAD R1.xyz, R1, fragment.texcoord[5], R2;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[3].z;
END
# 30 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 26 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c2, 0.10000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord7 v7
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, v1
dp3_pp r0.y, r2, v2
dp3_pp r0.z, r2, v3
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r0, r1
mul r0.xyz, r0, r0.w
mad r0.xyz, -r0, c1.x, r1
dp3_pp r0.w, r2, v4
texld r1.xyz, v0, s0
texld r0.xyz, r0, s2
mul_pp r2.yzw, r1.xxyz, c0.xxyz
max_pp r0.w, r0, c1
mul_pp r2.yzw, r2, r0.w
texldp r2.x, v7, s3
mul_pp r0.w, r2.x, c1.x
add r2.xyz, r2.yzww, c1.w
mul r2.xyz, r2, r0.w
mul r0.xyz, r0, c2.x
mad_pp r1.xyz, r1, v5, r2
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 208 // 32 used size, 11 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_ShadowMapTexture] 2D 0
// 29 instructions, 4 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkoiphompekkfngleegiimgkehccbaicoabaaaaaaleafaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcemaeaaaaeaaaaaaabdabaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadlcbabaaa
aiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
acaaaaaadkbabaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaiaebaaaaaa
aaaaaaaaagajbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaajgahbaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaacaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegbcbaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaaiaaaaaa
pgbpbaaaaiaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaa
akaabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 30 ALU, 5 TEX
PARAM c[2] = { { 8, 2, 1, 0.1 },
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[0].y, -c[0].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[0];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R2.x, fragment.texcoord[1], R0;
DP3 R2.y, R0, fragment.texcoord[2];
DP3 R2.z, R0, fragment.texcoord[3];
MOV R1.y, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[2].w;
MOV R1.w, fragment.texcoord[3];
DP3 R0.x, R2, R1.yzww;
MUL R3.xyz, R2, R0.x;
TXP R1.x, fragment.texcoord[5], texture[3], 2D;
TEX R0, fragment.texcoord[4], texture[4], 2D;
MUL R2.xyz, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[0].x;
MAD R3.xyz, -R3, c[0].y, R1.yzww;
MUL R2.xyz, R2, c[0].y;
MIN R2.xyz, R0, R2;
MUL R1.xyz, R0, R1.x;
TEX R0.xyz, R3, texture[2], CUBE;
MAX R1.xyz, R2, R1;
MUL R2.xyz, R0, c[0].w;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, c[1].x;
END
# 30 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 25 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
def c0, 8.00000000, 2.00000000, -1.00000000, 1.00000000
def c1, 0.10000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.y, c0.z
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.w
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, v1, r1
dp3_pp r0.y, r1, v2
dp3_pp r0.z, r1, v3
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r0, r1
mul r2.xyz, r0, r0.w
mad r1.xyz, -r2, c0.y, r1
texld r1.xyz, r1, s2
texldp r0.x, v5, s3
texld r3, v4, s4
mul_pp r0.yzw, r3.xxyz, r0.x
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c0.x
mul_pp r0.yzw, r0, c0.y
mul_pp r2.xyz, r3, r0.x
min_pp r0.yzw, r3.xxyz, r0
max_pp r0.xyz, r0.yzww, r2
mul r1.xyz, r1, c1.x
texld r2.xyz, v0, s0
mad_pp oC0.xyz, r2, r0, r1
mov_pp oC0.w, c1.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_ShadowMapTexture] 2D 0
SetTexture 4 [unity_Lightmap] 2D 4
// 31 instructions, 3 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedngkmdcjehdflpcjfknbjbepcopgdibonabaaaaaaliafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciaaeaaaaeaaaaaaacaabaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaa
adaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaa
egacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaaf
ccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaafaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aaaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 38 ALU, 6 TEX
PARAM c[4] = { { 2, 1, 8, 0.1 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[0].x, -c[0].y;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[0].y;
RSQ R1.z, R0.x;
RCP R1.z, R1.z;
TEX R0, fragment.texcoord[4], texture[5], 2D;
DP3_SAT R2.z, R1, c[1];
DP3_SAT R2.x, R1, c[3];
DP3_SAT R2.y, R1, c[2];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R2;
DP3 R3.y, R1, fragment.texcoord[1];
DP3 R3.z, R1, fragment.texcoord[2];
DP3 R3.w, R1, fragment.texcoord[3];
DP3 R0.w, R0, c[0].z;
TEX R2, fragment.texcoord[4], texture[4], 2D;
MUL R0.xyz, R2.w, R2;
MUL R0.xyz, R0, R0.w;
TXP R3.x, fragment.texcoord[6], texture[3], 2D;
MUL R2.xyz, R2, R3.x;
MUL R0.xyz, R0, c[0].z;
MUL R2.xyz, R2, c[0].x;
MIN R2.xyz, R0, R2;
MUL R0.xyz, R0, R3.x;
MAX R0.xyz, R2, R0;
MOV R1.x, fragment.texcoord[1].w;
MOV R1.z, fragment.texcoord[3].w;
MOV R1.y, fragment.texcoord[2].w;
DP3 R0.w, R3.yzww, R1;
MUL R3.yzw, R3, R0.w;
MAD R1.xyz, -R3.yzww, c[0].x, R1;
TEX R1.xyz, R1, texture[2], CUBE;
MUL R1.xyz, R1, c[0].w;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R2, R0, R1;
MOV result.color.w, c[1];
END
# 38 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 32 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c1, -0.40824828, -0.70710677, 0.57735026, 0.10000000
def c2, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c3, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xy
dcl_texcoord6 v6
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r1.z, r0.x
rcp_pp r1.z, r1.z
texld r0, v4, s5
dp3_pp_sat r2.z, r1, c1
dp3_pp_sat r2.x, r1, c3
dp3_pp_sat r2.y, r1, c2
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r2
dp3_pp r3.y, r1, v1
dp3_pp r3.z, r1, v2
dp3_pp r3.w, r1, v3
dp3_pp r0.w, r0, c0.w
texld r2, v4, s4
mul_pp r0.xyz, r2.w, r2
mul_pp r0.xyz, r0, r0.w
texldp r3.x, v6, s3
mul_pp r2.xyz, r2, r3.x
mul_pp r0.xyz, r0, c0.w
mul_pp r2.xyz, r2, c0.x
min_pp r2.xyz, r0, r2
mul_pp r0.xyz, r0, r3.x
max_pp r0.xyz, r2, r0
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3 r0.w, r3.yzww, r1
mul r3.yzw, r3, r0.w
mad r1.xyz, -r3.yzww, c0.x, r1
texld r1.xyz, r1, s2
mul r1.xyz, r1, c1.w
texld r2.xyz, v0, s0
mad_pp oC0.xyz, r2, r0, r1
mov_pp oC0.w, c2
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_ShadowMapTexture] 2D 0
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 39 instructions, 5 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddffebgfojoogkldlpkodljkcnglfkicaabaaaaaapiagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiafaaaaeaaaaaaagkabaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagcbaaaad
lcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaafaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaafaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
apcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaa
igaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
ahaaaaaapgbpbaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaa
agaabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaddaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
acaaaaaadkbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaa
aaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 26 to 35
//   d3d9 - ALU: 29 to 38
//   d3d11 - ALU: 24 to 33, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Matrix 48 [_LightMatrix0] 4
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpnepbfppffojfeeloibpkcdjniinmlejabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float atten_6;
  atten_6 = texture2D (_LightTexture0, vec2(tmpvar_5)).w;
  lowp vec4 c_7;
  lowp float tmpvar_8;
  tmpvar_8 = max (0.0, dot (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), lightDir_2));
  highp vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 2.0));
  c_7.xyz = tmpvar_9;
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float atten_7;
  atten_7 = texture2D (_LightTexture0, vec2(tmpvar_6)).w;
  lowp vec4 c_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (normal_4, lightDir_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 2.0));
  c_8.xyz = tmpvar_10;
  c_8.w = 0.0;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 401
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 415
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 397
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 408
#line 424
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 426
v2f_surf vert_surf( in appdata_full v ) {
    #line 428
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 432
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 436
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 440
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 401
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 415
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 397
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 408
#line 424
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 408
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 412
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 442
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 444
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    SurfaceOutput o;
    #line 448
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 452
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    #line 456
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 26 ALU
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c13.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 144 // 144 used size, 10 vars
Vector 112 [_MainTex_ST] 4
Vector 128 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedljdpejaiijdhefcfokcoiklkogejamhdabaaaaaakeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  lowp float tmpvar_5;
  tmpvar_5 = max (0.0, dot (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), lightDir_2));
  highp vec3 tmpvar_6;
  tmpvar_6 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_5) * 2.0);
  c_4.xyz = tmpvar_6;
  c_4.w = 0.0;
  c_1.xyz = c_4.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_5;
  lowp float tmpvar_6;
  tmpvar_6 = max (0.0, dot (normal_4, lightDir_2));
  highp vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_6) * 2.0);
  c_5.xyz = tmpvar_7;
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 413
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 406
#line 421
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 438
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 423
v2f_surf vert_surf( in appdata_full v ) {
    #line 425
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 429
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 433
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 413
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 406
#line 421
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 438
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 406
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 410
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 438
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 442
    surfIN.uv_BumpMap = IN.pack0.zw;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 446
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 450
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), 1.0);
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Matrix 48 [_LightMatrix0] 4
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlpdmdpkopmoioacaapcifmjmdckhdlimabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_7;
  atten_7 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_5).w) * texture2D (_LightTextureB0, vec2(tmpvar_6)).w);
  lowp vec4 c_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), lightDir_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 2.0));
  c_8.xyz = tmpvar_10;
  c_8.w = 0.0;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_8;
  atten_8 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_6).w) * texture2D (_LightTextureB0, vec2(tmpvar_7)).w);
  lowp vec4 c_9;
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (normal_4, lightDir_2));
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_10) * (atten_8 * 2.0));
  c_9.xyz = tmpvar_11;
  c_9.w = 0.0;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 410
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 406
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 435
v2f_surf vert_surf( in appdata_full v ) {
    #line 437
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 441
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 445
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 449
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 410
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 406
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 417
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 398
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 394
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 417
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 421
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 451
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 453
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    SurfaceOutput o;
    #line 457
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 461
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    #line 465
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Matrix 48 [_LightMatrix0] 4
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedpnepbfppffojfeeloibpkcdjniinmlejabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float atten_6;
  atten_6 = (texture2D (_LightTextureB0, vec2(tmpvar_5)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  lowp vec4 c_7;
  lowp float tmpvar_8;
  tmpvar_8 = max (0.0, dot (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), lightDir_2));
  highp vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_8) * (atten_6 * 2.0));
  c_7.xyz = tmpvar_9;
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float atten_7;
  atten_7 = (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  lowp vec4 c_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (normal_4, lightDir_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_9) * (atten_7 * 2.0));
  c_8.xyz = tmpvar_10;
  c_8.w = 0.0;
  c_1.xyz = c_8.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
#line 397
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform samplerCube _Cube;
#line 409
#line 425
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 427
v2f_surf vert_surf( in appdata_full v ) {
    #line 429
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 433
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 437
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 441
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
#line 397
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform samplerCube _Cube;
#line 409
#line 425
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 443
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 445
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    SurfaceOutput o;
    #line 449
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 453
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    #line 457
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 208 // 208 used size, 11 vars
Matrix 48 [_LightMatrix0] 4
Vector 176 [_MainTex_ST] 4
Vector 192 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 33 instructions, 2 temp regs, 0 temp arrays:
// ALU 32 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfhkfbcjengghcaldoepalghfpijbpcakabaaaaaapiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmafaaaaeaaaabaa
fhabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lightDir_2 = xlv_TEXCOORD1;
  lowp float atten_4;
  atten_4 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  lowp vec4 c_5;
  lowp float tmpvar_6;
  tmpvar_6 = max (0.0, dot (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), lightDir_2));
  highp vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_6) * (atten_4 * 2.0));
  c_5.xyz = tmpvar_7;
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  lightDir_2 = xlv_TEXCOORD1;
  lowp float atten_5;
  atten_5 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  lowp vec4 c_6;
  lowp float tmpvar_7;
  tmpvar_7 = max (0.0, dot (normal_4, lightDir_2));
  highp vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_3.xyz * _LightColor0.xyz) * tmpvar_7) * (atten_5 * 2.0));
  c_6.xyz = tmpvar_8;
  c_6.w = 0.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 401
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 415
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 397
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 408
#line 424
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 426
v2f_surf vert_surf( in appdata_full v ) {
    #line 428
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 432
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 436
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 440
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 401
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 415
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    mediump vec3 lightDir;
    mediump vec3 viewDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
#line 397
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 408
#line 424
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 408
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 412
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 442
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 444
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    SurfaceOutput o;
    #line 448
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 452
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    #line 456
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 15 to 27, TEX: 2 to 4
//   d3d9 - ALU: 13 to 23, TEX: 2 to 4
//   d3d11 - ALU: 10 to 20, TEX: 2 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 21 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].y, -c[3].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
DP3 R0.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, fragment.texcoord[1];
ADD R0.z, -R0, c[3];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.x, R0, R1;
MAX R1.x, R0, c[3];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[0];
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.xyz, R0, R1.x;
MUL R0.w, R0, c[3].y;
ADD R0.xyz, R0, c[3].x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[3].x;
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
mul_pp r1.xyz, r0.w, v1
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, r1
max_pp r0.y, r0.x, c1.w
texld r1.xyz, v0, s0
dp3 r0.x, v3, v3
texld r0.x, r0.x, s2
mul_pp r1.xyz, r1, c0
mul_pp r0.w, r0.x, c1.x
mul_pp r1.xyz, r1, r0.y
add r0.xyz, r1, c1.w
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 208 // 32 used size, 11 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
// 20 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbgciaokoblloigdihioaapcdaioedjehabaaaaaaomadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoeacaaaaeaaaaaaaljaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 15 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 2, 1 } };
TEMP R0;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].y, -c[3].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[3];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, fragment.texcoord[1];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAX R0.w, R0, c[3].x;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R0.w;
ADD R0.xyz, R0, c[3].x;
MUL result.color.xyz, R0, c[3].y;
MOV result.color.w, c[3].x;
END
# 15 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"ps_3_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, v1
texld r0.xyz, v0, s0
max_pp r0.w, r0, c1
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, r0.w
add r0.xyz, r0, c1.w
mul oC0.xyz, r0, c1.x
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 144 // 32 used size, 10 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
// 14 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddmbddcklpodljlollakkinilcplnfppaabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 27 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].y, -c[3].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
DP3 R0.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, fragment.texcoord[1];
ADD R0.z, -R0, c[3];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.x, R0, R1;
MAX R1.z, R0.x, c[3].x;
RCP R0.w, fragment.texcoord[3].w;
MAD R1.xy, fragment.texcoord[3], R0.w, c[3].w;
TEX R0.w, R1, texture[2], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[0];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
SLT R1.x, c[3], fragment.texcoord[3].z;
MUL R0.xyz, R0, R1.z;
TEX R1.w, R1.w, texture[3], 2D;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, R1;
MUL R0.w, R0, c[3].y;
ADD R0.xyz, R0, c[3].x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[3].x;
END
# 27 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 23 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c2, 0.50000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord3 v3
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
mul_pp r1.xyz, r0.w, v1
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, r1
max_pp r0.y, r0.x, c1.w
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c2.x
texld r1.xyz, v0, s0
dp3 r0.x, v3, v3
texld r0.w, r2, s2
cmp r0.z, -v3, c1.w, c1
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.w, r0.z, r0.x
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r1, r0.y
mul_pp r0.w, r0, c1.x
add r0.xyz, r0, c1.w
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 208 // 32 used size, 11 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
// 26 instructions, 2 temp regs, 0 temp arrays:
// ALU 19 float, 0 int, 1 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlcaellgflfepdkaloegoagklnpfphlpeabaaaaaameaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclmadaaaaeaaaaaaaopaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
abaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 23 ALU, 4 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].y, -c[3].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
DP3 R0.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R0.w;
ADD R0.z, -R0, c[3];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.w, fragment.texcoord[1];
RCP R0.z, R0.z;
DP3 R0.w, R0, R1;
MAX R1.x, R0.w, c[3];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[0];
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, R1.x;
TEX R0.w, fragment.texcoord[3], texture[3], CUBE;
TEX R1.w, R1.y, texture[2], 2D;
MUL R0.w, R1, R0;
MUL R0.w, R0, c[3].y;
ADD R0.xyz, R0, c[3].x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[3].x;
END
# 23 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v1
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, r1
max_pp r0.y, r0.x, c1.w
texld r1.xyz, v0, s0
dp3 r0.x, v3, v3
texld r0.x, r0.x, s2
texld r0.w, v3, s3
mul r0.w, r0.x, r0
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r1, r0.y
mul_pp r0.w, r0, c1.x
add r0.xyz, r0, c1.w
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 208 // 32 used size, 11 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
// 21 instructions, 3 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedihlmjibphiiknafffobmhagjbinggahnabaaaaaacmaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcceadaaaaeaaaaaaamjaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
abaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 17 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[3].y, -c[3].z;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[3].z;
RSQ R0.x, R0.x;
RCP R1.z, R0.x;
DP3 R0.w, R1, fragment.texcoord[1];
MAX R1.x, R0.w, c[3];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[0];
TEX R0.w, fragment.texcoord[3], texture[2], 2D;
MUL R0.xyz, R0, R1.x;
MUL R0.w, R0, c[3].y;
ADD R0.xyz, R0, c[3].x;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[3].x;
END
# 17 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 2.00000000, -1.00000000, 1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord3 v3.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.w, r1, v1
max_pp r1.x, r0.w, c1.w
texld r0.xyz, v0, s0
mul_pp r0.xyz, r0, c0
texld r0.w, v3, s2
mul_pp r0.xyz, r0, r1.x
mul_pp r0.w, r0, c1.x
add r0.xyz, r0, c1.w
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 208 // 32 used size, 11 vars
Vector 16 [_LightColor0] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 11 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednllbgdnnohkopiamfjmenibpkidhbdniabaaaaaaieadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchmacaaaaeaaaaaaajpaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 21 to 21
//   d3d9 - ALU: 22 to 22
//   d3d11 - ALU: 20 to 20, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 21 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_BumpMap_ST]
"vs_3_0
; 22 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4.xyz, r0, c8.w
mad o1.xy, v3, c9, c9.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 128 // 128 used size, 9 vars
Vector 112 [_BumpMap_ST] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 30 instructions, 3 temp regs, 0 temp arrays:
// ALU 20 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedhploepobnmbpacdgkjoeellillkeopffabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD2 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump float tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  highp float tmpvar_5;
  tmpvar_5 = _SpecularColor.x;
  tmpvar_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD1, tmpvar_4);
  worldN_2.x = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD2, tmpvar_4);
  worldN_2.y = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD3, tmpvar_4);
  worldN_2.z = tmpvar_8;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = tmpvar_3;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD1 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD2 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump float tmpvar_3;
  lowp vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  highp float tmpvar_5;
  tmpvar_5 = _SpecularColor.x;
  tmpvar_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD1, normal_4);
  worldN_2.x = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD2, normal_4);
  worldN_2.y = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD3, normal_4);
  worldN_2.z = tmpvar_8;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = tmpvar_3;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 413
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 406
#line 422
uniform highp vec4 _BumpMap_ST;
#line 435
#line 423
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 426
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 430
    o.TtoW0 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 0).xyz) * unity_Scale.w);
    o.TtoW1 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 1).xyz) * unity_Scale.w);
    o.TtoW2 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 2).xyz) * unity_Scale.w);
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.TtoW0);
    xlv_TEXCOORD2 = vec3(xl_retval.TtoW1);
    xlv_TEXCOORD3 = vec3(xl_retval.TtoW2);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
};
#line 413
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 406
#line 422
uniform highp vec4 _BumpMap_ST;
#line 435
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 406
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 410
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, IN.worldRefl).xyz * 0.1);
}
#line 435
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_BumpMap = IN.pack0.xy;
    #line 439
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 443
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 worldN;
    #line 447
    worldN.x = dot( IN.TtoW0, o.Normal);
    worldN.y = dot( IN.TtoW1, o.Normal);
    worldN.z = dot( IN.TtoW2, o.Normal);
    o.Normal = worldN;
    #line 451
    lowp vec4 res;
    res.xyz = ((o.Normal * 0.5) + 0.5);
    res.w = o.Specular;
    return res;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.TtoW0 = vec3(xlv_TEXCOORD1);
    xlt_IN.TtoW1 = vec3(xlv_TEXCOORD2);
    xlt_IN.TtoW2 = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 12 to 12, TEX: 1 to 1
//   d3d9 - ALU: 11 to 11, TEX: 1 to 1
//   d3d11 - ALU: 9 to 9, TEX: 1 to 1, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Vector 0 [_SpecularColor]
SetTexture 0 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 12 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[1].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.z, fragment.texcoord[3], R0;
DP3 R1.x, R0, fragment.texcoord[1];
DP3 R1.y, R0, fragment.texcoord[2];
MAD result.color.xyz, R1, c[1].z, c[1].z;
MOV result.color.w, c[0].x;
END
# 12 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_SpecularColor]
SetTexture 0 [_BumpMap] 2D
"ps_3_0
; 11 ALU, 1 TEX
dcl_2d s0
def c1, 2.00000000, -1.00000000, 1.00000000, 0.50000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0, s0
mad_pp r0.xy, r0.wyzw, c1.x, c1.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c1
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3 r1.z, v3, r0
dp3 r1.x, r0, v1
dp3 r1.y, r0, v2
mad_pp oC0.xyz, r1, c1.w, c1.w
mov_pp oC0.w, c0.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 128 // 80 used size, 9 vars
Vector 64 [_SpecularColor] 4
BindCB "$Globals" 0
SetTexture 0 [_BumpMap] 2D 0
// 12 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpaddkbhnomdjlgchoachihcllgnienmiabaaaaaapiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
aaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaag
iccabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 6
//   opengl - ALU: 41 to 55
//   d3d9 - ALU: 42 to 56
//   d3d11 - ALU: 36 to 47, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 55 ALU
PARAM c[25] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[13];
MOV R0.w, c[0].y;
ADD result.texcoord[5].xyz, R2, R3;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP4 R1.w, vertex.position, c[4];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[22].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[22].w;
DP3 R0.y, R1, c[7];
DP4 R1.z, vertex.position, c[3];
DP3 R0.w, -R2, c[7];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].x;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[4], R0, c[22].w;
MOV R0.x, R2;
MUL R0.y, R2, c[14].x;
ADD result.texcoord[1].xy, R0, R2.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 55 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 56 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c25, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c25.y
add o6.xyz, r2, r3
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c22.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c22.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c22.w
dp3 r0.y, r1, c6
dp4 r1.z, v0, c2
dp3 r0.w, -r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c25.x
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c22.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o2.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o2.zw, r1
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 160 // 144 used size, 11 vars
Vector 112 [_MainTex_ST] 4
Vector 128 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 62 instructions, 4 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgbbnafhnnaaoookhffbfflefnjffekkiabaaaaaacmakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgaaiaaaaeaaaabaabiacaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegambaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaa
adaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaaakiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaaakiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaabaaaaaa
bkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  mat3 tmpvar_27;
  tmpvar_27[0] = _Object2World[0].xyz;
  tmpvar_27[1] = _Object2World[1].xyz;
  tmpvar_27[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_27 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  tmpvar_7 = tmpvar_29;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_5, tmpvar_13);
  tmpvar_14.y = dot (tmpvar_6, tmpvar_13);
  tmpvar_14.z = dot (tmpvar_7, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 - (2.0 * (dot (tmpvar_14, tmpvar_4) * tmpvar_14)));
  lowp vec3 tmpvar_16;
  tmpvar_16 = (textureCube (_Cube, tmpvar_15).xyz * 0.1);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_19;
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_12.xyz * light_3.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = 0.0;
  c_2 = c_20;
  c_2.xyz = (c_2.xyz + tmpvar_16);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  mat3 tmpvar_27;
  tmpvar_27[0] = _Object2World[0].xyz;
  tmpvar_27[1] = _Object2World[1].xyz;
  tmpvar_27[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_27 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  tmpvar_7 = tmpvar_29;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_13;
  normal_13.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_5, normal_13);
  tmpvar_14.y = dot (tmpvar_6, normal_13);
  tmpvar_14.z = dot (tmpvar_7, normal_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 - (2.0 * (dot (tmpvar_14, tmpvar_4) * tmpvar_14)));
  lowp vec3 tmpvar_16;
  tmpvar_16 = (textureCube (_Cube, tmpvar_15).xyz * 0.1);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_19;
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_12.xyz * light_3.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = 0.0;
  c_2 = c_20;
  c_2.xyz = (c_2.xyz + tmpvar_16);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 447
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 429
v2f_surf vert_surf( in appdata_full v ) {
    #line 431
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 435
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 439
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 443
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 447
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 449
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 451
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 455
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 459
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 463
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 467
    light = (-log2(light));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    #line 471
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 47 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[17];
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[15];
DP4 R2.x, R0, c[13];
DP4 R2.y, R0, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 R0.y, R1, c[9];
DP3 R0.w, -R2, c[9];
DP4 R1.w, vertex.position, c[8];
DP3 R0.x, vertex.attrib[14], c[9];
DP3 R0.z, vertex.normal, c[9];
MUL result.texcoord[2], R0, c[20].w;
DP3 R0.y, R1, c[10];
DP3 R0.w, -R2, c[10];
DP3 R0.x, vertex.attrib[14], c[10];
DP3 R0.z, vertex.normal, c[10];
MUL result.texcoord[3], R0, c[20].w;
DP3 R0.y, R1, c[11];
DP4 R1.z, vertex.position, c[7];
DP3 R0.w, -R2, c[11];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].x;
DP3 R0.x, vertex.attrib[14], c[11];
DP3 R0.z, vertex.normal, c[11];
MUL result.texcoord[4], R0, c[20].w;
MOV R0.x, R2;
MUL R0.y, R2, c[18].x;
ADD result.texcoord[1].xy, R0, R2.z;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[19];
MUL result.texcoord[6].xyz, R0, c[19].w;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 47 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 48 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c24, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c16
mov r0.w, c24.y
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r2.xyz, r2, c20.w, -v0
dp3 r0.y, r1, c8
dp3 r0.w, -r2, c8
dp4 r1.w, v0, c7
dp3 r0.x, v1, c8
dp3 r0.z, v2, c8
mul o3, r0, c20.w
dp3 r0.y, r1, c9
dp3 r0.w, -r2, c9
dp3 r0.x, v1, c9
dp3 r0.z, v2, c9
mul o4, r0, c20.w
dp3 r0.y, r1, c10
dp4 r1.z, v0, c6
dp3 r0.w, -r2, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c24.x
dp3 r0.x, v1, c10
dp3 r0.z, v2, c10
mul o5, r0, c20.w
mov r0.x, r2
mul r0.y, r2, c17.x
mad o2.xy, r2.z, c18.zwzw, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c19
mul o7.xyz, r0, c19.w
mov r0.x, c19.w
add r0.y, c24, -r0.x
dp4 r0.x, v0, c2
mov o0, r1
mov o2.zw, r1
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 160 used size, 13 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 59 instructions, 4 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaagbbmkahenaemakibnnbfphfmhfnlnoabaaaaaadiakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
feaiaaaaeaaaabaabfacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaaaoaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaa
adaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaa
egaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaa
ckiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaa
aaaaaaaapgipcaaaadaaaaaabeaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
ahaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaahaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  tmpvar_7.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_7.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  tmpvar_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD4.xyz;
  tmpvar_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_8, tmpvar_16);
  tmpvar_17.y = dot (tmpvar_9, tmpvar_16);
  tmpvar_17.z = dot (tmpvar_10, tmpvar_16);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_7 - (2.0 * (dot (tmpvar_17, tmpvar_7) * tmpvar_17)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = (textureCube (_Cube, tmpvar_18).xyz * 0.1);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_21.w;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lmFull_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  lmIndirect_3 = tmpvar_24;
  light_6.xyz = (tmpvar_21.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15.xyz * light_6.xyz);
  c_25.xyz = tmpvar_26;
  c_25.w = 0.0;
  c_2 = c_25;
  c_2.xyz = (c_2.xyz + tmpvar_19);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  tmpvar_7.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_7.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  tmpvar_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD4.xyz;
  tmpvar_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_8, normal_16);
  tmpvar_17.y = dot (tmpvar_9, normal_16);
  tmpvar_17.z = dot (tmpvar_10, normal_16);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_7 - (2.0 * (dot (tmpvar_17, tmpvar_7) * tmpvar_17)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = (textureCube (_Cube, tmpvar_18).xyz * 0.1);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_21.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp float tmpvar_24;
  tmpvar_24 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((8.0 * tmpvar_22.w) * tmpvar_22.xyz);
  lmFull_4 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((8.0 * tmpvar_23.w) * tmpvar_23.xyz);
  lmIndirect_3 = tmpvar_26;
  light_6.xyz = (tmpvar_21.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_15.xyz * light_6.xyz);
  c_27.xyz = tmpvar_28;
  c_27.w = 0.0;
  c_2 = c_27;
  c_2.xyz = (c_2.xyz + tmpvar_19);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 454
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
v2f_surf vert_surf( in appdata_full v ) {
    #line 433
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 437
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 441
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 445
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 454
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 455
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 458
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    #line 462
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 466
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 470
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    #line 474
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    #line 478
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    #line 482
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 41 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.w, c[0].y;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
MUL R1.xyz, vertex.attrib[14].w, R0;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[15].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[15].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[15].w;
MUL R1.y, R3, c[14].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 41 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.w, c19.y
mov r1.xyz, c12
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mul r1.xyz, v1.w, r0
dp3 r0.y, r1, c4
dp3 o7.y, r1, r2
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c15.w
dp3 r0.y, r1, c5
dp3 r1.y, r1, c6
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c15.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r3.xyz, r0.xyww, c19.x
dp3 r1.x, v1, c6
dp3 r1.w, -r2, c6
dp3 r1.z, v2, c6
mul o5, r1, c15.w
mul r1.y, r3, c13.x
mov r1.x, r3
mad o2.xy, r3.z, c14.zwzw, r1
dp3 o7.z, v2, r2
dp3 o7.x, v1, r2
mov o0, r0
mov o2.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o6.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 160 used size, 13 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 50 instructions, 5 temp regs, 0 temp arrays:
// ALU 36 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmfoaaocieongkpodidoahennclkagejabaaaaaameaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaagaaaaeaaaabaaliabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaa
aaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaa
abaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaa
abaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaa
aeaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaacaaaaaaaoaaaaaa
baaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaa
bkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaaeaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
aeaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaa
ckiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
pccabaaaafaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_7.zw;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_23;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (tmpvar_13 * (((_World2Object * tmpvar_26).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  mediump float tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  highp float tmpvar_15;
  tmpvar_15 = _SpecularColor.x;
  tmpvar_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_5, tmpvar_14);
  tmpvar_16.y = dot (tmpvar_6, tmpvar_14);
  tmpvar_16.z = dot (tmpvar_7, tmpvar_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_4 - (2.0 * (dot (tmpvar_16, tmpvar_4) * tmpvar_16)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = (textureCube (_Cube, tmpvar_17).xyz * 0.1);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD6);
  mediump vec4 tmpvar_21;
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_20;
  highp float nh_23;
  mat3 tmpvar_24;
  tmpvar_24[0].x = 0.816497;
  tmpvar_24[0].y = -0.408248;
  tmpvar_24[0].z = -0.408248;
  tmpvar_24[1].x = 0.0;
  tmpvar_24[1].y = 0.707107;
  tmpvar_24[1].z = -0.707107;
  tmpvar_24[2].x = 0.57735;
  tmpvar_24[2].y = 0.57735;
  tmpvar_24[2].z = 0.57735;
  mediump vec3 normal_25;
  normal_25 = tmpvar_14;
  mediump vec3 scalePerBasisVector_26;
  mediump vec3 lm_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lm_27 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  scalePerBasisVector_26 = tmpvar_29;
  lm_27 = (lm_27 * dot (clamp ((tmpvar_24 * normal_25), 0.0, 1.0), scalePerBasisVector_26));
  vec3 v_30;
  v_30.x = tmpvar_24[0].x;
  v_30.y = tmpvar_24[1].x;
  v_30.z = tmpvar_24[2].x;
  vec3 v_31;
  v_31.x = tmpvar_24[0].y;
  v_31.y = tmpvar_24[1].y;
  v_31.z = tmpvar_24[2].y;
  vec3 v_32;
  v_32.x = tmpvar_24[0].z;
  v_32.y = tmpvar_24[1].z;
  v_32.z = tmpvar_24[2].z;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_14, normalize((normalize((((scalePerBasisVector_26.x * v_30) + (scalePerBasisVector_26.y * v_31)) + (scalePerBasisVector_26.z * v_32))) + viewDir_22))));
  nh_23 = tmpvar_33;
  mediump float arg1_34;
  arg1_34 = (tmpvar_12 * 128.0);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = lm_27;
  tmpvar_35.w = pow (nh_23, arg1_34);
  tmpvar_21 = tmpvar_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_21);
  light_3 = tmpvar_36;
  lowp vec4 c_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_13.xyz * tmpvar_36.xyz);
  c_37.xyz = tmpvar_38;
  c_37.w = 0.0;
  c_2 = c_37;
  c_2.xyz = (c_2.xyz + tmpvar_18);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_7.zw;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_23;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (tmpvar_13 * (((_World2Object * tmpvar_26).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  mediump float tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_14;
  normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_14.z = sqrt((1.0 - clamp (dot (normal_14.xy, normal_14.xy), 0.0, 1.0)));
  highp float tmpvar_15;
  tmpvar_15 = _SpecularColor.x;
  tmpvar_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_5, normal_14);
  tmpvar_16.y = dot (tmpvar_6, normal_14);
  tmpvar_16.z = dot (tmpvar_7, normal_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_4 - (2.0 * (dot (tmpvar_16, tmpvar_4) * tmpvar_16)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = (textureCube (_Cube, tmpvar_17).xyz * 0.1);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_22;
  highp float nh_25;
  mat3 tmpvar_26;
  tmpvar_26[0].x = 0.816497;
  tmpvar_26[0].y = -0.408248;
  tmpvar_26[0].z = -0.408248;
  tmpvar_26[1].x = 0.0;
  tmpvar_26[1].y = 0.707107;
  tmpvar_26[1].z = -0.707107;
  tmpvar_26[2].x = 0.57735;
  tmpvar_26[2].y = 0.57735;
  tmpvar_26[2].z = 0.57735;
  mediump vec3 normal_27;
  normal_27 = normal_14;
  mediump vec3 scalePerBasisVector_28;
  mediump vec3 lm_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_20.w) * tmpvar_20.xyz);
  lm_29 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = ((8.0 * tmpvar_21.w) * tmpvar_21.xyz);
  scalePerBasisVector_28 = tmpvar_31;
  lm_29 = (lm_29 * dot (clamp ((tmpvar_26 * normal_27), 0.0, 1.0), scalePerBasisVector_28));
  vec3 v_32;
  v_32.x = tmpvar_26[0].x;
  v_32.y = tmpvar_26[1].x;
  v_32.z = tmpvar_26[2].x;
  vec3 v_33;
  v_33.x = tmpvar_26[0].y;
  v_33.y = tmpvar_26[1].y;
  v_33.z = tmpvar_26[2].y;
  vec3 v_34;
  v_34.x = tmpvar_26[0].z;
  v_34.y = tmpvar_26[1].z;
  v_34.z = tmpvar_26[2].z;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, dot (normal_14, normalize((normalize((((scalePerBasisVector_28.x * v_32) + (scalePerBasisVector_28.y * v_33)) + (scalePerBasisVector_28.z * v_34))) + viewDir_24))));
  nh_25 = tmpvar_35;
  mediump float arg1_36;
  arg1_36 = (tmpvar_12 * 128.0);
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = lm_29;
  tmpvar_37.w = pow (nh_25, arg1_36);
  tmpvar_23 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_23);
  light_3 = tmpvar_38;
  lowp vec4 c_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_13.xyz * tmpvar_38.xyz);
  c_39.xyz = tmpvar_40;
  c_39.w = 0.0;
  c_2 = c_39;
  c_2.xyz = (c_2.xyz + tmpvar_18);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
v2f_surf vert_surf( in appdata_full v ) {
    #line 433
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 437
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 441
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 445
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 454
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 457
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    #line 461
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 465
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 469
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    #line 473
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor);
    #line 477
    light += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 55 ALU
PARAM c[25] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[13];
MOV R0.w, c[0].y;
ADD result.texcoord[5].xyz, R2, R3;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 R0.y, R1, c[5];
DP3 R0.w, -R2, c[5];
DP4 R1.w, vertex.position, c[4];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[22].w;
DP3 R0.y, R1, c[6];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[22].w;
DP3 R0.y, R1, c[7];
DP4 R1.z, vertex.position, c[3];
DP3 R0.w, -R2, c[7];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].x;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[4], R0, c[22].w;
MOV R0.x, R2;
MUL R0.y, R2, c[14].x;
ADD result.texcoord[1].xy, R0, R2.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 55 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 56 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c25, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c25.y
add o6.xyz, r2, r3
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c22.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c22.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c22.w
dp3 r0.y, r1, c6
dp4 r1.z, v0, c2
dp3 r0.w, -r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c25.x
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c22.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o2.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o2.zw, r1
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 160 // 144 used size, 11 vars
Vector 112 [_MainTex_ST] 4
Vector 128 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 62 instructions, 4 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgbbnafhnnaaoookhffbfflefnjffekkiabaaaaaacmakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgaaiaaaaeaaaabaabiacaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaa
amaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegambaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaa
adaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaaakiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaaakiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaabaaaaaa
bkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  mat3 tmpvar_27;
  tmpvar_27[0] = _Object2World[0].xyz;
  tmpvar_27[1] = _Object2World[1].xyz;
  tmpvar_27[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_27 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  tmpvar_7 = tmpvar_29;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_5, tmpvar_13);
  tmpvar_14.y = dot (tmpvar_6, tmpvar_13);
  tmpvar_14.z = dot (tmpvar_7, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 - (2.0 * (dot (tmpvar_14, tmpvar_4) * tmpvar_14)));
  lowp vec3 tmpvar_16;
  tmpvar_16 = (textureCube (_Cube, tmpvar_15).xyz * 0.1);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_19;
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_12.xyz * light_3.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = 0.0;
  c_2 = c_20;
  c_2.xyz = (c_2.xyz + tmpvar_16);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  mat3 tmpvar_27;
  tmpvar_27[0] = _Object2World[0].xyz;
  tmpvar_27[1] = _Object2World[1].xyz;
  tmpvar_27[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (tmpvar_27 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_29;
  mediump vec4 normal_30;
  normal_30 = tmpvar_28;
  highp float vC_31;
  mediump vec3 x3_32;
  mediump vec3 x2_33;
  mediump vec3 x1_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (unity_SHAr, normal_30);
  x1_34.x = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (unity_SHAg, normal_30);
  x1_34.y = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (unity_SHAb, normal_30);
  x1_34.z = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normal_30.xyzz * normal_30.yzzx);
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHBr, tmpvar_38);
  x2_33.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHBg, tmpvar_38);
  x2_33.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHBb, tmpvar_38);
  x2_33.z = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = ((normal_30.x * normal_30.x) - (normal_30.y * normal_30.y));
  vC_31 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (unity_SHC.xyz * vC_31);
  x3_32 = tmpvar_43;
  tmpvar_29 = ((x1_34 + x2_33) + x3_32);
  tmpvar_7 = tmpvar_29;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_13;
  normal_13.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_5, normal_13);
  tmpvar_14.y = dot (tmpvar_6, normal_13);
  tmpvar_14.z = dot (tmpvar_7, normal_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 - (2.0 * (dot (tmpvar_14, tmpvar_4) * tmpvar_14)));
  lowp vec3 tmpvar_16;
  tmpvar_16 = (textureCube (_Cube, tmpvar_15).xyz * 0.1);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_19;
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_12.xyz * light_3.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = 0.0;
  c_2 = c_20;
  c_2.xyz = (c_2.xyz + tmpvar_16);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 447
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 429
v2f_surf vert_surf( in appdata_full v ) {
    #line 431
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 435
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 439
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 443
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 427
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 447
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 449
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 451
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    #line 455
    surfIN.TtoW0 = IN.TtoW0.xyz;
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    #line 459
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 463
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 467
    light.xyz += IN.vlight;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 47 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[17];
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[15];
DP4 R2.x, R0, c[13];
DP4 R2.y, R0, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 R0.y, R1, c[9];
DP3 R0.w, -R2, c[9];
DP4 R1.w, vertex.position, c[8];
DP3 R0.x, vertex.attrib[14], c[9];
DP3 R0.z, vertex.normal, c[9];
MUL result.texcoord[2], R0, c[20].w;
DP3 R0.y, R1, c[10];
DP3 R0.w, -R2, c[10];
DP3 R0.x, vertex.attrib[14], c[10];
DP3 R0.z, vertex.normal, c[10];
MUL result.texcoord[3], R0, c[20].w;
DP3 R0.y, R1, c[11];
DP4 R1.z, vertex.position, c[7];
DP3 R0.w, -R2, c[11];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].x;
DP3 R0.x, vertex.attrib[14], c[11];
DP3 R0.z, vertex.normal, c[11];
MUL result.texcoord[4], R0, c[20].w;
MOV R0.x, R2;
MUL R0.y, R2, c[18].x;
ADD result.texcoord[1].xy, R0, R2.z;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[19];
MUL result.texcoord[6].xyz, R0, c[19].w;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 47 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 48 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c24, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c16
mov r0.w, c24.y
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r2.xyz, r2, c20.w, -v0
dp3 r0.y, r1, c8
dp3 r0.w, -r2, c8
dp4 r1.w, v0, c7
dp3 r0.x, v1, c8
dp3 r0.z, v2, c8
mul o3, r0, c20.w
dp3 r0.y, r1, c9
dp3 r0.w, -r2, c9
dp3 r0.x, v1, c9
dp3 r0.z, v2, c9
mul o4, r0, c20.w
dp3 r0.y, r1, c10
dp4 r1.z, v0, c6
dp3 r0.w, -r2, c10
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c24.x
dp3 r0.x, v1, c10
dp3 r0.z, v2, c10
mul o5, r0, c20.w
mov r0.x, r2
mul r0.y, r2, c17.x
mad o2.xy, r2.z, c18.zwzw, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c19
mul o7.xyz, r0, c19.w
mov r0.x, c19.w
add r0.y, c24, -r0.x
dp4 r0.x, v0, c2
mov o0, r1
mov o2.zw, r1
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 160 used size, 13 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 59 instructions, 4 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedaagbbmkahenaemakibnnbfphfmhfnlnoabaaaaaadiakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
feaiaaaaeaaaabaabfacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaa
gfaaaaadpccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaaaoaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaa
adaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaa
adaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaadaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaa
egaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaa
ckiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaa
aaaaaaaapgipcaaaadaaaaaabeaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
ahaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaahaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  tmpvar_7.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_7.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  tmpvar_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD4.xyz;
  tmpvar_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_8, tmpvar_16);
  tmpvar_17.y = dot (tmpvar_9, tmpvar_16);
  tmpvar_17.z = dot (tmpvar_10, tmpvar_16);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_7 - (2.0 * (dot (tmpvar_17, tmpvar_7) * tmpvar_17)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = (textureCube (_Cube, tmpvar_18).xyz * 0.1);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_21.w;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lmFull_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  lmIndirect_3 = tmpvar_24;
  light_6.xyz = (tmpvar_21.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_15.xyz * light_6.xyz);
  c_25.xyz = tmpvar_26;
  c_25.w = 0.0;
  c_2 = c_25;
  c_2.xyz = (c_2.xyz + tmpvar_19);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_glesVertex.xyz - ((_World2Object * tmpvar_9).xyz * unity_Scale.w)));
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_1.xyz;
  tmpvar_13 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_2.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_2.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_2.z;
  vec4 v_15;
  v_15.x = _Object2World[0].x;
  v_15.y = _Object2World[1].x;
  v_15.z = _Object2World[2].x;
  v_15.w = _Object2World[3].x;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (tmpvar_14 * v_15.xyz);
  tmpvar_16.w = tmpvar_11.x;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * unity_Scale.w);
  tmpvar_4 = tmpvar_17;
  vec4 v_18;
  v_18.x = _Object2World[0].y;
  v_18.y = _Object2World[1].y;
  v_18.z = _Object2World[2].y;
  v_18.w = _Object2World[3].y;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_14 * v_18.xyz);
  tmpvar_19.w = tmpvar_11.y;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  vec4 v_21;
  v_21.x = _Object2World[0].z;
  v_21.y = _Object2World[1].z;
  v_21.z = _Object2World[2].z;
  v_21.w = _Object2World[3].z;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_14 * v_21.xyz);
  tmpvar_22.w = tmpvar_11.z;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_8.zw;
  tmpvar_7.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_7.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_24;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  tmpvar_7 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD4.xyz;
  tmpvar_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_8, normal_16);
  tmpvar_17.y = dot (tmpvar_9, normal_16);
  tmpvar_17.z = dot (tmpvar_10, normal_16);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_7 - (2.0 * (dot (tmpvar_17, tmpvar_7) * tmpvar_17)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = (textureCube (_Cube, tmpvar_18).xyz * 0.1);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_21.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp float tmpvar_24;
  tmpvar_24 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((8.0 * tmpvar_22.w) * tmpvar_22.xyz);
  lmFull_4 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((8.0 * tmpvar_23.w) * tmpvar_23.xyz);
  lmIndirect_3 = tmpvar_26;
  light_6.xyz = (tmpvar_21.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_15.xyz * light_6.xyz);
  c_27.xyz = tmpvar_28;
  c_27.w = 0.0;
  c_2 = c_27;
  c_2.xyz = (c_2.xyz + tmpvar_19);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 454
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
v2f_surf vert_surf( in appdata_full v ) {
    #line 433
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 437
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 441
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 445
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 454
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 455
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 458
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    #line 462
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 466
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 470
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 474
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    #line 478
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    #line 482
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 41 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1.w, c[0].y;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
MUL R1.xyz, vertex.attrib[14].w, R0;
DP3 R0.y, R1, c[5];
DP3 result.texcoord[6].y, R1, R2;
DP3 R0.w, -R2, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2], R0, c[15].w;
DP3 R0.y, R1, c[6];
DP3 R1.y, R1, c[7];
DP3 R0.w, -R2, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3], R0, c[15].w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
DP3 R1.x, vertex.attrib[14], c[7];
DP3 R1.w, -R2, c[7];
DP3 R1.z, vertex.normal, c[7];
MUL result.texcoord[4], R1, c[15].w;
MUL R1.y, R3, c[14].x;
MOV R1.x, R3;
ADD result.texcoord[1].xy, R1, R3.z;
DP3 result.texcoord[6].z, vertex.normal, R2;
DP3 result.texcoord[6].x, vertex.attrib[14], R2;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 41 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c19, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mov r1.w, c19.y
mov r1.xyz, c12
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
mul r1.xyz, v1.w, r0
dp3 r0.y, r1, c4
dp3 o7.y, r1, r2
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c15.w
dp3 r0.y, r1, c5
dp3 r1.y, r1, c6
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c15.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r3.xyz, r0.xyww, c19.x
dp3 r1.x, v1, c6
dp3 r1.w, -r2, c6
dp3 r1.z, v2, c6
mul o5, r1, c15.w
mul r1.y, r3, c13.x
mov r1.x, r3
mad o2.xy, r3.z, c14.zwzw, r1
dp3 o7.z, v2, r2
dp3 o7.x, v1, r2
mov o0, r0
mov o2.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o6.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 160 used size, 13 vars
Vector 112 [unity_LightmapST] 4
Vector 128 [_MainTex_ST] 4
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 50 instructions, 5 temp regs, 0 temp arrays:
// ALU 36 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmfoaaocieongkpodidoahennclkagejabaaaaaameaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oaagaaaaeaaaabaaliabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagfaaaaaddccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaa
aaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaa
abaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaa
abaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaa
aeaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaacaaaaaaaoaaaaaa
baaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaa
bkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaaeaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
aeaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaa
ckiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
pccabaaaafaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaadcaaaaal
dccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_7.zw;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_23;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (tmpvar_13 * (((_World2Object * tmpvar_26).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  mediump float tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  highp float tmpvar_15;
  tmpvar_15 = _SpecularColor.x;
  tmpvar_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_5, tmpvar_14);
  tmpvar_16.y = dot (tmpvar_6, tmpvar_14);
  tmpvar_16.z = dot (tmpvar_7, tmpvar_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_4 - (2.0 * (dot (tmpvar_16, tmpvar_4) * tmpvar_16)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = (textureCube (_Cube, tmpvar_17).xyz * 0.1);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD6);
  mediump vec4 tmpvar_21;
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_20;
  highp float nh_23;
  mat3 tmpvar_24;
  tmpvar_24[0].x = 0.816497;
  tmpvar_24[0].y = -0.408248;
  tmpvar_24[0].z = -0.408248;
  tmpvar_24[1].x = 0.0;
  tmpvar_24[1].y = 0.707107;
  tmpvar_24[1].z = -0.707107;
  tmpvar_24[2].x = 0.57735;
  tmpvar_24[2].y = 0.57735;
  tmpvar_24[2].z = 0.57735;
  mediump vec3 normal_25;
  normal_25 = tmpvar_14;
  mediump vec3 scalePerBasisVector_26;
  mediump vec3 lm_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lm_27 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  scalePerBasisVector_26 = tmpvar_29;
  lm_27 = (lm_27 * dot (clamp ((tmpvar_24 * normal_25), 0.0, 1.0), scalePerBasisVector_26));
  vec3 v_30;
  v_30.x = tmpvar_24[0].x;
  v_30.y = tmpvar_24[1].x;
  v_30.z = tmpvar_24[2].x;
  vec3 v_31;
  v_31.x = tmpvar_24[0].y;
  v_31.y = tmpvar_24[1].y;
  v_31.z = tmpvar_24[2].y;
  vec3 v_32;
  v_32.x = tmpvar_24[0].z;
  v_32.y = tmpvar_24[1].z;
  v_32.z = tmpvar_24[2].z;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (tmpvar_14, normalize((normalize((((scalePerBasisVector_26.x * v_30) + (scalePerBasisVector_26.y * v_31)) + (scalePerBasisVector_26.z * v_32))) + viewDir_22))));
  nh_23 = tmpvar_33;
  mediump float arg1_34;
  arg1_34 = (tmpvar_12 * 128.0);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = lm_27;
  tmpvar_35.w = pow (nh_23, arg1_34);
  tmpvar_21 = tmpvar_35;
  mediump vec4 tmpvar_36;
  tmpvar_36 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_21);
  light_3 = tmpvar_36;
  lowp vec4 c_37;
  mediump vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_13.xyz * tmpvar_36.xyz);
  c_37.xyz = tmpvar_38;
  c_37.w = 0.0;
  c_2 = c_37;
  c_2.xyz = (c_2.xyz + tmpvar_18);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_glesVertex.xyz - ((_World2Object * tmpvar_8).xyz * unity_Scale.w)));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  vec4 v_14;
  v_14.x = _Object2World[0].x;
  v_14.y = _Object2World[1].x;
  v_14.z = _Object2World[2].x;
  v_14.w = _Object2World[3].x;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = (tmpvar_13 * v_14.xyz);
  tmpvar_15.w = tmpvar_10.x;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * unity_Scale.w);
  tmpvar_4 = tmpvar_16;
  vec4 v_17;
  v_17.x = _Object2World[0].y;
  v_17.y = _Object2World[1].y;
  v_17.z = _Object2World[2].y;
  v_17.w = _Object2World[3].y;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_13 * v_17.xyz);
  tmpvar_18.w = tmpvar_10.y;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].z;
  v_20.y = _Object2World[1].z;
  v_20.z = _Object2World[2].z;
  v_20.w = _Object2World[3].z;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_13 * v_20.xyz);
  tmpvar_21.w = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_7.zw;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = o_23;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (tmpvar_13 * (((_World2Object * tmpvar_26).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _SpecularColor;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD3.w;
  tmpvar_8.z = xlv_TEXCOORD4.w;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD2.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD3.xyz;
  tmpvar_6 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD4.xyz;
  tmpvar_7 = tmpvar_11;
  mediump float tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec3 normal_14;
  normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_14.z = sqrt((1.0 - clamp (dot (normal_14.xy, normal_14.xy), 0.0, 1.0)));
  highp float tmpvar_15;
  tmpvar_15 = _SpecularColor.x;
  tmpvar_12 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_5, normal_14);
  tmpvar_16.y = dot (tmpvar_6, normal_14);
  tmpvar_16.z = dot (tmpvar_7, normal_14);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_4 - (2.0 * (dot (tmpvar_16, tmpvar_4) * tmpvar_16)));
  lowp vec3 tmpvar_18;
  tmpvar_18 = (textureCube (_Cube, tmpvar_17).xyz * 0.1);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_22;
  highp float nh_25;
  mat3 tmpvar_26;
  tmpvar_26[0].x = 0.816497;
  tmpvar_26[0].y = -0.408248;
  tmpvar_26[0].z = -0.408248;
  tmpvar_26[1].x = 0.0;
  tmpvar_26[1].y = 0.707107;
  tmpvar_26[1].z = -0.707107;
  tmpvar_26[2].x = 0.57735;
  tmpvar_26[2].y = 0.57735;
  tmpvar_26[2].z = 0.57735;
  mediump vec3 normal_27;
  normal_27 = normal_14;
  mediump vec3 scalePerBasisVector_28;
  mediump vec3 lm_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_20.w) * tmpvar_20.xyz);
  lm_29 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = ((8.0 * tmpvar_21.w) * tmpvar_21.xyz);
  scalePerBasisVector_28 = tmpvar_31;
  lm_29 = (lm_29 * dot (clamp ((tmpvar_26 * normal_27), 0.0, 1.0), scalePerBasisVector_28));
  vec3 v_32;
  v_32.x = tmpvar_26[0].x;
  v_32.y = tmpvar_26[1].x;
  v_32.z = tmpvar_26[2].x;
  vec3 v_33;
  v_33.x = tmpvar_26[0].y;
  v_33.y = tmpvar_26[1].y;
  v_33.z = tmpvar_26[2].y;
  vec3 v_34;
  v_34.x = tmpvar_26[0].z;
  v_34.y = tmpvar_26[1].z;
  v_34.z = tmpvar_26[2].z;
  mediump float tmpvar_35;
  tmpvar_35 = max (0.0, dot (normal_14, normalize((normalize((((scalePerBasisVector_28.x * v_32) + (scalePerBasisVector_28.y * v_33)) + (scalePerBasisVector_28.z * v_34))) + viewDir_24))));
  nh_25 = tmpvar_35;
  mediump float arg1_36;
  arg1_36 = (tmpvar_12 * 128.0);
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = lm_29;
  tmpvar_37.w = pow (nh_25, arg1_36);
  tmpvar_23 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_23);
  light_3 = tmpvar_38;
  lowp vec4 c_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_13.xyz * tmpvar_38.xyz);
  c_39.xyz = tmpvar_40;
  c_39.w = 0.0;
  c_2 = c_39;
  c_2.xyz = (c_2.xyz + tmpvar_18);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
v2f_surf vert_surf( in appdata_full v ) {
    #line 433
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 437
    highp vec3 viewDir = (-ObjSpaceViewDir( v.vertex));
    highp vec3 worldRefl = (mat3( _Object2World) * viewDir);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 441
    o.TtoW0 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 0).xyz), worldRefl.x) * unity_Scale.w);
    o.TtoW1 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 1).xyz), worldRefl.y) * unity_Scale.w);
    o.TtoW2 = (vec4( (rotation * xll_matrixindex_mf4x4_i (_Object2World, 2).xyz), worldRefl.z) * unity_Scale.w);
    o.screen = ComputeScreenPos( o.pos);
    #line 445
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec3 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.screen);
    xlv_TEXCOORD2 = vec4(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec4(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec4(xl_retval.TtoW2);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec3(xl_retval.viewDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 399
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 worldRefl;
    mediump vec3 TtoW0;
    mediump vec3 TtoW1;
    mediump vec3 TtoW2;
};
#line 416
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 screen;
    lowp vec4 TtoW0;
    lowp vec4 TtoW1;
    lowp vec4 TtoW2;
    highp vec2 lmap;
    highp vec3 viewDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _Color;
uniform highp vec4 _SpecularColor;
#line 393
uniform highp vec4 _ReflectColor;
uniform highp float _Shininess;
uniform highp float _AmbientWhiteLight;
uniform sampler2D _MainTex;
#line 397
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
#line 409
#line 428
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    o.Albedo = texture( _MainTex, IN.uv_MainTex).xyz;
    o.Normal = UnpackNormal( texture( _BumpMap, IN.uv_BumpMap));
    #line 413
    o.Specular = float( _SpecularColor);
    o.Emission = (texture( _Cube, reflect( IN.worldRefl, vec3( dot( IN.TtoW0, o.Normal), dot( IN.TtoW1, o.Normal), dot( IN.TtoW2, o.Normal)))).xyz * 0.1);
}
#line 454
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 457
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.worldRefl = vec3( IN.TtoW0.w, IN.TtoW1.w, IN.TtoW2.w);
    surfIN.TtoW0 = IN.TtoW0.xyz;
    #line 461
    surfIN.TtoW1 = IN.TtoW1.xyz;
    surfIN.TtoW2 = IN.TtoW2.xyz;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 465
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 469
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    mediump vec3 specColor;
    #line 473
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor);
    light += lm;
    #line 477
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec3 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.screen = vec4(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec4(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec4(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 23 to 37, TEX: 4 to 6
//   d3d9 - ALU: 19 to 31, TEX: 4 to 6
//   d3d11 - ALU: 15 to 24, TEX: 4 to 6, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 26 ALU, 4 TEX
PARAM c[1] = { { 2, 1, 0.1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[0].x, -c[0].y;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[0].y;
RSQ R0.x, R0.x;
RCP R1.z, R0.x;
DP3 R0.x, fragment.texcoord[2], R1;
DP3 R0.y, R1, fragment.texcoord[3];
DP3 R0.z, R1, fragment.texcoord[4];
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R0.w, R0, R1;
MUL R0.xyz, R0, R0.w;
MAD R0.xyz, -R0, c[0].x, R1;
TEX R1.xyz, R0, texture[2], CUBE;
TXP R0.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R2.xyz, R1, c[0].z;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R1.xyz, -R0, fragment.texcoord[5];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, c[0];
END
# 26 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
"ps_3_0
; 22 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c0, 2.00000000, -1.00000000, 1.00000000, 0.10000000
def c1, 0.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, v2, r1
dp3_pp r0.y, r1, v3
dp3_pp r0.z, r1, v4
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r0.w, r0, r1
mul r0.xyz, r0, r0.w
mad r0.xyz, -r0, c0.x, r1
texld r1.xyz, r0, s2
texldp r0.xyz, v1, s3
mul r2.xyz, r1, c0.w
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r1.xyz, -r0, v5
texld r0.xyz, v0, s0
mad_pp oC0.xyz, r0, r1, r2
mov_pp oC0.w, c1.x
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
// 25 instructions, 3 temp regs, 0 temp arrays:
// ALU 16 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlfbmdifdghigpdblnmckoppdekhlginjabaaaaaaoiaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaadaaaaeaaaaaaaomaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaaaaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaaaaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaacpaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 37 ALU, 6 TEX
PARAM c[3] = { program.local[0],
		{ 8, 2, 1, 0.1 },
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[1].y, -c[1].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
TEX R1, fragment.texcoord[5], texture[4], 2D;
TEX R2, fragment.texcoord[5], texture[5], 2D;
ADD R0.z, -R0, c[1];
MUL R2.xyz, R2.w, R2;
RSQ R0.z, R0.z;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R2, c[1].x;
RCP R0.z, R0.z;
MAD R3.xyz, R1, c[1].x, -R2;
MAD_SAT R0.w, R0, c[0].z, c[0];
DP3 R1.x, fragment.texcoord[2], R0;
DP3 R1.y, R0, fragment.texcoord[3];
DP3 R1.z, R0, fragment.texcoord[4];
MOV R0.x, fragment.texcoord[2].w;
MOV R0.z, fragment.texcoord[4].w;
MOV R0.y, fragment.texcoord[3].w;
DP3 R1.w, R1, R0;
MUL R1.xyz, R1, R1.w;
MAD R1.xyz, -R1, c[1].y, R0;
TXP R0.xyz, fragment.texcoord[1], texture[3], 2D;
MAD R2.xyz, R0.w, R3, R2;
TEX R1.xyz, R1, texture[2], CUBE;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R2;
MUL R2.xyz, R1, c[1].w;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2].x;
END
# 37 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 31 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 8.00000000, 2.00000000, -1.00000000, 1.00000000
def c2, 0.10000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.y, c1.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
texld r1, v5, s4
texld r2, v5, s5
add_pp r0.z, -r0, c1.w
mul_pp r2.xyz, r2.w, r2
rsq_pp r0.z, r0.z
dp4 r0.w, v6, v6
rsq r0.w, r0.w
rcp r0.w, r0.w
mul_pp r1.xyz, r1.w, r1
mul_pp r2.xyz, r2, c1.x
rcp_pp r0.z, r0.z
mad_pp r3.xyz, r1, c1.x, -r2
mad_sat r0.w, r0, c0.z, c0
dp3_pp r1.x, v2, r0
dp3_pp r1.y, r0, v3
dp3_pp r1.z, r0, v4
mov r0.x, v2.w
mov r0.z, v4.w
mov r0.y, v3.w
dp3 r1.w, r1, r0
mul r1.xyz, r1, r1.w
mad r1.xyz, -r1, c1.y, r0
texldp r0.xyz, v1, s3
mad_pp r2.xyz, r0.w, r3, r2
texld r1.xyz, r1, s2
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, r2
mul r2.xyz, r1, c2.x
texld r1.xyz, v0, s0
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c2.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Vector 160 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkhfgbjhjocagpgnnfpcojlgmneaekdkaabaaaaaajiagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceiafaaaaeaaaaaaafcabaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaagcbaaaadpcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaa
aaaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaaaaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaahaaaaaaegbobaaaahaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaagaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaagaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 36 ALU, 6 TEX
PARAM c[5] = { program.local[0],
		{ 2, 1, 8, 0.1 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[5], texture[5], 2D;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[1].y;
RSQ R0.z, R0.z;
MUL R2.xyz, R1.w, R1;
RCP R0.z, R0.z;
DP3_SAT R1.z, R0, c[2];
DP3_SAT R1.x, R0, c[4];
DP3_SAT R1.y, R0, c[3];
MUL R1.xyz, R2, R1;
DP3 R1.w, R1, c[1].z;
DP3 R2.x, R0, fragment.texcoord[2];
DP3 R2.y, R0, fragment.texcoord[3];
DP3 R2.z, R0, fragment.texcoord[4];
TEX R0, fragment.texcoord[5], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R2.w, R2, R1;
MUL R2.xyz, R2, R2.w;
MAD R2.xyz, -R2, c[1].x, R1;
TXP R1.xyz, fragment.texcoord[1], texture[3], 2D;
TEX R2.xyz, R2, texture[2], CUBE;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, c[1].z, -R1;
MUL R2.xyz, R2, c[1].w;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2];
END
# 36 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 30 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c1, -0.40824828, -0.70710677, 0.57735026, 0.10000000
def c2, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c3, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r1, v5, s5
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c0
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r1.w, r1
rcp_pp r0.z, r0.z
dp3_pp_sat r1.z, r0, c1
dp3_pp_sat r1.x, r0, c3
dp3_pp_sat r1.y, r0, c2
mul_pp r1.xyz, r2, r1
dp3_pp r1.w, r1, c0.w
dp3_pp r2.x, r0, v2
dp3_pp r2.y, r0, v3
dp3_pp r2.z, r0, v4
texld r0, v5, s4
mul_pp r0.xyz, r0.w, r0
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r2, r1
mul r2.xyz, r2, r2.w
mad r2.xyz, -r2, c0.x, r1
texldp r1.xyz, v1, s3
texld r2.xyz, r2, s2
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, c0.w, -r1
mul r2.xyz, r2, c1.w
texld r1.xyz, v0, s0
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c2
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 35 instructions, 5 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedeodfjagkkjkbbbkapldmdeghpdjjgchhabaaaaaaimagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdmafaaaaeaaaaaaaepabaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
dcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaacpaaaaaf
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
agaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaaapcaaaakbcaabaaaaeaaaaaa
aceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaak
ccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaa
adaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
acaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmmmdn
mnmmmmdnmnmmmmdnaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 23 ALU, 4 TEX
PARAM c[1] = { { 2, 1, 0.1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[0].x, -c[0].y;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[0].y;
RSQ R0.x, R0.x;
RCP R1.z, R0.x;
DP3 R0.x, fragment.texcoord[2], R1;
DP3 R0.y, R1, fragment.texcoord[3];
DP3 R0.z, R1, fragment.texcoord[4];
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R0.w, R0, R1;
MUL R0.xyz, R0, R0.w;
MAD R0.xyz, -R0, c[0].x, R1;
TEX R0.xyz, R0, texture[2], CUBE;
MUL R2.xyz, R0, c[0].z;
TXP R1.xyz, fragment.texcoord[1], texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R1.xyz, R1, fragment.texcoord[5];
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, c[0];
END
# 23 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
"ps_3_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c0, 2.00000000, -1.00000000, 1.00000000, 0.10000000
def c1, 0.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c0.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, v2, r1
dp3_pp r0.y, r1, v3
dp3_pp r0.z, r1, v4
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r0.w, r0, r1
mul r0.xyz, r0, r0.w
mad r0.xyz, -r0, c0.x, r1
texld r0.xyz, r0, s2
mul r2.xyz, r0, c0.w
texldp r1.xyz, v1, s3
texld r0.xyz, v0, s0
add_pp r1.xyz, r1, v5
mad_pp oC0.xyz, r0, r1, r2
mov_pp oC0.w, c1.x
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjchcfmgjiljpgbbnjlkjpaeeajenacnmabaaaaaanaaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiadaaaaeaaaaaaaogaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaaaaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaaaaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 34 ALU, 6 TEX
PARAM c[3] = { program.local[0],
		{ 8, 2, 1, 0.1 },
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[1].y, -c[1].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
TEX R1, fragment.texcoord[5], texture[4], 2D;
TEX R2, fragment.texcoord[5], texture[5], 2D;
ADD R0.z, -R0, c[1];
MUL R2.xyz, R2.w, R2;
RSQ R0.z, R0.z;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R2, c[1].x;
MAD R3.xyz, R1, c[1].x, -R2;
RCP R0.z, R0.z;
DP3 R1.x, fragment.texcoord[2], R0;
DP3 R1.y, R0, fragment.texcoord[3];
DP3 R1.z, R0, fragment.texcoord[4];
MOV R0.x, fragment.texcoord[2].w;
MOV R0.z, fragment.texcoord[4].w;
MOV R0.y, fragment.texcoord[3].w;
DP3 R1.w, R1, R0;
MUL R1.xyz, R1, R1.w;
MAD R0.xyz, -R1, c[1].y, R0;
MAD_SAT R0.w, R0, c[0].z, c[0];
MAD R1.xyz, R0.w, R3, R2;
TEX R2.xyz, R0, texture[2], CUBE;
TXP R0.xyz, fragment.texcoord[1], texture[3], 2D;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[1].w;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2].x;
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 28 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 8.00000000, 2.00000000, -1.00000000, 1.00000000
def c2, 0.10000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c1.y, c1.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
texld r1, v5, s4
texld r2, v5, s5
add_pp r0.z, -r0, c1.w
mul_pp r2.xyz, r2.w, r2
rsq_pp r0.z, r0.z
dp4 r0.w, v6, v6
rsq r0.w, r0.w
rcp r0.w, r0.w
mul_pp r1.xyz, r1.w, r1
mul_pp r2.xyz, r2, c1.x
mad_pp r3.xyz, r1, c1.x, -r2
rcp_pp r0.z, r0.z
dp3_pp r1.x, v2, r0
dp3_pp r1.y, r0, v3
dp3_pp r1.z, r0, v4
mov r0.x, v2.w
mov r0.z, v4.w
mov r0.y, v3.w
dp3 r1.w, r1, r0
mul r1.xyz, r1, r1.w
mad r0.xyz, -r1, c1.y, r0
mad_sat r0.w, r0, c0.z, c0
mad_pp r1.xyz, r0.w, r3, r2
texld r2.xyz, r0, s2
texldp r0.xyz, v1, s3
add_pp r0.xyz, r0, r1
mul r2.xyz, r2, c2.x
texld r1.xyz, v0, s0
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c2.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 192 // 176 used size, 13 vars
Vector 160 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 34 instructions, 3 temp regs, 0 temp arrays:
// ALU 23 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddopdlbpbbikjccmbfodoihbebfameabjabaaaaaaiaagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaafaaaaeaaaaaaaemabaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaaagaaaaaagcbaaaadpcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaa
aaaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaaaaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaa
bbaaaaahicaabaaaaaaaaaaaegbobaaaahaaaaaaegbobaaaahaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadccaaaalicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaagaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaagaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 33 ALU, 6 TEX
PARAM c[5] = { program.local[0],
		{ 2, 1, 8, 0.1 },
		{ -0.40824828, -0.70710677, 0.57735026, 0 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[5], texture[5], 2D;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[1].y;
RSQ R0.z, R0.z;
MUL R2.xyz, R1.w, R1;
RCP R0.z, R0.z;
DP3_SAT R1.z, R0, c[2];
DP3_SAT R1.x, R0, c[4];
DP3_SAT R1.y, R0, c[3];
MUL R1.xyz, R2, R1;
DP3 R1.w, R1, c[1].z;
DP3 R2.x, R0, fragment.texcoord[2];
DP3 R2.y, R0, fragment.texcoord[3];
DP3 R2.z, R0, fragment.texcoord[4];
TEX R0, fragment.texcoord[5], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MOV R1.x, fragment.texcoord[2].w;
MOV R1.z, fragment.texcoord[4].w;
MOV R1.y, fragment.texcoord[3].w;
DP3 R2.w, R2, R1;
MUL R2.xyz, R2, R2.w;
MAD R2.xyz, -R2, c[1].x, R1;
TEX R2.xyz, R2, texture[2], CUBE;
TXP R1.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R0.xyz, R0, R1.w;
MAD R0.xyz, R0, c[1].z, R1;
MUL R2.xyz, R2, c[1].w;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[2];
END
# 33 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Cube] CUBE
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 27 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c1, -0.40824828, -0.70710677, 0.57735026, 0.10000000
def c2, -0.40824831, 0.70710677, 0.57735026, 0.00000000
def c3, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r1, v5, s5
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c0
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r1.w, r1
rcp_pp r0.z, r0.z
dp3_pp_sat r1.z, r0, c1
dp3_pp_sat r1.x, r0, c3
dp3_pp_sat r1.y, r0, c2
mul_pp r1.xyz, r2, r1
dp3_pp r1.w, r1, c0.w
dp3_pp r2.x, r0, v2
dp3_pp r2.y, r0, v3
dp3_pp r2.z, r0, v4
texld r0, v5, s4
mul_pp r0.xyz, r0.w, r0
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r2, r1
mul r2.xyz, r2, r2.w
mad r2.xyz, -r2, c0.x, r1
texld r2.xyz, r2, s2
texldp r1.xyz, v1, s3
mul_pp r0.xyz, r0, r1.w
mad_pp r0.xyz, r0, c0.w, r1
mul r2.xyz, r2, c1.w
texld r1.xyz, v0, s0
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c2
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 34 instructions, 5 temp regs, 0 temp arrays:
// ALU 23 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednmppikpjbhfglffaocmmgbeiepgifdmfabaaaaaaheagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcceafaaaaeaaaaaaaejabaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
dcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaagaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaagaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaa
apcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaa
igaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaabaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
afaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaadaaaaaa
dgaaaaafccaabaaaacaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaacaaaaaa
dkbabaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

}
	}

#LINE 47

    }

	// Vertex lighting
	SubShader {
		Tags { "RenderType"="Opaque" }
        Pass {
            Material {
                Diffuse [_Color]
                Ambient [_Color]
                Shininess [_Shininess]
                Specular [_SpecularColor]
                Emission [_Cube]
            }
            Lighting On
            SeparateSpecular On
            SetTexture [_MainTex] {
                Combine texture * primary DOUBLE, texture * primary
            }
            SetTexture [_Cube] {
            	constantColor[_ReflectColor]
                Combine constant * texture + previous, previous
            }
        }

    }

    FallBack "VertexLit"
}
