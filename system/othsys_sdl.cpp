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
#include "system/othsys_sdl.h"
#include <cute_png.h>

extern volatile int g_xCoord;
extern volatile int g_yCoord;
extern volatile bool g_mouseDown;

constexpr int ICON_DIM = 64;
constexpr int ICON_DIM_INV = 48;

const struct {
	int col;
	int width;
	int height;
	int frames;
} texInfoUI[] = {
	{0, 48, 48, 6 }, // cogs
	{1, 42, 44, 6 }, // exit_down
	{2, 42, 44, 6 }, // exit_left
	{3, 42, 44, 6 }, // exit_right
	{4, 42, 44, 6 }, // exit_up
	{5, 48, 48, 10 }, // eye
	{6, 48, 48, 10 }, // hand
	{7, 64, 60, 1 }, // hints
	{8, 64, 60, 2 }, // inventory
	{9, 48, 48, 10 }, // mouth
	{10, 64, 60, 1 }, // options
	{11, 16, 16, 3 }, // search
};

const struct {
	int id;
	int row;
	int col;
	int frames;
} texInfoInv[] = {
	{2304, 0, 0, 2 },
	{3201, 0, 2, 2 },
	{3203, 0, 4, 2 },
	{3205, 0, 6, 2 },
	{3207, 0, 8, 2 },
	{3209, 1, 0, 2 },
	{3211, 1, 2, 2 },
	{4672, 1, 4, 2 },
	{4674, 1, 6, 2 },
	{5568, 1, 8, 2 },
	{5570, 2, 0, 2 },
	{12225, 2, 2, 2 },
	{12227, 2, 4, 2 },
	{12229, 2, 6, 2 },
	{12231, 2, 8, 2 },
	{12233, 3, 0, 2 },
	{12235, 3, 2, 2 },
	{12237, 3, 4, 2 },
	{12239, 3, 6, 2 },
	{12241, 3, 8, 2 },
	{12243, 4, 0, 2 },
	{12245, 4, 2, 2 },
	{12247, 4, 4, 2 },
	{12249, 4, 6, 2 },
	{12251, 4, 8, 2 },
	{12253, 5, 0, 2 },
	{12255, 5, 2, 2 },
	{12257, 5, 4, 2 },
	{16768, 5, 6, 2 },
	{16832, 5, 8, 2 },
	{16896, 6, 0, 2 },
	{16960, 6, 2, 2 },
	{17024, 6, 4, 2 },
	{17088, 6, 6, 2 },
	{17152, 6, 8, 2 },
	{17154, 7, 0, 2 },
	{17156, 7, 2, 2 },
	{17158, 7, 4, 2 },
	{17160, 7, 6, 2 },
	{17162, 7, 8, 2 },
	{17164, 8, 0, 2 },
	{17216, 8, 2, 2 },
	{17344, 8, 4, 2 },
	{17408, 8, 6, 2 },
};

static void *loadFileToMem(const char *filename) {
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

	return nullptr;
}

// ima4.cpp
extern int16 *ima4CAFToPCM(const void *srcBuf, bool &isStereo, int &uncompressed_size, int &sampleRate);

