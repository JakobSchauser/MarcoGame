shader_type canvas_item;

uniform float scale = 2.0;

uniform bool wave = false;

uniform sampler2D overlay_texture;

uniform float offset = 0.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
	vec2 uv2 = UV;
	uv2.x *= scale/TEXTURE_PIXEL_SIZE.x/3000.0;
	uv2.y *= scale/TEXTURE_PIXEL_SIZE.y/3000.0;
	
	if(wave){
	uv2.x -= sin(TIME/5.0)/2.0*(0.5-UV.y);
		
	}
	
	
    if (color.a > 0.1) {
        vec4 color_overlay = texture(overlay_texture, uv2);
        // color = mix(color, color_overlay, 1);
        color = color_overlay;
    }
    

    COLOR = color;
}

