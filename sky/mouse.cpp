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
#include "sky/logic.h"
#include "sky/mouse.h"
#include "sky/sky.h"
#include "sky/skydefs.h"
#include "sky/struc.h"
#include "sky/compact.h"
#include "sky/saveload.h"


extern volatile bool g_mouseDown;


namespace Sky {

extern "C"	void CPP_startControlPanel();
extern "C"	void CPP_startHelpPanel();
extern "C"	void CPP_sendTweet(int which);
extern "C"	void CPP_newGameAlert(bool on);

#define MICE_FILE	60300
#define NO_MAIN_OBJECTS	24
#define NO_LINC_OBJECTS	21

uint32 Mouse::_mouseMainObjects[24] = {
	65,
	9,
	66,
	64,
	8,
	63,
	10,
	11,
	71,
	76,
	37,
	36,
	42,
	75,
	79,
	6,
	74,
	39,
	49,
	43,
	34,
	35,
	77,
	38
};

uint32 Mouse::_mouseLincObjects[21] = {
	24625,
	24649,
	24827,
	24651,
	24583,
	24581,
	24582,
	24628,
	24650,
	24629,
	24732,
	24631,
	24584,
	24630,
	24626,
	24627,
	24632,
	24643,
	24828,
	24830,
	24829
};

Mouse::Mouse(OSystem *system, Disk *skyDisk, SkyCompact *skyCompact) {
	_skyDisk = skyDisk;
	_skyCompact = skyCompact;
	_system = system;
	_mouseB = 0;
	_currentCursor = 6;
	_mouseX = GAME_SCREEN_WIDTH / 2;
	_mouseY = GAME_SCREEN_HEIGHT / 2;

	_miceData = _skyDisk->loadFile(MICE_FILE);

	//load in the object mouse file
	_objectMouseData = _skyDisk->loadFile(MICE_FILE + 1);

	resetUI();
}

//----------------------------------------------------------------------------------------------------------------------------------
void	Mouse::resetUI()//tony21july09
{
	//popup
	_clickedNum=0;
	_prevMouseOn=false;
	_touchId=0;
	_holding=false;
	_timeOn=0;
	_fadeOut=0;
	m_mode=Gameplay;//master ui mode
	_isFloor=false;
	_isExit=false;
	_actionFlash=false;
	_floorLock=false;

	_system->clearAllProximityIcons(false);
	_system->clearAllIcons(false);

	//printf("ResetUI\n");
}

Mouse::~Mouse( ){
	free (_miceData);
	free (_objectMouseData);
}

void Mouse::replaceMouseCursors(uint16 fileNo) {
	free(_objectMouseData);
	_objectMouseData = _skyDisk->loadFile(fileNo);
}

bool Mouse::fnAddHuman() {
	//reintroduce the mouse so that the human can control the player
	//could still be switched out at high-level


	//iBASS: make player release touch when UI returns - stops clicks after speech registering
	if (m_mode==Gameplay)
		m_mode=MustRelease;

	if (!Logic::_scriptVariables[MOUSE_STOP]) {
		Logic::_scriptVariables[MOUSE_STATUS] |= 6;	//cursor & mouse

		if (_mouseY < 2) //stop mouse activating top line
			_mouseY = 2;

		_system->warpMouse(_mouseX, _mouseY);

		//force the pointer engine into running a get-off
		//even if it's over nothing

		//KWIK-FIX
		//get off may contain script to remove mouse pointer text
		//surely this script should be run just in case
		//I am going to try it anyway
		if (Logic::_scriptVariables[GET_OFF])
			_skyLogic->script((uint16)Logic::_scriptVariables[GET_OFF],(uint16)(Logic::_scriptVariables[GET_OFF] >> 16));

		Logic::_scriptVariables[SPECIAL_ITEM] = 0xFFFFFFFF;
		Logic::_scriptVariables[GET_OFF] = RESET_MOUSE;

                // iBASS
		//printf("TWITTER check\n");
		for	(int j=0;j<TWITTER_total_actions;j++)
		{
			//if not full filled action
			if	(!Sky::g_engine->giveTwitterAction(j))
			{
				//printf("Check action %d\n", j);
				switch(j)
				{
					case	0://sandwich
						if	(Sky::g_engine->giveScriptVar(70))
						{
							Sky::g_engine->setTwitterAction(j);//register done
							CPP_sendTweet(1238);//		@"I've just nicked a KNACKWURST sandwich! Playing Beneath a Steel Sky on the iPhone #iBASS",//4
						}
						break;
					//--------------------------------------------------------
					case	1://lambs video - o16=85
						if	(Sky::g_engine->giveScriptVar(85))
						{
							Sky::g_engine->setTwitterAction(j);//register done
							CPP_sendTweet(1239);//I've got picked up Lamb's dodgy cat video in Beneath a Steel Sky. I don't trust the fellow one little bit.
						}
						break;
					//--------------------------------------------------------
					case	2://piermont/dog dog_in_lake=796
						if	(Sky::g_engine->giveScriptVar(796))
						{
							Sky::g_engine->setTwitterAction(j);//register done
							CPP_sendTweet(1240);//Escaped the amorous advances of Danielle Piermont in Beneath a Steel Sky. Dunked her yapping mutt into a pond - just as well he can swim.
						}
						break;
					//--------------------------------------------------------
					case	3://blood vessel - crowbar_in_clot=679 clot_ruptured=680
						if	(Sky::g_engine->giveScriptVar(680))
						{
							Sky::g_engine->setTwitterAction(j);//register done
							CPP_sendTweet(1241);//I just burst a security computer's blood vessel in Beneath a Steel Sky. So this thing bleeds. Gross!
						}
						break;
					//--------------------------------------------------------
					case	4://blood vessel - crowbar_in_clot=679
						if	(Sky::g_engine->giveCurrentScreen()==82)
						{
							Sky::g_engine->setTwitterAction(j);//register done
							CPP_sendTweet(1242);//I just completed Beneath a Steel Sky on iPhone/iPod touch and saved the world!
						}
						break;
					//--------------------------------------------------------
					default:
						break;
				}
			}
		}
	}

	return true;
}

void Mouse::fnSaveCoods() {
	Logic::_scriptVariables[SAFEX] = _mouseX + TOP_LEFT_X;
	Logic::_scriptVariables[SAFEY] = _mouseY + TOP_LEFT_Y;
}

void Mouse::lockMouse() {
	SkyEngine::_systemVars.systemFlags |= SF_MOUSE_LOCKED;
}

void Mouse::unlockMouse() {
	SkyEngine::_systemVars.systemFlags &= ~SF_MOUSE_LOCKED;
}

void Mouse::restoreMouseData(uint16 frameNum) {
	warning("Stub: Mouse::restoreMouseData");
}

void Mouse::drawNewMouse() {
	warning("Stub: Mouse::drawNewMouse");
	//calculateMouseValues();
	//saveMouseData();
	//drawMouse();
}

// TODO: add eventmanager
void Mouse::waitMouseNotPressed(int minDelay) {
	bool mousePressed = true;
	uint32 now = _system->getMillis();
	Event event;
	while (mousePressed || _system->getMillis() < now + minDelay) {

		/*
		if (eventMan->shouldQuit()) {
			minDelay = 0;
			mousePressed = false;
		}
		*/

		if (!g_mouseDown /*!eventMan->getButtonState()*/)
			mousePressed = false;

		while (_system->pollEvent(&event)) {
			switch (event.type) {
			case 0:
				if (event.type == EVENT_QUIT) {
					minDelay = 0;
					mousePressed = false;
				}
				break;
			default:
				break;
			}
		}
		_system->updateScreen();
		_system->delayMillis(20);
	}
}

//----------------------------------------------------------------------------------------------------------------------------------
//set the mouse, called when it changes - coords make no difference :)
void Mouse::spriteMouse(uint16 frameNum, uint8 mouseX, uint8 mouseY) {
	//printf("spriteMouse [%d]\n",frameNum);

	//hotspot an exit?
	if (frameNum==MOUSE_LEFT || frameNum==MOUSE_RIGHT || frameNum==MOUSE_UP || frameNum==MOUSE_DOWN )
		setHotspotIsExit(frameNum);

	_currentCursor = frameNum;

	byte *newCursor = _miceData;
	newCursor += ((DataFileHeader *)_miceData)->s_sp_size * frameNum;
	newCursor += sizeof(DataFileHeader);

//	uint16 mouseWidth = ((dataFileHeader *)_miceData)->s_width;
//	uint16 mouseHeight = ((dataFileHeader *)_miceData)->s_height;

	//_system->setDragIconFromGameData(newCursor, mouseWidth, mouseHeight, mouseX, mouseY/*, 0*/);
}
//----------------------------------------------------------------------------------------------------------------------------------
bool Mouse::IsUILive()//tony7may09
{
	if (!Logic::_scriptVariables[MOUSE_STOP] && (Logic::_scriptVariables[MOUSE_STATUS] & (1 << 1)) && (Logic::_scriptVariables[MOUSE_STATUS] & (1 << 2)) )
		return	true;

	return false;
}

//----------------------------------------------------------------------------------------------------------------------------------
void	Mouse::KillUI()//tony11june09
{
	//remove popup icons and so on when fnNoHuman called

	if	(m_mode!=INV_temp_examine)
	{
		_holding=false;
		_touchId=0;
		//remove hotspot icons
		_system->clearAllIcons();
		_skyLogic->KillInventory();
	}
}
//----------------------------------------------------------------------------------------------------------------------------------


void Mouse::mouseEngine()
{
	//_logicClick = (_mouseB > 0); // click signal is available for Logic for one gamecycle

	if (_mouseB)
		_logicClick++;
	else
		_logicClick=0;

	//flash
	if	(_actionFlash)
	{
		//printf("Flash %d\n", _actionFlashTime);

		_actionFlashTime--;
		if	(!_actionFlashTime)
		{
			_actionFlash=false;
		}

		if	(!(_actionFlashTime&1))
		{
			//off
			_system->clearIcon(_actionFlashIcon, false);
		}
		else
		{
			//on
			_system->setIcon(_actionFlashIcon, _actionFlashX, _actionFlashY);
		}
	}

	//human allowed?
	if (!IsUILive())
	{
		return;
	}

	//first gameplay
	if	(!_mouseB && !Sky::g_engine->giveTwitterAction(19))
	{
//		printf("new game alert!\n");

		Sky::g_engine->setTwitterAction(19);
		CPP_newGameAlert(true);//do
		//init inv bg
		giveSystem()->showInventory(40, 60, 280, 140);
		//click past move
		m_mode=Alert_to_game;


		//first, some autosaving incase this is a fatal, yes FATAL, interaction
		if (g_engine->canSaveGameStateCurrently())
		{
			//printf("addHUMAN Autosaving...\n");
			g_engine->saveGameState(0);
		}
	}

	//what we doin?
	switch(m_mode)
	{
		case	Alert_to_game:
			if(!_mouseB)
				return;

			CPP_newGameAlert(false);//do

			giveSystem()->hideInventory();
			m_mode=MustRelease;
			break;
		case	MustRelease:
			if(_mouseB)
				return;
			resetUI();
			m_mode=Gameplay;
			break;
		case	Gameplay://normal search
			pointerEngine(_mouseX + TOP_LEFT_X, _mouseY + TOP_LEFT_Y);
			break;
		case	PreInventory:
			if(_mouseB)
				return;
			m_mode=Inventory;
			break;
		case	Inventory:
			if	(isLincInv())
				LincInvMouse(_mouseX + TOP_LEFT_X, _mouseY + TOP_LEFT_Y);
			else
				InvMouse(_mouseX + TOP_LEFT_X, _mouseY + TOP_LEFT_Y);
			break;
		case	InventoryUseOn:
			InvUseOn(_mouseX + TOP_LEFT_X, _mouseY + TOP_LEFT_Y);
			break;
		case	Text_chooser:
			TextChooser(_mouseX + TOP_LEFT_X, _mouseY + TOP_LEFT_Y);
			break;
	}

}

//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::TextChooser(uint16 xPos, uint16 yPos)//tony29april09
{
	//speech conversation text choose mode
	uint32 currentListNum = Logic::_scriptVariables[MOUSE_LIST_NO];
	uint16 *currentList;
	Compact *itemData;
	uint32	itemNum;


	if	(yPos<(TOP_LEFT_Y+4))
		yPos=(TOP_LEFT_Y+4);

	if (_mouseB)
	{
		do
		{
			currentList = (uint16 *)_skyCompact->fetchCpt(currentListNum);
			while ((*currentList != 0) && (*currentList != 0xFFFF))
			{
				itemNum = *currentList;
				itemData = _skyCompact->fetchCpt(itemNum);
				currentList++;

				if ((itemData->screen == Logic::_scriptVariables[SCREEN]) && (itemData->status & 16))
				{
					if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
					if (itemData->xcood + ((int16)itemData->mouseRelX) + itemData->mouseSizeX < xPos) continue;
					if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
					if (itemData->ycood + ((int16)itemData->mouseRelY) + itemData->mouseSizeY < yPos) continue;

					if (_touchId!=itemNum)
					{
						//run previous items get-off, if there was one (gone straight from one object onto another!)
						if (Logic::_scriptVariables[GET_OFF])
							_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

						//write mouse off script number
						Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

						//record what we're touching
						Logic::_scriptVariables[SPECIAL_ITEM] = itemNum;

						_touchId=itemNum;

						if (itemData->mouseOn)
							_skyLogic->mouseScript(itemData->mouseOn, itemData);
					}

					//touching something - we're done
					return;
				}
			}
			if (*currentList == 0xFFFF)
				currentListNum = currentList[1];
		}
		while (*currentList != 0);

		//run previous items get-off, if there was one (gone straight from one object onto another!)
		if (Logic::_scriptVariables[GET_OFF])
		{
			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

			Logic::_scriptVariables[GET_OFF]=0;
		}
		//clear
		_touchId=0;

	}//if _mouseB
	else//released - on anything to use-on?
	{
		//run previous items get-off, if there was one (gone straight from one object onto another!)
		if (Logic::_scriptVariables[GET_OFF])
		{
			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

			Logic::_scriptVariables[GET_OFF]=0;
		}

		if (_touchId)
		{
			//an sfx
			Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);

			Logic::_scriptVariables[BUTTON] = 3;

			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			if (itemData->mouseClick)
				_skyLogic->mouseScript(itemData->mouseClick, itemData);

			_logicClick=2;

			//back to normal search ui
			_touchId=0;
			m_mode=Gameplay;

		}
	}

}
//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::InvUseOn(uint16 xPos, uint16 yPos)//tony26april09
{
//dragging inv object around the screen - release to use

//	uint32 currentListNum = Logic::_scriptVariables[MOUSE_LIST_NO];
//	uint16 *currentList;
	Compact *itemData;
	uint32	itemNum;
	uint16	midx, midy;

	//crude way to avoid old inv start method - the inv start object is of course still live and kicking up there
	//but only if mouse is pressed, if not pressed then let the mode cancel normally
	if (yPos<(TOP_LEFT_Y+5) && _mouseB)
		return;

	if (_mouseB)
		_logicClick++;
	else
		_logicClick=0;


	if (_mouseB)
	{
		//what are we near?
		itemNum=doProximityHighlights(xPos,yPos);
		//shouldn't ever happen!?
		if	(!itemNum)
			return;

		itemData = _skyCompact->fetchCpt(itemNum);

		midx=giveXcood(itemData, itemNum);	//->xcood + ((int16)itemData->mouseRelX) + (itemData->mouseSizeX>>1);
		midy=giveYcood(itemData, itemNum);//itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);

		int	d= abs(xPos-midx)+abs(yPos-midy);
		if	(d<USE_ON_DIST)
		{
			if (_touchId!=itemNum)
			{
				//("\nOnto new %d",j);

				//run previous items get-off, if there was one (gone straight from one object onto another!)
				if (Logic::_scriptVariables[GET_OFF])
				{	_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);
				//	printf("run old Off\n");
				}

				//write mouse off script number
				Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

				//record what we're touching
				Logic::_scriptVariables[SPECIAL_ITEM] = itemNum;

				_touchId=itemNum;

				if (itemData->mouseOn)
				{	_skyLogic->mouseScript(itemData->mouseOn, itemData);
					//highlight on
					_system->setDragIconHighlight(true);
				}
				else
				{
					//highlight off - incase moving off hotspot onto floor
					_system->setDragIconHighlight(false);
				}
			}

			//touching something - we're done
			_system->setProximityNotAnimate(_nearestProximityIconId);

			return;
		}

		//touching nothing

		//run previous items get-off, if there was one (gone straight from one object onto another!)
		if (Logic::_scriptVariables[GET_OFF])
		{
			//highlight off
			_system->setDragIconHighlight(false);

			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

			Logic::_scriptVariables[GET_OFF]=0;
		}
		//clear
		_touchId=0;

	}
	else//released - on anything to use-on?
	{
		_system->clearAllProximityIcons();

		//run previous items get-off, if there was one (gone straight from one object onto another!)
		if (Logic::_scriptVariables[GET_OFF])
		{
			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

			Logic::_scriptVariables[GET_OFF]=0;
		}

		if (_touchId)
		{
			//first, some autosaving incase this is a fatal, yes FATAL, interaction
			if (g_engine->canSaveGameStateCurrently())
			{
			//	printf("Autosaving...\n");
				g_engine->saveGameState(0);
			}
			else
			{
			//	printf("Autosave not allowed!\n");
			}

			//an sfx
			Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);

			Logic::_scriptVariables[BUTTON] = 3;

			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			if (itemData->mouseClick && itemData->mouseOn)	//
			{
				//seems we need to do this, because advisor-188 script unsets the other way
				Logic::_scriptVariables[SAFE_LOGIC_LIST]=Logic::_scriptVariables[LOGIC_LIST_NO];
				_skyLogic->mouseScript(itemData->mouseClick, itemData);
				//printf("Running use-on id=%d scipt=%d held=%d list=%d\n", _touchId, itemData->mouseClick, Logic::_scriptVariables[OBJECT_HELD], Logic::_scriptVariables[LOGIC_LIST_NO]);
			}
		}

		//back to normal search ui
		resetUI();
		_touchId=0;
		m_mode=Gameplay;
		_system->clearDragIcon();//clear the dragging icon
		//printf("Exiting use-on mode ----------------\n");
	}

}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
UIIcon Mouse::getInteractIcon(uint32	id)//tony9july09
{

	switch(id)
	{
		case	70://screen 1 stairs
		case	4119://elevator hole
		case	8210://outside stairs to furnace
			return	UI_ICON_DOWN;//

		case	69://screen 1 stairs
			return	UI_ICON_UP;//

		case	1://joey
		case	4122://hobbins
		case	16://lamb
		case	8324://guard
		case	8211://sam
		case	8301://norville
		case	8544://clipboard man
		case	136://power room man
		case	12546://galagher
		case	12442://insurance man
		case	12430://anchor man
		case	12407://dr burke
		case	16516://henri
		case	16601://guard
		case	16441://piermont
		case	16599://gameboy
		case	16600://gardener
		case	16701://barman
		case	16772://babs
		case	16737://man1
		case	16731://man2
//		case	20511://medi joey
		case	20911://ken
		case	137://anita
	//	case	12407://patient
		case	12289://mr cool
		case	8205://rad suit man
		case	8309://guard walkway
		case	21014://father @ end
			return	UI_ICON_MOUTH;//talk

		case	4151://notice
		case	4152://ledge-side notice
		case	12383://sculpture
		case	12388://mural
		case	12386://poster
		case	12387://ins poster
		case	12378://surgery poster
		case	12375://surgery poster
		case	12376://surgery poster
		case	12377://surgery poster
		case	12401://dr poster
		case	12402://dr poster
		case	12545://ins poster
		case	20678://crowbar on floor
		case	12508://reich poster
		case	12507://reich cert
		case	12495://reich poster
		case	8500://sensors
		case	20576://medical computer monitor
		case	20578://medical computer
		case	8543://securty hq linc terminal
			return	UI_ICON_LOOK;//look at

		case	4113://sandwhich
		case	4114://sandwhich
		case	8://reich card
		case	9://sunglasses
		case	8442://key
		case	8443://wd40
		case	8446://putty
		case	24642://linc item
		case	24602://linc item
		case	16501://secateurs
		case	16747://glass
		case	20527://brick
		case	20660://tongs
		case	71://anita card
		case	49://dog biscuits
		case	24638://linc
		case	24639://linc
		case	24604://linc
		case	12588://light bulb
		case	12501://magazine
		case	12565://tour ticket
		case	8517://reactor anita card??!
		case	20526://plaster
		case	24641://linc world tuning fork
		case	24787://virus
		case	12517://video
		case	12434://anchor
		case	12435://anchor
			return	UI_ICON_HAND;
	}

	return	UI_ICON_USE;
}
//----------------------------------------------------------------------------------------------------------------------------------
bool Mouse::hasSingleInteractIcon(uint32	id)//tony9july09
{
	switch(id)
	{
		case	1://joey
		case	4122://hobbins
		case	4151://notice
		case	4152://ledge-side notice
		case	16://lamb
		case	8500://sensors
		case	8324://guard
		case	8211://sam
		case	8301://norville
		case	8544://clipboard man
		case	136://power room man
		case	12546://galagher
		case	12383://sculpture
		case	12442://insurance man
		case	12388://mural
		case	12386://ins poster
		case	12387://ins poster
		case	12430://anchor man
		case	12378://surgery poster
		case	12375://surgery poster
		case	12376://surgery poster
		case	12377://surgery poster
		case	12407://dr burke
		case	12401://dr poster
		case	12402://dr poster
		case	12545://ins poster
		case	24810://linc window button
		case	16516://henri
		case	16601://guard
		case	16441://piermont
		case	16599://gameboy
		case	16600://gardener
		case	16701://barman
		case	16772://babs
		case	16737://man1
		case	16731://man2
//		case	20511://medi joey
		case	20911://ken
		case	137://anita
		case	12508://reich poster
		case	12507://reich cert
		case	12495://reich poster
//		case	12407://patient
		case	12289://mr cool
		case	8205://rad suit man
		case	8309://guard walkway

		case	20576://medical computer monitor
		case	20578://medical computer

		case	24586://linc maze
		case	24592://linc maze
		case	24633://linc maze
		case	24634://linc maze
		case	24593://linc maze
		case	24594://linc maze
		case	24595://linc maze
		case	24598://linc maze
		case	8543://securty hq linc terminal

		case	69://screen 1 stairs
		case	70://screen 1 stairs
		case	4119://elevator hole
		case	8210://outside stairs to furnace

		case	21014://father @ end

				return	true;

	}

	return	false;
}