static Mix_Chunk *loadCAF(const void *buf) {
	bool isStereo = false;
	int uncompressed_size = 0;
	int sampleRate = 0;
	Mix_Chunk *res = nullptr;

	//uncompress IMA4 audio to PCM
	int16 *pcm16 = ima4CAFToPCM(buf, isStereo, uncompressed_size, sampleRate);
	assert(pcm16);

	int mixerFreq, mixerChannels;
	Uint16 mixerFormat;
	Mix_QuerySpec(&mixerFreq, &mixerFormat, &mixerChannels);

	SDL_AudioCVT wavecvt;

	/* Build the audio converter and create conversion buffers */
	if (AUDIO_S16LSB != mixerFormat || sampleRate != mixerFreq ||
		((isStereo && mixerChannels != 2) ||
		(!isStereo && mixerChannels != 1))) {
		if (SDL_BuildAudioCVT(&wavecvt,
			AUDIO_S16LSB, isStereo ? 2 : 1, sampleRate,
			mixerFormat, mixerChannels, mixerFreq) < 0) {
			free(pcm16);
			printf("no audio cvt\n");
			return res;
		}
		int samplesize = 2 * (isStereo ? 2 : 1);
		wavecvt.len = uncompressed_size & ~(samplesize - 1);
		wavecvt.buf = (Uint8 *)calloc(1, wavecvt.len * wavecvt.len_mult);
		if (wavecvt.buf == NULL) {
			free(pcm16);
			printf("malloc\n");
			return res;
		}
		memcpy(wavecvt.buf, pcm16, wavecvt.len);
		free(pcm16);

		/* Run the audio converter */
		if (SDL_ConvertAudio(&wavecvt) < 0) {
			free(wavecvt.buf);
			printf("convert failed\n");
			return res;
		}

		Uint8 *resized_buf = (Uint8 *)realloc(wavecvt.buf, wavecvt.len_cvt);
		Uint8 *dataptr;
		if (resized_buf == nullptr) {
			dataptr = wavecvt.buf;
		} else {
			dataptr = resized_buf;
		}

		res = Mix_QuickLoad_RAW(dataptr, wavecvt.len_cvt);
		res->allocated = 1;
	} else {
		res = Mix_QuickLoad_RAW((Uint8 *)pcm16, uncompressed_size);
		res->allocated = 1;
	}

	return res;
}

static Mix_Chunk* loadSound(const char *name) {
	char filename[32];

	// first try relocated assets
	snprintf(filename, sizeof(filename), "sfx/%s.caf", name);
	void *buf = loadFileToMem(filename);
	if(!buf) {
		// try original location
		snprintf(filename, sizeof(filename), "%s.caf", name);
		buf = loadFileToMem(filename);
	}
	// check existence
	if(!buf)
		return nullptr;

	Mix_Chunk *res = loadCAF(buf);
	free(buf);
	assert(res);

	return res;
}

SDL_Texture *OtherSystem_SDL::loadPNG(const char *filename) {
	//load file
	cp_image_t img = cp_load_png(filename);
	if(!img.pix) return nullptr;

	//Now generate the texture
	SDL_Surface *tmp = SDL_CreateRGBSurfaceWithFormatFrom(img.pix, img.w,
		img.h, 0, img.w * 4, SDL_PIXELFORMAT_RGBA32);
	SDL_Texture *tex = SDL_CreateTextureFromSurface(_renderer, tmp);
	SDL_FreeSurface(tmp);
	free(img.pix);

	return tex;
}

OtherSystem_SDL::OtherSystem_SDL(SDL_Window *window, SDL_Renderer *renderer) :
	_window(window), _renderer(renderer) {
	//allocate and clear buffers
	_offscreenBuf = (uint8 *)calloc(GAME_W * GAME_H, 1);
	_screenTexBuf = (uint32 *)calloc(GAME_W * GAME_H, 4);

	//clear palette
	memset(_pal32, 0, 256 * 4);

	_gameScreenTexture = nullptr;
	_uiTexture = nullptr;
	_invTexture = nullptr;

	_mouseX = 0;
	_mouseY = 0;

	g_mouseDown = false;

	_dragIconDrawOffsetX = 0;
	_dragIconDrawOffsetY = 0;

	initIcons();

	// get scale hint
	auto hint = SDL_GetHint(SDL_HINT_RENDER_SCALE_QUALITY);

	// create game texture to upscale
	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "nearest");
	_gameScreenTexture = SDL_CreateTexture(_renderer, SDL_PIXELFORMAT_RGBA32,
		SDL_TEXTUREACCESS_STREAMING, GAME_W, GAME_H);

	// create big second texture to downscale from
	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
	_arcTexture = SDL_CreateTexture(_renderer, SDL_PIXELFORMAT_RGBA32,
		SDL_TEXTUREACCESS_TARGET, GAME_ARC_W * SCALE_FACTOR_ARC_W,
		GAME_ARC_H * SCALE_FACTOR_ARC_H);

	_uiTexture = loadPNG("gui/ui.png");
	_invTexture = loadPNG("gui/inv.png");

	// restore scale hint
	if(hint)
		SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, hint);

	_invVisible = false;

	_invX1 = _invY1 = _invX2 = _invY2 = 0;

	_needFullUpdate = true;

	int w, h;
	if (SDL_GetRendererOutputSize(_renderer, &w, &h) == 0) {
		_winRect.x = 0;
		_winRect.y = 0;
		_winRect.w = w;
		_winRect.h = h;

		float xScale = w / GAME_ARC_W;
		float yScale = h / GAME_ARC_H;

		_scale = xScale > yScale ? yScale : xScale;
	}

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
	Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 1024);
	Mix_AllocateChannels(AUDIO_NUM_BUFFERS);
	_music = nullptr;
	_speech = nullptr;
	for(int i = 0; i < MAX_NUM_SFX; i++)
		_sfx[i] = nullptr;
	for(int i = 0; i < NUM_UI_SOUNDS; i++)
		_uiSFX[i] = nullptr;

	//load UI sounds
	_uiSFX[UI_SOUND_MENU_INTO] = loadSound("sfx_menu_into");
	assert(_uiSFX[UI_SOUND_MENU_INTO]);
	_uiSFX[UI_SOUND_MENU_ACK] = loadSound("sfx_menu_ack");
	assert(_uiSFX[UI_SOUND_MENU_ACK]);
	_uiSFX[UI_SOUND_BLEEP_FAIL] = loadSound("sfx_bleep_fail");
	assert(_uiSFX[UI_SOUND_BLEEP_FAIL]);
}

