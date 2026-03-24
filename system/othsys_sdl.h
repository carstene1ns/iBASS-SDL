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


#ifndef OTHSYS_SDL_H
#define	OTHSYS_SDL_H

#include "system/types.h"
#include "system/othsys.h"

#include <SDL.h>
#include <SDL_mixer.h>

enum {
	AUDIO_SFX0 = 0,
	AUDIO_SFX1,
	AUDIO_SFX_UI,
	AUDIO_SPEECH,
	//AUDIO_MUSIC,
	AUDIO_NUM_BUFFERS
};

#define	MAX_NUM_SFX	30

#ifndef MAX_PATH
#define MAX_PATH 256
#endif

#define MAX_FRAMES	16	//maximum number of frames per animation

#define NUM_INV_ANIMS 44	//unique textures
#define NUM_INV_ICONS 20	//(max) number of on-screen items
#define NUM_PROXIMITY_ICONS 16	//(max) number of proximity icons

struct Icon {
	int x;
	int y;
	bool visible;
	bool animating;
	bool isInventory;
	int texId;
	int cur_frame;
	int tick;
	float alpha;

	Icon() { reset(); }

	void reset(void) {
		visible = false;
		animating = true;
		isInventory = false;
		texId = 0;
		cur_frame = 0;
		tick = 0;
		x = y = 0;
		alpha = 0.0f;
	}

	void set(int xPos, int yPos, float alphaVal = 1.0f) {
		x = xPos;
		y = yPos;
		visible = true;
		alpha = alphaVal;
	}
};


class OtherSystem_SDL : public OtherSystem {
public:
	OtherSystem_SDL(int width, int height);
	virtual ~OtherSystem_SDL();

	virtual void setPalette(const uint8 *colors, int start, int num);
	virtual bool pollEvent(Event *event);
	virtual void copyRectToScreen(const uint8 *buf, int pitch, int x, int y, int w, int h);
	virtual void updateScreen(void);
	virtual uint32 getMillis(void);
	virtual void delayMillis(uint32 msecs);

	void drawMouse(void);
	void fullTextureUpdate(void);

	virtual void startMusic(int section, int song);
	virtual void stopMusic(void);
	virtual bool isMusicPlaying(void) const;
	virtual void setMusicVolume(float volume);
	virtual float getMusicVolume(void) const;

	virtual void playSpeech(void *mem, int size);
	virtual void stopSpeech(void);
	virtual bool isSpeechPlaying(void) const;
	virtual void setSpeechVolume(float volume);
	virtual float getSpeechVolume(void) const;

	virtual void loadSFXSection(int section);
	virtual void playSFX(int section, int sound, int chan, float volume, bool loop);
	virtual void stopSFX(int chan);
	virtual bool isSFXPlaying(int chan) const;
	virtual void setSFXVolume(float volume);
	virtual float getSFXVolume(void) const;
	virtual void pauseAudioForMenu(bool pause, bool playMenuMusic = true);
	virtual void playUISFX(int num);
	virtual void clearPauseFlag(void);

	virtual void quit(void) const;

	void setDragIconDrawOffset(int x, int y);

	void drawIcon(Icon *icon);
	void drawIcons(void);


	void setIcon(int idx, int x, int y) {
		if (idx < 0 || idx >= NUM_UI_ICONS)
			return;

		_uiIcon[idx].set(x, y);
	}

	void clearIcon(int idx, bool fade = true) {
		_uiIcon[idx].visible = false;
		//_uiIcon[idx].x = _uiIcon[idx].y = 0;

		if (!fade) {
			_uiIcon[idx].alpha = 0.0f;
		}
	}

	void clearAllIcons(bool fade = true) {
		for (int i = 0; i < NUM_UI_ICONS; i++) {
			clearIcon(i, fade);
		}
	}

	void setIconNotAnimate(int idx, int frame) {
		if (idx < 0 || idx >= NUM_UI_ICONS)
			return;

		_uiIcon[idx].cur_frame = frame;
		_uiIcon[idx].animating = false;
	}

