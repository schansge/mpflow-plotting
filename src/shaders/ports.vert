#version 330

in vec3 position;
in vec3 color;

out vec3 v_position;
out vec3 v_color;
out vec4 shadow_position;

uniform mat4 perspective;
uniform mat4 view;
uniform mat4 model;

uniform mat4 shadow_perspective;
uniform mat4 shadow_view;
const mat4 shadow_bias = mat4(
    vec4(0.5, 0.0, 0.0, 0.0),
    vec4(0.0, 0.5, 0.0, 0.0),
    vec4(0.0, 0.0, 0.5, 0.0),
    vec4(0.5, 0.5, 0.5, 1.0));

void main() {
    v_color = color;

    // position of vertex in clip space
    gl_Position = perspective * view * model * vec4(position, 1.0);

    // position of vertex in camera space
    v_position = (view * model * vec4(position, 1.0)).xyz;

    // position of vertex in shadow space
    shadow_position = shadow_bias * shadow_perspective * shadow_view * model * vec4(position, 1.0);
}
