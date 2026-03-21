/* ScummVM - Graphic Adventure Engine
 *
 * ScummVM is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to:
 * http://www.scummvm.org/credits/
 *
 * Portions Copyright (C) 2009 Revolution Software Ltd.
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
 *
 * $URL: https://scummvm.svn.sourceforge.net/svnroot/scummvm/scummvm/trunk/backends/platform/iphone/iphone_common.h $
 * $Id: iphone_common.h 40867 2009-05-24 15:17:42Z lordhoto $
 *
 */


enum InputEvent {
	kInputMouseDown,
	kInputMouseUp,
	kInputMouseDragged,
	kInputMouseSecondDragged,
	kInputMouseSecondDown,
	kInputMouseSecondUp,
	kInputOrientationChanged,
	kInputKeyPressed,
	kInputApplicationSuspended,
	kInputApplicationResumed,
	kInputSwipe
};

enum ScreenOrientation {
	kScreenOrientationPortrait,
	kScreenOrientationLandscape,
	kScreenOrientationFlippedLandscape
};

typedef enum
{
	kUIViewSwipeUp = 1,
	kUIViewSwipeDown = 2,
	kUIViewSwipeLeft = 4,
	kUIViewSwipeRight = 8
} UIViewSwipeDirection;

// We need this to be able to call functions from/in Objective-C.
#ifdef  __cplusplus
extern "C" {
#endif

// On the ObjC side
void iPhone_swapBuffers();
void iPhone_initSurface(int width, int height);
bool iPhone_fetchEvent(int *outEvent, float *outX, float *outY);
const char* iPhone_getDocumentsDir();	
bool iPhone_isOS3(void);

bool iPhone_isMusicPlaying();
void iPhone_playMusic(int section, int song);
void iPhone_stopMusic(void);
float iPhone_getMusicVolume(void);
void iPhone_setMusicVolume(float vol);
	
#ifdef __cplusplus
}
#endif
