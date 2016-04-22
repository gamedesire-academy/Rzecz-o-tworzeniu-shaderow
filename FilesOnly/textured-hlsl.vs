float3 lightPos;
float4x4 matView;
float4x4 matProjection;
float4x4 matViewInverse;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   float3 Normal :   NORMAL0;
};

struct VS_OUTPUT 
{
   float4 Position :        POSITION0;
   float2 Texcoord :        TEXCOORD0;
   float3 Normal :          TEXCOORD1;
   float3 LightDirection:   TEXCOORD2;
   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;
   
   float4x4 VP = mul (matView, matProjection);

   Output.Position          = mul( Input.Position, VP);
   Output.Texcoord         = Input.Texcoord;
   
   Output.Normal           = Input.Normal;

   float3 lightDirWorld = mul(lightPos, matViewInverse) - Input.Position;
   Output.LightDirection = lightDirWorld;
   
   return( Output );
   
}


