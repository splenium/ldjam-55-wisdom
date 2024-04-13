#define sat(a) clamp(a, 0., 1.)
mat2 r2d(float a) { float c = cos(a), s = sin(a); return mat2(vec2(c, -s), vec2(s, c)); }

vec3 pentacle(vec2 uv, sampler2D noiseTex, float iTime)
{
		// Called for every pixel the material is visible on.
	float shape = abs(length(uv)-.4)-0.01;
    uv *= 4.;
    float penta = 10000.;
    float pentarad = 1.2;
    for (float i = 0.;i < 5.; ++i)
    {
        vec2 p = uv;
        p *= r2d(i*PI*2./5.);
        //p-=vec2(.2,0.);
        
        float pentaside = abs(p.y+pentarad-abs(p.x)*3.)-.02;
        penta = min(penta, pentaside);
    }
    penta = max(penta, length(uv)-pentarad);
    shape = min(shape, penta);
    vec3 col = vec3(1.,0.,0.)*(1.-sat(sat(shape*500.)));
    
    col += vec3(1.,0.1,0.2)*(1.-sat(shape*20.))*.5*
    texture(noiseTex, uv*.1+vec2(0.,-iTime*.02)).x;
    
        col += vec3(1.000,0.278,0.102)*(1.-sat(penta*3.))*.5*
    texture(noiseTex, uv*.1+vec2(0.,-iTime*.02)).x;
    
    
    col += vec3(1.)*(1.-sat(penta*50.))*.2;
	col*=2.;
	return col;
}


vec3 rdrFlame(vec2 uv, float seed, sampler2D noiseTex, float iTime)
{
vec3 rgb = mix(vec3(1.), vec3(0.647,1.000,0.600), 
texture(noiseTex, uv*.2+vec2(0., -iTime*.1+seed)).x);
    vec3 col = vec3(0.);
    uv.x *= 2.;
    uv.x += .01*sin(uv.y*100.-iTime*5.+seed);
    float an = atan(uv.x, uv.y);
    float shape = length(uv)-.15+.05*pow(abs(an)*10.5,.3);

    float sharp = 1.-sat(shape*500.);
    float blur = 1.-sat(shape*30.);
    col += sharp*rgb;
    col += blur*rgb;
    return col*sat(texture(noiseTex, uv*.2+vec2(0., -iTime*.01+seed)).x-sat(uv.y*10.));
}
