shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float kraken;
uniform float Shake;
uniform float factor;

void vertex() {
	// Called for every vertex the material is visible on.
}

#include "res://shaders/common.gdshaderinc"

const float speed = 15.;
float tentacle(vec2 uv, float seed, float iTime)
{   

    float th = mix(.1,.2, sin(seed)*.5+.5);
    if (uv.x >0.)
        return abs(uv.y-sin(uv.x*6.+sin(iTime+seed)*.9+seed+iTime*.3*speed)*.1)-pow(uv.x,.4)*th;
    return 1.;
}



vec3 rdr(vec2 uv)
{
	float iTime = TIME;
    vec3 col = textureLod(screen_texture, uv, 0).rgb;

    vec3 rgb = vec3(0.);
    float cnt =4.;
    float acc = 0.;
    for (float j = 0.; j < cnt; ++j)
    {
        float f = sat(j/cnt);
        f = f*f*f;
        acc += f;
		rgb += textureLod(screen_texture, uv, j).xyz*f;
    }
    rgb /= acc;
    col = textureLod(screen_texture, uv, 0).xyz + pow(rgb, vec3(2.));
	uv -= .5;
    
    
    vec2 ouv = uv;
    uv.x = abs(uv.x);
    for (float i = 0.; i < 7.; ++i)
    {
    vec2 p = uv*2.+vec2(-sat(1.-kraken)+-.2-.1*(sin(iTime)*.5+.5)-.1*sin(i*10.3+5.*sign(ouv.x)), -.7+i*.35);
    float shape = tentacle(p, i*sign(ouv.x)+3.3+sign(ouv.x), iTime);
    
    vec3 rgb = mix(vec3(.6, .2,.1), vec3(.1), sat(abs(uv.x*2.+.1)/*+pow(texture(iChannel1, uv).x, 4.)*/));
    rgb *= mix(1.,.5, 1.-i/7.);
    col = mix(col, rgb, (1.-sat(shape*500.)));
}
    
    return col;
}

vec3 rdrMain(vec2 uv)
{
		float t = TIME;
		// Shake
	uv += (vec2(sin(t*23.), sin(t*27.3+1.))*.01
	+vec2(sin(t*33.), sin(t*47.3+1.))*.005)*sat(Shake);
	
		vec2 cuv = uv-.5;
		vec3 col =  rdr(uv);

		col *= sat(1.-pow(sat(length(cuv)-.1), 2.)*3.);
		return col;
}

vec3 rdrChroma(vec2 uv)
{
	vec3 col = vec3(0.);
	vec2 off = vec2(0.002, 0.);
	col.x = rdrMain(uv+off).x;
	col.y = rdrMain(uv).y;
	col.z = rdrMain(uv-off).z;
	return col;
}

vec3 rdrScene(vec2 uv)
{
	vec3 col = vec3(0.);
	for (float i = 0.; i < 8.; ++i)
	{
		vec2 p = uv-.5;
		col += rdrChroma(p*mix(1.,1.1,i/8.)+.5)*mix(vec3(1.), vec3(1.,.7,.6), i/8.);
	}
	return col/8.;
}

vec3 rdr1(vec2 uv)
{
	return mix(rdrChroma(uv), rdrScene(uv), kraken);
}

vec3 rdrFinal(vec2 uv)
{
	vec2 cuv = uv-.5;
	vec2 off = cuv;
	float offt = .2*factor;
	float an = atan(cuv.y, cuv.x);
	vec2 uv1 = uv;
	vec2 uv2 = uv;
	vec2 uv3 = uv;
	uv1 -= .5;
	uv1 *= r2d((pow(sat(1.-length(uv1))+.1, .5)*TIME*1.-offt)*factor);
	uv1 += .5;
	uv2 -= .5;
	uv2 *= r2d((pow(sat(1.-length(uv2))+.1, .5)*TIME*1.)*factor);
	uv2 += .5;
	uv3 -= .5;
	uv3 *= r2d((pow(sat(1.-length(uv3))+.1, .5)*TIME*1.+offt)*factor);
	uv3 += .5;
    vec3 col = vec3(0.);
	
	col.x = rdr1(uv1).x;
	col.y = rdr1(uv2).y;
	col.z = rdr1(uv3).z;
	return col;
}

void fragment() {
	
	vec3 col = vec3(0.);
	col = rdrFinal(SCREEN_UV);
	COLOR.rgb = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
