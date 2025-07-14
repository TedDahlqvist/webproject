shader_type canvas_item;

void fragment() {
    // Super-bright white to trigger bloom
    COLOR = vec4(3.0, 3.0, 3.0, 1.0);
}
