shader_type spatial;
uniform sampler2D voronoise;

varying vec3 wpos;
void vertex() {
	wpos = VERTEX;
	// Called for every vertex the material is visible on.
}
#define sat(a) clamp(a, 0., 1.)
void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO.rgb = vec3(1.);
	vec2 uv = UV;
	float shape = max(abs(uv.x-.5)-.25, abs(uv.y-.5)-.25);
	
	ALPHA = texture(voronoise, UV*2.).x * sat(texture(voronoise, UV*1.+vec2(0., -TIME*.02)).x-.5)*
	sat(texture(voronoise, UV*.5+vec2(0., -TIME*.01)).x)*
	(1.-sat(shape*5.));
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
