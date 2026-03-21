/*
 * Copyright (C) 2009 Revolution Software Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */



#include "system/types.h"
#include "system/othsys_opengl.h"

#define RGB16(r, g, b)  ((((r)&0xf8) << 8) | (((g)&0xfc) << 3) | (((b)&0xf8) >> 3))


extern volatile int g_xCoord;
extern volatile int g_yCoord;
extern volatile bool g_mouseDown;



const int GAME_TEX_W = 512;
const int GAME_TEX_H = 256;


//const int MOUSE_TEX_W = 64;
//const int MOUSE_TEX_H = 64;


const float xScale = (480.0f / 320.0f);	//1.5
const float yScale = (320.0f / 200.0f);	//1.6



static const int invIconId[NUM_INV_ANIMS + 1] = {
	2304,
	3201,
	3203,
	3205,
	3207,
	3209,
	3211,
	4672,
	4674,
	5568,
	5570,
	12225,
	12227,
	12229,
	12231,
	12233,
	12235,
	12237,
	12239,
	12241,
	12243,
	12245,
	12247,
	12249,
	12251,
	12253,
	12255,
	12257,
	16768,
	16832,
	16896,
	16960,
	17024,
	17088,
	17152,
	17154,
	17156,
	17158,
	17160,
	17162,
	17164,
	17216,
	17344,
	17408,
	-1,
};


void *loadFileToMem(const char *filename) {
	FILE *fp = fopen(filename, "rb");
	if (fp) {
		fseek(fp, 0, SEEK_END);
		int filesize = ftell(fp);
		void *mem = malloc(filesize);
		fseek(fp, 0, SEEK_SET);
		fread(mem, filesize, 1, fp);
		fclose(fp);
		return mem;
	}

	return NULL;
}

extern int16 *ima4CAFToPCM(const void *srcBuf, bool &isStereo, int &uncompressed_size, int &sampleRate);

void loadCAF(const ALint buf_id, const void *buf) {
	bool isStereo = false;
	ALsizei uncompressed_size = 0;
	ALsizei sampleRate = 0;

	//uncompress IMA4 audio to PCM
	int16 *pcm16 = ima4CAFToPCM(buf, isStereo, uncompressed_size, sampleRate);
	assert(pcm16);

	//hand buffer to OpenAL
	alBufferData(buf_id, isStereo ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16, pcm16, uncompressed_size, sampleRate);

	//and free it again (OpenAL has its own local copy)
	free(pcm16);
}

Animation *loadAnim(const char *filename) {
	FILE *fp = fopen(filename, "rb");

	if (!fp) {
		return 0;
	}

	Animation *anim = new Animation;

	int num_frames;
	int width;
	int height;
	char magic[4];
	fread(magic, 4, 1, fp);
	fread(&num_frames, sizeof(int), 1, fp);
	fread(&width, sizeof(int), 1, fp);
	fread(&height, sizeof(int), 1, fp);

	if (0 != strncmp(magic, "JPTX", 4) || width > 64 || height > 64) {
		printf("TOO LARGE OR INVALID TEXTURE!\n");
		return 0;
	}

	//printf("loadAnim(%s): num_frames: %d\n", filename, num_frames);
	if (num_frames >= MAX_FRAMES) {
		printf("Too many frames (%d)\n", num_frames);
		return 0;
	}

	anim->num_frames = num_frames;
	anim->width = width;
	anim->height = height;

	//TEMP 64x64 power of 2 fuckery
	unsigned char *image_data = (unsigned char *)calloc(64 * 64 * 4, 1);

	for (int frame = 0; frame < num_frames; frame++) {
		memset(image_data, 0, 64 * 64 * 4);

		for (int i = 0; i < height; i++) {
			fread(image_data + (((height - 1) - i) * 64 * 4), width * 4, 1, fp);	//need to read in reversed!
		}

		//Now generate the OpenGL texture object
		glGenTextures(1, &anim->frame_handle[frame]);
		glBindTexture(GL_TEXTURE_2D, anim->frame_handle[frame]);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 64, 64, 0, GL_RGBA, GL_UNSIGNED_BYTE, (GLvoid*)image_data);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	}

	free(image_data);
	fclose(fp);

	return anim;
}



