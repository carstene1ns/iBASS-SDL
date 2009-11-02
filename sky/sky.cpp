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
 */

#include "common/system.h"
#include "system/othsys.h"

#include "sky/disk.h"
#include "sky/grid.h"
#include "sky/logic.h"
#include "sky/mouse.h"
#include "sky/music.h"
#include "sky/screen.h"
#include "sky/sky.h"
#include "sky/skydefs.h"
#include "sky/sound.h"
#include "sky/text.h"
#include "sky/compact.h"
#include "sky/saveload.h"


/*
 At the beginning the reverse engineers were happy, and did rejoice at
 their task, for the engine before them did shineth and was full of
 promise. But then they did look closer and see'th the aweful truth;
 it's code was assembly and messy (rareth was its comments). And so large
 were it's includes that did at first seem small; queereth also was its
 compact(s). Then they did findeth another version, and this was slightly
 different from the first. Then a third, and this was different again.
 All different, but not really better, for all were not really compatible.
 But, eventually, it did come to pass that Steel Sky was implemented on
 a modern platform. And the programmers looked and saw that it was indeed a
 miracle. But they were not joyous and instead did weep for nobody knew
 just what had been done. Except people who read the source. Hello.

 With apologies to the CD32 SteelSky file.
*/

namespace Sky {

