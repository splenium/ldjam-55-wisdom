shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}
#include "res://shaders/common.gdshaderinc"

void fragment() {
	vec2 uv = (UV-.5);
	float shape = length(uv)-.1;
	ALBEDO.rgb = COLOR.rgb*15.;
	ALPHA = (1.-sat(shape*5.))*COLOR.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
