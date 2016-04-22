float4x4 matView;
float4x4 matProjection;
float4x4 matView_static;
float time;
float intensity;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float2 TexCoords: TEXCOORD0;
   float3 Normal: NORMAL0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float2 TexCoords: TEXCOORD0;
   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;
   
   float4 posProj = mul( Input.Position, mul( matView_static, matProjection) );
   float4 normalProj = mul (Input.Normal, mul( matView_static, matProjection) ); 
   
   float mod = sin(time + Input.Position.x) * intensity;
   Output.Position = posProj + mul(normalProj, mod);
   Output.TexCoords = Input.TexCoords;
   
   return( Output );
   
}



