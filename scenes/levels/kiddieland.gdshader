shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float u_contrast : hint_range(0.0, 2.0) = 1.0;
uniform float u_saturation : hint_range(0.0, 2.0) = 1.0;
uniform float u_hue_shift : hint_range(-1.0, 1.0) = 0.0;
uniform float u_brightness : hint_range(-1.0, 1.0) = 0.0;
uniform float u_dreaminess : hint_range(0.0, 1.0) = 0.0; // 🎁 surprise slider

vec3 apply_contrast_saturation_brightness(vec3 color, float contrast, float saturation, float brightness) {
	vec3 gray = vec3(dot(color, vec3(0.299, 0.587, 0.114)));
	color = mix(gray, color, saturation);
	color = mix(vec3(0.5), color, contrast);
	color += brightness;
	return clamp(color, 0.0, 1.0);
}

vec3 hue_rotate(vec3 color, float shift) {
	float angle = shift * 6.28318; // 2 * PI
	float cosA = cos(angle);
	float sinA = sin(angle);
	mat3 hueRotation = mat3(
		vec3(0.213 + cosA * 0.787 - sinA * 0.213, 0.715 - cosA * 0.715 - sinA * 0.715, 0.072 - cosA * 0.072 + sinA * 0.928),
		vec3(0.213 - cosA * 0.213 + sinA * 0.143, 0.715 + cosA * 0.285 + sinA * 0.140, 0.072 - cosA * 0.072 - sinA * 0.283),
		vec3(0.213 - cosA * 0.213 - sinA * 0.787, 0.715 - cosA * 0.715 + sinA * 0.715, 0.072 + cosA * 0.928 + sinA * 0.072)
	);
	return clamp(hueRotation * color, 0.0, 1.0);
}

void fragment() {
	vec4 tex = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec3 color = tex.rgb;

	color = hue_rotate(color, u_hue_shift);
	color = apply_contrast_saturation_brightness(color, u_contrast, u_saturation, u_brightness);

	// 🎁 Surprise: dreamy soft bloom-like blending
	color = mix(color, vec3(dot(color, vec3(0.33))), u_dreaminess);

	COLOR = vec4(color, tex.a);
}
