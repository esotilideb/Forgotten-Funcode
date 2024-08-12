// https://www.shadertoy.com/view/wtXyz4

#pragma header

#define round(a) floor(a + 0.5)
#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
#define texture flixel_texture2D

// third argument fix
vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
	vec4 color = texture2D(bitmap, coord, bias);
	if (!hasTransform)
	{
		return color;
	}
	if (color.a == 0.0)
	{
		return vec4(0.0, 0.0, 0.0, 0.0);
	}
	if (!hasColorTransform)
	{
		return color * openfl_Alphav;
	}
	color = vec4(color.rgb / color.a, color.a);
	mat4 colorMultiplier = mat4(0);
	colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
	colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
	colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
	colorMultiplier[3][3] = openfl_ColorMultiplierv.w;
	color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);
	if (color.a > 0.0)
	{
		return vec4(color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
	}
	return vec4(0.0, 0.0, 0.0, 0.0);
}

// variables which is empty, they need just to avoid crashing shader
uniform float iTimeDelta;
uniform float iFrameRate;
uniform int iFrame;
#define iChannelTime float[4](iTime, 0., 0., 0.)
#define iChannelResolution vec3[4](iResolution, vec3(0.), vec3(0.), vec3(0.))
uniform vec4 iMouse;
uniform vec4 iDate;

const vec3 mainColor = vec3(0.302,0.063,0.404);

float spiral(vec2 m, float t) {
	float r = length(m);
	float a = atan(m.y, m.x);
	float v = sin(50.*(sqrt(r)-0.02*a-.3*t));
	return clamp(v,0.,1.);

}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord/iResolution.xy;
    
    // fix aspect ratio
    float aspectRatio = iResolution.x / iResolution.y;
    uv.x *= aspectRatio;
    uv.x -= (aspectRatio - 1.) * .5;
     
    // pixelate
    float pxAmt = 90.;
    
    uv.x = floor(uv.x * pxAmt) / pxAmt;
    uv.y = floor(uv.y * pxAmt) / pxAmt;
    
    // interlacing .
    if (mod(fragCoord.y, 2.) < 1.) {
        uv += .4 + sin(iTime * .5 + uv.y * 5.) * (.3 + sin(iTime) * .1);
    } else {
        uv -= .4 + sin(iTime * .5 + uv.y * 5. + .5) * (.3 + sin(iTime) * .1);
    }
    
    // spiralllllllllllllll
    vec3 color = mainColor * spiral(uv - .5, iTime * .2 + sin(uv.y * 7.) * .2);
        
    // color shortening
    // gives it a kind of like snes-like palette
    float shortAmt = 4.0;
    color = ceil(color * shortAmt) / shortAmt;
    
    fragColor = vec4(color,texture(iChannel0, uv).a);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}