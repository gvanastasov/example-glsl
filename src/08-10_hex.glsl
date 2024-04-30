#ifdef GL_ES
precision mediump float;
#endif

#define S(r,v,a) smoothstep(a/u_resolution.y,0.,abs(v-(r)))

const vec2 s = vec2(1, 1.7320508);

uniform vec2 u_resolution;

float calcHexDistance(vec2 p)
{
    p = abs(p);
    return max(dot(p, s * .5), p.x);
}

vec2 calcHexOffset(vec2 uv)
{
    vec4 hexCenter = floor((vec4(uv, uv - vec2(.5, 1.)) / s.xyxy) + 0.5);
    vec4 offset = vec4(uv - hexCenter.xy * s, uv - (hexCenter.zw + .5) * s);
    return dot(offset.xy, offset.xy) < dot(offset.zw, offset.zw) ? offset.xy : offset.zw;
}

float hex(vec2 st, float columns, float size, float feather) {
    vec2 hexInfo = calcHexOffset(st * columns);
    
    float h = calcHexDistance(hexInfo);

    float mask = smoothstep(size * 0.5 + 12.0/u_resolution.y, size * 0.5 - feather, h);

    return mask;
}

void main() 
{
    // vec2 st = (2.0 * gl_FragCoord.xy - u_resolution) / u_resolution.y;
	vec2 st = gl_FragCoord.xy/u_resolution;

    float mask = hex(st, 3.0, .8, 0.01);

    vec3 color = vec3(mask);
    gl_FragColor = vec4(color, 1.0);
}