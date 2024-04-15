shader_type canvas_item;
uniform sampler2D voronoise;
render_mode blend_add;
varying vec3 wpos;
uniform float seed;
uniform vec4 color : source_color;

void vertex() {
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

	// Called for every pixel the material is visible on.
	COLOR.rgb = vec3(.5);
	COLOR.rgb *= mix(1.,.5,1.-sat((length(SCREEN_UV)-1.5)*2.));
	vec2 uv = UV;
	uv.x += sin(uv.y*10.+TIME*.1+wpos.z*.0)*.1;
	float shape = max(abs(uv.x-.5)-.25, abs(uv.y-.5)-.25+.1*(sin(seed*5.)*0.5+.5));
	COLOR = color;
	COLOR.a *= sampleMirror(voronoise, UV*2.).x * sat(sampleMirror(voronoise, UV*1.+vec2(0., -TIME*.02+seed*2.)).x-.5)*
	sat(sampleMirror(voronoise, UV*.5+vec2(0., -TIME*.0+seed)).x)*
	(1.-sat(shape*2.));
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
