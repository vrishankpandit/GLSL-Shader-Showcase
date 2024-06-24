// precision mediump float;

// varying float vTime;
// uniform vec3 uColor;
// uniform sampler2D uTexture;

varying vec2 vUv;
// varying float vElevation;

void main(){
    // vec4 textureColor= texture2D(uTexture,vUv);
    // textureColor.rgb *= vElevation * 2.0 + 0.5 ;
    // gl_FragColor = textureColor;

    //Pattern 3
    // float strength=vUv.x;

    // Pattern 4
    // float strength=vUv.y;

    //Pattern5
    // float strength=1.0-vUv.y;

    //Pattern 6
    // float strength=vUv.y*10.0;

    // Pattern7
    // float segments=9.0;
    // float strength=mod((vUv.y)*segments,1.0);

    // Pattern8
    // float segments=9.0;
    // float strength=mod((vUv.y)*segments,1.0);
    // strength=step(0.8,strength);
    
    // Pattern 9
    // float segments=9.0;
    // float strength=mod((vUv.x)*segments,1.0) ;
    // strength=step(0.9,strength);
    // strength +=mod((vUv.y)*segments,1.0);
    // strength=step(0.9,strength);

    // Pattern 10
    // float segments=9.0;
    // float strength=mod((vUv.x)*segments,1.0) ;
    // strength=step(0.2,strength);
    // strength *=mod((vUv.y)*segments,1.0);
    // strength=step(0.9,strength);


    // // Pattern 10
    // float segments=9.0;
    // float barX=step(0.2,mod((vUv.x)*segments,1.0));
    // barX *=step(0.9,mod((vUv.y)*segments+0.2,1.0));

    // float barY=step(0.8,mod(vUv.x*segments+0.2,1.0));
    // barY *= step(0.2,mod(vUv.y*segments,1.0));

    // float strength=barX+barY;

    //pattern 11
    // float strength=min(abs(vUv.x-0.5),abs(vUv.y-0.5));
    
    //pattern 12
    // float strength=max(abs(vUv.x-0.5),abs(vUv.y-0.5));

    //pattern 13
    // float strength=step(0.2,max(abs(vUv.x-0.5),abs(vUv.y-0.5)));
    
    //pattern 13
    // float square1=step(0.2,max(abs(vUv.x-0.5),abs(vUv.y-0.5)));
    // float square2=1.0 - step(0.25,max(abs(vUv.x-0.5),abs(vUv.y-0.5)));

    // float strength = square2*square1;
    
    //pattern 14
    float strength= vUv.x;


    gl_FragColor=vec4(strength,strength,strength,1.0);
}