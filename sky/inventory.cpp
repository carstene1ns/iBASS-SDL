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
/*
 *  inventory.cpp
 *  iBASS
 *
 *  Created by tony warriner on 14/04/2009.
 *
 *	Done simply to seperate code out
 */

#include "sky/logic.h"
#include "sky/compact.h"
#include "sky/text.h"
#include "sky/screen.h"
#include "sky/mouse.h"


namespace Sky {

//----------------------------------------------------------------------------------------------------------------------------------
void	Logic::Start_inventory(uint32	highlightedId)//tony23april2009
{
	//normal gameplay inv
	fnStartMenu(_scriptVariables[FIRST_ICON],highlightedId,0);
}
//----------------------------------------------------------------------------------------------------------------------------------
bool Logic::fnStartMenu(uint32 firstObject, uint32 highlightedId, uint32 c)
{
	/// initialize the top menu bar
	// firstObject is o0 for game menu, k0 for linc

	//normal inv is base object 276 + 30

	Compact *cpt;

//	printf("Init inv menu %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n\n\n\n", firstObject);


	//safety flag
	_liveInv=true;

	if	(firstObject==2048)		_skyMouse->setLincInv(true);
	else if	(firstObject==2168)	_skyMouse->setLincInv(true);
	else if	(firstObject==2288)	_skyMouse->setLincInv(true);
	else						_skyMouse->setLincInv(false);

	_skyMouse->incLincMenuRef();//mental hack to make linc inv work
	_skyMouse->giveSystem()->hideInventory();
	_skyMouse->giveSystem()->clearAllInvIcons();

	uint i;
	firstObject /= 4;

	// (1) FIRST, SET UP THE 2 ARROWS SO THEY APPEAR ON SCREEN

/*	Compact *cpt = _skyCompact->fetchCpt(47);
	cpt->status = ST_MOUSE + ST_FOREGROUND + ST_LOGIC + ST_RECREATE;
	cpt->screen = (uint16)(_scriptVariables[SCREEN] & 0xffff);

	cpt = _skyCompact->fetchCpt(48);
	cpt->status = ST_MOUSE + ST_FOREGROUND + ST_LOGIC + ST_RECREATE;
	cpt->screen = (uint16)(_scriptVariables[SCREEN] & 0xffff);
*/
	// (2) COPY OBJECTS FROM NON-ZERO INVENTORY VARIABLES INTO OBJECT DISPLAY LIST (& COUNT THEM)

	// sort the objects and pad with blanks

	uint32 menuLength = 0;
	for (i = firstObject; i < firstObject + ARRAYSIZE(_objectList); i++)
	{
		//skip unused linc items
		if	(_scriptVariables[i]==24581 ||_scriptVariables[i]==24628)
			continue;

		if (_scriptVariables[i])
			_objectList[menuLength++] = _scriptVariables[i];
	}
	_scriptVariables[MENU_LENGTH] = menuLength;

//	printf("Menu len %d\n\n\n",menuLength);


	// (3) OK, NOW TOP UP THE LIST WITH THE REQUIRED NO. OF BLANK OBJECTS (for min display length 11)

//	uint32 blankID = 51;
//	for (i = menuLength; i < 11; i++)
//		_objectList[i] = blankID++;

	// (4) KILL ID's OF ALL 20 OBJECTS SO UNWANTED ICONS (SCROLLED OFF) DON'T REMAIN ON SCREEN
	// (There should be a better way of doing this - only kill id of 12th item when menu has scrolled right)

//	for (i = 0; i < ARRAYSIZE(_objectList); i++)
//	{
//		if (_objectList[i])
//			(_skyCompact->fetchCpt(_objectList[i]))->status = ST_LOGIC;
//		else break;
//	}

	// (5) NOW FIND OUT WHICH OBJECT TO START THE DISPLAY FROM (depending on scroll offset)

//	if (menuLength < 11) // check we can scroll
//		_scriptVariables[SCROLL_OFFSET] = 0;
//	else if (menuLength < _scriptVariables[SCROLL_OFFSET] + 11)
//		_scriptVariables[SCROLL_OFFSET] = menuLength - 11;

	// (6) AND FINALLY, INITIALIZE THE 11 OBJECTS SO THEY APPEAR ON SCREEEN



	uint16 rollingX = TOP_LEFT_X + XWIDTH;
	int	xx=0;
	uint16 rollingY=236;

	int	didx, didy;
	didx=0;
	didy=1;

	for (i = 0; i < menuLength; i++)
	{
		if (xx==8)
		{
			rollingX = TOP_LEFT_X + XWIDTH;
			xx=0;
			rollingY += YDEPTH;

			didy++;
		}

		cpt = _skyCompact->fetchCpt(_objectList[i]);
		//printf("Init i=%d ob=%d fr=%d\n", i, _objectList[i],cpt->frame);

		cpt->status = ST_MOUSE + ST_FOREGROUND + /*ST_LOGIC +*/ ST_RECREATE;
		cpt->screen = 999;//(uint16)(_scriptVariables[SCREEN] & 0xffff);
		//cpt->screen = (uint16)(_scriptVariables[SCREEN] & 0xffff);

		cpt->xcood = rollingX;
		cpt->ycood = rollingY;//112;

		int	frame=cpt->frame;

		//if LINC then check for odd frames and mask off :O :O
		if	(_objectList[i]>20000)
			if	(!(frame&1))
				frame--;

		_skyMouse->giveSystem()->addInvIcon(frame, rollingX-TOP_LEFT_X, rollingY-TOP_LEFT_Y, (highlightedId==_objectList[i]));

		rollingX += XWIDTH;

		xx++;

		if	(didy==1)
			didx++;


	}

	//tell mouse engine inv dimensions
	_skyMouse->SetInvDims(TOP_LEFT_X + XWIDTH, 236, (didx*XWIDTH),(didy*YDEPTH));

	//init inv bg
	_skyMouse->giveSystem()->showInventory(XWIDTH, (236-TOP_LEFT_Y), XWIDTH+(8*XWIDTH),(236-TOP_LEFT_Y)+(didy*YDEPTH));

	return true;
}
//----------------------------------------------------------------------------------------------------------------------------------
bool Logic::fnLookAt(uint32 a, uint32 b, uint32 c)
{
//this is inventory left-button look-at

//	printf("fnLookAt\n");
	DisplayedText textInfo = _skyText->lowTextManager(a, 240, 0, 248, true);
	Compact *textCpt = _skyCompact->fetchCpt(textInfo.compactNum);
	textCpt->xcood = 168;
	textCpt->ycood = (uint16)c;

	//fetch the clicked on compact
	Compact *clickObject = _skyCompact->fetchCpt(_skyMouse->giveClickedOnId());
	//push back to new inv coordinate, for this render, now logic has run and emerged here

	//get y coord of this inv item back
	clickObject->ycood=_skyMouse->popInvY();

	_skyScreen->recreate();
	_skyScreen->spriteEngine();
	_skyScreen->flip();

	fnNoHuman(0, 0, 0);
	_skyMouse->lockMouse();

	_skyMouse->waitMouseNotPressed(3000);

	_skyMouse->unlockMouse();
	fnAddHuman(0, 0, 0);
	textCpt->status = 0;

	return true;
}
//----------------------------------------------------------------------------------------------------------------------------------
void	Logic::KillInventory()//tony26april09
{
	//shut down displayed inv objects

	Compact *itemData;

//	printf("KillMenu len %d\n\n\n",_scriptVariables[MENU_LENGTH]);


	if	(_liveInv)
	{
		//an sfx
		Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);

		for (size_t j=0;j<_scriptVariables[MENU_LENGTH];j++)
		{
	//		printf(" Kill %d\n",_objectList[j]);
			//fetch the compact
			itemData = _skyCompact->fetchCpt(_objectList[j]);

			itemData->status=0;
		}
	}


	_liveInv=false;

	//kill inv bg
	_skyMouse->giveSystem()->hideInventory();
	_skyMouse->giveSystem()->clearAllInvIcons();

}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------

}//close namespace
