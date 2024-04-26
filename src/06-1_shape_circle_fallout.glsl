#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float maskCircle(in vec2 space) {
    return distance(space, vec2(0.5));
}

void main(){
	vec2 st = gl_FragCoord.xy / u_resolution;

    float mask = maskCircle(st);

    mask *= sin(u_time * 2.0) * 0.5 + 0.5;

    vec3 color = vec3(mask);

	gl_FragColor = vec4( color, 1.0 );
}
