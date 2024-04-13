shader_type spatial;
uniform sampler2D voronoise;

varying vec3 wpos;
void vertex() {
	wpos = (INV_VIEW_MATRIX*vec4(VERTEX, 1.)).xyz;
	// Called for every vertex the material is visible on.
}

vec4 sampleMirror(sampler2D tex, vec2 uv)
{
	 vec2 mirroredUV = abs(fract(uv - 0.5) - 0.5) * 2.0;

    // Sample the texture using mirrored UV coordinates
    return texture(tex, mirroredUV);
}

#define sat(a) clamp(a, 0., 1.)
void fragment() {
	vec3 wpos_ = (INV_VIEW_MATRIX*vec4(VERTEX, 1.)).xyz;
	// Called for every pixel the material is visible on.
	ALBEDO.rgb = vec3(.5);
	ALBEDO.rgb *= mix(1.,.5,1.-sat((length(wpos_.xy)-1.5)*2.));
	vec2 uv = UV;
	uv.x += sin(uv.y*10.+TIME*.1+NODE_POSITION_WORLD.z)*.1;
	float shape = max(abs(uv.x-.5)-.25, abs(uv.y-.5)-.25+.1*(sin(NODE_POSITION_WORLD.z*5.)*0.5+.5));
	
	ALPHA = sampleMirror(voronoise, UV*2.).x * sat(sampleMirror(voronoise, UV*1.+vec2(0., -TIME*.02+NODE_POSITION_WORLD.z*10.)).x-.5)*
	sat(sampleMirror(voronoise, UV*.5+vec2(0., -TIME*.01)).x)*
	(1.-sat(shape*5.));
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
