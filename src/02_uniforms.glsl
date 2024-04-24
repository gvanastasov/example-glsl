#ifdef GL_ES
    precision mediump float;
#endif

/*
    passed from CPU to GPU

    same for all pixels

    represents the number of seconds since the shader started running
*/
uniform float u_time;

void main() {
    /*
        GPU provides a set of built-in hardware functions:

        abs is a built-in function that returns the absolute value of a number
        sin is a built-in function that returns the sine of a number
    */
    gl_FragColor = vec4(abs(sin(u_time)), 0.0, 0.0, 1.0);
}