	void setProximityIcon(int idx, int x, int y, float alpha, int frame) {
		if (idx < 0 || idx >= NUM_PROXIMITY_ICONS)
			return;

		_proximityIcon[idx].set(x, y, alpha);
		_proximityIcon[idx].animating = true;
		_proximityIcon[idx].cur_frame = frame;
	}


	void setProximityNotAnimate(int idx) {
		if (idx < 0 || idx >= NUM_PROXIMITY_ICONS)
			return;

		_proximityIcon[idx].animating = false;
		_proximityIcon[idx].cur_frame = 2;
	}

	void clearProximityIcon(int idx, bool fade = true) {
		if (idx < 0 || idx >= NUM_PROXIMITY_ICONS)
			return;

		_proximityIcon[idx].visible = false;

		if (!fade) {
			_proximityIcon[idx].alpha = 0.0f;
		}
	}

	void clearAllProximityIcons(bool fade = true) {
		for (int i = 0; i < NUM_PROXIMITY_ICONS; i++) {
			clearProximityIcon(i, fade);
		}
	}

	void addInvIcon(int frame, int x, int y, bool highlighted = false) {
		if (_invIconsInUse >= NUM_INV_ICONS) {
			return;
		}

		_invIcon[_invIconsInUse].texId = getInventoryAnimIdx(frame);
		_invIcon[_invIconsInUse].set(x, y);
		_invIcon[_invIconsInUse].cur_frame = highlighted ? 1 : 0;

		_invIconsInUse++;
	}

	void clearAllInvIcons(void) {
		_invIconsInUse = 0;
		//... no real point in clearing the struct
	}

	int getInventoryAnimIdx(int frame);

	void showInventory(int x1, int y1, int x2, int y2) {
		_invX1 = x1;
		_invY1 = y1;
		_invX2 = x2;
		_invY2 = y2;
		_invVisible = true;
	}

	void hideInventory(void) {
		_invVisible = false;
	}

	void setDragIcon(int frame, bool highlighted = false) {
		_dragIcon.texId = getInventoryAnimIdx(frame);
		_dragIcon.set(0, 0);
		_dragIcon.cur_frame = highlighted ? 1 : 0;
	}

	virtual void clearDragIcon(void) {
		_dragIcon.visible = false;
	}

	void setDragIconHighlight(bool highlighted) {
		_dragIcon.cur_frame = highlighted ? 1 : 0;
	}

protected:
	void initIcons(void);
	void drawInvBackground(void);
	SDL_Texture *loadPNG(const char *filename);

	Mix_Music *_music;
	Mix_Chunk *_speech;
	Mix_Chunk *_sfx[MAX_NUM_SFX];
	Mix_Chunk *_uiSFX[NUM_UI_SOUNDS];

	float _sfxVolume;
	float _speechVolume;
	float _musicVolume;

	int _effectNum[2];
	float _effectVol[2];
	bool _effectIsPlaying[2];
	bool _speechIsPlaying;
	bool _musicIsPlaying;

	int _musicSection;
	int _musicSong;
	int _prevMusicSection;
	int _prevMusicSong;
	bool _audioPaused;

	int _width, _height;

	bool _invVisible;
	int _invX1;
	int _invY1;
	int _invX2;
	int _invY2;

	int _mouseX;
	int _mouseY;

	int _dragIconDrawOffsetX;
	int _dragIconDrawOffsetY;

	bool _needFullUpdate;

	int _invIconsInUse;

	uint8 *_offscreenBuf;	//8-bit image data
	uint32 *_screenTexBuf;	//32-bit screen texture buffer

	SDL_Window *_window;
	SDL_Renderer *_renderer;

	//texture handles
	SDL_Texture *_gameScreenTexture;
	SDL_Texture *_uiTexture;
	SDL_Texture *_invTexture;

	uint32 _pal32[256];	//32-bit palette

	Icon _dragIcon;

	Icon _uiIcon[NUM_UI_ICONS];
	Icon _proximityIcon[NUM_PROXIMITY_ICONS];
	Icon _invIcon[NUM_INV_ICONS];
};

#endif
