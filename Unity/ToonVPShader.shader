Shader "Unlit/ToonVPShader"
{
	Properties
	{
		_DefaultColor("Default Color", Color) = (1, 1, 1, 1)
		_BorderColor("Border Color", Color) = (0, 1, 1, 1)
		_Thickness("Thickness", float) = 0.02
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CULL FRONT

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			float4 _BorderColor;
			float _Thickness;

			struct appdata
			{
				float4 vertex : POSITION0;
				float4 normal: NORMAL0;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;

				float4 origin = mul(UNITY_MATRIX_MVP, v.vertex);
				float4 norm = mul(UNITY_MATRIX_MVP, v.normal);

				o.vertex = origin + mul(norm, _Thickness);

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = _BorderColor;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}

		PASS
		{
			Tags {"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION0;
				float4 normal: NORMAL0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half intensity : TEXCOORD0;
				UNITY_FOG_COORDS(1)
			};

			float4 _DefaultColor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.intensity = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half colorMod = 1;
				if(i.intensity > 0.95)
					colorMod = 1;
				else if(i.intensity > 0.5)
					colorMod = 0.7;
				else if(i.intensity > 0.05)
					colorMod = 0.35;
				else
					colorMod = 0.1;

				// sample the texture
				fixed4 col = _DefaultColor * colorMod;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}

			ENDCG
		}
	}
}