OtherSystem_OpenGL::OtherSystem_OpenGL(int width, int height) : _width(width), _height(height) {
	//allocate buffers
	_offscreenBuf = (uint8 *)malloc(320 * 200);
	_screenTexBuf = (uint16 *)malloc(GAME_TEX_W * GAME_TEX_H * 2);
//	_mouseTexBuf = (uint32 *)malloc(MOUSE_TEX_W * MOUSE_TEX_H * 4);

	//clear all buffers
	memset(_offscreenBuf, 0, 320 * 200);
	memset(_screenTexBuf, 0, GAME_TEX_W * GAME_TEX_H * 2);
//	memset(_mouseTexBuf, 0, MOUSE_TEX_W * MOUSE_TEX_H * 4);
	memset(_pal16, 0, 256 * 2);
	memset(_pal32, 0, 256 * 4);

	_gameScreenTexture = 0;
//	_mouseTexture = 0;

	_mouseX = 0;
	_mouseY = 0;

	g_mouseDown = false;

	_dragIconDrawOffsetX = 0;
	_dragIconDrawOffsetY = 0;

	initIcons();

	iPhone_initSurface(320, 200);

	glGenTextures(1, &_gameScreenTexture);
	glBindTexture(GL_TEXTURE_2D, _gameScreenTexture);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, GAME_TEX_W, GAME_TEX_H, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, NULL);

	/*GLenum result =*/ glGetError();

	//enable blending (for icons)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);

	//Load UI textures
	initIcon(UI_ICON_LOOK, "eye.tex");
	initIcon(UI_ICON_USE, "cogs.tex");
	initIcon(UI_ICON_HAND, "hand.tex");
	initIcon(UI_ICON_MOUTH, "mouth.tex");
	initIcon(UI_ICON_HELP, "hints.tex");
	initIcon(UI_ICON_INV, "inventory.tex");
	initIcon(UI_ICON_OPTIONS, "options.tex");
	initIcon(UI_ICON_UP, "exit_up.tex");
	initIcon(UI_ICON_DOWN, "exit_down.tex");
	initIcon(UI_ICON_LEFT, "exit_left.tex");
	initIcon(UI_ICON_RIGHT, "exit_right.tex");

	//proximity
	Animation *proximityAnimation = loadAnim("search.tex");
		for (int i = 0; i < NUM_PROXIMITY_ICONS; i++) {
		_proximityIcon[i].anim = proximityAnimation;
	}


	//load inventory graphics
	for (int i = 0; i < NUM_INV_ANIMS; i++) {
		char invTexFile[64];
		sprintf(invTexFile, "%d.tex", invIconId[i]);

		_invAnim[i] = loadAnim(invTexFile);
	}


	//mouse
//	glGenTextures(1, &_mouseTexture);
//	glBindTexture(GL_TEXTURE_2D, _mouseTexture);
//	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, MOUSE_TEX_W, MOUSE_TEX_H, 0, GL_RGBA, GL_UNSIGNED_BYTE, _mouseTexBuf);
//	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

	_invVisible = false;

	_invX1 = _invY1 = _invX2 = _invY2 = 0;

	_needFullUpdate = true;