//----------------------------------------------------------------------------------------------------------------------------------
uint16	Mouse::giveXcood(Compact *itemData, uint32 id)//tony12july09
{
	//push objects that are too far to left, or to the right, back onto the screen
	uint16 mid, midy;

	mid= itemData->xcood + ((int16)itemData->mouseRelX) + (itemData->mouseSizeX>>1);
	midy=itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);

	//object beneath INV button?
	if (mid<HOTSPOT_invx && midy>HOTSPOT_invy)
		return	HOTSPOT_invx+16;


	if(id!=16)//not lamb
	{
		if	(mid > 428)
			return	428;
		if	(mid < 142)
			return	142;
	}

	switch(id)
	{
		case	4112:{mid=258;break;}//cupboard door
		case	4113:{mid=254;break;}//sandwich
		case	4114:{mid=254;break;}//spanner

		case	12358:	{mid=428;break;}//bellevue - missing exit
		case	12681:	{mid=428;break;}//bellevue
		case	12349:	{mid=142;break;}//bellevue
		case	12347:	{mid=428;break;}//bellevue
		case	90:{mid=404;break;}//first room, door
		case	97:{mid=190;break;}//ledge room, door
		case	4116:{mid=269;break;}//elevator
		case	4119:{mid=269;break;}//hole
		case	4110:{mid=356;break;}//lathe
		case	8248:{mid=357;break;}//walkway to security lobby
		case	8238:{mid=181;break;}//walkway to power
		case	8317:{mid=426;break;}//walkway to crash
		case	8341:{mid=173;break;}//factory to walkway
		case	8344:{mid=433;break;}//factory to factory 2
		case	8500:{mid=224;break;}//sensors
		case	8355:{mid=428;break;}//factory 2 to factory 3
		case	8446:{mid=226;break;}//putty
		case	8438:{mid=226;break;}//gangway
		case	12680:{mid=201;break;}//exit
		case	12679:{mid=307;break;}//exit
		case	12678:{mid=179;break;}//exit
		case	12677:{mid=319;break;}//exit
		case	12324:{mid=191;break;}//exit
		case	12336:{mid=182;break;}//exit
		case	12442:{mid=376;break;}//exit
		case	8483:{mid=225;break;}//console
		case	12641:{mid=158;break;}//exit

		//linc
		case	12633:{mid=190;break;}//maze
		case	24586:{mid=210;break;}//maze
		case	24592:{mid=288;break;}//maze mid-bot
		case	24593:{mid=400;break;}//maze mid-bot
		case	24594:{mid=203;break;}//maze left-mid
		case	24595:{mid=299;break;}//maze left-mid


		//hyde
		case	16496:{mid=263;break;}//plant
		//cathedral
		case	16462:{mid=168;break;}//exit

		//lockers
		case	16576:{mid=246;break;}//body == 16569
		case	16577:{mid=271;break;}//body == 16570
		case	16578:{mid=296;break;}//body == 16571
		case	16579:{mid=321;break;}//body == 16572
		case	16580:{mid=346;break;}//body == 16573

		//underworld
		case	20506:{mid=389;break;}//metal door
		//pit room
		case	20600:{mid=283;break;}//cover
		case	20648:{mid=283;break;}//pit
		case	20570:{mid=247;break;}//exit to medical droid room

		case	20575:{mid=277;break;}//slot
		case	20577:{mid=297;break;}//recharge unit

		case	24786:{mid=288;break;}//linc crystal
		case	24787:{mid=288;break;}//virus

		case	20712:{mid=305;break;}//console
		case	20713:{mid=356;break;}//console

		case	20728:{mid=388;break;}//exit from door room

		case	8272:{mid=278;break;}//power room chair

		case	12390:{mid=187;break;}//burke door
		case	12541:{mid=187;break;}//burke exit


	}