OtherSystem_SDL::~OtherSystem_SDL() {
	Mix_FreeMusic(_music);
	_music = nullptr;
	for(int i = 0; i < MAX_NUM_SFX; i++) {
		Mix_FreeChunk(_sfx[i]);
		_sfx[i] = nullptr;
	}
	for(int i = 0; i < NUM_UI_SOUNDS; i++) {
		Mix_FreeChunk(_uiSFX[i]);
		_uiSFX[i] = nullptr;
	}

	Mix_Quit();

	free(_offscreenBuf);
	_offscreenBuf = nullptr;

	free(_screenTexBuf);
	_screenTexBuf = nullptr;

	SDL_DestroyTexture(_uiTexture);
	SDL_DestroyTexture(_invTexture);
	SDL_DestroyTexture(_arcTexture);
	SDL_DestroyTexture(_gameScreenTexture);
}

void OtherSystem_SDL::initIcons() {
	_invIconsInUse = 0;

	for (int i = 0; i < NUM_UI_ICONS; i++) {
		_uiIcon[i].reset();
		_uiIcon[i].texId = i;
	}

	for (int i = 0; i < NUM_PROXIMITY_ICONS; i++) {
		_proximityIcon[i].reset();
		_proximityIcon[i].texId = NUM_UI_ICONS; // last icon row
	}

	for (int i = 0; i < NUM_INV_ICONS; i++) {
		_invIcon[i].reset();
		_invIcon[i].isInventory = true;
		_invIcon[i].animating = false;
	}

	_dragIcon.reset();
	_dragIcon.isInventory = true;
	_dragIcon.animating = false;
}

