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

#ifndef SKY_MOUSE_H
#define SKY_MOUSE_H


#include "common/scummsys.h"

class OSystem;

namespace Sky {

//max click cycles before interact is not valid upon release
#define	CLICK_THRESHOLD	10
//cycles before inv use-on trigger
#define USEON_THRESHOLD 5
//time till hotspot fades out after stopped touching
#define	HOTSPOT_FADEOUT	36
//hotspot icon size
#define HOTSPOT_dim		36
//exit is just one icon, so half width as straddles centre point
#define HOTSPOT_ExitDim (HOTSPOT_dim>>1)
//closed hotspot radius
#define	HOTSPOT_RADx 8
#define	HOTSPOT_RAD 16

//how far the popup icons sit above the midy
#define	HOTSPOT_yoff 48
//differentiate exits, just incase
#define HOTSPOT_exit_yoff 48

//use on cursor offset
#define HOTSPOT_useon_yoff	(-55)

//inv button (bottom left)
#define HOTSPOT_invx	(TOP_LEFT_X+40)
#define HOTSPOT_invy	(TOP_LEFT_Y+FULL_SCREEN_HEIGHT-35)

//control panel button (top left)
#define HOTSPOT_optionsx	(TOP_LEFT_X+30)
#define HOTSPOT_optionsy	(TOP_LEFT_Y+30)

//help button (top right)
#define HOTSPOT_helpx	(TOP_LEFT_X+FULL_SCREEN_WIDTH-30)
#define HOTSPOT_helpy	(TOP_LEFT_Y+30)

//glow proximity
#define GLOW_DIST 150
//drag to use on distance
#define	USE_ON_DIST	40

//fix super deep exits
#define	TWEEKY_EXIT_ADJUST	(FULL_SCREEN_HEIGHT+TOP_LEFT_Y-40);


//inv item sizes
#define	XWIDTH 32
#define YDEPTH 32

//action flash
#define	ACTION_FLASH_TIME	7

class Disk;
class Logic;
class SkyCompact;

class Mouse {

public:

	Mouse(OSystem *system, Disk *skyDisk, SkyCompact *skyCompact);
	~Mouse(void);

	void mouseEngine();
	void replaceMouseCursors(uint16 fileNo);
	bool fnAddHuman(void);
	void fnSaveCoods(void);
	void fnOpenCloseHand(bool open);
	uint16 findMouseCursor(uint32 itemNum);
	void lockMouse(void);
	void unlockMouse(void);
	void restoreMouseData(uint16 frameNum);
	void drawNewMouse(void);
	void spriteMouse(uint16 frameNum, uint8 mouseX, uint8 mouseY);
	void useLogicInstance(Logic *skyLogic) { _skyLogic = skyLogic; };
	void buttonPressed(uint8 button);
	void mouseMoved(uint16 mouseX, uint16 mouseY);
	void waitMouseNotPressed(int minDelay = 0);
	uint16 giveMouseX(void) { return _mouseX; };
	uint16 giveMouseY(void) { return _mouseY; };
	uint16 giveCurrentMouseType(void) { return _currentCursor; };
	bool wasClicked(void);
//	void logicClick(void) { _logicClick = true; };
	void resetCursor();
	uint16 giveClickedOnId(){return _touchId;}//tony24april09

