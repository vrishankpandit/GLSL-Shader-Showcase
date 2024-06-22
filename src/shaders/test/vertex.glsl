// uniform mat4 projectionMatrix; //projectionMatrix transform the coordinates into the clip space coordinates
// uniform mat4 viewMatrix; //viewMatrix apply transformations relative to the camera ( position ,rotation, field of view, near, far)
// uniform mat4 modelMatrix;//modelMatrix apply transformations relative to the Mesh ( position ,rotation, scale)

uniform vec2 uFrequency;
uniform float uTime;

// varying float vTime;

// attribute vec3 position;
attribute float aRandom;

// attribute vec2 uv;

varying vec2 vUv;
varying float vElevation;

void main(){
    vec4 modelPosition = modelMatrix *  vec4(position,1.0);

    float elevation = sin(modelPosition.x*uFrequency.x + uTime)*0.1;
    elevation += sin(modelPosition.y*uFrequency.y + uTime)*0.1;

    modelPosition.z += elevation;
    // modelPosition.z += aRandom*0.1;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition =  projectionMatrix * viewPosition ;

    gl_Position=projectedPosition;
    // vTime=uTime;
    vUv=uv;
    vElevation=elevation;
}