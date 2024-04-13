shader_type canvas_item;
uniform sampler2D iChannel1;
render_mode blend_add;

void vertex() {
	// Called for every vertex the material is visible on.
	
}
#define sat(a) clamp(a, 0., 1.)
vec3 rdrFlame(vec2 uv, float seed, float iTime)
{
vec3 rgb = mix(vec3(1.), vec3(0.647,1.000,0.600), 
texture(iChannel1, uv*.2+vec2(0., -iTime*.1+seed)).x);
    vec3 col = vec3(0.);
    uv.x *= 2.;
    uv.x += .01*sin(uv.y*100.-iTime*5.+seed);
    float an = atan(uv.x, uv.y);
    float shape = length(uv)-.15+.05*pow(abs(an)*10.5,.3);

    float sharp = 1.-sat(shape*500.);
    float blur = 1.-sat(shape*30.);
    col += sharp*rgb;
    col += blur*rgb;
    return col*sat(texture(iChannel1, uv*.2+vec2(0., -iTime*.01+seed)).x-sat(uv.y*10.));
}

void fragment() {
	COLOR.rgb = rdrFlame((UV - 0.5)*vec2(1.,-1.)*.25, 0., TIME);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
