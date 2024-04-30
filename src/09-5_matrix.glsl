#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float random(in float x) 
{
    return fract(sin(x) * 1e4);
}

float random (vec2 st) {
    return
        fract(
            sin(
                dot(st.xy, vec2(12.345, 67.890))
            ) * 43758.5453123);
}

float maskRect(in vec2 space, in vec2 center, in vec2 size) {
    vec2 dist = abs(space - center) - size * 0.5;
    return step(max(dist.x, dist.y), 0.0);
}

float maskCross(vec2 st, in vec2 center, in float thickness, in float size) {
    return
        maskRect(st, center, vec2(thickness, size)) + 
        maskRect(st, center, vec2(size, thickness));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    st *= vec2(400, 300);
    
    vec2 ipos = floor(st);

    vec3 color = vec3(0.0);

    vec2 vel = vec2(0.0, u_time * (0.08 + random(ipos.x)) * 100.0); 
    vec2 anim = floor(st + vel);

    color.g = random(anim) - random(ipos.x);

    float mask = maskCross(st / vec2(400,300), vec2(0.5, 0.5), 0.2, 0.05);

    color.g += 0.3 * mask;

    color.r = step(0.96, color.g);
    color.b = step(0.9, color.g);

    // fake depth
    float sm = 0.4;
    color = mix(vec3(0.0), color, smoothstep(0.0, sm, fract(st.x)));
    color = mix(color, vec3(0.0), smoothstep(1.0 - sm, 1.0, fract(st.x)));

    gl_FragColor = vec4(color, 1.0);
}