shader_type spatial;

uniform vec4 colorA  : source_color = vec4(1.,0.,0.,1.);
uniform vec4 colorB : source_color = vec4(0.);
render_mode blend_mix;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = mix(colorB.rgb, colorA.rgb, UV.y);
	ALPHA = mix(colorB.a, colorA.a, UV.y);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
