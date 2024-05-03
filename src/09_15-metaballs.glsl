#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec2 random2 (vec2 st) {
    st = vec2( 
        dot(st,vec2(127.1,311.7)),
        dot(st,vec2(269.5,183.3)) 
    );

    return fract(sin(st) * 43758.5453123);
}

float random(in float x) 
{
    return fract(sin(x) * 1e4);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    
    vec3 color = vec3(0.0);

    st *= 10.0;

    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    float m_dist = 1.0;

   for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            vec2 neighbor = vec2(float(x),float(y));

            vec2 point = random2(ipos + neighbor);

            point = 0.5 + 0.5 * sin(u_time + 5.0 * point);

            vec2 diff = neighbor + point - fpos;

            float dist = length(diff);

            m_dist = min(m_dist, m_dist * dist);
        }
    }

    color += 1. - (smoothstep(0.1, 0.105, m_dist) - smoothstep(0.11, 0.115, m_dist));

    gl_FragColor = vec4(color, 1.0);
}