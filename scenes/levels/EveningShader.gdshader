shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float darkness : hint_range(0.0, 1.0) = 0.5;
uniform float contrast : hint_range(0.5, 2.0) = 1.0;

void fragment() {
    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
    col.rgb = ((col.rgb - 0.5) * contrast) + 0.5;
    col.rgb *= 1.0 - darkness;

    COLOR = col;
}