//	if	(id==16569)	printf("69 x=%d\n", mid);

	return	mid;
}

//----------------------------------------------------------------------------------------------------------------------------------
uint16	Mouse::giveYcood(Compact *itemData, uint32 id)//tony12july09
{
	//push objects that are too far to left, or to the right, back onto the screen
	uint16 mid;

	mid=itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);

	//tweeky check for weird exits
//	if	(midy>300)
//		midy=TWEEKY_EXIT_ADJUST;

	switch(id)
	{
		case	4112://cupboard door - not if open
		{
			if	(Sky::g_engine->giveScriptVar(112))//cupb_flag
				return	0;
			mid=221;
			break;
		}
		case	4113:{mid=218;break;}//sandwich
		case	4114:{mid=226;break;}//spanner

		case	4108:{mid=0;break;}//remove monitor screen
		case	4111:{mid=0;break;}//remove lazer
		case	4115:{mid=0;break;}//remove monitor screen
		case	4117:{mid=0;break;}//remove monitor screen
		case	4154:{mid=0;break;}//remove right sign


		case	12349:	{mid=TWEEKY_EXIT_ADJUST;break;}//bellevue
		case	12347:	{mid=TWEEKY_EXIT_ADJUST;break;}//bellevue
		case	12358:	{mid=TWEEKY_EXIT_ADJUST;break;}//bellevue
		case	90:{mid=208;break;}//first room, door
		case	97:{mid=216;break;}//ledge room, door
		case	4116:{mid=259;break;}//elevator
		case	4119:{mid=259;break;}//hole
		case	4315:{mid=261;break;}//exit left from junk room
		case	4103:{mid=242;break;}//exit right from junk room
		case	4105:{mid=241;break;}//exit left from hobbins room
		case	4110:{mid=230;break;}//lathe
		case	8248:{mid=222;break;}//walkway to security lobby
		case	8238:{mid=222;break;}//walkway to power
		case	8310:{mid=222;break;}//walkway to first room
		case	8246:{mid=273;break;}//power exit
		case	8317:{mid=273;break;}//walkway to crash
		case	8331:{mid=230;break;}//walkway to factory
		case	8341:{mid=239;break;}//factory to walkway
		case	8344:{mid=282;break;}//factory to factory 2
		case	8500:{mid=197;break;}//sensors
		case	8355:{mid=255;break;}//factory 2 to factory 3
		case	8366:{mid=227;break;}//factory 2 to storeroom
		case	8375:{mid=238;break;}//storeroom to factory 2
		case	8446:{mid=247;break;}//putty
		case	8438:{mid=247;break;}//gangway
		case	8364:{mid=252;break;}//exit
		case	8459:{mid=252;break;}//exit
		case	8256:{mid=297;break;}//exit

		//bellevue
		case	12304:{mid=252;break;}//exit
		case	12338:{mid=286;break;}//exit
		case	12681:{mid=250;break;}//exit
		case	12370:{mid=289;break;}//exit
		case	12361:{mid=267;break;}//exit
		case	12679:{mid=179;break;}//exit
		case	12678:{mid=179;break;}//exit
		case	12677:{mid=179;break;}//exit
		case	12313:{mid=284;break;}//exit
		case	12676:{mid=241;break;}//exit
		case	12327:{mid=244;break;}//exit
		case	12315:{mid=286;break;}//exit
		case	12324:{mid=308;break;}//exit
		case	12336:{mid=306;break;}//exit
		case	12442:{mid=246;break;}//exit
		case	12447:{mid=242;break;}//exit
		case	12680:{mid=179;break;}//exit
		case	12459:{mid=281;break;}//exit
		case	12471:{mid=302;break;}//exit
		case	12399:{mid=257;break;}//exit
		case	12390:{mid=264;break;}//burke door
		case	12541:{mid=264;break;}//burke exit

		case	12630:{mid+=4;break;}//slot
		case	12616:{mid+=4;break;}//slot
		case	12629:{mid+=4;break;}//slot
		case	12628:{mid+=4;break;}//slot
		case	12627:{mid+=4;break;}//slot
		case	12626:{mid+=4;break;}//slot

		case	12620:{mid=220;break;}//locker
		case	12621:{mid=220;break;}//locker
		case	12622:{mid=220;break;}//locker
		case	12623:{mid=220;break;}//locker
		case	12613:{mid=220;break;}//locker
		case	12624:{mid=220;break;}//locker

		case	12631:{mid=273;break;}//exit
		case	12641:{mid=290;break;}//exit
		case	12642:{mid=273;break;}//exit

		case	12474:{mid=282;break;}//lamb door
		case	12486:{mid=298;break;}//lamb door

		//security room
		case	8295:{mid=299;break;}//exit

		//hyde
		case	16415:{mid=261;break;}//exit
		case	16403:{mid=261;break;}//exit
		case	16393:{mid=246;break;}//exit
		case	16487:{mid=256;break;}//exit
		case	16492:{mid=287;break;}//exit
		case	16394:{mid=313;break;}//exit
		case	16412:{mid=276;break;}//exit
		case	16428:{mid=233;break;}//exit
		case	16424:{mid=236;break;}//exit


		//cathedral
		case	16462:{mid=296;break;}//exit
		case	16464:{mid=250;break;}//exit
		case	16465:{mid=226;break;}//exit
		case	16474:{mid=263;break;}//exit

		case	16576:{mid=229;break;}//body == 16569
		case	16577:{mid=229;break;}//body == 16570
		case	16578:{mid=229;break;}//body == 16571
		case	16579:{mid=229;break;}//body == 16572
		case	16580:{mid=229;break;}//body == 16573

		//reactor
		case	8478:{mid=291;break;}//exit
		case	8481:{mid=253;break;}//exit
		case	8511:{mid=271;break;}//exit

		//club
		case	16538:{mid=279;break;}//exit

		//abandoned subway
		case	16439:{mid=267;break;}//exit

		//entrance to underworld
		case	16592:{mid=267;break;}//exit

		//underworld
		case	16649:{mid=291;break;}//exit
		case	16660:{mid=285;break;}//exit
		case	16662:{mid=254;break;}//exit
		case	16661:{mid=291;break;}//exit
		case	16671:{mid=291;break;}//exit
		case	16681:{mid=282;break;}//exit
		case	16682:{mid=282;break;}//exit
		case	16719:{mid=287;break;}//exit
		case	16720:{mid=287;break;}//exit
		case	16729:{mid=291;break;}//exit
		case	16730:{mid=301;break;}//exit
		case	20506:{mid=276;break;}//metal door
		//underworld main
		case	20518:{mid=276;break;}//metal door
		case	20532:{mid=264;break;}//exit
		case	20558:{mid=296;break;}//exit
		case	20598:{mid=237;break;}//exit
		case	20601:{mid=183;break;}//metal bar
		case	20600:{mid=237;break;}//cover
		case	20648:{mid=237;break;}//pit
		case	20570:{mid=268;break;}//exit to medical droid room

		case	20573:{mid=290;break;}//droid room exit
		case	20579:{mid=272;break;}//droid room exit
		case	20572:{mid=277;break;}//droid room exit
		case	20578:{mid=286;break;}//console
		case	20674:{mid=279;break;}//droid room exit

		case	20675:{mid=238;break;}//robot
		case	20511:{mid=259;break;}//slot

		case	20583:{mid=291;break;}//tank room exit
		case	20604:{mid=264;break;}//tank room exit
		case	20676:{mid=294;break;}//exit
		case	20619:{mid=269;break;}//exit
		case	20628:{mid=284;break;}//exit
		case	20617:{mid=295;break;}//exit

		case	24786:{mid=256;break;}//linc crystal
		case	24787:{mid=256;break;}//linc crystal

		case	20672:{mid=265;break;}//android room exit
		case	20696:{mid=265;break;}//android room exit
		case	20697:{mid=265;break;}//android room exit
		case	20715:{mid=265;break;}//android room exit

		case	20711:{mid=219;break;}//console
		case	20712:{mid=219;break;}//console
		case	20713:{mid=219;break;}//console

		case	20725:{mid=268;break;}//exit

		case	20726:{mid=270;break;}//exit from door room
		case	20728:{mid=219;break;}//exit from door room

		case	20741:{mid=254;break;}//exit from first vein room
		case	20743:{mid=279;break;}//exit from first vein room
		case	20752:{mid=279;break;}//exit near end
		case	20886:{mid=243;break;}//exit orifice to linc

		case	20874:{mid=0;break;}//pipe support - removed as appears to have no interaction

		//linc
		case	24592:{mid=306;break;}//maze mid-bot
		case	24634:{mid=306;break;}//maze mid-bot
//		case	24633:{mid=308;break;}//maze left-mid
		case	24594:{mid=278;break;}//maze left-mid

		case	8272:{mid=0;break;}//REMOVE power room chair

		case	8290:
		case	8291://power room switches
		{
			if	(!Sky::g_engine->giveScriptVar(429))
				return	0;
		}//switch_flag
	}


	return	mid;
}

