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



#ifndef OTHSYS_H
#define	OTHSYS_H

#include "system/types.h"

struct Event {
	int type, x, y;
};

enum EventCodes {
	EVENT_MOUSEMOVE = 0,
	EVENT_LBUTTONDOWN,
	EVENT_LBUTTONUP,
	EVENT_RBUTTONDOWN,
	EVENT_RBUTTONUP,
	EVENT_QUIT,
	EVENT_ESC
};

enum UIIcon {
	UI_ICON_INV = 0,
	UI_ICON_LOOK,
	UI_ICON_USE,
	UI_ICON_HAND,
	UI_ICON_MOUTH,
	UI_ICON_HELP,
	UI_ICON_OPTIONS,
	UI_ICON_UP,
	UI_ICON_DOWN,
	UI_ICON_LEFT,
	UI_ICON_RIGHT,
	NUM_UI_ICONS
};

enum UISound {
	UI_SOUND_MENU_INTO = 0,
	UI_SOUND_MENU_ACK,
	UI_SOUND_BLEEP_FAIL,
	NUM_UI_SOUNDS
};


class OtherSystem {
public:
	virtual ~OtherSystem() { }

	virtual void setPalette(const uint8 *colors, int start, int num) = 0;
	virtual bool pollEvent(Event *event) = 0;
	virtual void copyRectToScreen(const uint8 *buf, int pitch, int x, int y, int w, int h) = 0;

	virtual void updateScreen(void) = 0;
	virtual void warpMouse(int x, int y) { }
	virtual uint32 getMillis(void) = 0;
	virtual void delayMillis(uint32 msecs) = 0;

	//audio methods
	virtual void playMusic(int section, int song) = 0;
	virtual void stopMusic(void) = 0;
	virtual bool isMusicPlaying(void) const = 0;
	virtual void setMusicVolume(float volume) = 0;
	virtual float getMusicVolume(void) const = 0;

	virtual void playSpeech(void *mem, int size) = 0;
	virtual void stopSpeech(void) = 0;
	virtual bool isSpeechPlaying(void) const = 0;
	virtual void setSpeechVolume(float volume) = 0;
	virtual float getSpeechVolume(void) const = 0;

	virtual void loadSFXSection(int section) = 0;
	virtual void playSFX(int section, int sound, int chan, float volume, bool loop) = 0;
	virtual void stopSFX(int chan) = 0;
	virtual bool isSFXPlaying(int chan) const = 0;
	virtual void setSFXVolume(float volume) = 0;
	virtual float getSFXVolume(void) const = 0;
	virtual void pauseAudioForMenu(bool pause, bool playMenuMusic = true) = 0;
	virtual void clearPauseFlag(void) = 0;

	virtual void playUISFX(int num) = 0;

	virtual void quit(void) const = 0;

	virtual void setIcon(int icon, int x, int y) = 0;
	virtual void clearIcon(int icon, bool fade = true) = 0;
	virtual void clearAllIcons(bool fade = true) = 0;
	virtual void setIconNotAnimate(int idx, int frame) = 0;

	virtual void setProximityIcon(int idx, int x, int y, float alpha, int frame) = 0;
	virtual void clearProximityIcon(int idx, bool fade = true) = 0;
	virtual void clearAllProximityIcons(bool fade = true) = 0;
	virtual	void setProximityNotAnimate(int idx) = 0;


	virtual void setDragIcon(int frame, bool highlighted = false) = 0;
	virtual void clearDragIcon(void) = 0;
	virtual void setDragIconDrawOffset(int x, int y) = 0;
	virtual void setDragIconHighlight(bool highlighted) = 0;

	virtual	void addInvIcon(int frame, int x, int y, bool highlighted = false) = 0;
	virtual	void clearAllInvIcons(void) = 0;
	virtual	void showInventory(int x1, int y1, int x2, int y2) = 0;
	virtual void hideInventory(void) = 0;
};

#define OSystem OtherSystem

#endif
