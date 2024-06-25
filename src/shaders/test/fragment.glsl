// precision mediump float;
#define PI 3.14159265359
// varying float vTime;
// uniform vec3 uColor;
// uniform sampler2D uTexture;

varying vec2 vUv;
// varying float vElevation;

float random (vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

vec2 rotate(vec2 uv,float rotation,vec2 mid){
    return vec2(
        cos(rotation) * (uv.x-mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
        cos(rotation) * (uv.y-mid.y) -sin(rotation) * (uv.x - mid.x) + mid.y
    );
}


vec2 fade(vec2 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}


float cnoise(vec2 P){
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);
  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x,gy.x);
  vec2 g10 = vec2(gx.y,gy.y);
  vec2 g01 = vec2(gx.z,gy.z);
  vec2 g11 = vec2(gx.w,gy.w);
  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));
  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

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
    // float strength= floor(vUv.x* 10.0)/10.0;
    
    //pattern 15
    // float strength = floor(vUv.x* 10.0)/10.0;
    // strength *= floor(vUv.y * 10.0)/10.0;
    
    //pattern 16
    // float strength = random(vUv);

    //pattern 17
    // vec2 gridUv = vec2(
    //     floor(vUv.x* 10.0)/10.0,
    //     floor(vUv.y * 10.0)/10.0
    // );

    // float strength = random(gridUv);
    
    //pattern 18
    // vec2 gridUv = vec2(
    //     floor(vUv.x* 10.0)/10.0,
    //     floor(vUv.y * 10.0 + vUv.x * 5.0)/10.0
    // );

    // float strength = random(gridUv);

    // pattern 18
    // float strength=length(vUv);
    
    // pattern 18
    // float strength=distance(vUv,vec2(0.5));
    
    // pattern 19
    // float strength=0.7-distance(vUv,vec2(0.5));
    
    // pattern 20
    // float strength=0.02/distance(vUv,vec2(0.5));
    
    // // pattern 20
    // vec2 lightUv=vec2(
    //     vUv.x*0.1 + 0.45,
    //     vUv.y*0.5 + 0.25
    // );

    // float strength=0.02/distance(lightUv,vec2(0.5));
    
    // pattern 21
    // vec2 lightUvX = vec2(vUv.x*0.1 + 0.45,vUv.y*0.5 + 0.25);
    // float lightX = 0.02/distance(lightUvX,vec2(0.5));

    // vec2 lightUvY = vec2(vUv.x*0.5 + 0.25,vUv.y*0.1 + 0.45);
    // float lightY = 0.02/distance(lightUvY,vec2(0.5));

    // float strength = lightX*lightY;
    
    // pattern 22
    
    // vec2 rotatedUv = rotate(vUv,PI/4.0,vec2(0.5));

    // vec2 lightUvX = vec2(rotatedUv.x*0.1 + 0.45,rotatedUv.y*0.5 + 0.25);
   
    // float lightX = 0.010/distance(lightUvX,vec2(0.5));

    // vec2 lightUvY = vec2(rotatedUv.x*0.5 + 0.25,rotatedUv.y*0.1 + 0.45);
    // float lightY = 0.010/distance(lightUvY,vec2(0.5));

    // float strength = lightX * lightY;

    // pattern 23
    // float strength=step(0.2,distance(vUv,vec2(0.5)));

    // pattern 24
    // float strength=abs(distance(vUv,vec2(0.5))-0.25);

    // pattern 25
    // float strength=step(0.01,abs(distance(vUv,vec2(0.5))-0.25));

    // pattern 26
    // float strength=1.0-step(0.01,abs(distance(vUv,vec2(0.5))-0.25));
    
    // // pattern 27
    // vec2 wavedUv=vec2(
    //     vUv.x,
    //     vUv.y + sin(vUv.x * 30.0) *0.2
    // );

    // float strength=1.0-step(0.01,abs(distance(wavedUv,vec2(0.5))-0.25));

    // // // pattern 28
    // vec2 wavedUv=vec2(
    //     vUv.x + sin(vUv.y * 30.0) *0.2,
    //     vUv.y + sin(vUv.x * 30.0) *0.2
    // );
    // float strength=1.0-step(0.01,abs(distance(wavedUv,vec2(0.5))-0.25));
    
    // // // pattern 29
    // vec2 wavedUv=vec2(
    //     vUv.x + sin(vUv.y * 100.0) *0.05,
    //     vUv.y + sin(vUv.x * 100.0) *0.05
    // );

    // float strength=1.0-step(0.01,abs(distance(wavedUv,vec2(0.5))-0.25));

    // // // pattern 30
    // float angle = atan(vUv.x,vUv.y);
    // float strength = angle;

    // // // pattern 31
    // float angle = atan(vUv.x-0.5,vUv.y-0.5);
    // float strength = angle;

    // // // pattern 32
    // float angle = atan(vUv.x-0.5,vUv.y-0.5);
    // angle+=PI;
    // angle/=PI*2.0;
    // float strength = angle;
    
    // // // pattern 33
    // float segments=16.0;
    // float angle = atan(vUv.x-0.5,vUv.y-0.5);
    // angle+=PI;
    // angle/=PI*2.0;

    // angle=mod(angle*segments,1.0);
    // float strength = angle;
    
    // // // pattern 34
    // float segments=16.0;
    // float angle = atan(vUv.x-0.5,vUv.y-0.5);
    // angle+=PI;
    // angle/=PI*2.0;

    // float strength = sin(angle*50.0);
    
    // // // // pattern 35
    // float segments=16.0;
    // float angle = atan(vUv.x-0.5,vUv.y-0.5);
    // angle+=PI;
    // angle/=PI*2.0;

    // float sinusoid=sin(angle*50.0);

    // float radius = 0.25 + sinusoid*0.02;

    // float strength = 1.0 - step(0.01,abs(distance(vUv,vec2(0.5))-radius));

    // pattern 36
    // float strength=cnoise(vUv*10.0);

    // pattern 37
    // float strength=step(0.0,cnoise(vUv*10.0));

    // pattern 38
    // float strength=abs(cnoise(vUv*10.0));

    // pattern 38
    // float strength=1.0-abs(cnoise(vUv*10.0));

    // pattern 38
    // float strength=1.0-abs(cnoise(vUv*10.0));

    // pattern 39
    float strength=sin(1.0-abs(cnoise(vUv*10.0)) * 10.0);

    // //Black and white color
    // gl_FragColor=vec4(strength,strength,strength,1.0);

    //clamp strenght
    strength=clamp(strength,0.0,1.0);

    //colored version
    vec3 blackColor=vec3(0.0);
    vec3 uvColor=vec3(vUv,1.0);

    vec3 mixedColor = mix(blackColor , uvColor ,strength);
    gl_FragColor=vec4(mixedColor , 1.0);

}