	void SetInvDims(uint16 x,uint16 y,uint16 w,uint16 h){_invX=x;_invY=y;_invW=w;_invH=h;}//tony26april09
	void setTextChooserMode(){m_mode=Text_chooser;}//tony29april09
	bool isScreenTouched(){return _mouseB ? true : false;}//tony1may09
	uint16	givePointerTextX();//tony1may09
	uint16	givePointerTextY();//tony1may09
	int16	giveMouseYOff(){return _mouseYOff;}//tony1may09
	int16	giveMouseXOff(){return _mouseXOff;}//tony31july09
	bool	IsUILive();//tony7may09
	bool	IsInv(){return (m_mode==Inventory||m_mode==InventoryUseOn||m_mode==PreInventory) ? true : false;}//tony21may09
	bool	IsTextChooser(){return (m_mode==Text_chooser) ? true : false;}//tony21may09
	void	KillUI();//tony11june09
	void	setHotspotIsExit(uint32 frameNum){_isExit=true;_exitType=frameNum;}//tony13june09
	UIIcon	getInteractIcon(uint32	id);//tony9july09
	bool	hasSingleInteractIcon(uint32	id);//tony9july09
	void	updateHotspotCoordinate(uint16 xPos);//tony10july09
	int		doProximityHighlights(uint16 xPos, uint16 yPos);//tony10july09
	uint16	giveXcood(Compact *itemData, uint32 id);//tony12july09
	uint16	giveYcood(Compact *itemData, uint32 id);//tony27july09
	void	setLincInv(bool	inv){_isLincInv=inv;}//tony15july09
	bool	isLincInv(){return _isLincInv;}//tony15july09
	void	incLincMenuRef(){_lincMenuRef++;}//tony15july09
	void	pushInvY(uint16 y){_invYCoord=y;}//tony17july09
	uint16	popInvY(){return _invYCoord;}//tony17july09
	void	resetUI();//tony21july09
	OSystem *giveSystem(){return	_system;}//Grrr27july09
	int		touchingFloor(uint16 xPos, uint16 yPos);//tony3aug09

protected:

	void pointerEngine(uint16 xPos, uint16 yPos);
	void InvMouse(uint16 xPos, uint16 yPos);//tony23april09
	void LincInvMouse(uint16 xPos, uint16 yPos);//tony15july09
	void InvUseOn(uint16 xPos, uint16 yPos);//tony26april09
	void TextChooser(uint16 xPos, uint16 yPos);//tony29april09
	void initExitIcon(uint32 type, int	iconx, int	icony);//tony31july09

	uint16 _logicClick;

	uint16 _mouseB;	//mouse button
	uint16 _mouseX;	//actual mouse coordinates
	uint16 _mouseY;

	int16	_mouseXOff;
	int16	_mouseYOff;
	uint16	_timeOn;//how long have we held on this item
	uint16	_clickedNum;//remmebers what we clicked last
	uint16	_fadeOut;//how long before current hotspot fades out when let go
	bool	_prevMouseOn;//touching yes/no last cycle
	uint16	_touchId;
	uint16	_touchIdLegacy;
	uint16	_hoverId;	//inv drag over inv
	bool	_holding;
	bool	_isExit;	//cur hotspot an exit?
	uint32	_exitType;	//what type of exit
	bool	_isFloor;
	bool	_isLincInv;	//current inventory is in LINC which works weirdly differently
	uint32	_lincMenuRef;	//used to check if a linc inv menu restarted the inv
	uint16	_invYCoord;	//store inv item y coords ready for patching back in
	int		_nearestProximityIconId;
	bool	_floorLock;//stop moving off hotpots onto floors then releasing to get an interaction

	uint16	_invX;//inventory bounds x
	uint16	_invY;//inventory bounds y
	uint16	_invW;//inventory bounds w
	uint16	_invH;//inventory bounds h

	bool	_actionFlash;	//clicked on action icon flasher
	int		_actionFlashTime;//counts down
	int		_actionFlashIcon;
	int		_actionFlashX;
	int		_actionFlashY;

	uint16 _currentCursor;

	byte *_miceData;	//address of mouse sprites
	byte *_objectMouseData;	//address of object mouse sprites

	static uint32 _mouseMainObjects[24];
	static uint32 _mouseLincObjects[21];

	OSystem *_system;
	Disk *_skyDisk;
	Logic *_skyLogic;
	SkyCompact *_skyCompact;

	enum
	{
		Gameplay,
		PreInventory,
		Inventory,
		INV_temp_examine,
		InventoryUseOn,
		Text_chooser,
		MustRelease,
		Alert_to_game,//new game alert box
	} m_mode;
};

} // End of namespace Sky

#endif //SKYMOUSE_H
