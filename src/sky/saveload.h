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
 *
 */

#ifndef SKY_SAVELOAD_H
#define SKY_SAVELOAD_H

#include "common/system.h"
#include "system/savefile.h"

class OSystem;

namespace Sky {

class Disk;
class Screen;
class Logic;
class Mouse;
class Text;
class Music;
class Sound;
class SkyCompact;
struct Compact;
struct DataFileHeader;
struct MegaSet;

#define	DATAFILENAME	"DATA.JP7"

#define MAINPANEL 0
#define SAVEPANEL 1

#define NO_MASK false
#define WITH_MASK true


#define CANCEL_PRESSED  100
#define NAME_TOO_SHORT  101
#define GAME_SAVED              102
#define SHIFTED                 103
#define TOGGLED                 104
#define RESTARTED               105
#define GAME_RESTORED   106
#define RESTORE_FAILED  107
#define NO_DISK_SPACE   108
#define SPEED_CHANGED   109
#define QUIT_PANEL              110

//-
#define SAVE_EXT	 1
#define SAVE_MEGA0	 2
#define SAVE_MEGA1	 4
#define SAVE_MEGA2	 8
#define SAVE_MEGA3	16
#define SAVE_GRAFX	32
#define SAVE_TURNP	64

#define SAVE_FILE_REVISION 6
#define OLD_SAVEGAME_TYPE 5


//number of saves, and filename length
//these must be the same as defined in save_panel.h
#define MAX_saves	8
#define MAX_save_text_length 30//user filename size


//twitter
#define	TWITTER_username_len	16
#define	TWITTER_password_len	32



struct	_saveSlot
{
	bool	m_used;
	char	m_ascii[MAX_save_text_length];
};



struct AllocedMem {
	uint16 *mem;
	AllocedMem *next;
};


class SaveLoad {
public:
	SaveLoad(Screen *screen, Disk *disk, Mouse *mouse, Text *text, Music *music, Logic *logic, Sound *sound, SkyCompact *skyCompact, OSystem *system);
	~SaveLoad();
	void restartGame();
	//void doAutoSave();
	bool loadSaveAllowed();

	//bool autoSaveExists();
	bool saveGameToFile(uint16 selectedGame);
	bool restoreGameFromFile(uint16 selectedGame);

	bool	slotUsed(int slot);//tony3june09
	char	*giveSlotAscii(int slot);//tony3june09
	void	setSlotAscii(int slot, const char *ascii);//tony4june09
	bool	savesExist(){return _savesExist;}//tony11june09
	bool	autoSaveExists(){return _autoSaveExists;}//tony15july09
	void	writeExtraData();//tony14july09

	void	saveHints(uint16 selectedGame);//tony14july09
	void	restoreHints(uint16 selectedGame);//tony14july09


	bool	hasTwitterUsername();//tony6aug09
	char	*giveTwitterUsername();//tony6aug09
	void	setTwitterUsername(const char *ascii);//tony6aug09
	bool	hasTwitterPassword();//tony6aug09
	char	*giveTwitterPassword();//tony6aug09
	void	setTwitterPassword(const char *ascii);//tony6aug09
	char	_twitterUsername[TWITTER_username_len];
	char	_twitterPassword[TWITTER_password_len];
	bool	_hasTwitterUsername;
	bool	_hasTwitterPassword;
	bool	_twitterOn;

	bool	giveTwitterOnOff(){return	_twitterOn;}//tony7aug09
	void	setTwitterOnOff(bool	t){_twitterOn=t;}//tony7aug09

private:
	void	initSlots();//tony3june09
	void	writeSlots();//tony4june09
	void	initExtraData();//tony14july09



	uint32 prepareSaveData(uint8 *destBuf);

	void importOldMegaSet(uint8 **srcPos, MegaSet *mega);
	void importOldCompact(Compact* destCpt, uint8 **srcPos, uint16 numElems, uint16 type, char *name);
	uint16 parseSaveData(uint8 *srcBuf);

	SkyCompact *_skyCompact;
	Screen *_skyScreen;
	Disk *_skyDisk;
	Mouse *_skyMouse;
	Text *_skyText;
	Music *_skyMusic;
	Logic *_skyLogic;
	Sound *_skySound;
	OSystem *_system;

	//slot names
	_saveSlot	mSlots[MAX_saves];
	bool		_savesExist;//yes or no, for start menu
	bool		_autoSaveExists;//yes or no, for start menu
};

} // End of namespace Sky

#endif // SAVELOAD_H
