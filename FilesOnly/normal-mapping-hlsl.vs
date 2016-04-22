float3 lightPos;
float4x4 matView;
float4x4 matProjection;
float4x4 matViewInverse;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 Texcoord : TEXCOORD0;
   float3 Normal :   NORMAL0;
   float3 Binormal : BINORMAL0;
   float3 Tangent :  TANGENT0;
   
};

struct VS_OUTPUT 
{
   float4 Position :        POSITION0;
   float2 Texcoord :        TEXCOORD0;
   float3 LightDirection:   TEXCOORD1;
   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;
   
   float4x4 matViewProjection = mul (matView, matProjection);

   Output.Position          = mul( Input.Position, matViewProjection);
   Output.Texcoord         = Input.Texcoord;
   
   float3x3 TBN = transpose(float3x3(Input.Tangent, Input.Binormal, Input.Normal));
   float3 lightDirWorld = normalize(mul(lightPos, matViewInverse) - Input.Position);
   Output.LightDirection = mul(lightDirWorld, TBN);
   
   return( Output );
   
}