//----------------------------------------------------------------------------------------------------------------------------------
int Mouse::doProximityHighlights(uint16 xPos, uint16 yPos)//tony10july09
{
	uint32 currentListNum = Logic::_scriptVariables[MOUSE_LIST_NO];
	uint16 *currentList;
	int	midx,midy;
	Compact *itemData;
	uint16 itemNum;
	int	found=0;
	int	nearestDist=99999;
	int	nearestId=0;
	_nearestProximityIconId=0;

	static int	proxFrame=0;
	static int	proxFrameSpeed=0;

	proxFrameSpeed++;
	if	(proxFrameSpeed&1)
		proxFrame++;
	if	(proxFrame==3)
		proxFrame=0;

	//near inv button?
	if (yPos>HOTSPOT_invy && xPos<HOTSPOT_invx)
		return	0;

	//printf("[%d,%d]", xPos,yPos);

	//not on same as last time, or was not on anything previously, so re-scan all objects
	do
	{
		currentList = (uint16 *)_skyCompact->fetchCpt(currentListNum);
		while ((*currentList != 0) && (*currentList != 0xFFFF))
		{
			itemNum = *currentList;
			itemData = _skyCompact->fetchCpt(itemNum);
			currentList++;

			if ((itemData->screen == Logic::_scriptVariables[SCREEN]) && (itemData->status & 16))
			{
				//hotspot, if a non-floor object
				if (itemData->mouseOn && yPos>(20+TOP_LEFT_Y))//extra bit just so we can catch old inv, for now
				{
					midx=giveXcood(itemData,itemNum);
					midy=giveYcood(itemData,itemNum);//itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);

					//skip very high hotspots - eg the old inventory catch object
					if (midy<(TOP_LEFT_Y+5))
						continue;

					//how far from finger?
					int	d= abs(xPos-midx)+abs(yPos-midy);
					if	(d<GLOW_DIST)
					{
						float opacity= 1.0-((d*1.0)/GLOW_DIST);
						_system->setProximityIcon(found++, midx-TOP_LEFT_X-4, ((midy-TOP_LEFT_Y)-4), opacity,proxFrame);
					}

					//nearest
					if (d<nearestDist)
					{
						nearestDist=d;
						nearestId=itemNum;
						_nearestProximityIconId=(found-1);
					}
					//printf("[%d,%d]", midx-TOP_LEFT_X, midy-TOP_LEFT_Y);
				}
			}

		}
		if (*currentList == 0xFFFF)
			currentListNum = currentList[1];
	}
	while (*currentList != 0);



	//printf("f=%d ", found);
//	if	(!nearestId)
//		printf("NO PROX\n");


	return	nearestId;
}

//----------------------------------------------------------------------------------------------------------------------------------
int Mouse::touchingFloor(uint16 xPos, uint16 yPos)//tony3aug09
{
	uint32 currentListNum = Logic::_scriptVariables[MOUSE_LIST_NO];
	uint16 *currentList;
	Compact *itemData;
	uint16 itemNum;

	//do not detect floors beyond a certain depth
	if	(yPos > (HOTSPOT_invy+8)) return 0;
	if	(yPos<(20+TOP_LEFT_Y))	return 0;

	do
	{
		currentList = (uint16 *)_skyCompact->fetchCpt(currentListNum);
		while ((*currentList != 0) && (*currentList != 0xFFFF))
		{
			itemNum = *currentList;
			itemData = _skyCompact->fetchCpt(itemNum);
			currentList++;

			//on this screen, active, and a floor
			if ((itemData->screen == Logic::_scriptVariables[SCREEN]) && (!itemData->mouseOn) && (itemData->status & 16))
			{
				if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
				if (itemData->xcood + ((int16)itemData->mouseRelX) + itemData->mouseSizeX < xPos) continue;
				if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
				if (itemData->ycood + ((int16)itemData->mouseRelY) + itemData->mouseSizeY < yPos) continue;

				//hit this floor - we're done here
				return	itemNum;
			}
		}
		if (*currentList == 0xFFFF)
			currentListNum = currentList[1];
	}
	while (*currentList != 0);


	//found nowt
	return	0;
}

//----------------------------------------------------------------------------------------------------------------------------------
/*

Cos in the Liberty of Norton Folgate
Walking wild and free
And in your second hand coat
Happy just to float
In this little taste of liberty
Cos you’re a part of everything you see
Yes you’re a part of everything you see

*/

