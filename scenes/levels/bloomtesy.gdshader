shader_type canvas_item;

void fragment() {
    // Output a super-bright color to trigger bloom
    COLOR = vec4(2.0, 2.0, 2.0, 1.0); // white, but brighter than 1.0
}