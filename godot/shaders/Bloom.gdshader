shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

#include "res://shaders/common.gdshaderinc"
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec3 col = vec3(0.);
	vec2 uv = SCREEN_UV;
	col = textureLod(screen_texture, uv, 0).rrr;
	   
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
    col = textureLod(screen_texture, uv, 0).xyz + pow(rgb, vec3(1.5))*1.5;
	COLOR.rgb = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