void Mouse::pointerEngine(uint16 xPos, uint16 yPos)
{
	int	midx,midy;//open hotspot dimensions
	Compact *itemData;
	int		itemProx;
	int	d=0;

	//crude way to avoid old inv start method - the inv start object is of course still live and kicking up there
	if (yPos<(TOP_LEFT_Y+5))
		return;


	//mouse must be down/finger touching screen, to search for stuff
	if (_mouseB)
	{
		//what are we near?
		itemProx=doProximityHighlights(xPos,yPos);

		//seems we need to clear this, but only safe to do so when a new touch occurs as player is still live when walking to interact after a use-on interaction
		//but not in linc terminal
		if	(101!=Logic::_scriptVariables[SCREEN])//haha, room 101 indeed
			Logic::_scriptVariables[OBJECT_HELD]=0;

		//need to check if still touching any currently popped up hotspot
		if (_touchId && _timeOn<CLICK_THRESHOLD)
		{
			//printf("Still on %d\n", _touchId);

			if	(_prevMouseOn==false)
				_timeOn=1;

			//fetch the compact
			itemData = _skyCompact->fetchCpt(_touchId);

			//if not a floor
			if (itemData->mouseOn)
			{
				_system->setProximityNotAnimate(_nearestProximityIconId);//we want this one remaining one to not animate



				midx=giveXcood(itemData,_touchId);
				midy=giveYcood(itemData,_touchId);
				//calc dist
				d= abs(xPos-midx)+abs(yPos-midy);

				//some left hand edge adjust for twin-hotspot non-exits
				if	(!hasSingleInteractIcon(_touchId) && !_isExit)
					if	( (midx-HOTSPOT_dim) < TOP_LEFT_X)
						midx=TOP_LEFT_X+HOTSPOT_dim;

				//still touching a normal hotspot?
				if (!_isExit && midx-HOTSPOT_dim < xPos && midx+HOTSPOT_dim > xPos && midy-HOTSPOT_yoff < yPos && midy/*+HOTSPOT_yoff*/ > yPos)
				{
					//if newly touching, and same item as last time, then inc the click count
					if	(_prevMouseOn==false)
					{
					//	if	(Logic::_scriptVariables[BUTTON] == 2)//left
							//("LEFT Re-touch id=%d clickedNum=%d Mid=%d x=%d\n", _touchId, _clickedNum, midx, xPos);
					//	else
					//		printf("RIGHT Re-touch id=%d clickedNum=%d Mid=%d x=%d\n", _touchId, _clickedNum, midx, xPos);
						_clickedNum++;	//one more click
						//reset fade out timer to max
						_fadeOut=HOTSPOT_FADEOUT;
						//reset hover time
						_timeOn=1;
					}
					else
					{
						_timeOn++;//one more cycle
					}

					int	icony=midy-HOTSPOT_yoff;
					icony-=TOP_LEFT_Y;//normalise for renderer
					if	(icony<0)
						icony=0;

					if	(hasSingleInteractIcon(_touchId))
					{
						//update the coordinate of the hotspot
						midx-=TOP_LEFT_X;
						midx-=HOTSPOT_ExitDim;

						//draw the icons
				//		_system->setIcon( getInteractIcon(_touchId), midx+4, icony);

						_actionFlashX=midx+4;
						_actionFlashIcon=getInteractIcon(_touchId);
						_actionFlashY=icony;
					}
					else	//2 icons
					{
						//update the coordinate of the hotspot
						midx-=TOP_LEFT_X;
						midx-=HOTSPOT_dim;

						//draw the icons
					//	_system->setIcon(UI_ICON_LOOK, midx, icony);
					//	_system->setIcon( getInteractIcon(_touchId), midx+HOTSPOT_dim+4, icony);

						_actionFlashY=icony;

						//still touching the poped up area
						//which action
						if (xPos<=(midx+HOTSPOT_dim+TOP_LEFT_X))
						{
							Logic::_scriptVariables[BUTTON] = 2;
							_actionFlashX=midx;
							_actionFlashIcon=UI_ICON_LOOK;
						}
						else
						{
							Logic::_scriptVariables[BUTTON] = 1;
							_actionFlashX=midx+HOTSPOT_dim+4;
							_actionFlashIcon=getInteractIcon(_touchId);
						}
					}


					//mouse on
					_prevMouseOn=true;

					//end here, when button held on something
					return;
				}//-----------------------------------------------------------------------------------------------------------
				else if (_isExit && midx-HOTSPOT_dim < xPos &&	midx+HOTSPOT_dim > xPos && midy-HOTSPOT_yoff < yPos && midy/*+HOTSPOT_yoff*/ > yPos)
				{
					//still touching the poped up exit
					//which action
					Logic::_scriptVariables[BUTTON] = 1;

					//if newly touching, and same item as last time, then inc the click count
					if	(_prevMouseOn==false)
					{
						//						printf("Re-touch\n");
						_clickedNum++;	//one more click
						//reset fade out timer to max
						_fadeOut=HOTSPOT_FADEOUT;
						//reset hover time
						_timeOn=0;
					}
//					else
					{
						_timeOn++;//one more cycle

						//update the coordinate of the hotspot
						int	iconx=midx-HOTSPOT_ExitDim;
						iconx-=TOP_LEFT_X;//normalise for renderer
						if	(iconx<0)
							iconx=0;

						int	icony=midy-HOTSPOT_exit_yoff;
						icony-=TOP_LEFT_Y;//normalise for renderer
						if	(icony<0)
							icony=0;

						//draw the icon
						initExitIcon(_exitType, iconx, icony);

						_actionFlashY=icony;

					}

					//mouse on
					_prevMouseOn=true;

					//end here, when button held on something
					return;
				}
				else //-----------------------------------------------------------------------------------------------------------
				{
					//moved off hotspot - hmm, what to do
					//printf("Off");
					_touchId=0;
					_clickedNum=0;
					//remove hotspot icons
					//_system->clearAllIcons(false);

					//fall through to new search, which will close existing hotspot if non found, or open a new one
				}
			}
			else//else if floor
			{
				//floors just count time - we only want clicks(jabs)
				//still touching it?
				if	((itemData->xcood + ((int16)itemData->mouseRelX) < xPos) &&
					(itemData->xcood + ((int16)itemData->mouseRelX) + itemData->mouseSizeX > xPos) &&
					(itemData->ycood + ((int16)itemData->mouseRelY) < yPos) &&
					(itemData->ycood + ((int16)itemData->mouseRelY) + itemData->mouseSizeY > yPos))
				{
					_timeOn++;//one more cycle
					//printf("Floor touch %d\n", _timeOn);
				}
				else
				{
					//printf("Off Floor\n");
					_touchId=0;
					_clickedNum=0;
				}
			}
			//now then, whether on or off a floor, we go on to search other hotspots. Floor is lower priority than any object on it - eg joey, transporter lift, etc.
		}


		//find if we're touching a floor
		int	floor=touchingFloor(xPos,yPos);



		//fetch nearest object to mouse
		if	(itemProx)
		{
			itemData = _skyCompact->fetchCpt(itemProx);
			midx=giveXcood(itemData, itemProx);	//->xcood + ((int16)itemData->mouseRelX) + (itemData->mouseSizeX>>1);
			midy=giveYcood(itemData, itemProx);//itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);
			//calc dist
			d= abs(xPos-midx)+abs(yPos-midy);
			//printf("f=%d, Proxid=%d, _touchId=%d, dist=%d\n", floor, itemProx, _touchId, d);
		}


		//not close enough to real hotspot, and still touching previous floor
		if (floor && (d>=USE_ON_DIST))
			if (floor==_touchId)
			{
			//	printf("skip floor id=%d\n", itemNum);
				//if we skip floor, and dont hit another hotspot, then we quit after this search, because there is no fadeOut on floors, so the system resets the couter
				//floorSkip=true;
				//continue;
				return;	//we're done
			}

		if	((itemProx && d<USE_ON_DIST) || floor)
		{
			// we've hit a new object
			//printf("Hit\n");

			//floor or object?
			if	(itemProx && d<USE_ON_DIST)//d<USE_ON_DIST)
			{
				//record what we're touching
				Logic::_scriptVariables[SPECIAL_ITEM] = itemProx;//put in here now, for mouseOn script
				_touchId=itemProx;
				_touchIdLegacy=itemProx;	//remembered when mouse off
			}
			else
			{
				//record what we're touching
				Logic::_scriptVariables[SPECIAL_ITEM] = floor;//put in here now, for mouseOn script
				_touchId=floor;
				_touchIdLegacy=floor;	//remembered when mouse off
			}

			itemData = _skyCompact->fetchCpt(_touchId);
			//printf("New-touch id=%d status=%d\n", _touchId, (itemData->status & 16));

			//jumping straight from one object to another?
			if (Logic::_scriptVariables[SPECIAL_ITEM])
			{
				//remove hotspot icons
				//printf("Fade");
				_system->clearAllIcons(false);
			}

			//reset hover time to max
			_timeOn=1;
			_clickedNum=0;

			//run previous items get-off, if there was one (gone straight from one object onto another!)
			if (Logic::_scriptVariables[GET_OFF])
				_skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

			//write mouse off script number
			Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

			//run the mouse on script
			if (itemData->mouseOn)
			{
				//disallow sliding back onto floors
				_floorLock=true;

				//reset fade out timer
				_fadeOut=HOTSPOT_FADEOUT;

				_system->setProximityNotAnimate(_nearestProximityIconId);//we want this one remaining one to not animate

				//assume not
				_isExit=false;
				_isFloor=false;

				_skyLogic->mouseScript(itemData->mouseOn, itemData);

				//exit, or hotspot?
				if (_isExit)
				{
					//printf("Is an Exit\n");

					int	iconx=midx-HOTSPOT_ExitDim;
					iconx-=TOP_LEFT_X;//normalise for renderer
					if	(iconx<0)
						iconx=0;

					int	icony=midy-HOTSPOT_exit_yoff;
					icony-=TOP_LEFT_Y;//normalise for renderer
					if	(icony<0)
						icony=0;

					//draw the icon
					initExitIcon(_exitType, iconx, icony);
				}
				else
				{
					int	icony=midy-HOTSPOT_yoff;
					icony-=TOP_LEFT_Y;//normalise for renderer
					if	(icony<0)
						icony=0;

					if	(hasSingleInteractIcon(_touchId))
					{
						//update the coordinate of the hotspot
						int	iconx=midx-HOTSPOT_ExitDim;
						iconx-=TOP_LEFT_X;//normalise for renderer
						if	(iconx<0)
							iconx=0;

						//draw the icons

						_system->setIcon( getInteractIcon(_touchId), iconx+4, icony);

						if	(_touchId==70 || _touchId==69 || _touchId==24633 || _touchId==24634 || _touchId==4119 || _touchId==8210)//stairs on screen 1 - normal object turned into exit - need to hack the button - the rest are either talk-to, which doesnt seem to matter, or look-at, like posters on walls
							Logic::_scriptVariables[BUTTON] = 1;
						else
							Logic::_scriptVariables[BUTTON] = 2;

					}
					else	//2 icons
					{
						//update the coordinate of the hotspot
						int	iconx=midx-HOTSPOT_dim;
						iconx-=TOP_LEFT_X;//normalise for renderer
						if	(iconx<0)
							iconx=0;

						//draw the icons
						_system->setIcon(UI_ICON_LOOK, iconx, icony);
						_system->setIcon(getInteractIcon(_touchId), iconx+HOTSPOT_dim+4, icony);
					}
				}
			}
			else if (!_floorLock)//no mouseOn script, which probably always means this is a floor?
			{
//printf("New floor touch\n");
				//printf(":O\n");
				//set action
				Logic::_scriptVariables[BUTTON] = 1;
				//non graphical hotspots - floors - can interact first click
				_clickedNum=1;
				//reset hover time to max
				_timeOn=1;
				_isFloor=true;
			}
			else
			{
				_touchId=0;	//locked floor
			}

			//mouse on
			_prevMouseOn=true;
			//we're done
			return;
		}
		else
		{
			//not touching anything, force open hotspot to close
			if	(_fadeOut)
			{
				//printf("O");
				_fadeOut=0;
				//_system->clearAllIcons(true);
			}
		}

		//not touching a game object - but what about HU buttons, such as Inv?
		if (!_prevMouseOn && 101!=Logic::_scriptVariables[SCREEN] && Logic::_scriptVariables[LOGIC_LIST_NO]!=24765)
		{
			if (xPos<HOTSPOT_invx && yPos>HOTSPOT_invy)
			{
				//printf("Inventory start\n");
				_system->playUISFX(UI_SOUND_MENU_INTO);
				_skyLogic->Start_inventory();
				_touchId=0;
				_holding=false;
				m_mode=PreInventory;
				_system->clearAllProximityIcons(false);
				_system->clearAllIcons(false);
				return;
			}
			//control panel
			if (xPos<HOTSPOT_optionsx && yPos<HOTSPOT_optionsy)
			{
				CPP_startControlPanel();
				_system->playUISFX(UI_SOUND_MENU_INTO);
				_system->clearAllProximityIcons(false);
				_system->clearAllIcons(false);
				_mouseB=0;
			}
			//help screen
			if (xPos>HOTSPOT_helpx && yPos<HOTSPOT_helpy)
			{
				CPP_startHelpPanel();
				_system->playUISFX(UI_SOUND_MENU_INTO);
				_system->clearAllProximityIcons(false);
				_system->clearAllIcons(false);
				_mouseB=0;
			}
		}

		//mouse on
		_prevMouseOn=true;
	}
	else//not touching screen
	{
		if	(_prevMouseOn)
		{
			//printf("XY= %d,%d\n", xPos,yPos);
			if(!_touchId || _isFloor)
				_system->clearAllProximityIcons();
			else	if (_touchId)
			{
				_system->clearAllProximityIcons();
				//clear all but the one relating to the highlighted hotspot - hmmm
				itemData = _skyCompact->fetchCpt(_touchId);
				midx=giveXcood(itemData,_touchId);
				midy=giveYcood(itemData,_touchId);//itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);
				_system->setProximityIcon(0, midx-TOP_LEFT_X-4, ((midy-TOP_LEFT_Y)-4), 1.0, 0);
				_system->setProximityNotAnimate(0);//we want this one remaining one to not animate
			}
		}

		//let go
		_prevMouseOn=false;
		_floorLock=false;

		//if 2nd or more click on this item, and clicked fast enough, then interact
		if(_timeOn<CLICK_THRESHOLD && _timeOn && _clickedNum)
		{

			//first, some autosaving incase this is a fatal, yes FATAL, interaction
			if (g_engine->canSaveGameStateCurrently())
			{
			//	printf("Autosaving...\n");
				g_engine->saveGameState(0);
			}
			else
			{
		//		printf("Autosave not allowed!\n");
			}

			//an sfx
			Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);

		//	printf("Interact %d %d\n",Logic::_scriptVariables[SPECIAL_ITEM], _touchId);
			_fadeOut=0;	//force getOff script to run also

			//setup action flash
			if	(!_isFloor)
			{
				_actionFlash=true;
				_actionFlashTime=ACTION_FLASH_TIME;
			}
			//set this again, as there's a chance some other random script may have cleared it since we first touched this hotspot
			Logic::_scriptVariables[SPECIAL_ITEM]=_touchId;


			//over anything?
			Compact *item = _skyCompact->fetchCpt(Logic::_scriptVariables[SPECIAL_ITEM]);
			if (item->mouseClick/* && item->cursorText*/)	//not floors
			{	_skyLogic->mouseScript(item->mouseClick, item);
			//	printf("Run\n");
			}
		}

		//reset ready for next stab
		_timeOn=0;
	}

	//mouse is not pressed, or not touching anything

	//count down to fade out and run get-off
	if	(_fadeOut)
	{	_fadeOut--;
		//printf("[%d %d]", _fadeOut, _touchId);
		//update coordinate, so hotspot follows walking megas
		updateHotspotCoordinate(xPos);
	}


	if (!_fadeOut)
	{
		_system->clearAllProximityIcons();

		//reset number of times we clicked on this
		_clickedNum=0;
		_touchId=0;

		//process get-off script, if we were touching, and there is one
		if (Logic::_scriptVariables[SPECIAL_ITEM] != 0)
		{
			//close the hotspot popup
			//printf("Closing hotspot\n");

			//remove hotspot icons
			_system->clearAllIcons();

			Logic::_scriptVariables[SPECIAL_ITEM] = 0;

			//get off
//			printf("GETOFF\n");
			if (Logic::_scriptVariables[GET_OFF])
				_skyLogic->script((uint16)Logic::_scriptVariables[GET_OFF],(uint16)(Logic::_scriptVariables[GET_OFF] >> 16));
//			printf("~GETOFF\n");

			Logic::_scriptVariables[GET_OFF] = 0;
		}
	}
}

