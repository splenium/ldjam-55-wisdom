shader_type spatial;
uniform sampler2D iChannel0;

render_mode blend_add;

void vertex() {
	// Called for every vertex the material is visible on.
}
#define sat(a) clamp(a, 0., 1.)
mat2 r2d(float a) { float c = cos(a), s = sin(a); return mat2(vec2(c, -s), vec2(s, c)); }

void fragment() {
	float iTime = TIME;
	vec2 uv = UV-.5;
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
    texture(iChannel0, uv*.1+vec2(0.,-iTime*.02)).x;
    
        col += vec3(1.000,0.278,0.102)*(1.-sat(penta*3.))*.5*
    texture(iChannel0, uv*.1+vec2(0.,-iTime*.02)).x;
    
    
    col += vec3(1.)*(1.-sat(penta*50.))*.2;
	ALBEDO = col*2.;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
