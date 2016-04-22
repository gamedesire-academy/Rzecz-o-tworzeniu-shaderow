float4x4 matViewProjection;

struct VS_INPUT 
{
   float4 Position : POSITION0; 
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position =  mul( Input.Position, matViewProjection );
  
   return( Output );
   
}