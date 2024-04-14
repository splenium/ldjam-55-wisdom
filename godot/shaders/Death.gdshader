shader_type spatial;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    ALBEDO.rgb = textureLod(screen_texture, SCREEN_UV, 0.0).xyz;
}