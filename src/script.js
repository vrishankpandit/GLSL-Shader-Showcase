import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
import * as dat from 'lil-gui'
import testVertexShader from './shaders/water/vertex.glsl'
import testFragmentShader from './shaders/water/fragment.glsl'

// console.log(testVertexShader)

/**
 * Base
 */
// Debug
const gui = new dat.GUI()

const debugObject={}



// Canvas
const canvas = document.querySelector('canvas.webgl')

// Scene
const scene = new THREE.Scene()

/**
 * Textures
 */
const textureLoader = new THREE.TextureLoader()
const flagTexure=textureLoader.load('/textures/india-flag.jpeg')
// console.log(flagTexure)
/**
 * Test mesh
 */
// Geometry
const geometry = new THREE.PlaneGeometry(1, 1, 64, 64)

const count=geometry.attributes.position.count;
const randoms=new Float32Array(count)

for(let i=0;i<count;i++){
    randoms[i]=Math.random();
}

geometry.setAttribute('aRandom',new THREE.BufferAttribute(randoms,1))
console.log(new THREE.BufferAttribute(randoms,1))

debugObject.depthColor='#186691'
debugObject.surfaceColor='#9bd8ff'

// Material
const material = new THREE.ShaderMaterial({
    vertexShader:testVertexShader,
    fragmentShader:testFragmentShader,
    transparent:true,
    
    // wireframe:true
    // transparent:true,
    // uniforms:
    // {
    //     uFrequency:{value:new THREE.Vector2(10,5)},
    //     uTime:{value:0},
    //     uColor:{value:new THREE.Color('#6eb7dd')},
    //     uTexture:{value:flagTexure }
    // }

    uniforms:{
        uTime:{value : 0.0},

        uBigWaveElevation:{ value : 0.15},
        uBigWaveFrequency:{ value: new THREE.Vector2(7.0,2.0)},
        uWaveSpeed:{value: 1.0},

        uSmallWaveElevation:{value: 0.15},
        uSmallWaveSpeed:{value:0.3 },
        uSmallWaveFrequency:{value: 5.0},
        uSmallWaveIterations:{value:4.0},

        uDepthColor:{value : new THREE.Color(debugObject.depthColor)},
        uSurfaceColor:{value : new THREE.Color(debugObject.surfaceColor)},
        uColorOffset:{value : 0.08},

        uColorMultiplier:{value : 5.0}
    }
})

gui.add(material.uniforms.uBigWaveElevation,'value').min(0.0).max(1.0).step(0.01).name("uBigWaveElevation");
gui.add(material.uniforms.uBigWaveFrequency.value,'x').min(0.0).max(20.0).step(0.001).name("uBigWaveFrequncy.x");
gui.add(material.uniforms.uBigWaveFrequency.value,'y').min(0.0).max(20.0).step(0.001).name("uBigWaveFrequncy.y");
gui.add(material.uniforms.uWaveSpeed,'value').min(0.0).max(5.0).step(0.001).name("uWaveSpeed");
gui
.addColor(debugObject,'depthColor')
.name("depthColor")
.onChange((value)=>{
    material.uniforms.uDepthColor.value.set(debugObject.depthColor);
});
gui.addColor(debugObject,'surfaceColor').name("surfaceColor")
.onChange((value)=>{
    material.uniforms.uSurfaceColor.value.set(debugObject.surfaceColor);
});;

gui.add(material.uniforms.uColorOffset,'value').min(0.0).max(1.0).step(0.001).name("uColorOffset");
gui.add(material.uniforms.uColorMultiplier,'value').min(0.0).max(6.0).step(0.001).name("uColorMultiplier");

gui.add(material.uniforms.uSmallWaveIterations,'value').min(0.0).max(10.0).step(0.001).name("uSmallWaveIterations");
gui.add(material.uniforms.uSmallWaveFrequency,'value').min(0.0).max(10.0).step(0.001).name("uSmallWaveFrequency");
gui.add(material.uniforms.uSmallWaveSpeed,'value').min(0.0).max(2.0).step(0.001).name("uSmallWaveSpeed");
gui.add(material.uniforms.uSmallWaveElevation,'value').min(0.0).max(1.0).step(0.001).name("uSmallWaveElevation");


// gui.add(material.uniforms.uFrequency.value,'x').min(0).max(20).step(0.01).name('FrequencyX')
// gui.add(material.uniforms.uFrequency.value,'y').min(0).max(20).step(0.01).name('FrequencyY')

// Mesh
const mesh = new THREE.Mesh(geometry, material)
mesh.rotation.x=-Math.PI * 0.5;
scene.add(mesh)

/**
 * Sizes
 */
const sizes = {
    width: window.innerWidth,
    height: window.innerHeight
}

window.addEventListener('resize', () =>
{
    // Update sizes
    sizes.width = window.innerWidth
    sizes.height = window.innerHeight

    // Update camera
    camera.aspect = sizes.width / sizes.height
    camera.updateProjectionMatrix()

    // Update renderer
    renderer.setSize(sizes.width, sizes.height)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
})

/**
 * Camera
 */
// Base camera
const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 100)
camera.position.set(0.5,0.5,0.5)
scene.add(camera)

// Controls
const controls = new OrbitControls(camera, canvas)
controls.enableDamping = true

/**
 * Renderer
 */
const renderer = new THREE.WebGLRenderer({
    canvas: canvas
})
renderer.setSize(sizes.width, sizes.height)
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

/**
 * Animate
 */
const clock = new THREE.Clock()

const tick = () =>
{
    const elapsedTime = clock.getElapsedTime()
    material.uniforms.uTime.value=elapsedTime;

    // Update controls
    controls.update()

    // Render
    renderer.render(scene, camera)

    // Call tick again on the next frame
    window.requestAnimationFrame(tick)
}

tick()