//	_mouseVisible = false;


	_musicSection = _musicSong = _prevMusicSection = _prevMusicSong = 0;

	_sfxVolume = 1.0f;
	_speechVolume = 1.0f;
	_musicVolume = 1.0f;

	_effectNum[0] = _effectNum[1] = -1;
	_effectVol[0] = _effectVol[1] = 1.0f;
	_effectIsPlaying[0] = _effectIsPlaying[1] = false;
	_speechIsPlaying = false;
	_musicIsPlaying = false;

	_audioPaused = false;

	//Audio init
	ALenum			error;

	// Create a new OpenAL Device
	// Pass NULL to specify the system’s default output device
	_alDevice = alcOpenDevice(NULL);
	if (_alDevice != NULL) {
		// Create a new OpenAL Context
		// The new context will render to the OpenAL Device just created
		_alContext = alcCreateContext(_alDevice, 0);
		if (_alContext != NULL) {
			// Make the new context the Current OpenAL Context
			alcMakeContextCurrent(_alContext);

			// Create some OpenAL Buffer Objects
			alGenBuffers(AUDIO_NUM_BUFFERS, _alBuffer);
			alGenBuffers(MAX_NUM_SFX, _sfxBuffer);
			alGenBuffers(NUM_UI_SOUNDS, _uiSFXBuffer);

			if ((error = alGetError()) != AL_NO_ERROR) {
				printf("Error Generating Buffers: %x", error);
				exit(1);
			}

			// Create some OpenAL Source Objects
			alGenSources(AUDIO_NUM_BUFFERS, _alSource);
			if (alGetError() != AL_NO_ERROR) {
				printf("Error generating sources! %x\n", error);
				exit(1);
			}

		}
	}
	// clear any errors
	alGetError();

	//load UI sounds
	void *buf = 0;

	buf = loadFileToMem("sfx_menu_into.caf");
	assert(buf);
	loadCAF(_uiSFXBuffer[UI_SOUND_MENU_INTO], buf);
	free(buf);

	buf = loadFileToMem("sfx_menu_ack.caf");
	assert(buf);
	loadCAF(_uiSFXBuffer[UI_SOUND_MENU_ACK], buf);
	free(buf);

	buf = loadFileToMem("sfx_bleep_fail.caf");
	assert(buf);
	loadCAF(_uiSFXBuffer[UI_SOUND_BLEEP_FAIL], buf);
	free(buf);
}

OtherSystem_OpenGL::~OtherSystem_OpenGL() {
	// Delete the Sources
	alDeleteSources(AUDIO_NUM_BUFFERS, _alSource);
	// Delete the Buffers
	alDeleteBuffers(AUDIO_NUM_BUFFERS, _alBuffer);
	alDeleteBuffers(MAX_NUM_SFX, _sfxBuffer);
	alDeleteBuffers(NUM_UI_SOUNDS, _uiSFXBuffer);

	//Release context
	alcDestroyContext(_alContext);
	//Close device
	alcCloseDevice(_alDevice);

	//TODO: Free Icon Animation* !
	//TODO: Free _invAnim[] !

	free(_offscreenBuf);
	_offscreenBuf = 0;

	free(_screenTexBuf);
	_screenTexBuf = 0;

//	free(_mouseTexBuf);
//	_mouseTexBuf = 0;
}

void OtherSystem_OpenGL::initIcons(void) {
	_invIconsInUse = 0;

	for (int i = 0; i < NUM_UI_ICONS; i++) {
		_uiIcon[i].reset();
	}

	for (int i = 0; i < NUM_PROXIMITY_ICONS; i++) {
		_proximityIcon[i].reset();
	}

	for (int i = 0; i < NUM_INV_ICONS; i++) {
		_invIcon[i].reset();
		_invIcon[i].animating = false;
	}

	for (int i = 0; i < NUM_INV_ANIMS; i++) {
		_invAnim[i] = 0;
	}

	_dragIcon.reset();
	_dragIcon.animating = false;
}

void OtherSystem_OpenGL::initIcon(int idx, const char *filename) {
	_uiIcon[idx].anim = loadAnim(filename);
}


void OtherSystem_OpenGL::drawIcons(void) {
	//render proximity icons first (they can be underneath regular icons)
	for (int i = 0; i < NUM_PROXIMITY_ICONS; i++) {
		if (_proximityIcon[i].visible || _proximityIcon[i].alpha > 0.0f) {
			drawIcon(&_proximityIcon[i]);
		}
	}

	//draw normal UI icons
	for (int i = 0; i < NUM_UI_ICONS; i++) {
		if (_uiIcon[i].visible || _uiIcon[i].alpha > 0.0f) {
			drawIcon(&_uiIcon[i]);
		}
	}

	//draw inv icons
	for (int i = 0; i < _invIconsInUse; i++) {
		if (_invIcon[i].visible || _invIcon[i].alpha > 0.0f) {
			drawIcon(&_invIcon[i]);
		}
	}
}

