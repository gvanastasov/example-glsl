#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius-feather, radius, dot(dist,dist) * 4.0);
}

void main(){
	vec2 st = gl_FragCoord.xy / u_resolution;

    vec3 color = vec3(1.0, 0.0, 0.0) * maskCircle(st, vec2(0.4), 0.5, 0.0);
    color += vec3(0.0, 1.0, 0.0) * maskCircle(st, vec2(0.6, 0.4), 0.5, 0.1);
    color += vec3(0.0, 0.0, 1.0) * maskCircle(st, vec2(0.5, 0.6), 0.5, 0.3);

	gl_FragColor = vec4( color, 1.0 );
}
