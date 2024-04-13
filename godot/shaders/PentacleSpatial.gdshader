shader_type spatial;
uniform sampler2D iChannel0;

render_mode blend_add;
#include "res://shaders/common.gdshaderinc"

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float iTime = TIME;
	vec2 uv = UV-.5;
	vec3 col = pentacle(uv, iChannel0, iTime);
	ALBEDO = col;
	SPECULAR = 0.;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
