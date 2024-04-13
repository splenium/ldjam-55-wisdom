shader_type spatial;

uniform sampler2D mask;
uniform sampler2D noise;

void vertex() {
	// Called for every vertex the material is visible on.
}
#define sat(a) clamp(a, 0., 1.)

float _sqr(vec2 p, vec2 s)
{
    vec2 l = abs(p)-s;
    return max(l.x, l.y);
}
#define r2d(a) mat2(vec2(cos(a), -sin(a)),vec2(sin(a), cos(a)))
vec3 rdr(vec2 uv, float iTime)
{
    vec3 col = vec3(0.);
    
    float globalShape = 10000.;
    float cnt = 16.;
    for (float i = 0.; i < cnt; ++i)
    {
		uv+= vec2(0.,.03);
        uv *= r2d(.1+iTime*.05);
        float th = 0.0001;
        float sz = mix(.1,.5,i/cnt);
        float shape = abs(_sqr(uv, vec2(1.,.6)*sz))-th;
        globalShape = min(globalShape, shape);
		vec3 rgb = mix(vec3(0.675,0.020,0.980), vec3(0.39f, 0.83f, 0.31f), sat((i/16.)*2.));
        col += pow(1.-sat(shape*5.),4.)*rgb*.1;
    }
    float sharp = 200.;
	
    col = mix(col, vec3(1.), 1.-sat(globalShape*sharp));
	col *= 1.-sat((length(uv)-.1)*2.);
	col *= sat((length(uv))*2.);
    return col*2.;
}

void fragment() {
	vec2 off = texture(noise, UV).xx;
	ALBEDO.rgb = rdr(UV-.5+off*.1, TIME);
	// Called for every pixel the material is visible on.
	ALPHA = texture(mask, UV).x;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
