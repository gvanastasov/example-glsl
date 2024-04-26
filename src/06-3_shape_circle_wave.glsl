#ifdef GL_ES
    precision mediump float;
#endif

#define RADIUS 0.5
#define WAVE_SPEED 2.0
#define WAVE_FREQUENCY 100.0

uniform vec2 u_resolution;
uniform float u_time;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius - feather, radius, dot(dist,dist) * 4.0);
}

void main(){
	vec2 st = gl_FragCoord.xy / u_resolution;

    float waveRadius = sin(WAVE_FREQUENCY * length(st - vec2(0.5)) - u_time * WAVE_SPEED) * RADIUS;

    float mask = maskCircle(st, vec2(0.5), waveRadius, 0.05);

    vec3 color = vec3(mask);

	gl_FragColor = vec4( color, 1.0 );
}


