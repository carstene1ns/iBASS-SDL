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
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 */

#ifndef SKY_SKY_H
#define SKY_SKY_H

#include "system/othsys.h"
//#include "sky/struc.h"	//MegaSet

/**
 * This is the namespace of the Sky engine.
 *
 * Status of this engine: ???
 *
 * Games using this engine:
 * - Beneath a Steel Sky
 */
namespace Sky {

struct SystemVars {
	uint32 systemFlags;
	uint32 gameVersion;
	uint32 mouseFlag;
	uint16 language;
	uint32 currentPalette;
	uint16 gameSpeed;
	uint16 currentMusic;
	bool pastIntro;
	bool paused;
};

class Sound;
class Disk;
class Text;
class Logic;
class Mouse;
class Screen;
class Control;
class Music;
class SkyCompact;
class SaveLoad;

class SkyEngine {
protected:
	byte _key_pressed;

	Sound *_skySound;
	Disk *_skyDisk;
	Text *_skyText;
	Logic *_skyLogic;
	Mouse *_skyMouse;
	Screen *_skyScreen;
	Control *_skyControl;
	SkyCompact *_skyCompact;
	SaveLoad *_saveLoad;

	Music *_skyMusic;

public:
	SkyEngine(OSystem *syst);
	virtual ~SkyEngine();

	//virtual void syncSoundSettings();

	static bool isDemo();
	static bool isCDVersion();

	bool loadGameState(int slot);
	bool saveGameState(int slot);
	void writeExtraData();//tony14july09

	bool canLoadGameStateCurrently();
	bool canSaveGameStateCurrently();
	//slot names
	bool slotUsed(int slot);//tony3june09
	char	*giveSlotAscii(int slot);//tony3june09
	void	setSlotAscii(int slot, const char *ascii);//tony4june09
	void	unPauseEngine(bool audio=true);
	void	pauseEngine(bool audio=true);
	bool	savesExist();//tony11june09
	bool	autoSaveExists();//tony15july09
	int		giveCurrentScreen();//tony16june09
	void	initNewGame();//tony16june09

	//hints viewed data - needs writing out ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#define	TOTAL_hint_answers	164
	bool	answerSeen[TOTAL_hint_answers];
	void	setHintAnswerSeen(int answer);//tony16june09
	bool	isHintAnswerSeen(int answer);//tony16june09

	bool	*giveHintData(){return &answerSeen[0];}//tony14july09

	#define	TOTAL_screens	100
	bool	seenScreen[TOTAL_screens];
	void	setSeenScreen(int screen);//tony21july09
	bool	hasSeenScreen(int screen);//tony21july09
	bool	*giveSeenScreenData(){return &seenScreen[0];}//tony21july09
	//hints viewed data - needs writing out ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	uint32	giveScriptVar(uint32 s);
	uint32	giveSystemFlags(){return	_systemVars.systemFlags;}//tony28july09
	void	setSystemFlags(uint32	f){_systemVars.systemFlags=f;}//tony28july09
	uint16	giveLanguageFlag(){return	_systemVars.language;}//tony28july09
	void	setLanguageFlag(uint16 l);

	static void *fetchItem(uint32 num);
	static void *_itemList[300];

	static SystemVars _systemVars;

	uint16	_curScreen;//cheap and nasty method of detecting screen changes
	#define	TWITTER_total_actions	20
	bool	_twitterActions[TWITTER_total_actions];
	bool	hasTwitterUsername();//tony6aug09
	char	*giveTwitterUsername();//tony6aug09
	void	setTwitterUsername(const char *ascii);//tony6aug09
	bool	hasTwitterPassword();//tony6aug09
	char	*giveTwitterPassword();//tony6aug09
	void	setTwitterPassword(const char *ascii);//tony6aug09
	bool	giveTwitterOnOff();//tony7aug09
	void	setTwitterOnOff(bool	t);//tony7aug09
	bool	giveTwitterAction(int	n);//tony7aug09
	void	setTwitterAction(int	n);//tony7aug09
	bool	*giveTwitterActions(){return &_twitterActions[0];}//tony8aug09

	OSystem	*giveSystem(){return _system;}//tony8aug09

	void	setHasInitFile(bool n){_hasInitFile=n;}//tony19aug09
	bool	giveHasInitFile(){return _hasInitFile;}//tony19aug09

	// Engine APIs
	bool init();
	bool runGameCycle();

protected:
	byte _fastMode;

	void delay(int32 amount);
	void handleKey();

	uint32 _lastSaveTime;
	uint32 _delayCount;

	bool _inited;

	bool _hasInitFile;

	void initItemList();

	void initVirgin();
	void loadFixedItems();

	bool _shouldQuit;
	bool shouldQuit() const { return _shouldQuit; }	//from Engine base class

	OSystem *_system;	//normally this would be in the Engine base class
};

extern SkyEngine *g_engine;

} // End of namespace Sky

#endif
