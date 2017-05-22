﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "DX11/Sample 3D Texture" {
	Properties{
		_MainTex("Texture", 3D) = "" {}
	}
	SubShader{
		Pass{

		//Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" "IgnoreProjector" = "True" }
		//ZWrite Off
		//Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

			struct vs_input {
				float4 vertex : POSITION;
			};

			struct ps_input {
				float4 pos : SV_POSITION;
				float3 uv : TEXCOORD0;
			};


			ps_input vert(vs_input v)
			{
				ps_input o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.vertex.xyz;
				return o;
			}

			sampler3D _MainTex;

			float4 frag(ps_input i) : COLOR
			{
				//return float4(1,0,0,tex3D(_MainTex, i.uv).r);
				return tex3D(_MainTex, i.uv);
			}

			ENDCG

		}
	}

	Fallback "VertexLit"
}