void OtherSystem_SDL::drawIcons() {
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

void OtherSystem_SDL::drawIcon(Icon *icon) {
	const int id = icon->texId;
	SDL_Texture *texHandle;
	const int xPos = icon->x * _scale + _winRect.x;
	const int yPos = icon->y * _scale + _winRect.y;
	SDL_Rect dst = { xPos, yPos, 0, 0 };
	if(icon->isInventory) {
		texHandle = _invTexture;
		dst.w = dst.h = (ICON_DIM / 2) * _scale;
	} else {
		texHandle = _uiTexture;
		dst.w = (texInfoUI[id].width / 2) * _scale;
		dst.h = (texInfoUI[id].height / 2) * _scale;
	}

	//fade down if necessary.
	if (!icon->visible && icon->alpha > 0.0f) {
		icon->alpha -= 0.40f;
	}

	auto checkAnimFrame = [&icon, id]() {
		int frames = icon->isInventory ? texInfoInv[id].frames : texInfoUI[id].frames;

		if (icon->cur_frame >= frames)
			icon->cur_frame = 0;
	};

	auto isAnimating = [&icon, id]() -> bool {
		int frames = icon->isInventory ? texInfoInv[id].frames : texInfoUI[id].frames;
		return frames > 1 && icon->animating;
	};

	if (isAnimating()) { //animate
		if (icon != &_uiIcon[UI_ICON_USE] ) {
			//tick is used to display every other frame -- rather shitty, but does the job :)
			if (icon->tick) {
				icon->cur_frame++;
				checkAnimFrame();

				icon->tick = 0;
			} else {
				icon->tick++;
			}
		} else {
			//full-speed
			icon->cur_frame++;
			checkAnimFrame();
		}
	}

	//select frame
	SDL_Rect src;
	if(icon->isInventory) {
		src = { (texInfoInv[id].col + icon->cur_frame) * ICON_DIM_INV,
			texInfoInv[id].row * ICON_DIM_INV, ICON_DIM_INV, ICON_DIM_INV };
	} else {
		src = { texInfoUI[id].col * ICON_DIM, icon->cur_frame * ICON_DIM,
			texInfoUI[id].width, texInfoUI[id].height };
	}

	//perform any blending
	SDL_SetTextureAlphaMod(texHandle, icon->alpha * 255);

	SDL_RenderCopy(_renderer, texHandle, &src, &dst);
}

int OtherSystem_SDL::getInventoryAnimIdx(int frame) {
	for (int i = 0; i < NUM_INV_ANIMS; i++) {
		if(frame == texInfoInv[i].id)
			return i;
	}

	printf("Couldn't find inventory item %d\n", frame);
	return 0; //fallback
}

void OtherSystem_SDL::drawInvBackground() {
	if (_invX2 <= _invX1 || _invY2 <= _invY1)
		return;

	const int rectWidth = (_invX2 - _invX1) * _scale;
	const int rectHeight = (_invY2 - _invY1) * _scale;
	const int xPos = _invX1 * _scale + _winRect.x;
	const int yPos = _invY1 * _scale + _winRect.y;

	const SDL_Rect pos = { xPos, yPos, rectWidth, rectHeight };

	SDL_SetRenderDrawBlendMode(_renderer, SDL_BLENDMODE_BLEND);
	SDL_SetRenderDrawColor(_renderer, 0, 0, 0, 0xCC);
	SDL_RenderFillRect(_renderer, &pos);
	SDL_SetRenderDrawColor(_renderer, 0, 0, 0, 0xFF);
	SDL_SetRenderDrawBlendMode(_renderer, SDL_BLENDMODE_NONE);
}

void OtherSystem_SDL::setPalette(const uint8 *colors, int start, int num) {
	for (int i = 0; i < num; i++) {
		//32-bit
		memcpy(&_pal32[start + i], &colors[i * 4], 4);
		//set alpha: colour 0 should be fully transparant, all others fully opaque.
		((uint8 *)&_pal32[start + i])[3] = (start + i) == 0 ? 0 : 0xFF;
	}

	_needFullUpdate = true;
}

bool OtherSystem_SDL::pollEvent(Event *event) {
	static bool prevCycleDown = false;
	static int prevMouseX = 0;
	static int prevMouseY = 0;

	int x, y;
	auto res = SDL_GetMouseState(&x, &y);
	g_mouseDown = res & SDL_BUTTON(1);
	g_xCoord = (x - _winRect.x) / _scale;
	g_yCoord = (y - _winRect.y) / (_scale * SCALE_FACTOR_ARC_Y);

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


void OtherSystem_SDL::copyRectToScreen(const uint8 *buf, int pitch, int x, int y, int w, int h) {
	if ((x < 0) || (y < 0) || (x + w > GAME_W) || (y + h > GAME_H)) {
		return;
	}

	const uint8 *src = buf;
	uint8 *offscreenDest = _offscreenBuf + (y * GAME_W) + x;
	uint32 *texDest = _screenTexBuf + (y * GAME_W) + x;

	while (h--) {
		memcpy(offscreenDest, src, w);

		for (int i = 0; i < w; i++) {
			texDest[i] = _pal32[src[i]];
		}

		src += pitch;
		offscreenDest += GAME_W;
		texDest += GAME_W;
	}
}

void OtherSystem_SDL::fullTextureUpdate() {
	for (int h = 0; h < GAME_H; h++) {
		uint32 *lineStart = &_screenTexBuf[h * GAME_W];

		for (int w = 0; w < GAME_W; w++) {
			lineStart[w] = _pal32[_offscreenBuf[(h * GAME_W) + w]];
		}
	}
}

void OtherSystem_SDL::updateWindow(SDL_Rect window, float scale) {
	_winRect = window;
	_scale = scale;
}

void OtherSystem_SDL::updateScreen() {
	SDL_RenderClear(_renderer);

	if (_needFullUpdate) {
		fullTextureUpdate();
		_needFullUpdate = false;
	}

	// save rendertarget
	auto renderTarget = SDL_GetRenderTarget(_renderer);

	// get game screen
	SDL_UpdateTexture(_gameScreenTexture, nullptr, _screenTexBuf, GAME_W * 4);

	// scale content up for aspect ratio correction
	SDL_Rect src = { 0, 0, GAME_W, GAME_H };
	int scaleW = (_scale + 1 > SCALE_FACTOR_ARC_W) ? SCALE_FACTOR_ARC_W : _scale + 1;
	SDL_Rect tmp = { 0, 0, GAME_ARC_W * scaleW, GAME_ARC_H * SCALE_FACTOR_ARC_H };
	SDL_SetRenderTarget(_renderer, _arcTexture);
	SDL_RenderCopy(_renderer, _gameScreenTexture, &src, &tmp);

	// restore render target
	SDL_SetRenderTarget(_renderer, renderTarget);

	// scale content down
	const int screenWidth = GAME_ARC_W * _scale;
	const int screenHeight = GAME_ARC_H * _scale;
	SDL_Rect dst = { _winRect.x, _winRect.y, screenWidth, screenHeight };
	SDL_RenderCopy(_renderer, _arcTexture, &tmp, &dst);

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

	SDL_RenderPresent(_renderer);
}

void OtherSystem_SDL::setDragIconDrawOffset(int x, int y) {
	_dragIconDrawOffsetX = x;
	_dragIconDrawOffsetY = y;
}

uint32 OtherSystem_SDL::getMillis() {
	return SDL_GetTicks();
}

void OtherSystem_SDL::delayMillis(uint32 msecs) {
	SDL_Delay(msecs);
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
		//apparently not a dupe!
		return sfx;
		break;
	}
}

void OtherSystem_SDL::loadSFXSection(int section) {
	//printf("loadSFXSection(%d)\n", section);

	char sfxFileName[32];
	for (int i = 0; i < MAX_NUM_SFX; i++) {
		// free up old resources
		Mix_FreeChunk(_sfx[i]);

		int sfxNum = getSFXNumber((section * 100) + i);

		// load new
		snprintf(sfxFileName, sizeof(sfxFileName), "sfx_%03d", sfxNum);
		_sfx[i] = loadSound(sfxFileName);
	}
}

void OtherSystem_SDL::startMusic(int section, int song) {
	if (8 != section) {
		_musicSection = section;
		_musicSong = song;
	}

	//fade out and clear
	if(Mix_PlayingMusic())
		Mix_FadeOutMusic(250);
	stopMusic();

	//handle dupes
	if ((section == 2 && song == 1) || (section == 5 && song == 1)) {
		section = 1;
		song = 1;
	} else if ((section == 2 && song == 4) || (section == 5 && song == 4)) {
		section = 1;
		song = 4;
	} else if (section == 5 && song == 6) {
		section = 4;
		song = 4;
	}

	char musicFile[32];
	int musNum = (section * 100) + song;
	// first try relocated assets
	snprintf(musicFile, sizeof(musicFile), "music/music_%03d.mp3", musNum);
	_music = Mix_LoadMUS(musicFile);
	if(!_music) {
		// try original location
		snprintf(musicFile, sizeof(musicFile), "music_%03d.mp3", musNum);
		_music = Mix_LoadMUS(musicFile);
	}

	// check existence
	if(!_music) return;

	int numberOfLoops = -1; //set to looping...
	//...unless
	if ((section == 1 && (song == 1 || song == 4))
		|| (section == 2 && (song == 1 || song == 4))
		|| (section == 4 && (song == 2 || song == 3 || song == 5 || song == 6 ||song == 11))
		|| (section == 5 && (song == 1 || song == 3 || song == 4))
		) {
		numberOfLoops = 0;	//these are non-looping
	}

	Mix_FadeInMusic(_music, numberOfLoops, 250);
}

void OtherSystem_SDL::stopMusic() {
	Mix_HaltMusic();
	Mix_FreeMusic(_music);
	_music = nullptr;
}

bool OtherSystem_SDL::isMusicPlaying() const {
	return Mix_PlayingMusic();
}

void OtherSystem_SDL::setMusicVolume(float volume) {
	_musicVolume = volume;
	Mix_VolumeMusic(volume * MIX_MAX_VOLUME);
}

float OtherSystem_SDL::getMusicVolume() const {
	return _musicVolume;
}

void OtherSystem_SDL::playSpeech(void *mem, int size) {
	Mix_FreeChunk(_speech);
	_speech = nullptr;
	_speech = loadCAF(mem);
	assert(_speech);
	free(mem);

	Mix_Volume(AUDIO_SPEECH, _speechVolume * MIX_MAX_VOLUME);
	Mix_PlayChannel(AUDIO_SPEECH, _speech, 0);
}

void OtherSystem_SDL::stopSpeech() {
	Mix_HaltChannel(AUDIO_SPEECH);
}

bool OtherSystem_SDL::isSpeechPlaying() const {
	return Mix_Playing(AUDIO_SPEECH);
}

void OtherSystem_SDL::setSpeechVolume(float volume) {
	_speechVolume = volume;
}

float OtherSystem_SDL::getSpeechVolume() const {
	return _speechVolume;
}

void OtherSystem_SDL::playSFX(int section, int sound, int chan, float volume, bool loop) {
	stopSFX(chan);

	_effectNum[chan] = sound;
	_effectVol[chan] = volume;

	Mix_Volume(AUDIO_SFX0 + chan, _sfxVolume * volume * MIX_MAX_VOLUME);
	Mix_PlayChannel(AUDIO_SFX0 + chan, _sfx[sound], loop ? -1 : 0);
}

void OtherSystem_SDL::stopSFX(int chan) {
	Mix_HaltChannel(AUDIO_SFX0 + chan);
}

bool OtherSystem_SDL::isSFXPlaying(int chan) const {
	return Mix_Playing(AUDIO_SFX0 + chan);
}

void OtherSystem_SDL::setSFXVolume(float volume) {
	_sfxVolume = volume;

	//update volume
	Mix_Volume(AUDIO_SFX0, _sfxVolume * _effectVol[0] * MIX_MAX_VOLUME);
	Mix_Volume(AUDIO_SFX1, _sfxVolume * _effectVol[0] * MIX_MAX_VOLUME);
}

float OtherSystem_SDL::getSFXVolume() const {
	return _sfxVolume;
}

void OtherSystem_SDL::pauseAudioForMenu(bool pause, bool playMenuMusic) {

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

		if (_effectIsPlaying[0]) Mix_Pause(AUDIO_SFX0);
		if (_effectIsPlaying[1]) Mix_Pause(AUDIO_SFX1);
		if (_speechIsPlaying) Mix_Pause(AUDIO_SPEECH);

		_prevMusicSection = _musicSection;
		_prevMusicSong = _musicSong;

		if (playMenuMusic) {
			//start menu music
			startMusic(8, 1);
		}
	} else {
		if (_effectIsPlaying[0]) Mix_Resume(AUDIO_SFX0);
		if (_effectIsPlaying[1]) Mix_Resume(AUDIO_SFX1);
		if (_speechIsPlaying) Mix_Resume(AUDIO_SPEECH);
		if (_musicIsPlaying) {
			//restart music that was playing
			startMusic(_prevMusicSection, _prevMusicSong);
		} else {
			//if nothing playing, then at least kill the menu music
			stopMusic();
		}
	}
}

void OtherSystem_SDL::clearPauseFlag() {
	_audioPaused = false;
}

void OtherSystem_SDL::playUISFX(int num) {
	if (num >= NUM_UI_SOUNDS)
		return;

	Mix_HaltChannel(AUDIO_SFX_UI);

	Mix_Volume(AUDIO_SFX_UI, _sfxVolume * MIX_MAX_VOLUME);
	Mix_PlayChannel(AUDIO_SFX_UI, _uiSFX[num], 0);
}

void OtherSystem_SDL::quit() const {

}
