Shader "MyShaders/StencilWall"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SRef("Stencil Reference", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] 
        _SComp("Stencil Compare", Float) = 6
        [Enum(UnityEngine.Rendering.StencilOp)] 
        _SOp("Stencil Operator", Float) = 6
        [Enum(UnityEngine.Rendering.StencilOp)] 
        _SFail("Stencil Fail", Float) = 6
    }
    SubShader
    {
       Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Stencil 
            {
                Ref [_SRef]
                Comp [_SComp]
                Pass [_SOp]
                Fail [_SFail]
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}

// 4 stencil windows