# Example GLSL

Just another demo repository showing the capabilities of shading (starting with some very basics and then trying out some more complex cases).

![pulse-shaders-demo](.github/pulse.gif)

## Development (VSCode)

1. Install language support for VSCode - [https://marketplace.visualstudio.com/items?itemName=slevesque.shader](Shader languages support for VS Code).
2. Install GLSL live preview for VSCode - [https://marketplace.visualstudio.com/items?itemName=circledev.glsl-canvas](glsl-canvas)
3. Install linter - [https://marketplace.visualstudio.com/items?itemName=dtoplak.vscode-glsllint](GLSL Lint)
    - herein the linter might require extra bit of work - you would need to probably download the [https://github.com/KhronosGroup/glslang](https://github.com/KhronosGroup/glslang), get proper release version for your machine and update the extension setting `glsllint.glslangValidatorPath` to point at the `bin\glslangValidator.exe` from the release binaries
4. Add GLSL snippets - [https://marketplace.visualstudio.com/items?itemName=j0hnm4r5.glsl-snippets](glsl-snippets)

## Topics

1. Whats glsl?

GLSL, or the OpenGL Shading Language, is a high-level shading language used to program shaders in OpenGL, OpenGL ES, and Vulkan. It's specifically designed for writing shaders that run directly on the GPU, allowing developers to specify how vertices and fragments (pixels) are processed during rendering. GLSL offers a wide range of features for creating complex visual effects, including vertex shaders, fragment shaders, geometry shaders, and compute shaders.

2. Whats fragment shader?

A fragment shader, also known as a pixel shader, is a type of shader in the OpenGL pipeline responsible for computing the color and other attributes of each pixel (fragment) being rendered on the screen. It operates on individual fragments after the rasterization stage, determining their final color based on various factors such as lighting, textures, and other shader inputs. Fragment shaders are commonly used for tasks like applying materials, adding visual effects, and post-processing the rendered image before it's displayed to the screen. In the context of your GLSL repository, focusing on fragment shaders allows you to explore the visual aspects of shader programming, making them ideal for learning and experimentation.

## Shaders

1. [Hello World](./src/01_hello_world.glsl)
2. [Uniforms](./src/02_uniforms.glsl)
3. Screen Coords
    - [Normalized](./src/03_screen_coords.glsl)
    - [Mouse](./src/03-1_mouse_coords.glsl)
4. Algorithmic Drawing
    - [Diagonal](./src/04_algorithmic_diagonal.glsl)
    - [Curve](./src/04-1_algorithmic_curve.glsl)
    - [Edge](./src/04-2_algorithmic_edge.glsl)
    - [Sine Wave](./src/04-3_algorithmic_sin.glsl)
    - [Cosine Wave](./src/04-4_algorithmic_cos.glsl)
    - [Circle/Cursor](./src/04-5_algorithmic_cursor.glsl)
    - [Function Area](./src/04-6_algorithmic_area.glsl)
    - [Polar Coords](./src/04-7_polar_coords.glsl)
    - [Cone](./src/04-8_cone.glsl)
    - [Line](./src/04-9_line.glsl)
5. Colors
    - [Mix](./src/05_mixing_colors.glsl)
    - [Channels](./src/05-1_mixing_channels.glsl)
    - [Day-Night Animation](./src/05-2_mixing_painting.glsl)
    - [Rainbow](./src/05-3_rainbow.glsl)
    - [Country Flags](./src/05-4_flag.glsl)
    - [HSB angle](./src/05-5_hsb.glsl)
6. Shapes
    - [Square Mask](./src/06_shape_square_mask.glsl)
    - [Square Outline](./src/06_shape_square_outline.glsl)
    - [Square Path Move](./src/06_shape_square_path.glsl)
    - [Circle Fallout](./src/06-1_shape_circle_fallout.glsl)
    - [Circle Position](./src/06-2_shape_circle.glsl)
    - [Sound Wave](./src/06-3_shape_circle_wave.glsl)
    - [Cross](./src/06-4_cross.glsl)
    - [Ngon](./src/06-5_shape_ngon.glsl)
7. Matrices
    - [Translate](./src/07_matrix_translate.glsl)
    - [Pendulum](./src/07-1_matrix_pendulum.glsl)
    - [Rotation](./src/07-2_matrix_rotation.glsl)
    - [Scale](./src/07-3_matrix_scale.glsl)
    - [Skew](./src/07-3_skew.glsl)
    - [Mul](./src/07-4_matrix_mul.glsl)
    - [Radar](./src/07-5_radar.glsl)
8. Patterns
    - [Grid](./src/08-1_grid.glsl)
    - [Grid Cell](./src/08-2_grid-cell.glsl)
    - [Tic-tac-toe](./src/08-3_tic-tac-toe.glsl)
    - [Checkers](./src/08-4_checkers.glsl)
    - [Quads](./src/08-5_quads.glsl)
    - [Net](./src/08-6_net.glsl)
    - [Scottish Tartan](./src/08-6_scottish_tartan.glsl)
    - [Offset](./src/08-7_offset.glsl)
    - [Belts](./src/08-8_belts.glsl)
    - [Truchet](./src/08-9_truchet.glsl)
    - [Hex Grid](./src/08-10_hex.glsl)
9. Random
    - [1D](./src/09-1_random.glsl)
    - [2D Noise](./src//09-2_2d_noise.glsl)
    - [10 Print](./src/09-3_10print.glsl)
    - [Barcode](./src/09-4_barcode.glsl)
    - [Matrix](./src/09-5_matrix.glsl)
    - [Live Paint](./src/09-6_live_paint.glsl)
    - [Value Noise](./src/09-7_value_noise.glsl)
    - [Gradient Noise](./src/09-8_gradient_noise.glsl)
    - [Wood Stripes](./src/09-9_wood_stripes.glsl)
    - [Silk](./src/09-10_silk.glsl)
    - [Simplex Grid](./src/09-11_simplex.glsl)
    - [Simplex Noise](./src/9_12_simplex_noise.glsl)
    - [Cellular](./src/09_12-cell.glsl)
    - [Cellular Isolines (PRND)](./src/09_13-cell-isolines.glsl)
    - [Voronoi](./src/09_14-voronoi.glsl)
    - [Metaballs](./src/09_15-metaballs.glsl)
    - [Voronoi Outline](./src/09_16-voronoi_outline.glsl)
10. Fractal Brownian Motion
    - [Wave](./src/10-1_wave.glsl)
    - [Cloud](./src/10-2_cloud.glsl)
    - [Endless Height Map](./src/10-3_endless_height_map.glsl)
    - [Turbolence](./src/10-4_turbolence.glsl)
    - [Ridges](./src/10-5_ridge.glsl)
    - [Pulse](./src/10-6_pulse_nova.glsl)
    - [Domain Warp](./src/10-7_domain_warp.glsl)
    
## Credits
inspired by [The Book of Shaders](https://thebookofshaders.com/)
