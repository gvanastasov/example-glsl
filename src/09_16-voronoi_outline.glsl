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

vec3 voronoiOutline( in vec2 x ) {
    vec2 ipos = floor(x);
    vec2 fpos = fract(x);

    vec2 m_neighbor, m_diff, m_point;
    float m_dist = 1.0;

    // regular voronoi
    for (int j=-1; j<=1; j++ ) {
        for (int i=-1; i<=1; i++ ) {
            vec2 neighbor = vec2(float(i),float(j));
            vec2 point = random2( ipos + neighbor );
            vec2 diff = neighbor + point - fpos;
            float dist = length(diff);

            if( dist<m_dist ) {
                m_dist = dist;
                m_diff = diff;
                m_point = point;
                m_neighbor = neighbor;
            }
        }
    }

    // distance to borders
    m_dist = 1.0;
    for (int j=-2; j<=2; j++ ) {
        for (int i=-2; i<=2; i++ ) {
            vec2 neighbor = m_neighbor + vec2(float(i),float(j));
            vec2 point = random2(ipos + neighbor);
            vec2 diff = neighbor + point - fpos;
            float dist = length (m_diff - diff);

            if( dist > 0.00001 ) {
                m_dist = min(m_dist, dot(0.5 * (m_diff + diff), normalize(diff - m_diff)));
            }
        }
    }
    return vec3( m_dist, m_point );
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st = (st-.5)*1.+.5;
    if (u_resolution.y > u_resolution.x ) {
        st.y *= u_resolution.y/u_resolution.x;
        st.y -= (u_resolution.y*.5-u_resolution.x*.5)/u_resolution.x;
    } else {
        st.x *= u_resolution.x/u_resolution.y;
        st.x -= (u_resolution.x*.5-u_resolution.y*.5)/u_resolution.y;
    }

	st -= .5;
	st *= .7;

    vec3 color = vec3(0.0);

    // scale
    st = st * 40. * (0.1 + 1.0 - dot(st, st) * 5.0);

    vec3 c = voronoiOutline( st );

    color = mix( vec3(1.0), color, smoothstep( 0.0001, 0.1, c.x ) );

    gl_FragColor = vec4(color, 1.0);
}