void OtherSystem_OpenGL::drawIcon(Icon *icon) {
	const float x = (float)icon->x;
	const float y = (float)icon->y;
	const GLuint texHandle = icon->anim->frame_handle[icon->cur_frame];

	const float iconWidth = 64.0f;
	const float iconHeight = 64.0f;

	const float xPos = (320.0f - iconWidth) - (y * yScale);
	const float yPos = (480.0f - iconHeight) - (x * xScale);

	const GLfloat vertices[] = {
		xPos, yPos,
		xPos + iconWidth, yPos,
		xPos, yPos + iconHeight,
		xPos + iconWidth, yPos + iconHeight
	};

	const GLfloat texCoords[] = {
		1.0f, 1.0f,
		1.0f, 0.0f,
		0.0f, 1.0f,
		0.0f, 0.0f
	};


	//fade down if necessary.
	if (!icon->visible && icon->alpha > 0.0f) {
		icon->alpha -= 0.40f;
	}

	if (icon->anim->num_frames > 1 && icon->animating) { //animate
		if (icon != &_uiIcon[UI_ICON_USE] ) {
			//tick is used to display every other frame -- rather shitty, but does the job :)
			if (icon->tick) {
				icon->cur_frame++;

				if (icon->cur_frame >= icon->anim->num_frames) icon->cur_frame = 0;

				icon->tick = 0;
			} else {
				icon->tick++;
			}
		} else {
			//full-speed
			icon->cur_frame++;

			if (icon->cur_frame >= icon->anim->num_frames) icon->cur_frame = 0;
		}
	}

	//perform any blending
	const float blend = icon->alpha;
	glColor4f(1.0f, 1.0f, 1.0f, blend);

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texCoords);

	glBindTexture(GL_TEXTURE_2D, texHandle);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

	//restore draw colour
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
}

int OtherSystem_OpenGL::getInventoryAnimIdx(int frame) {
	for (int i = 0; i < NUM_INV_ANIMS; i++) {
		if (frame == invIconId[i])
			return i;
	}

	printf("Couldn't find inventory item %d\n", frame);
	return 0;	//fallback
}


/*
void OtherSystem_OpenGL::drawMouse(void) {
	const float iconWidth = 64.0f * xScale;
	const float iconHeight = 64.0f * yScale;

	int x = g_xCoord;
	int y = g_yCoord;

	x += _mouseDrawOffsetX;
	y += _mouseDrawOffsetY;

	const float xPos = (320.0f - iconHeight) - (y * yScale);
	const float yPos = (480.0f - iconWidth) - (x * xScale);

	const GLfloat vertices[] = {
		xPos, yPos,
		xPos + iconWidth, yPos,
		xPos, yPos + iconHeight,
		xPos + iconWidth, yPos + iconHeight
	};

	const GLfloat texCoords[] = {
		1.0f, 1.0f,
		1.0f, 0.0f,
		0.0f, 1.0f,
		0.0f, 0.0f
	};

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texCoords);

	glBindTexture(GL_TEXTURE_2D, _mouseTexture);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}
*/

void OtherSystem_OpenGL::drawInvBackground(void) {
	if (_invX2 <= _invX1 || _invY2 <= _invY1)
		return;

	const float rectWidth = ((float)_invY2 - (float)_invY1) * yScale;
	const float rectHeight = ((float)_invX2 - (float)_invX1) * xScale;

	const float xPos = (320.0f - rectWidth) - (_invY1 * yScale);
	const float yPos = (480.0f - rectHeight) - (_invX1 * xScale);

	const GLfloat vertices[] = {
		xPos, yPos,
		xPos + rectWidth, yPos,
		xPos, yPos + rectHeight,
		xPos + rectWidth, yPos + rectHeight
	};

	glDisable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);

	GLfloat colour[16];

	for (int i = 0; i < 4; i++) {
		colour[(i * 4) + 0] = 0.0f;
		colour[(i * 4) + 1] = 0.0f;
		colour[(i * 4) + 2] = 0.0f;
		colour[(i * 4) + 3] = 0.7f;
	}

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colour);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

	glDisableClientState(GL_COLOR_ARRAY);
	glEnable(GL_TEXTURE_2D);

	//restore draw colour
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
}


