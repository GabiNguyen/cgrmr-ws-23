Shader "MyShaders/BasicDiffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SpecIntensity ("Spec Intensity", Range(0.0, 50.0)) = 1
        _SpecPower ("Spec Power", Range(0.0, 50.0)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXTCOORD1;
                float4 viewDir : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _SpecIntensity;
            float _SpecPower;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                o.normal = UnityObjectToWorldNormal(v.normal);
                o.viewDir = normalize(UnityWorldSpaceViewDir(v.vertex));

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {

                float ndotl = max(0.0, dot(i.normal, _WorldSpaceLightPos0));
                float3 diffuse = ndotl * _LightColor0;

                float3 h = normalize(i.viewDir + _WorldSpaceLightPos0);
                float specular = pow(max(0.0, dot(i.normal, h)), _SpecPower) * _SpecIntensity * _LightColor0;

                // sample the texture
                // fixed4 col = tex2D(_MainTex, i.uv);
                return half4(diffuse + specular, 1.0f);
            }
            ENDCG
        }
    }
}
