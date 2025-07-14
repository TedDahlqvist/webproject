float best_dist = 10.0;
vec3  best_color = tex_color.rgb;

for (int i = 0; i < palette_size; i++) {
    float offset = (float(i) + 0.5) / float(palette_size);
    vec3 orig = texture(palette, vec2(offset, 0.0)).rgb;
    vec3 repl = texture(palette, vec2(offset, 1.0)).rgb;

    float d = distance(tex_color.rgb, orig);
    if (d < best_dist) {
        best_dist = d;
        best_color = repl;
    }
}
final_color.rgb = best_color;