shader_type canvas_item;

// Rainbow controls
uniform float speed = 0.5;
uniform float saturation = 0.8;
uniform float lightness = 0.6;

// Outline detection threshold
uniform float outline_threshold : hint_range(0, 0.1) = 0.05;

vec3 hsl_to_rgb(float h, float s, float l) {
    float c = (1.0 - abs(2.0 * l - 1.0)) * s;
    float x = c * (1.0 - abs(mod(h * 6.0, 2.0) - 1.0));
    float m = l - c * 0.5;

    vec3 rgb;
    if (h < 1.0/6.0)      rgb = vec3(c, x, 0.0);
    else if (h < 2.0/6.0) rgb = vec3(x, c, 0.0);
    else if (h < 3.0/6.0) rgb = vec3(0.0, c, x);
    else if (h < 4.0/6.0) rgb = vec3(0.0, x, c);
    else if (h < 5.0/6.0) rgb = vec3(x, 0.0, c);
    else                   rgb = vec3(c, 0.0, x);

    return rgb + m;
}

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Detect outline (pure black pixels)
    if (length(tex_color.rgb) < outline_threshold) {
        COLOR = tex_color;
    }
    // Apply rainbow to font & shadow
    else {
        float hue = fract(TIME * speed);
        vec3 rainbow = hsl_to_rgb(hue, saturation, lightness);
        COLOR = vec4(rainbow, tex_color.a);
    }
}