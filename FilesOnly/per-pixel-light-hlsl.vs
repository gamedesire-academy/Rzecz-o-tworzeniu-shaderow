float4x4 matViewProjection;
float4x4 matView;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float3 Normal: NORMAL0;
   
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float4 IPosition : TEXCOORD0;
   float3 Normal: TEXCOORD1;  
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position =  mul( Input.Position, matViewProjection );
   Output.IPosition =  mul( Input.Position, matView );
   
   Output.Normal =  mul(Input.Normal, matView); 
   return( Output );
   
}