shader_type canvas_item;

uniform sampler2D NOISE_PATTERN;

uniform float Noise_amplitude : hint_range(1, 100) = 50.0;

uniform vec4 color : hint_color;

void fragment() {
    float noiseValue = texture(NOISE_PATTERN, UV + vec2((fract(TIME/20.0)*20.0)/10.0)).x-0.5;


    // sample from texture using the noise value as the position
    vec2 pos = SCREEN_UV.xy;
    // pos.y = 1.0 - pos.y;

    vec4 tex = texture(SCREEN_TEXTURE, vec2(pos.x + noiseValue/Noise_amplitude, pos.y + noiseValue/Noise_amplitude));


    COLOR = tex;
}
