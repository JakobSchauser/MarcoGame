shader_type canvas_item;

uniform sampler2D overlay_texture;

void fragment() {
    vec4 color = texture(TEXTURE, UV);

    if (color.a > 0.1) {
        vec4 color_overlay = texture(overlay_texture, UV);
        // color = mix(color, color_overlay, 1);
        color = color_overlay;
    }
    

    COLOR = color;
}

