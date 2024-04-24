#ifdef GL_ES
    precision mediump float;
#endif

/*
    Canvas size (width,height) in pixels
*/
uniform vec2 u_resolution;

/*
    Mouse position in pixels
*/
uniform vec2 u_mouse;

void main() {
    /*
        gl_FragCoord - default input with the pixel coordinates
        inside screen space

        we have to normalize those (0.0 - 1.0) to get the
        correct color values
    */
    vec2 st = (gl_FragCoord.xy - u_mouse)/u_resolution;
    gl_FragColor = vec4(st.x, st.y, 0.0, 1.0);
}