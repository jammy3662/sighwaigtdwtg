#version 330

in vec3 vertexPosition;
in vec3 vertexNormal;
in vec2 vertexTexCoord;
in vec2 vertexTexCoord2;
in vec4 vertexColor;

uniform mat4 mvp;
uniform mat4 matView;
uniform mat4 matProjection;
uniform mat4 matModel;
uniform mat4 matNormal;

out vec4 fragPos;
out vec4 fragSun; // fragment position in sun space
out vec2 fragCoord;
out vec2 fragCoord2;
out vec3 fragNormal;
out vec3 fragTangent;
out vec4 fragColor;

uniform mat4 sunView;
uniform mat4 sunProj;

void main()
{
	// Send vertex attributes to fragment shader
	fragPos = matModel * vec4(vertexPosition, 1.0);
	fragCoord = vertexTexCoord;
	fragColor = vertexColor;
	fragNormal = (matNormal * vec4(vertexNormal, 1.0)).xyz;
	
	// this is the same calculation as
	// the final vertex position, except
	// from the light camera
	fragSun = sunProj * sunView * matModel * vec4(vertexPosition, 1.0);
	
	// Calculate final vertex position
	gl_Position = mvp * vec4(vertexPosition, 1.0);
}
