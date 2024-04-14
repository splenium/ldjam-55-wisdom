shader_type spatial;

#include "res://shaders/common.gdshaderinc"
uniform float kraken;
void vertex() {
	// Called for every vertex the material is visible on.
}
const float speed = 25.;
float tentacle(vec2 uv, float seed, float iTime)
{   

    float th = mix(.1,.2, sin(seed)*.5+.5);
    if (uv.x >0.)
        return abs(uv.y-sin(uv.x*6.+sin(iTime+seed)*.9+seed+iTime*.3*speed)*.1)-pow(uv.x,.4)*th;
    return 1.;
}
void fragment() {
	// Called for every pixel the material is visible on.

	float iTime = TIME;
	vec2 uv = UV-vec2(0.,0.1+1.-kraken);
	uv = uv.yx;
	vec2 ouv = uv;
	vec3 col = vec3(0.);
	for (float i = 0.; i < 7.; ++i)
    {
    vec2 p = uv*2.+vec2(-.1-.1*(sin(iTime+i)*.5+.5)-.1*sin(i*10.3+5.*sign(ouv.x)), -1.75+i*.25);
    float shape = tentacle(p, i*sign(ouv.x)+3.3+sign(ouv.x)+i*4.1, iTime);
    
    vec3 rgb = mix(vec3(.6, .2,.1), vec3(.1), sat(abs(uv.x*2.+.1)/*+pow(texture(iChannel1, uv).x, 4.)*/));
    rgb *= mix(1.,.1, 1.-i/7.);
    col = mix(col, rgb, (1.-sat(shape*500.)));
	}
	ALBEDO = col*.1;
	ALPHA = sat(length(col)*100.);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
