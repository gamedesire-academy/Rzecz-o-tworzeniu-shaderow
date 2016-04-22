float4x4 matViewProjection;
float4x4 matView;
float3 lightPos;

struct VS_INPUT 
{
   float4 Position : POSITION0;
   float3 Normal: NORMAL0;
};

struct VS_OUTPUT 
{
   float4 Position : POSITION0;
   float Specular : TEXCOORD1;
   float Light : TEXCOORD2;
   
};

VS_OUTPUT vs_main( VS_INPUT Input )
{
   VS_OUTPUT Output;

   Output.Position =  mul( Input.Position, matViewProjection );
   
   float4 posInCamera = mul(Input.Position, matView);
   float3 normal =  mul(Input.Normal, matView);
   float3 lightDir = normalize(lightPos - posInCamera);
   
   Output.Light = dot(lightDir, normal);
   
   float3 V = normalize(-posInCamera);
   float3 R = reflect(-lightDir, normal);
   Output.Specular = max(0, dot(R, V));
   
   
   return( Output );
   
}



