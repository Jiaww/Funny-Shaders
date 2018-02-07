#version 300 es

// This is a fragment shader. If you've opened this file first, please
// open and read lambert.vert.glsl before reading on.
// Unlike the vertex shader, the fragment shader actually does compute
// the shading of geometry. For every pixel in your program's output
// screen, the fragment shader is run for every bit of geometry that
// particular pixel overlaps. By implicitly interpolating the position
// data passed into the fragment shader by the vertex shader, the fragment shader
// can compute what color to apply to its pixel based on things like vertex
// position, light position, and vertex color.
precision highp float;

uniform vec4 u_Color; // The color with which to render this instance of geometry.
uniform vec2 u_Resolution;
uniform float u_Trig;
// These are the interpolated values out of the rasterizer, so you can't know
// their specific values without knowing the vertices that contributed to them
in vec4 fs_Nor;
in vec4 fs_LightVec;
in vec4 fs_Col;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

bool isInHex(vec2 p){
    float q2x = abs(p.x - 0.0);
    float q2y = abs(p.y - 0.0);
    float h = 0.1421;
    float v = 0.082;
    if(q2x > h || q2y > v*2.0)
        return false;
    return (2.0 * v * h - v * q2x - h * q2y >= 0.0);
}

void main()
{
    // Material base color (before shading)
    vec4 diffuseColor = fs_Col;
    vec2 p = vec2(gl_FragCoord.xy / u_Resolution.xy - 0.5);
    p.x *= u_Resolution.x / u_Resolution.y;
    if (u_Trig == 1.0){
        if (!isInHex(p))
            discard;
    }
    // Compute final shaded color
    out_Col = vec4(diffuseColor.rgb, diffuseColor.a);
}