void OtherSystem_OpenGL::setPalette(const uint8 *colors, int start, int num) {
	for (int i = 0; i < num; i++) {
		//16-bit
		_pal16[start + i] = RGB16(colors[i * 4 + 0], colors[i * 4 + 1], colors[i * 4 + 2]);

		//32-bit
		memcpy(&_pal32[start + i], &colors[i * 4], 4);
		//set alpha: colour 0 should be fully transparant, all others fully opaque.
		((uint8 *)&_pal32[start + i])[3] = (start + i) == 0 ? 0 : 0xFF;
	}

	_needFullUpdate = true;
}

bool OtherSystem_OpenGL::pollEvent(Event *event) {
	//volatile int g_xCoord = 0;
	//volatile int g_yCoord = 0;
	//volatile bool g_mouseDown = false;

	static bool prevCycleDown = false;
	static int prevMouseX = 0;
	static int prevMouseY = 0;

	if (prevCycleDown && !g_mouseDown) {
		event->type = EVENT_LBUTTONUP;	//EVENT_RBUTTONUP
		event->x = g_xCoord;
		event->y = g_yCoord;
		prevCycleDown = false;
		prevMouseX = g_xCoord;
		prevMouseY = g_yCoord;

		return true;
	}

	if (g_mouseDown && !prevCycleDown) {
		event->type = EVENT_LBUTTONDOWN; //EVENT_RBUTTONDOWN;
		event->x = g_xCoord;
		event->y = g_yCoord;

		prevCycleDown = true;
		prevMouseX = g_xCoord;
		prevMouseY = g_yCoord;

		return true;
	}

	//moved
	if	(g_xCoord != prevMouseX || g_yCoord != prevMouseY )
	{
		event->type = EVENT_MOUSEMOVE;
		event->x = g_xCoord;
		event->y = g_yCoord;

		prevMouseX = g_xCoord;
		prevMouseY = g_yCoord;

		return true;
	}

	return false;
}


void OtherSystem_OpenGL::copyRectToScreen(const uint8 *buf, int pitch, int x, int y, int w, int h) {
	if ((x + w > _width) || (y + h > _height)) {
		return;
	}

	const uint8 *src = buf;
	uint8 *offscreenDest = _offscreenBuf + (y * 320) + x;
	uint16 *texDest = _screenTexBuf + (y * GAME_TEX_W) + x;

	while (h--) {
		memcpy(offscreenDest, src, w);

		for (int i = 0; i < w; i++) {
			texDest[i] = _pal16[src[i]];
		}

		src += pitch;
		offscreenDest += 320;
		texDest += GAME_TEX_W;
	}
}

void OtherSystem_OpenGL::fullTextureUpdate(void) {
	for (int h = 0; h < 200; h++) {
		uint16 *lineStart = &_screenTexBuf[h * GAME_TEX_W];

		for (int w = 0; w < 320; w++) {
			lineStart[w] = _pal16[_offscreenBuf[(h * 320) + w]];
		}
	}
}

