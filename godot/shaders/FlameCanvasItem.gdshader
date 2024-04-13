shader_type canvas_item;
uniform sampler2D iChannel1;
render_mode blend_add;
#include "res://shaders/common.gdshaderinc"

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	COLOR.rgb = rdrFlame((UV - 0.5)*vec2(1.,-1.)*.25, 0., iChannel1, TIME);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
