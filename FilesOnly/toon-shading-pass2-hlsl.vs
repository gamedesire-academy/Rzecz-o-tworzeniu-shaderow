float4x4 matViewProjection;
float4x4 matView;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float3 Normal : NORMAL0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float3 Normal : TEXCOORD1;
   float4 PosInterpolated: TEXCOORD2;
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position = mul( Input.Position, matViewProjection );
   Output.PosInterpolated = mul(Input.Position, matView);
   Output.Normal = mul(Input.Normal, matView);

   return( Output );
   
}