void OtherSystem_OpenGL::updateScreen(void) {
	if (_needFullUpdate) {
		fullTextureUpdate();
		_needFullUpdate = false;
	}

	float _widthOffset = 0.0f;
	float _heightOffset = 0.0f;

	float _visibleWidth = 320.0f;
	float _visibleHeight = 480.0f;

	int _textureWidth = GAME_TEX_W;
	int _textureHeight = GAME_TEX_H;

	GLfloat vertices[] = {
		0.0f + _heightOffset, 0.0f + _widthOffset,
		_visibleWidth - _heightOffset, 0.0f + _widthOffset,
		0.0f + _heightOffset,  _visibleHeight - _widthOffset,
		_visibleWidth - _heightOffset,  _visibleHeight - _widthOffset
	};

	float texWidth = /*_width*/320.0f / (float)_textureWidth;
	float texHeight = /*_height*/200.0f / (float)_textureHeight;

	const GLfloat texCoords[] = {
		texWidth, texHeight,
		texWidth, 0.0f,
		0.0f, texHeight,
		0.0f, 0.0f
	};

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glTexCoordPointer(2, GL_FLOAT, 0, texCoords);

	glBindTexture(GL_TEXTURE_2D, _gameScreenTexture);

	// Unfortunately we have to update the whole texture every frame, since glTexSubImage2D is actually slower in all cases
	// due to the iPhone internals having to convert the whole texture back from its internal format when used.
	// In the future we could use several tiled textures instead.
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _textureWidth, _textureHeight, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, _screenTexBuf);

	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);


	if (_invVisible) {
		drawInvBackground();
	}

	drawIcons();

	//dragged icon drawing
	if (_dragIcon.visible) {
		int x = g_xCoord;
		int y = g_yCoord;

		x += _dragIconDrawOffsetX;
		y += _dragIconDrawOffsetY;

		_dragIcon.x = x;
		_dragIcon.y = y;

		drawIcon(&_dragIcon);
	}

	iPhone_swapBuffers();
}

void OtherSystem_OpenGL::setDragIconDrawOffset(int x, int y) {
	_dragIconDrawOffsetX = x;
	_dragIconDrawOffsetY = y;
}

/*
void OtherSystem_OpenGL::setMouseCursor(const byte *buf, int w, int h, int hotspotX, int hotspotY) {
	assert(w < MOUSE_TEX_W);
	assert(h < MOUSE_TEX_H);
	//printf("setMouseCursor(%d, %d)\n", w, h);

	//clear the texture, in case we were to set a smaller one (or call with buf == NULL)
	memset(_mouseTexBuf, 0, MOUSE_TEX_W * MOUSE_TEX_H * 4);
	_mouseVisible = false;

	if (buf) {
		const uint8 *src = buf;
		uint32 *dest = _mouseTexBuf;

		while (h--) {
			for (int i = 0; i < w; i++) {
				dest[i] = src[i] ? _pal32[src[i]] : 0;
			}

			src += w;
			dest += MOUSE_TEX_W;
		}

		_mouseVisible = true;
	}

	glBindTexture(GL_TEXTURE_2D, _mouseTexture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, MOUSE_TEX_W, MOUSE_TEX_H, 0, GL_RGBA, GL_UNSIGNED_BYTE, _mouseTexBuf);
}
*/

uint32 OtherSystem_OpenGL::getMillis(void) {
	static CFAbsoluteTime startTime = 0;
	if (startTime==0) startTime = CFAbsoluteTimeGetCurrent();
	return (CFAbsoluteTimeGetCurrent() - startTime) * 1000;
}

void OtherSystem_OpenGL::delayMillis(uint32 msecs) {
	uint32 destTime = getMillis() + msecs;
	do {
		int result;
		do {
			result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, TRUE);
		} while(result == kCFRunLoopRunHandledSource);

	} while (getMillis() < destTime);
}

//AUDIO STUFF STARTS HERE

//return the sfx which this effect might be a dupe of
int getSFXNumber(int sfx) {
	switch (sfx) {
	case 212:
	case 316:
	case 422:
		return 104;
		break;
	case 203:
		return 108;
		break;
	case 110:
	case 113:
	case 215:
	case 216:
	case 306:
	case 307:
	case 317:
	case 318:
	case 408:
	case 409:
	case 423:
	case 424:
	case 505:
	case 506:
		return 109;
		break;
	case 320:
	case 418:
		return 117;
		break;
	case 221:
	case 518:
		return 118;
		break;
	case 519:
		return 119;
		break;
	case 226:
	case 326:
	case 426:
	case 526:
	case 602:
	case 626:
		return 126;
		break;
	case 315:
		return 204;
		break;
	case 214:
	case 311:
	case 312:
	case 515:
		return 209;
		break;
	case 219:
		return 211;
		break;
	case 524:
		return 223;
		break;
	case 512:
		return 319;
		break;
	case 522:
		return 321;
		break;
	case 508:
		return 322;
		break;
	case 604:
		return 407;
		break;
	case 501:
		return 420;
		break;
	case 517:
		return 427;
		break;
	case 420:
		return 501;
		break;
	case 119:
		return 519;
		break;
	case 1:
		return 527;
		break;
	case 125:
	case 225:
	case 325:
	case 425:
	case 525:
	case 625:
		return 601;
		break;
	case 407:
		return 604;
		break;
	default:
		break;
	}

	//apparently not a dupe!
	return sfx;
}


