Shader "MyShaders/StencilXRay"
{
    Properties
    {
        _SRef("Stencil Reference", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] 
        _SComp("Stencil Compare", Float) = 6
        [Enum(UnityEngine.Rendering.StencilOp)] 
        _SOp("Stencil Operator", Float) = 2
        [Enum(UnityEngine.Rendering.StencilOp)] 
        _SFail("Stencil Fail", Float) = 0   
    }

    SubShader
    {

        Tags 
        { "RenderType"="Opaque" 
            "RenderPipeline" ="UniversalPipeline"    
            "Queue"="Geometry-100" 
        }        
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

            ZWrite Off
            ColorMask 0
        }
    }
}