//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::initExitIcon(uint32 type, int	iconx, int	icony)//tony31july09
{
	switch(type)
	{
		case MOUSE_LEFT:	{_actionFlashIcon=UI_ICON_LEFT;_actionFlashX=iconx+8;_system->setIcon(UI_ICON_LEFT, iconx+8, icony);break;}
		case MOUSE_RIGHT:	{_actionFlashIcon=UI_ICON_RIGHT;_actionFlashX=iconx+4;_system->setIcon(UI_ICON_RIGHT, iconx+4, icony);break;}
		case MOUSE_UP:		{_actionFlashIcon=UI_ICON_UP;_actionFlashX=iconx+5;_system->setIcon(UI_ICON_UP, iconx+5, icony);break;}
		case MOUSE_DOWN:	{_actionFlashIcon=UI_ICON_DOWN;_actionFlashX=iconx+5;_system->setIcon(UI_ICON_DOWN, iconx+5, icony);break;}
	}
}

//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::updateHotspotCoordinate(uint16 xPos)//tony10july09
{
	Compact *itemData;
	int	midx,midy;

	//printf("U %d", _touchIdLegacy);

	//fetch the compact
	itemData = _skyCompact->fetchCpt(_touchIdLegacy);

	//if not a floor
	if (itemData->mouseOn && !_isExit)
	{


		midx=giveXcood(itemData,_touchIdLegacy);//itemData->xcood + ((int16)itemData->mouseRelX) + (itemData->mouseSizeX>>1);
		midy=giveYcood(itemData,_touchIdLegacy);//itemData->ycood + ((int16)itemData->mouseRelY) + (itemData->mouseSizeY>>1);

		int	icony=midy-HOTSPOT_yoff;
		icony-=TOP_LEFT_Y;//normalise for renderer
		if	(icony<0)
			icony=0;

		if	(hasSingleInteractIcon(_touchIdLegacy))
		{
			//update the coordinate of the hotspot
			int	iconx=midx-HOTSPOT_ExitDim;
			iconx-=TOP_LEFT_X;//normalise for renderer
			if	(iconx<0)
				iconx=0;

			//draw the icons
			_system->setIcon(getInteractIcon(_touchIdLegacy), iconx+4, icony);
		}
		else	//2 icons
		{
			//update the coordinate of the hotspot
			int	iconx=midx-HOTSPOT_dim;
			iconx-=TOP_LEFT_X;//normalise for renderer
			if	(iconx<0)
				iconx=0;

			//draw the icons
			_system->setIcon(UI_ICON_LOOK, iconx, icony);
			_system->setIcon(getInteractIcon(_touchIdLegacy), iconx+HOTSPOT_dim+4, icony);

			//still touching the poped up area
			//which action
			if (xPos<=midx)
				Logic::_scriptVariables[BUTTON] = 2;
			else
				Logic::_scriptVariables[BUTTON] = 1;
		}

	}
}

//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::buttonPressed(uint8 button) {
	_mouseB = button;
}