		extern "C"	void CPP_startStartPanel(bool	movies);
		extern "C"	void CPP_startDeathPanel(void);
		extern "C"	void CPP_endMovie();
		extern "C"	bool	CPP_appIsPaused();

SkyEngine *g_engine = NULL;

void *SkyEngine::_itemList[300];

SystemVars SkyEngine::_systemVars = {0, 0, 0, 0, 4316, 0, 0, false, false };

SkyEngine::SkyEngine(OSystem *syst): _fastMode(0), _system(syst), _shouldQuit(false) {

	_curScreen = 0xFFFF;
	_key_pressed = -1;
	g_engine = this;
}

SkyEngine::~SkyEngine() {
	delete _skyLogic;
	delete _skySound;
	delete _skyMusic;
	delete _skyText;
	delete _skyMouse;
	delete _skyScreen;
	delete _skyDisk;
	delete _skyCompact;
	delete _saveLoad;

	for (int i = 0; i < 300; i++)
		if (_itemList[i])
			free(_itemList[i]);

	_inited = false;
}

void SkyEngine::initVirgin() {
	_skyScreen->setPalette(60111);
	_skyScreen->showScreen(60110);
}
//--------------------------------------------------------------------------------------------------------------

void SkyEngine::handleKey() {
        if ((_key_pressed == 27) && (!_systemVars.pastIntro)) {
                _saveLoad->restartGame();
        }

        _key_pressed = 0;
}
//--------------------------------------------------------------------------------------------------------------
bool SkyEngine::init() {

	_skyDisk = new Disk();
	_skySound = new Sound(_skyDisk, _system, 127);

	_systemVars.gameVersion = _skyDisk->determineGameVersion();

	_skyMusic = new Music(_system);

	//set default to english -- will override with chosen setting (if any)
	_systemVars.language = SKY_ENGLISH;

	//enable text + speech
	_systemVars.systemFlags |= SF_ALLOW_TEXT;
	_systemVars.systemFlags |= SF_ALLOW_SPEECH;

	_systemVars.systemFlags |= SF_PLAY_VOCS;
	_systemVars.gameSpeed = 80;

	//use roland tables
	_systemVars.systemFlags |= SF_ROLAND;

	_skyCompact = new SkyCompact();
	_skyText = new Text(_skyDisk, _skyCompact);
	_skyMouse = new Mouse(_system, _skyDisk, _skyCompact);
	_skyScreen = new Screen(_system, _skyDisk, _skyCompact);

	initVirgin();
	initItemList();
	loadFixedItems();
	_skyLogic = new Logic(_skyCompact, _skyScreen, _skyDisk, _skyText, _skyMusic, _skyMouse, _skySound);
	_skyMouse->useLogicInstance(_skyLogic);

	_saveLoad = new SaveLoad(_skyScreen, _skyDisk, _skyMouse, _skyText, _skyMusic, _skyLogic, _skySound, _skyCompact, _system);

	if (!_skyDisk->fileExists(60600 + SkyEngine::_systemVars.language * 8)) {
		warning("The language you selected does not exist in your BASS version.");
		if (_skyDisk->fileExists(60600))
			SkyEngine::_systemVars.language = SKY_ENGLISH; // default to GB english if it exists..
		else if (_skyDisk->fileExists(60600 + SKY_USA * 8))
			SkyEngine::_systemVars.language = SKY_USA;		// try US english...
		else
			for (uint8 cnt = SKY_ENGLISH; cnt <= SKY_SPANISH; cnt++)
				if (_skyDisk->fileExists(60600 + cnt * 8)) {	// pick the first language we can find
					SkyEngine::_systemVars.language = cnt;
					break;
				}
	}

	//Stuff taken from go()...

	//setup start of game - user might restore another game, or not
	//_skyLogic->initScreen0();
	_lastSaveTime = _system->getMillis();

	CPP_startStartPanel(giveHasInitFile());

	_delayCount = _system->getMillis();

	_inited = true;

	return true;
}
//--------------------------------------------------------------------------------------------------------------





bool SkyEngine::runGameCycle() {
	if (!_inited)
		return false;

	//===================================================================== mainloop ==========================================================

	if (!shouldQuit())
	{
		_skySound->checkFxQueue();

		if (!_systemVars.paused && !CPP_appIsPaused())//tony did this!
		{
			//check for screen changes
			if	(_curScreen != Logic::_scriptVariables[SCREEN])
			{
				_curScreen = Logic::_scriptVariables[SCREEN];
				//hints help
				setSeenScreen(_curScreen);
				_skyMouse->resetUI();
			}

			//printf("held=%d, sc=%d\n", Logic::_scriptVariables[OBJECT_HELD], Logic::_scriptVariables[SCREEN]);

			_skyMouse->mouseEngine();
			_skyLogic->engine();


			//if death screen, then init death panel
			if	(Logic::_scriptVariables[SCREEN]==102)
			{
				printf("Death!\n");
				//pauseEngine();

				//_system->stopMusic();
				CPP_startDeathPanel();
				//call up the death screen

				return	!shouldQuit();
			}

			//end credits
			if	(Logic::_scriptVariables[23]==42)
			{
				printf("End!\n");
				pauseEngine(false);

				CPP_endMovie();

				return	!shouldQuit();
			}

			//-----------------------------------------------------------------
			//tony did this to remove ALL mouse cursors except in inv mode because we need the drag to use cursor
			if(!_skyMouse->IsInv())
				_skyLogic->BlankMouse();

			_system->setDragIconDrawOffset(_skyMouse->giveMouseXOff(),_skyMouse->giveMouseYOff());

			//draw inv icon, if ui live, but not inv mode
			if (_skyMouse->IsUILive()&&!_skyMouse->IsInv()&&!_skyMouse->IsTextChooser() && 101!=Logic::_scriptVariables[SCREEN] && Logic::_scriptVariables[LOGIC_LIST_NO]!=24765)
			{
				_system->setIcon(UI_ICON_INV, 1, FULL_SCREEN_HEIGHT-39);
				_system->setIconNotAnimate(UI_ICON_INV, 1);

				_system->setIcon(UI_ICON_OPTIONS, 4,4);
				_system->setIcon(UI_ICON_HELP, FULL_SCREEN_WIDTH-30,2);
			}
			else if (_skyMouse->IsInv())
			{
				_system->setIcon(UI_ICON_INV, 1,FULL_SCREEN_HEIGHT-39);
				_system->setIconNotAnimate(UI_ICON_INV, 0);

				_system->clearIcon(UI_ICON_OPTIONS);
				_system->clearIcon(UI_ICON_HELP);
			}
			else
			{
				_system->clearIcon(UI_ICON_INV);
				_system->clearIcon(UI_ICON_OPTIONS);
				_system->clearIcon(UI_ICON_HELP);

			}
			//-----------------------------------------------------------------

			_skyScreen->recreate();
			_skyScreen->spriteEngine();
#if 0
			if (_debugger->showGrid()) {
				uint8 *grid = _skyLogic->_skyGrid->giveGrid(Logic::_scriptVariables[SCREEN]);
				if (grid) {
					_skyScreen->showGrid(grid);
					_skyScreen->forceRefresh();
				}
			}
#endif
			_skyScreen->flip();
		}//if !paused

		//12fps lock
		if (_fastMode & 2)
			delay(0);
		else if (_fastMode & 1)
			delay(10);
		else {
			_delayCount += _systemVars.gameSpeed;
			int needDelay = _delayCount - (int)_system->getMillis();
			if ((needDelay < 0) || (needDelay > _systemVars.gameSpeed)) {
				needDelay = 0;
				_delayCount = _system->getMillis();
			}
			delay(needDelay);
		}
	} else {
		_skyMusic->stopMusic();
	}
	//===================================================================== mainloop ==========================================================


	return !shouldQuit();
}
//--------------------------------------------------------------------------------------------------------------


void SkyEngine::initItemList() {
	//See List.asm for (cryptic) item # descriptions

	for (int i = 0; i < 300; i++)
		_itemList[i] = NULL;
}

void SkyEngine::loadFixedItems() {
	_itemList[49] = _skyDisk->loadFile(49);
	_itemList[50] = _skyDisk->loadFile(50);
	_itemList[73] = _skyDisk->loadFile(73);
	_itemList[262] = _skyDisk->loadFile(262);

	if (!isDemo()) {
		_itemList[36] = _skyDisk->loadFile(36);
		_itemList[263] = _skyDisk->loadFile(263);
		_itemList[264] = _skyDisk->loadFile(264);
		_itemList[265] = _skyDisk->loadFile(265);
		_itemList[266] = _skyDisk->loadFile(266);
		_itemList[267] = _skyDisk->loadFile(267);
		_itemList[269] = _skyDisk->loadFile(269);
		_itemList[271] = _skyDisk->loadFile(271);
		_itemList[272] = _skyDisk->loadFile(272);
	}
}

void *SkyEngine::fetchItem(uint32 num) {
	return _itemList[num];
}

uint32 SkyEngine::timerHandler(uint32 interval, void *refCon) {
	((SkyEngine *)refCon)->gotTimerTick();
        return 1000 / 50;
}

void SkyEngine::gotTimerTick() {
	_skyScreen->handleTimer();
}

// TODO: eventmanager
void SkyEngine::delay(int32 amount) {
        Event event;

        uint32 start = _system->getMillis();
        _key_pressed = 0;

        if (amount < 0)
                amount = 0;

        do
		{
            while (_system->pollEvent(&event))
			{
				switch (event.type)
				{
//                        case Common::EVENT_KEYDOWN:
//                              _keyPressed = event.kbd;
//                                break;
					case EVENT_ESC:
						_key_pressed = 27;
						break;
					case EVENT_QUIT:
						_shouldQuit = true;
						break;
					case EVENT_MOUSEMOVE:
						if (!(_systemVars.systemFlags & SF_MOUSE_LOCKED))
								_skyMouse->mouseMoved(event.x, event.y);
						break;
					case EVENT_LBUTTONDOWN:
						if (!(_systemVars.systemFlags & SF_MOUSE_LOCKED))
								_skyMouse->mouseMoved(event.x, event.y);
						{	_skyMouse->buttonPressed(2);
						}
						break;
					case EVENT_LBUTTONUP:
						if (!(_systemVars.systemFlags & SF_MOUSE_LOCKED))
								_skyMouse->mouseMoved(event.x, event.y);
						{	_skyMouse->buttonPressed(0);
							//printf("BUTTONU\n");
						}
						break;
					case EVENT_RBUTTONDOWN:
						if (!(_systemVars.systemFlags & SF_MOUSE_LOCKED))
								_skyMouse->mouseMoved(event.x, event.y);
						_skyMouse->buttonPressed(1);
						break;
					default:
						break;
					}
                }

		_system->updateScreen();

                if (amount > 0)
                        _system->delayMillis((amount > 10) ? 10 : amount);
        }
		while (_system->getMillis() < start + amount);


}

bool SkyEngine::isDemo() {
	switch (_systemVars.gameVersion) {
	case 109: // PC Gamer demo
	case 267: // English floppy demo
	case 272: // German floppy demo
	case 365: // CD demo
		return true;
	case 288:
	case 303:
	case 331:
	case 348:
	case 368:
	case 372:
	case 400: //iBASS
		return false;
	default:
		error("Unknown game version %d", _systemVars.gameVersion);
	}
}

bool SkyEngine::isCDVersion() {
	switch (_systemVars.gameVersion) {
	case 109:
	case 267:
	case 272:
	case 288:
	case 303:
	case 331:
	case 348:
		return false;
	case 365:
	case 368:
	case 372:
		return true;
	default:
		error("Unknown game version %d", _systemVars.gameVersion);
	}
	return true;
}

//----------------------------------------------------------------------------------------------------------------------------------

//OB-C glue
bool SkyEngine::hasTwitterUsername()//tony6aug09
{
	return _saveLoad->hasTwitterUsername();
}
char	*SkyEngine::giveTwitterUsername()//tony6aug09
{
	return	_saveLoad->giveTwitterUsername();
}
void	SkyEngine::setTwitterUsername(const char *ascii)//tony6aug09
{
	_saveLoad->setTwitterUsername(ascii);
}
//--------------------
bool SkyEngine::hasTwitterPassword()//tony6aug09
{
	return _saveLoad->hasTwitterPassword();
}
char	*SkyEngine::giveTwitterPassword()//tony6aug09
{
	return	_saveLoad->giveTwitterPassword();
}
void	SkyEngine::setTwitterPassword(const char *ascii)//tony6aug09
{
	_saveLoad->setTwitterPassword(ascii);
}
//--------------------
bool	SkyEngine::giveTwitterOnOff()//tony7aug09
{
	return	_saveLoad->giveTwitterOnOff();
}
void	SkyEngine::setTwitterOnOff(bool	t)//tony7aug09
{
	_saveLoad->setTwitterOnOff(t);
}
bool	SkyEngine::giveTwitterAction(int	n)//tony7aug09
{
	//return	_saveLoad->giveTwitterAction(n);
	if	(n<0 || n>TWITTER_total_actions)
		return	false;

	return	_twitterActions[n];
}
void	SkyEngine::setTwitterAction(int	n)//tony7aug09
{
	//_saveLoad->setTwitterAction(n);
	if	(n<0 || n>TWITTER_total_actions)
		return;

	_twitterActions[n]=true;
}
//--------------------
//--------------------
bool SkyEngine::slotUsed(int slot)//tony3june09
{
	return _saveLoad->slotUsed(slot);
}
char	*SkyEngine::giveSlotAscii(int slot)//tony3june09
{
	return	_saveLoad->giveSlotAscii(slot);
}
void	SkyEngine::setSlotAscii(int slot, const char *ascii)//tony4june09
{
	_saveLoad->setSlotAscii(slot, ascii);
}
bool SkyEngine::savesExist()//tony11june09
{
	return _saveLoad->savesExist();
}
bool	SkyEngine::autoSaveExists()//tony15july09
{
	return _saveLoad->autoSaveExists();
}
int		SkyEngine::giveCurrentScreen()//tony16june09
{
	return	Logic::_scriptVariables[SCREEN];
}

//----------------------------------------------------------------------------------------------------------------------------------

void	SkyEngine::initNewGame()//tony16june09
{

	_skyLogic->initScreen0();
	//reset the hints
	for(int j=0;j<TOTAL_hint_answers;j++)
		answerSeen[j]=false;

	//seen screen flags
	for(int j=0;j<TOTAL_screens;j++)
		seenScreen[j]=false;

	//twitter actions
	for	(int j=0;j<TWITTER_total_actions;j++)
		_twitterActions[j]=false;
}
//----------------------------------------------------------------------------------------------------------------------------------

void	SkyEngine::setHintAnswerSeen(int answer)//tony16june09
{
	//printf("setSeen %d %d\n", answer, answerSeen[answer]);

	if(answer>=TOTAL_hint_answers)
	{
		printf("setHintAnswerSeen says illegal answer %d\n", answer);
		exit(1);
	}
	answerSeen[answer]=true;
}
bool	SkyEngine::isHintAnswerSeen(int answer)//tony16june09
{
	//printf("isSeen %d %d\n", answer, answerSeen[answer]);
	if(answer>=TOTAL_hint_answers)
	{
		printf("isHintAnswerSeen says illegal answer %d\n", answer);
		exit(1);
	}
	return	answerSeen[answer];
}
//----------------------------------------------------------------------------------------------------------------------------------

void	SkyEngine::setSeenScreen(int screen)//tony21july09
{
	if(screen>=TOTAL_screens)
	{
		printf("isHintAnswerSeen says illegal screen %d\n", screen);
		return;
	}
	seenScreen[screen]=true;
}
bool	SkyEngine::hasSeenScreen(int screen)//tony21july09
{
	if(screen>=TOTAL_screens)
	{
		printf("hasSeenScreen says illegal screen %d\n", screen);
		return false;
	}
	return	seenScreen[screen];
}
//----------------------------------------------------------------------------------------------------------------------------------
uint32 SkyEngine::giveScriptVar(uint32 s)//tony21july09
{
	return	Logic::_scriptVariables[s];
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------



bool SkyEngine::loadGameState(int slot) {
//	if (!_saveLoad || !_saveLoad->loadSaveAllowed())
//		return false;

	return _saveLoad->restoreGameFromFile(slot);
}

bool SkyEngine::saveGameState(int slot) {
	if (!_saveLoad || !_saveLoad->loadSaveAllowed())
		return false;

	return _saveLoad->saveGameToFile(slot);
}

bool SkyEngine::canLoadGameStateCurrently() {
	if (!_saveLoad)
		return false;

	if	(Sky::g_engine->giveCurrentScreen()==81)
		return false;

	return _saveLoad->loadSaveAllowed();
}

bool SkyEngine::canSaveGameStateCurrently() {
	if (!_saveLoad)
		return false;

	if	(Sky::g_engine->giveCurrentScreen()==81)
		return false;

	return _saveLoad->loadSaveAllowed();
}


void SkyEngine::unPauseEngine(bool audio)
{
	_systemVars.paused=false;
	if	(audio)
		Sky::g_engine->giveSystem()->pauseAudioForMenu(false);
}
void SkyEngine::pauseEngine(bool audio)
{
	if	(audio)
	{
		printf("Pause audio\n");
		Sky::g_engine->giveSystem()->pauseAudioForMenu(true);
	}
	else
		printf("NOT Pause audio\n");

	_systemVars.paused=true;
}

void SkyEngine::writeExtraData()//tony14july09
{
	_saveLoad->writeExtraData();
}

void SkyEngine::setLanguageFlag(uint16 l) {
	_systemVars.language=l;

	_skyText->setLanguage(l);
}

} // End of namespace Sky
