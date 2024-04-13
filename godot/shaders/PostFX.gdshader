shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
}

#define sat(a) clamp(a, 0., 1.)
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
	uv -= .5;
    
    
    vec2 ouv = uv;
    uv.x = abs(uv.x);
    for (float i = 0.; i < 7.; ++i)
    {
    vec2 p = uv*2.+vec2(-.2-.1*(sin(iTime)*.5+.5)-.1*sin(i*10.3+5.*sign(ouv.x)), -.7+i*.35);
    float shape = tentacle(p, i*sign(ouv.x)+3.3+sign(ouv.x), iTime);
    
    vec3 rgb = mix(vec3(.6, .2,.1), vec3(.1), sat(abs(uv.x*2.+.1)/*+pow(texture(iChannel1, uv).x, 4.)*/));
    rgb *= mix(1.,.5, 1.-i/7.);
    col = mix(col, rgb, (1.-sat(shape*500.)));
}
    
    return col;
}

vec3 rdrMain(vec2 uv)
{
		vec2 cuv = uv-.5;
		vec3 col =  mix(textureLod(screen_texture, uv, 0).rgb, rdr(uv), 1.);
		//col = vec3(1.);
		col *= sat(1.-pow(sat(length(cuv)-.2), 2.)*3.);
		return col;
}

vec3 rdrChroma(vec2 uv)
{
	vec3 col = vec3(0.);
	vec2 off = vec2(0.001, 0.);
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

void fragment() {
	
	vec3 col =  rdrScene(SCREEN_UV);
	COLOR.rgb = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