/* Works around missing audio after movie playback */
void OtherSystem_OpenGL::alContextHack(void) {
	alcMakeContextCurrent(NULL);
	alcSuspendContext(_alContext);

	alcMakeContextCurrent(_alContext);
	alcProcessContext(_alContext);
}

void OtherSystem_OpenGL::loadSFXSection(int section) {
	//printf("loadSFXSection(%d)\n", section);

	//un-bind buffers
	alSourcei(_alSource[AUDIO_SFX0], AL_BUFFER, 0);
	alSourcei(_alSource[AUDIO_SFX1], AL_BUFFER, 0);

	for (int i = 0; i < MAX_NUM_SFX; i++) {
		char sfxFileName[64];
		int sfxNum = (section * 100) + i;

		sfxNum = getSFXNumber(sfxNum);

		sprintf(sfxFileName, "sfx_%03d.caf", sfxNum);

		void *buf = loadFileToMem(sfxFileName);
		if (buf) {
			loadCAF(_sfxBuffer[i], buf);
			free(buf);
		}
	}
}


void OtherSystem_OpenGL::playMusic(int section, int song) {
	if (8 != section) {
		_musicSection = section;
		_musicSong = song;
	}

	iPhone_playMusic(section, song);
}

void OtherSystem_OpenGL::stopMusic(void) {
	iPhone_stopMusic();
}

bool OtherSystem_OpenGL::isMusicPlaying(void) const {
	return iPhone_isMusicPlaying();
}

void OtherSystem_OpenGL::setMusicVolume(float volume) {
	_musicVolume = volume;
	iPhone_setMusicVolume(volume);
}

float OtherSystem_OpenGL::getMusicVolume(void) const {
	return iPhone_getMusicVolume();
}

void OtherSystem_OpenGL::playSpeech(void *mem, int size) {
	//un-bind buffer
	alSourcei(_alSource[AUDIO_SPEECH], AL_BUFFER, 0);

	//set up data...
	loadCAF(_alBuffer[AUDIO_SPEECH], mem);

	alSourcef(_alSource[AUDIO_SPEECH], AL_PITCH, 1.0f);
	alSourcef(_alSource[AUDIO_SPEECH], AL_GAIN, _speechVolume);
	alSourcei(_alSource[AUDIO_SPEECH], AL_BUFFER, _alBuffer[AUDIO_SPEECH]);
	alSourcei(_alSource[AUDIO_SPEECH], AL_LOOPING, AL_FALSE);

	alSourcePlay(_alSource[AUDIO_SPEECH]);
}

void OtherSystem_OpenGL::stopSpeech(void) {
	alSourceStop(_alSource[AUDIO_SPEECH]);
}

bool OtherSystem_OpenGL::isSpeechPlaying(void) const {
    ALenum state;

    alGetSourcei(_alSource[AUDIO_SPEECH], AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);
}

void OtherSystem_OpenGL::setSpeechVolume(float volume) {
	_speechVolume = volume;
}

float OtherSystem_OpenGL::getSpeechVolume(void) const {
	return _speechVolume;
}