void Mouse::mouseMoved(uint16 mouseX, uint16 mouseY) {
	_mouseX = mouseX;
	_mouseY = mouseY;

	//default
	_mouseYOff=-4;
	_mouseXOff=-16;

	//printf("mouse moved %d,%d\n", mouseX, mouseY);

	//holding an object, then raise up -
	if (m_mode==InventoryUseOn)
	{
		//just render offset - cursor is still beneath the finger
/*		if	(mouseY>FULL_SCREEN_HEIGHT-32)
		{
			_mouseXOff=HOTSPOT_useon_yoff;
			_mouseYOff=-24;
		}
		else*/
		{
			_mouseYOff=HOTSPOT_useon_yoff;
		}
	}
	//else if holding object within inventory, then just render offset
	else if (m_mode==Inventory && _holding)
	{
		_mouseYOff=HOTSPOT_useon_yoff;
	}
}

//----------------------------------------------------------------------------------------------------------------------------------
uint16	Mouse::givePointerTextX()//tony1may09
{
	//set position, for now
	return TOP_LEFT_X;
}
uint16	Mouse::givePointerTextY()//tony1may09
{
	//set position, for now
	return 0+TOP_LEFT_Y;
}

//----------------------------------------------------------------------------------------------------------------------------------
/*
void Mouse::buttonEngine1()
{
	//checks for clicking on special item
	//"compare the size of this routine to S1 mouse_button"

	if (_mouseB)
	{	//anything pressed?
		Logic::_scriptVariables[BUTTON] = _mouseB;

		if (Logic::_scriptVariables[SPECIAL_ITEM])
		{
			//over anything?
			Compact *item = _skyCompact->fetchCpt(Logic::_scriptVariables[SPECIAL_ITEM]);
			if (item->mouseClick)
				_skyLogic->mouseScript(item->mouseClick, item);
		}
	}
}
*/

void Mouse::resetCursor() {
	spriteMouse(_currentCursor, 0, 0);
}

uint16 Mouse::findMouseCursor(uint32 itemNum) {
	uint8 cnt;
	for (cnt = 0; cnt < NO_MAIN_OBJECTS; cnt++) {
		if (itemNum == _mouseMainObjects[cnt]) {
			return cnt;
		}
	}
	for (cnt = 0; cnt < NO_LINC_OBJECTS; cnt++) {
		if (itemNum == _mouseLincObjects[cnt]) {
			return cnt;
		}
	}
	return 0;
}
//----------------------------------------------------------------------------------------------------------------------------------
//grab/unGrab inv item
void Mouse::fnOpenCloseHand(bool open) {
//	if (open)	printf("Inv Ungrab\n");
//	else		printf("Inv grab\n");

	//let go, back to normal?
	if ((!open) && (!Logic::_scriptVariables[OBJECT_HELD])) {
		spriteMouse(1, 0, 0);
		return;
	}
	uint16 cursor = findMouseCursor(Logic::_scriptVariables[OBJECT_HELD]) << 1;
	if (open)
		cursor++;

	uint32 size = ((DataFileHeader *)_objectMouseData)->s_sp_size;
	uint8 *srcData;
	uint8 *destData;

	srcData = (uint8 *)_objectMouseData + size * cursor + sizeof(DataFileHeader);
	destData = (uint8 *)_miceData + sizeof(DataFileHeader);
	memcpy(destData, srcData, size);
	spriteMouse(0, 5, 5);
}

bool Mouse::wasClicked() {
//printf("was clicked\n");
	if (_logicClick==1) {
		_logicClick++;//stop repeating next time?
		return true;
	} else
		return false;
}

//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::LincInvMouse(uint16 xPos, uint16 yPos)//tony23april09
{
       uint32  *obj_list;
       int     j, num;
       Compact *itemData;
       bool    touched=false;

       if (_mouseB)
               _logicClick++;
       else
               _logicClick=0;


//      printf("Linc Inv\n");

       //get list of compacts in inventory
       obj_list=_skyLogic->Give_inv_list();
       //how many
       num=(int)Logic::_scriptVariables[MENU_LENGTH];

       if (_holding)
       {
               //dragged off of inv? Quit inv mode
               if (xPos<_invX || xPos>_invX+_invW || yPos<_invY || yPos>_invY+_invH)
               {
                       //dragged off of the inv
                       m_mode=InventoryUseOn;
                       //remove inv items from screen/logic processing
                       _skyLogic->KillInventory();
                       //got to tidy the inv item
                       itemData = _skyCompact->fetchCpt(_touchId);
                       itemData->frame--;
                       itemData->getToFlag = 0;

                       //start fresh
                       _touchId=0;

					   //highlight off
					  _system->setDragIconHighlight(false);

                       return;
               }

               //else, wait for release, and see if release on another item
               if (_mouseB)
               {
                       //keep scanning objects to run geton/off
                       for     (j=0;j<num;j++)
                       {
                               //fetch the compact
                               itemData = _skyCompact->fetchCpt(obj_list[j]);

                               if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
                               if (itemData->xcood + ((int16)itemData->mouseRelX) + XWIDTH < xPos) continue;
                               if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
                               if (itemData->ycood + ((int16)itemData->mouseRelY) + YDEPTH < yPos) continue;

                               touched=true;

                               //on previous?
                               if (_hoverId==obj_list[j])      continue;//still on previous, so skip


                               //run previous items get-off, if there was one (gone straight from one object onto another!)
                               if (Logic::_scriptVariables[GET_OFF])
                                       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], _skyCompact->fetchCpt(_hoverId));


                               //write new mouse off script number
                               Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

                               _hoverId=obj_list[j];

                               //new item
							   _skyLogic->Start_inventory(_hoverId);	//highlight touched item

                               //run the mouse on script
                               if (itemData->mouseOn)
                               {
                                     //  printf("MouseOn %d\n", _hoverId);

                                       uint16  tempy=itemData->ycood;
                                       pushInvY(tempy);//save clicked on items y coord, ready for resetting by Logic::fnLookAt
                                       itemData->ycood = 136;
                                       Logic::_scriptVariables[BUTTON] = 3;
                                       //not sure why...
                                       Logic::_scriptVariables[ICON_LIT] = _hoverId;
                                       Logic::_scriptVariables[SPECIAL_ITEM] = _hoverId;
                                       _skyLogic->mouseScript(itemData->mouseOn, itemData);
                                       //and bring back render position
                                       itemData->ycood = tempy;//itemData->invY;
                               }
                       }

                       //if we didn't register any hit then run the get off - we're sitting on blank inventory space
                       if (!touched)
                       {
                               //touching nothing
                               _hoverId=0;
                               if(     Logic::_scriptVariables[GET_OFF])
                               {       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], _skyCompact->fetchCpt(_hoverId));
                                       Logic::_scriptVariables[GET_OFF]=0;
                               }
                       }

                       //we're done
               //      printf("Drag - touch=%d hover=%d\n", _touchId, _hoverId);
                       return;
               }
				else
				{
				//	printf("RELEASE\n");
				}
               //holding, but finger off
         //      printf("Drag - finger off: touch=%d hover=%d\n", _touchId, _hoverId);

               //dropped on another item?

			   //these are the legal destiation objects
				if	(_hoverId==24584 || _hoverId==24630 || _hoverId==24732 || _hoverId==24643)
				{
				   //fetch the compact
				   itemData = _skyCompact->fetchCpt(_touchId);

				   //set button
				   Logic::_scriptVariables[BUTTON] = 3;
				   //record what we're touching
				   Logic::_scriptVariables[SPECIAL_ITEM] = _hoverId;

				   //fight internal logic's impulse to slide back up
				   uint16  tempy=itemData->ycood;
				   itemData->ycood = 136;
				   uint32  menuRef = _lincMenuRef;
				   _skyLogic->mouseScript(itemData->mouseClick, itemData);
				   //and bring back render position
				   itemData->ycood = tempy;//itemData->invY;


				   //if true use-on - not sure why we have to do this!
				   if      (menuRef != _lincMenuRef)
				   {
						   itemData = _skyCompact->fetchCpt(_touchId);
						   itemData->frame--;
						   itemData->getToFlag = 0;
				   }
				   else
				   {
	   				   	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_BLEEP_FAIL);
				   }
				}
				else
				{
					//wont combine
				   itemData = _skyCompact->fetchCpt(_touchId);
				   itemData->frame--;
				   itemData->getToFlag = 0;

				   	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_BLEEP_FAIL);
				}
			   //bring back new inv - have to call again to kick in this frame fix... lol
			   _skyLogic->Start_inventory();
               _holding=false;
               _system->clearDragIcon();//clear the dragging icon

               //cancel cursor
               Logic::_scriptVariables[OBJECT_HELD] = 0;

               return;
       }

       //---------------------------------------------------------------------------------------------------------------------------------------------

       //touching screen, but not an object yet
       if (_mouseB)
               for     (j=0;j<num;j++)
               {
                       //fetch the compact
                       itemData = _skyCompact->fetchCpt(obj_list[j]);

                       if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
                       if (itemData->xcood + ((int16)itemData->mouseRelX) + XWIDTH < xPos) continue;
                       if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
                       if (itemData->ycood + ((int16)itemData->mouseRelY) + YDEPTH < yPos) continue;

                       //record what we're touching
                       Logic::_scriptVariables[SPECIAL_ITEM] = obj_list[j];


                       if (_touchId!=obj_list[j] && !_holding)
                       {
                           //    printf("New touch\n");
                               //run previous items get-off, if there was one (gone straight from one object onto another!)
                               if (Logic::_scriptVariables[GET_OFF])
                                       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);

                               //write mouse off script number
                               Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

                               _touchId=obj_list[j];
                               _hoverId=obj_list[j];
                               //not sure why...
                               Logic::_scriptVariables[ICON_LIT] = obj_list[j];

                               _skyLogic->mouseScript(itemData->mouseOn, itemData);
                               //reset hold counter

                          //init drag
                               _system->setDragIcon(itemData->frame, true);

                               //set button
                               Logic::_scriptVariables[BUTTON] = 2;
                               //record what we're touching
                               Logic::_scriptVariables[SPECIAL_ITEM] = _touchId;
                               Logic::_scriptVariables[ICON_LIT] = 0;
                               Logic::_scriptVariables[OBJECT_HELD] = 0;

                               //fetch the compact
                               itemData = _skyCompact->fetchCpt(_touchId);

                               //fight internal logic's impulse to slide back up

                               uint16  tempy=itemData->ycood;
                               itemData->ycood = 136;

                               //special stuff for quit-linc
                               if      (_touchId==24582)
                               {   printf("QUIT LINC\n");
                                   itemData->frame--;

								   //remove inv items from screen/logic processing
								   _skyLogic->KillInventory();
								    _system->clearDragIcon();
									_skyLogic->mouseScript(itemData->mouseClick, itemData);
 								   return;
                               }
                               _skyLogic->mouseScript(itemData->mouseClick, itemData);
                               //and bring back render position
                               itemData->ycood = tempy;//itemData->invY;

                               if(Logic::_scriptVariables[OBJECT_HELD])
                               {
                                       //just render offset - cursor is still beneath the finger
                                       _mouseYOff=HOTSPOT_useon_yoff;
                                       _holding=true;
                                       _touchIdLegacy=_touchId;
										_skyLogic->Start_inventory(_touchId);	//highlight touched item
                               }


                       }

                       //touching something - we're done
                       return;
               }

       //touching nothing, or mouse off

       if (!_touchId && _mouseB)
               //not touching inv, but touching screen?
               if (xPos<_invX || xPos>_invX+_invW || yPos<_invY || yPos>_invY+_invH)
               {
//                      printf("Closing Inventory\n");
                       //back to game
                       m_mode=MustRelease;
                       //remove inv items from screen/logic processing
                       _skyLogic->KillInventory();
                       return;
               }

