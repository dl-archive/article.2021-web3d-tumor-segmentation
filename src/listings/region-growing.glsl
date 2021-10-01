// inputs excluding texture atlas information
vec2 uv, sampler2D uIntensity, sampler2D uRegion,
float uEncodedStep, float uSeedInt, float uThreshold

const float two_over_three = 2.0 / 3.0;
bool grow(float ownInt, float nInt, float nReg) {
    return all(lessThan(vec3(-nReg, abs(ownInt - uSeedInt) 
        * two_over_three - uThreshold, 
		abs(ownInt - nInt) - uThreshold), vec3(0.0)));
}

void main() {
    vec4 region = texture2D(uRegion, uv);
    if(region[0] > 0.0) { gl_FragColor = region; return; } 
    // ... texture atlas magic to get uv0 to uv5
    float int0 = texture2D(uIntensity, uv0)[0];
    float reg0 = texture2D(uRegion, uv0)[0];
    // ... the same for uv1 to uv5
    float ownInt = texture2D(uIntensity, uv)[0];
    if(!(grow(ownInt, int0, reg0) || ... )) discard;
    gl_FragColor = vec4(vec3(uEncodedStep), 1.0);
}