void OtherSystem_OpenGL::playSFX(int section, int sound, int chan, float volume, bool loop) {
	stopSFX(chan);

	_effectNum[chan] = sound;
	_effectVol[chan] = volume;

	//un-bind buffer
	alSourcei(_alSource[AUDIO_SFX0 + chan], AL_BUFFER, 0);

	alSourcef(_alSource[AUDIO_SFX0 + chan], AL_PITCH, 1.0f);
	alSourcef(_alSource[AUDIO_SFX0 + chan], AL_GAIN, _sfxVolume * volume);
	alSourcei(_alSource[AUDIO_SFX0 + chan], AL_BUFFER, _sfxBuffer[sound]);
	alSourcei(_alSource[AUDIO_SFX0 + chan], AL_LOOPING, loop ? AL_TRUE : AL_FALSE);

	alSourcePlay(_alSource[AUDIO_SFX0 + chan]);
}

void OtherSystem_OpenGL::stopSFX(int chan) {
	alSourceStop(_alSource[AUDIO_SFX0 + chan]);
}

bool OtherSystem_OpenGL::isSFXPlaying(int chan) const {
    ALenum state;

    alGetSourcei(_alSource[AUDIO_SFX0 + chan], AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);
}

void OtherSystem_OpenGL::setSFXVolume(float volume) {
	_sfxVolume = volume;

	//update volume of current source
	alSourcef(_alSource[AUDIO_SFX0], AL_GAIN, _sfxVolume * _effectVol[0]);
	alSourcef(_alSource[AUDIO_SFX1], AL_GAIN, _sfxVolume * _effectVol[1]);
}

float OtherSystem_OpenGL::getSFXVolume(void) const {
	return _sfxVolume;
}


void OtherSystem_OpenGL::pauseAudioForMenu(bool pause, bool playMenuMusic) {

	if (pause && _audioPaused)
		return;

	if (!pause && !_audioPaused)
		return;

	_audioPaused = pause;

	if (pause) {
		//check if playing.
		_effectIsPlaying[0] = isSFXPlaying(0);
		_effectIsPlaying[1] = isSFXPlaying(1);
		_speechIsPlaying = isSpeechPlaying();
		_musicIsPlaying = isMusicPlaying();

		if (_effectIsPlaying[0]) alSourcePause(_alSource[AUDIO_SFX0]);
		if (_effectIsPlaying[1]) alSourcePause(_alSource[AUDIO_SFX1]);
		if (_speechIsPlaying) alSourcePause(_alSource[AUDIO_SPEECH]);

		_prevMusicSection = _musicSection;
		_prevMusicSong = _musicSong;

		if (playMenuMusic) {
			//start menu music
			playMusic(8, 1);
		}
	} else {
		if (_effectIsPlaying[0]) alSourcePlay(_alSource[AUDIO_SFX0]);
		if (_effectIsPlaying[1]) alSourcePlay(_alSource[AUDIO_SFX1]);
		if (_speechIsPlaying) alSourcePlay(_alSource[AUDIO_SPEECH]);
		if (_musicIsPlaying) {
			//restart music that was playing
			playMusic(_prevMusicSection, _prevMusicSong);
		} else {
			//if nothing playing, then at least kill the menu music
			stopMusic();
		}
	}
}

void OtherSystem_OpenGL::clearPauseFlag(void) {
	_audioPaused = false;
}

void OtherSystem_OpenGL::playUISFX(int num) {
	if (num >= NUM_UI_SOUNDS)
		return;

	alSourceStop(_alSource[AUDIO_SFX_UI]);

	//un-bind buffer
	alSourcei(_alSource[AUDIO_SFX_UI], AL_BUFFER, 0);

	alSourcef(_alSource[AUDIO_SFX_UI], AL_PITCH, 1.0f);
	alSourcef(_alSource[AUDIO_SFX_UI], AL_GAIN, _sfxVolume);
	alSourcei(_alSource[AUDIO_SFX_UI], AL_BUFFER, _uiSFXBuffer[num]);
	alSourcei(_alSource[AUDIO_SFX_UI], AL_LOOPING, AL_FALSE);

	alSourcePlay(_alSource[AUDIO_SFX_UI]);
}

void OtherSystem_OpenGL::quit(void) const {
}