/*		if	(_holding && !_mouseB)
		{
			_system->clearDragIcon();//clear the dragging icon
			_skyLogic->Start_inventory();	//highlight touched item
        }
*/
		_holding=false;
       _touchId=0;
       //reset hold counter
       _timeOn=0;
 //  		resetUI();


       if (Logic::_scriptVariables[GET_OFF])
       {
               _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);
               Logic::_scriptVariables[GET_OFF]=0;
       }
}

//----------------------------------------------------------------------------------------------------------------------------------
void Mouse::InvMouse(uint16 xPos, uint16 yPos)//tony23april09
{
       uint32  *obj_list;
       int     j, num;
       Compact *itemData;
       bool    touched=false;

       if (_mouseB)
               _logicClick++;
       else
               _logicClick=0;



       //get list of compacts in inventory
       obj_list=_skyLogic->Give_inv_list();
       //how many
       num=(int)Logic::_scriptVariables[MENU_LENGTH];

       if (_holding)
       {
//		printf("Holding %d,%d %d,%d\n", _invX, _invY, _invW, _invH);
               //dragged off of inv? Quit inv mode
               if (xPos<_invX || xPos>_invX+_invW || yPos<_invY || yPos>_invY+_invH)
               {
				   //dragged off of the inv
				   m_mode=InventoryUseOn;
				   //remove inv items from screen/logic processing
				   _skyLogic->KillInventory();

				   //start fresh
				   _touchId=0;

				   //highlight off
				  _system->setDragIconHighlight(false);

				   return;
               }

               //else, wait for release, and see if release on another item
               if (_mouseB)
               {
                       //keep scanning objects to run geton/off
                       for     (j=0;j<num;j++)
                       {
                               //fetch the compact
                               itemData = _skyCompact->fetchCpt(obj_list[j]);

                               if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
                               if (itemData->xcood + ((int16)itemData->mouseRelX) + XWIDTH < xPos) continue;
                               if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
                               if (itemData->ycood + ((int16)itemData->mouseRelY) + YDEPTH < yPos) continue;

                               touched=true;

                               //on previous?
                               if (_hoverId==obj_list[j])      continue;//still on previous, so skip

                               //new item

                               //run previous items get-off, if there was one (gone straight from one object onto another!)
                               if (Logic::_scriptVariables[GET_OFF])
                                       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], _skyCompact->fetchCpt(_hoverId));


                               //write new mouse off script number
                               Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

                               _hoverId=obj_list[j];

                               //run the mouse on script
                               if (itemData->mouseOn)
                               {
										uint16	tempy=itemData->ycood;
                                       itemData->ycood = 136;
                                       Logic::_scriptVariables[BUTTON] = 2;
                                       //record what we're touching
                                       Logic::_scriptVariables[SPECIAL_ITEM] = _hoverId;
                                       _skyLogic->mouseScript(itemData->mouseOn, itemData);
                                       //and bring back render position
                                       itemData->ycood = tempy;//itemData->invY;
                               }

							   _skyLogic->Start_inventory(_hoverId);	//highlight touched item
                       }

                       //if we didn't register any hit then run the get off - we're sitting on blank inventory space
                       if (!touched)
                       {
                               //touching nothing
                               _hoverId=0;
                               if(     Logic::_scriptVariables[GET_OFF])
                               {       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], _skyCompact->fetchCpt(_hoverId));
                                       Logic::_scriptVariables[GET_OFF]=0;
                               }
                       }

                       //we're done
                       return;
               }


               //dropped on another item

               //fetch the compact
               itemData = _skyCompact->fetchCpt(_touchId);
               //cancel cursor
               Logic::_scriptVariables[OBJECT_HELD] = 0;


               //check for the actual 2 objects that can combine!
               //so if touchid=37 and hoverid=74 etc

				if ( (_touchId==74 && _hoverId==37) || (_touchId==37 && _hoverId==74) )
				{
					//printf("Combine\n");

					Logic::_scriptVariables[83]=0;
					Logic::_scriptVariables[89]=0;
					Logic::_scriptVariables[90]=39;

					//kill existing
					_skyLogic->KillInventory();
					//bring back new inv
					_skyLogic->Start_inventory();

					_touchId=0;
				}
				else //if (_touchId!=_hoverId)
				{
					//else if dropping on another that won't combine
					_touchId=0;
					Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_BLEEP_FAIL);
				}

				_system->clearDragIcon();//clear the dragging icon
			   _skyLogic->Start_inventory();	//clear highlight touched item

               _holding=false;
               return;
       }

       //---------------------------------------------------------------------------------------------------------------------------------------------

       if (_mouseB)
               for     (j=0;j<num;j++)
               {
                       //fetch the compact
                       itemData = _skyCompact->fetchCpt(obj_list[j]);

                       if (itemData->xcood + ((int16)itemData->mouseRelX) > xPos) continue;
                       if (itemData->xcood + ((int16)itemData->mouseRelX) + XWIDTH/*itemData->mouseSizeX*/ < xPos) continue;
                       if (itemData->ycood + ((int16)itemData->mouseRelY) > yPos) continue;
                       if (itemData->ycood + ((int16)itemData->mouseRelY) + YDEPTH/*itemData->mouseSizeY*/ < yPos) continue;

                       //record what we're touching
                       Logic::_scriptVariables[SPECIAL_ITEM] = obj_list[j];

                       if (_touchId!=obj_list[j] && !_holding)
                       {
                               //run previous items get-off, if there was one (gone straight from one object onto another!)
                               if (Logic::_scriptVariables[GET_OFF])
                                       _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);


                               //write mouse off script number
                               Logic::_scriptVariables[GET_OFF] = itemData->mouseOff;

                               _touchId=obj_list[j];
                               _hoverId=obj_list[j];
                               _skyLogic->mouseScript(itemData->mouseOn, itemData);
                               //reset hold counter
                               _timeOn=0;
							   _skyLogic->Start_inventory(_touchId);	//highlight touched item
                       }
                       else
                       {
                               //holding on
                               _timeOn++;

                               if (_timeOn==USEON_THRESHOLD)
                               {
									   //init drag
									   	_system->setDragIcon(itemData->frame, true);

                                       //set to highlighted frame
                                //       itemData->frame++;
                                  //     itemData->getToFlag = 1;

                                       //set icon
                                       Logic::_scriptVariables[OBJECT_HELD] = _touchId;
                                       //instant mouse pointer change
                               //        fnOpenCloseHand(false);

                                       //just render offset - cursor is still beneath the finger
                                       _mouseYOff=HOTSPOT_useon_yoff;

                                       _holding=true;
                               }
                       }

                       //touching something - we're done
                       return;
               }

       //touching nothing, or mouse off

       //were we touching?
       if      (!_mouseB && _touchId && _timeOn<CLICK_THRESHOLD)
       {
               //quick stab, run examine - for this we will use the actual script, as it seems to behave
				//an sfx
				Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);

               //set button
               Logic::_scriptVariables[BUTTON] = 2;
               //record what we're touching
               Logic::_scriptVariables[SPECIAL_ITEM] = _touchId;

               //fetch the compact
               itemData = _skyCompact->fetchCpt(_touchId);

               //fight internal logic's impulse to slide back up
		   		uint16	tempy=itemData->ycood;
				//save clicked on items y coord, ready for resetting by Logic::fnLookAt
				pushInvY(tempy);

               itemData->ycood = 136;
			   m_mode=INV_temp_examine;
               _skyLogic->mouseScript(itemData->mouseClick, itemData);
			   m_mode=Inventory;

			  	_system->clearDragIcon();//clear the dragging icon
				_skyLogic->Start_inventory();	//reset highlight touched item

       }

       if (!_touchId && _mouseB)
               //not touching inv, but touching screen?
               if (xPos<_invX || xPos>_invX+_invW || yPos<_invY || yPos>_invY+_invH)
               {
//                      printf("Closing Inventory\n");
                       //back to game
                       m_mode=MustRelease;
                       //remove inv items from screen/logic processing
                       _skyLogic->KillInventory();
                       return;
               }

       _holding=false;
       _touchId=0;

       if (Logic::_scriptVariables[GET_OFF])
       {
               _skyLogic->mouseScript(Logic::_scriptVariables[GET_OFF], itemData);
               Logic::_scriptVariables[GET_OFF]=0;
       }
}

} // End of namespace Sky
