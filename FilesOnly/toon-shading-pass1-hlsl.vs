float4x4 matViewProjection;
float outlineWidth;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float3 Normal : NORMAL0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;
   
   float4 origin = mul(Input.Position, matViewProjection);
   float4 normal = mul(Input.Normal, matViewProjection);

   Output.Position = origin + mul( normal, outlineWidth );
   
   return( Output );
   
}



