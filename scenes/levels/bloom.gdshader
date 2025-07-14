shader_type canvas_item;

uniform float glow_strength = 1.0;
uniform float glow_threshold = 0.6;
uniform int blur_samples = 8;
uniform float blur_radius = 4.0;

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
    float brightness = length(base_color.rgb); // perceived brightness

    vec4 glow = vec4(0.0);
    if (brightness > glow_threshold) {
        // blur glow in a radial pattern
        for (int i = 0; i < blur_samples; i++) {
            float angle = float(i) / float(blur_samples) * 6.2831; // 2π
            vec2 offset = vec2(cos(angle), sin(angle)) * blur_radius / VIEWPORT_SIZE;
            glow += texture(TEXTURE, UV + offset);
        }

        glow /= float(blur_samples);
        glow *= glow_strength;
    }

    COLOR = base_color + glow;
}
