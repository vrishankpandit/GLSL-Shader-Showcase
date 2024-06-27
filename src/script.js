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
        uBigWaveElevation:{ value : 0.2},
        uBigWaveFrequency:{ value: new THREE.Vector2(7.0,2.0)},
        uTime:{value : 0.0},
        uWaveSpeed:{value: 2.0}
    }
})

gui.add(material.uniforms.uBigWaveElevation,'value').min(0.0).max(1.0).step(0.01).name("uBigWaveElevation");
gui.add(material.uniforms.uBigWaveFrequency.value,'x').min(0.0).max(20.0).step(0.001).name("uBigWaveFrequncy.x");
gui.add(material.uniforms.uBigWaveFrequency.value,'y').min(0.0).max(20.0).step(0.001).name("uBigWaveFrequncy.y");
gui.add(material.uniforms.uWaveSpeed,'value').min(0.0).max(5.0).step(0.001).name("uWaveSpeed");

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
camera.position.set(1, 1, 1)
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