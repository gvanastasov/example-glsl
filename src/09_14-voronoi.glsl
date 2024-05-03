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

    // scale
    st *= 10.0;

    // tile the space
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    // distance
    float m_dist = 1.0;

    // minimum position
    vec2 m_point;

   for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            vec2 neighbor = vec2(float(x),float(y));

            vec2 point = random2(ipos + neighbor);

            point = 0.5 + 0.5 * sin(u_time + 6.2831 * point);

            vec2 diff = neighbor + point - fpos;

            float dist = length(diff);

            if( dist < m_dist ) {
                m_dist = dist;
                m_point = point;
            }
        }
    }

    color += m_dist;
    
    color.rg = m_point;

    color += 1.0 - step(0.02, m_dist);

    color.r += step(0.98, fpos.x) + step(0.98, fpos.y);

    gl_FragColor = vec4(color, 1.0);
}