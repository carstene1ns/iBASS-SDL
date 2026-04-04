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

#include "common/system.h"
#include "common/file.h"
#include "sky/compact.h"
#include "sky/saveload.h"
#include "sky/disk.h"
#include "sky/logic.h"
#include "sky/music.h"
#include "sky/mouse.h"
#include "sky/screen.h"
#include "sky/sky.h"
#include "sky/skydefs.h"
#include "sky/sound.h"
#include "sky/struc.h"
#include "sky/text.h"
#include "sky/compact.h"

namespace Sky {

	extern "C"	bool	isUSA();//tony28july09
	extern "C"	int	returnIPhoneLanguage();//tony28july09

//----------------------------------------------------------------------------------------------------------------------------------

SaveLoad::SaveLoad(Screen *screen, Disk *disk, Mouse *mouse, Text *text, Music *music, Logic *logic, Sound *sound, SkyCompact *skyCompact, OSystem *system) {
        _skyScreen = screen;
        _skyDisk = disk;
        _skyMouse = mouse;
        _skyText = text;
        _skyMusic = music;
        _skyLogic = logic;
        _skySound = sound;
        _skyCompact = skyCompact;
        _system = system;

		//save game index data
		initSlots();
		//volumes
		initExtraData();
}
//----------------------------------------------------------------------------------------------------------------------------------
SaveLoad::~SaveLoad() {
}
//----------------------------------------------------------------------------------------------------------------------------------
/*
bool SaveLoad::autoSaveExists() {
	bool test = false;
	char fName[20];
	strcpy(fName, "SKY-VM.000");

	SaveFile f(fName, "rb");
	if (!f.isOpen()) {
		test = true;
	}
	return test;
}
*/
//----------------------------------------------------------------------------------------------------------------------------------
//volumes
void	SaveLoad::initExtraData()//tony14july09
{
	char fName[20];
	strcpy(fName, DATAFILENAME);
	SaveFile file(fName, "rb");
	if (file.isOpen())
	{
		//found file

		Sky::g_engine->setHasInitFile(true);

	//	printf("Restoring volumes\n");

		float	vol;
		file.read(&vol, sizeof(float));
		_system->setMusicVolume(vol);
		file.read(&vol, sizeof(float));
		_system->setSpeechVolume(vol);
		file.read(&vol, sizeof(float));
		_system->setSFXVolume(vol);

		//text/audio
		file.read(&SkyEngine::_systemVars.systemFlags, sizeof(uint32));
		file.read(&SkyEngine::_systemVars.language, sizeof(uint16));

	//	printf("READ lang==%d\n", SkyEngine::_systemVars.language);

		//twitter
		file.read(&_hasTwitterUsername, sizeof(bool));
		file.read(&_hasTwitterPassword, sizeof(bool));
		file.read(giveTwitterUsername(), (sizeof(char)*TWITTER_username_len));
		file.read(giveTwitterPassword(), (sizeof(char)*TWITTER_password_len));

//		if	(_hasTwitterUsername)
//			printf("twitter username [%s]\n", giveTwitterUsername());
//		else
//			printf("No twitter username\n");


//		if	(_hasTwitterPassword)
//			printf("twitter password [%s]\n", giveTwitterPassword());
//		else
//			printf("No twitter password\n");

		file.read(&_twitterOn, sizeof(bool));



	}
	else
	{
//		printf("initExtraData failed to open %s\n",&fName[0]);

		Sky::g_engine->setHasInitFile(false);

		_system->setMusicVolume(0.3);
		_system->setSpeechVolume(0.5);
		_system->setSFXVolume(0.2);
		//twitter
		_hasTwitterUsername=false;
		_hasTwitterPassword=false;
		_twitterOn=true;//starts ON


		//get the language from machine settings
		SkyEngine::_systemVars.language=returnIPhoneLanguage();

		//special override
		if	(isUSA())
			SkyEngine::_systemVars.language=SKY_USA;

	//	printf("systemFlags== %x\n", (SkyEngine::_systemVars.systemFlags&TEXT_FLAG_MASK));

	}
}
//----------------------------------------------------------------------------------------------------------------------------------
void	SaveLoad::writeExtraData()//tony14july09
{
	char fName[20];
	strcpy(fName, DATAFILENAME);
	SaveFile file(fName, "wb");
	if (file.isOpen())
	{
		//found file
//		printf("Writing volume data\n");

		float	vol;
		vol = Sky::g_engine->giveSystem()->getMusicVolume();
		file.write(&vol, sizeof(float));

		vol=Sky::g_engine->giveSystem()->getSpeechVolume();
		file.write(&vol, sizeof(float));

		vol=Sky::g_engine->giveSystem()->getSFXVolume();
		file.write(&vol, sizeof(float));

		//text/audio flags
		file.write(&SkyEngine::_systemVars.systemFlags, sizeof(uint32));
		file.write(&SkyEngine::_systemVars.language, sizeof(uint16));

	//	printf("WRITE lang==%d\n", SkyEngine::_systemVars.language);

		//twitter
		file.write(&_hasTwitterUsername, sizeof(bool));
		file.write(&_hasTwitterPassword, sizeof(bool));
		file.write(giveTwitterUsername(), (sizeof(char)*TWITTER_username_len));
		file.write(giveTwitterPassword(), (sizeof(char)*TWITTER_password_len));
		file.write(&_twitterOn, sizeof(bool));


		file.flush();
	}
	else
	{
//		printf("writeExtraData failed to open %s\n",&fName[0]);
	}
}
//----------------------------------------------------------------------------------------------------------------------------------

void SaveLoad::saveHints(uint16 selectedGame)//tony14july09
{
	char fName[20];
	sprintf(fName,"SKY-HINTS.%03d", selectedGame);

	SaveFile slots(fName, "wb");
	if (!slots.isOpen())
	{
		printf("Failed to write [%s]\n", fName);
		return;
	}
	//save
	slots.write(Sky::g_engine->giveHintData(), (sizeof(bool)*TOTAL_hint_answers));
	slots.write(Sky::g_engine->giveSeenScreenData(), (sizeof(bool)*TOTAL_screens));
	slots.write(Sky::g_engine->giveTwitterActions(), (sizeof(bool)*TWITTER_total_actions));
	slots.flush();

//	printf("Wrote [%s]\n", fName);

/*	bool	*a=Sky::g_engine->giveTwitterActions();
	for (int j=0;j<TWITTER_total_actions;j++)
	{
		if	(*(a++))
			printf("TWEET[%d]=true\n", j);
		else
			printf("TWEET[%d]=false\n", j);
	}
	*/
}
//----------------------------------------------------------------------------------------------------------------------------------
void SaveLoad::restoreHints(uint16 selectedGame)//tony14july09
{
	char fName[20];
	sprintf(fName,"SKY-HINTS.%03d", selectedGame);

	SaveFile slots(fName, "rb");
	if (!slots.isOpen())
	{
		printf("Failed to open [%s]\n", fName);
		return;
	}
	//restore
	slots.read(Sky::g_engine->giveHintData(), (sizeof(bool)*TOTAL_hint_answers));
	slots.read(Sky::g_engine->giveSeenScreenData(), (sizeof(bool)*TOTAL_screens));
	slots.read(Sky::g_engine->giveTwitterActions(), (sizeof(bool)*TWITTER_total_actions));

//	printf("Read [%s]\n", fName);

/*	bool	*a=Sky::g_engine->giveTwitterActions();

	for (int j=0;j<TWITTER_total_actions;j++)
	{
		if	(*(a++))
			printf("TWEET[%d]=true\n", j);
		else
			printf("TWEET[%d]=false\n", j);
	}
*/
}
//----------------------------------------------------------------------------------------------------------------------------------
void	SaveLoad::initSlots()//tony3june09
{
	char fName[20];
	strcpy(fName, "SAVESLOTS.ADW");
	SaveFile slots(fName, "rb");
	if (!slots.isOpen())
	{
	//	printf("Didn't find [%s]\n", fName);

		//for start menu
		_savesExist=false;

		//reset them
		for(int j=0;j<MAX_saves;j++)
			mSlots[j].m_used=false;
	}
	else
	{
		//load previous data
		slots.read(&mSlots[0], (sizeof(_saveSlot)*MAX_saves));
		slots.close();

		//for start menu
		_savesExist=true;

	//	printf("Save games found\n");

	}

	//auto
	strcpy(fName, "SKY-VM.000");
	SaveFile autof(fName, "rb");
	if (autof.isOpen())
	{
	//	printf("AUTOSave game found\n");
		_autoSaveExists=true;
		autof.close();
	}
	else
		_autoSaveExists=false;

}
//----------------------------------------------------------------------------------------------------------------------------------
void	SaveLoad::writeSlots()//tony4june09
{
	char fName[20];
	strcpy(fName, "SAVESLOTS.ADW");
	SaveFile slots(fName, "wb");
	if (!slots.isOpen())
	{
		printf("Failed to write [%s]\n", fName);
		return;
	}
	//save
	slots.write(&mSlots[0], (sizeof(_saveSlot)*MAX_saves));
	slots.flush();
	slots.close();

//	printf("Wrote [%s]\n", fName);
}
//----------------------------------------------------------------------------------------------------------------------------------
bool	SaveLoad::slotUsed(int slot)//tony3june09
{
	return	mSlots[slot].m_used;
}
//----------------------------------------------------------------------------------------------------------------------------------
char	*SaveLoad::giveSlotAscii(int slot)//tony3june09
{
//	printf("Getting slot %d [%s]\n", slot, &mSlots[slot].m_ascii[0]);

	return	&mSlots[slot].m_ascii[0];
}


//----------------------------------------------------------------------------------------------------------------------------------
void	SaveLoad::setSlotAscii(int slot, const char *ascii)//tony4june09
{
//	printf("Setting slot %d to [%s] len=%d\n", slot, ascii, sizeof(ascii));
	mSlots[slot].m_used=true;
	strcpy(&mSlots[slot].m_ascii[0], ascii);
	//save slot - they're the future!
	writeSlots();
}



//----------------------------------------------------------------------------------------------------------------------------------
bool SaveLoad::loadSaveAllowed() {
	if (SkyEngine::_systemVars.systemFlags & SF_CHOOSING)
		return false; // texts get lost during load/save, so don't allow it during choosing
	if (Logic::_scriptVariables[SCREEN] >= 101)
		return false; // same problem with LINC terminals
	if ((Logic::_scriptVariables[SCREEN] >= 82) &&
		(Logic::_scriptVariables[SCREEN] != 85) &&
		(Logic::_scriptVariables[SCREEN] < 90))
		return false; // don't allow saving in final rooms

	return true;
}
//----------------------------------------------------------------------------------------------------------------------------------
bool SaveLoad::hasTwitterUsername()//tony6aug09
{
	return _hasTwitterUsername;
}
char	*SaveLoad::giveTwitterUsername()//tony6aug09
{
	return	&_twitterUsername[0];
}
void	SaveLoad::setTwitterUsername(const char *ascii)//tony6aug09
{
	strcpy(&_twitterUsername[0], ascii);
	_hasTwitterUsername=true;
}
//--------------------
bool SaveLoad::hasTwitterPassword()//tony6aug09
{
	return _hasTwitterPassword;
}
char	*SaveLoad::giveTwitterPassword()//tony6aug09
{
	return	&_twitterPassword[0];
}
void	SaveLoad::setTwitterPassword(const char *ascii)//tony6aug09
{
	strcpy(&_twitterPassword[0], ascii);
	_hasTwitterPassword=true;
}
//--------------------
//----------------------------------------------------------------------------------------------------------------------------------


/*
void SaveLoad::doAutoSave() {
	char fName[20];
	strcpy(fName, "SKY-VM.000");

	SaveFile outf(fName, "wb");
	if (!outf.isOpen()) {
		//displayMessage(0, "Unable to create autosave file '%s'. (%s)", fName, _saveFileMan->popErrorDesc().c_str());
		printf("Unable to create autosave file '%s'!\n", fName);
		return;
	}
	uint8 *saveData = (uint8 *)malloc(0x20000);
	uint32 fSize = prepareSaveData(saveData);

	outf.write(saveData, fSize);
	outf.flush(); //outf->finalize();

	if (outf.ioFailed()) {
		//displayMessage(0, "Unable to write autosave file '%s'. Disk full?", fName, _saveFileMan->popErrorDesc().c_str());
		printf("Unable to write autosave file '%s'!\n", fName);
	}

	free(saveData);


	//hints
	saveHints(0);
}
*/
//----------------------------------------------------------------------------------------------------------------------------------

bool SaveLoad::saveGameToFile(uint16 selectedGame) {
	char fName[20];
	sprintf(fName,"SKY-VM.%03d", selectedGame);

//	printf("Going to save [%s]\n", fName);

	SaveFile outf(fName, "wb");
	if (!outf.isOpen())
		return false;

	uint8 *saveData = (uint8 *)malloc(0x20000);
	uint32 fSize = prepareSaveData(saveData);

	uint32 writeRes = outf.write(saveData, fSize);
	outf.flush(); //outf->finalize();
	if (outf.ioFailed())
		writeRes = 0;
	free(saveData);

	//hints
	saveHints(selectedGame);

	return (writeRes == fSize);
}
//----------------------------------------------------------------------------------------------------------------------------------

#define STOSD(ptr, val) { *(uint32 *)(ptr) = TO_LE_32(val); (ptr) += 4; }
#define STOSW(ptr, val) { *(uint16 *)(ptr) = TO_LE_16(val); (ptr) += 2; }

uint32 SaveLoad::prepareSaveData(uint8 *destBuf) {
	uint32 cnt;
	memset(destBuf, 0, 4); // space for data size
	uint8 *destPos = destBuf + 4;
	STOSD(destPos, SAVE_FILE_REVISION);
	STOSD(destPos, SkyEngine::_systemVars.gameVersion);

	STOSW(destPos, _skySound->_saveSounds[0]);
	STOSW(destPos, _skySound->_saveSounds[1]);

	STOSD(destPos, _skyMusic->giveCurrentMusic());
	STOSD(destPos, _skyText->giveCurrentCharSet());
	STOSD(destPos, _skyMouse->giveCurrentMouseType());
	STOSD(destPos, SkyEngine::_systemVars.currentPalette);
	for (cnt = 0; cnt < 838; cnt++)
		STOSD(destPos, Logic::_scriptVariables[cnt]);
	uint32 *loadedFilesList = _skyDisk->giveLoadedFilesList();

	for (cnt = 0; cnt < 60; cnt++)
		STOSD(destPos, loadedFilesList[cnt]);

	for (cnt = 0; cnt < _skyCompact->_numSaveIds; cnt++) {
		uint16 numElems;
		uint16 *rawCpt = (uint16*)_skyCompact->fetchCptInfo(_skyCompact->_saveIds[cnt], &numElems, NULL, NULL);
		for (uint16 elemCnt = 0; elemCnt < numElems; elemCnt++)
			STOSW(destPos, rawCpt[elemCnt]);
	}

	*(uint32 *)destBuf = TO_LE_32(destPos - destBuf); // save size
	return destPos - destBuf;
}

#undef STOSD
#undef STOSW

#define LODSD(strPtr, val) { val = READ_LE_UINT32(strPtr); (strPtr) += 4; }
#define LODSW(strPtr, val) { val = READ_LE_UINT16(strPtr); (strPtr) += 2; }

void SaveLoad::importOldMegaSet(uint8 **srcPos, MegaSet *mega) {
	LODSW(*srcPos, mega->gridWidth);
	LODSW(*srcPos, mega->colOffset);
	LODSW(*srcPos, mega->colWidth);
	LODSW(*srcPos, mega->lastChr);
}

void SaveLoad::importOldCompact(Compact* destCpt, uint8 **srcPos, uint16 numElems, uint16 type, char *name) {
	uint16 saveType;
	LODSW(*srcPos, saveType);
	if ((saveType & (SAVE_EXT | SAVE_TURNP)) && (numElems < 54))
		error("Cpt %s: Savedata doesn't match cpt size (%d)!\n", name, numElems);
	if ((saveType & SAVE_MEGA0) && (numElems < 54 + 13))
		error("Cpt %s: Savedata doesn't match cpt size (%d)!\n", name, numElems);
	if ((saveType & SAVE_MEGA1) && (numElems < 54 + 13 + 13))
		error("Cpt %s: Savedata doesn't match cpt size (%d)!\n", name, numElems);
	if ((saveType & SAVE_MEGA2) && (numElems < 54 + 13 + 13 + 13))
		error("Cpt %s: Savedata doesn't match cpt size (%d)!\n", name, numElems);
	if ((saveType & SAVE_MEGA3) && (numElems < 54 + 13 + 13 + 13))
		error("Cpt %s: Savedata doesn't match cpt size (%d)!\n", name, numElems);
	if (saveType & SAVE_GRAFX) {
		uint16 graphType, target, pos;
		LODSW(*srcPos, graphType);
		LODSW(*srcPos, target);
		LODSW(*srcPos, pos);
		// convert to new compact system..
		destCpt->grafixProgPos = pos;
		if (graphType == OG_PTR_NULL)
			destCpt->grafixProgId = 0;
		else if (graphType == OG_AUTOROUTE)
			destCpt->grafixProgId = destCpt->animScratchId;
		else if (graphType == OG_COMPACT)
			destCpt->grafixProgId = target;
		else if (graphType == OG_TALKTABLE)
			destCpt->grafixProgId = ((uint16*)_skyCompact->fetchCpt(CPT_TALK_TABLE_LIST))[target];
		else if (graphType == OG_COMPACTELEM)
			destCpt->grafixProgId = *(uint16*)_skyCompact->getCompactElem(destCpt, target);
		else
			error("Illegal GrafixProg type encountered for compact %s", name);
	}
	if (saveType & SAVE_TURNP) {
		// basically impossible to import these. simply set it to end-of-turn and hope the script
		// will take care of it.
		destCpt->turnProgId = 0x13B;
		destCpt->turnProgPos = 1;
		uint16 turnSkipLen;
		LODSW(*srcPos, turnSkipLen);
		*srcPos += 2 * turnSkipLen;
	} else if (numElems >= 49) {
		destCpt->turnProgId = 0;
		destCpt->turnProgPos = 0;
	}
	LODSW(*srcPos, destCpt->logic);
	LODSW(*srcPos, destCpt->status);
	LODSW(*srcPos, destCpt->sync);
	LODSW(*srcPos, destCpt->screen);
	LODSW(*srcPos, destCpt->place);
	// getToTable
	LODSW(*srcPos, destCpt->xcood);
	LODSW(*srcPos, destCpt->ycood);
	LODSW(*srcPos, destCpt->frame);
	LODSW(*srcPos, destCpt->cursorText);
	LODSW(*srcPos, destCpt->mouseOn);
	LODSW(*srcPos, destCpt->mouseOff);
	LODSW(*srcPos, destCpt->mouseClick);
	LODSW(*srcPos, destCpt->mouseRelX);
	LODSW(*srcPos, destCpt->mouseRelY);
	LODSW(*srcPos, destCpt->mouseSizeX);
	LODSW(*srcPos, destCpt->mouseSizeY);
	LODSW(*srcPos, destCpt->actionScript);
	LODSW(*srcPos, destCpt->upFlag);
	LODSW(*srcPos, destCpt->downFlag);
	LODSW(*srcPos, destCpt->getToFlag);
	LODSW(*srcPos, destCpt->flag);
	LODSW(*srcPos, destCpt->mood);
	// grafixProg
	LODSW(*srcPos, destCpt->offset);
	LODSW(*srcPos, destCpt->mode);
	LODSW(*srcPos, destCpt->baseSub);
	LODSW(*srcPos, destCpt->baseSub_off);
	if (saveType & SAVE_EXT) {
		LODSW(*srcPos, destCpt->actionSub);
		LODSW(*srcPos, destCpt->actionSub_off);
		LODSW(*srcPos, destCpt->getToSub);
		LODSW(*srcPos, destCpt->getToSub_off);
		LODSW(*srcPos, destCpt->extraSub);
		LODSW(*srcPos, destCpt->extraSub_off);
		LODSW(*srcPos, destCpt->dir);
		LODSW(*srcPos, destCpt->stopScript);
		LODSW(*srcPos, destCpt->miniBump);
		LODSW(*srcPos, destCpt->leaving);
		LODSW(*srcPos, destCpt->atWatch);
		LODSW(*srcPos, destCpt->atWas);
		LODSW(*srcPos, destCpt->alt);
		LODSW(*srcPos, destCpt->request);
		LODSW(*srcPos, destCpt->spWidth_xx);
		LODSW(*srcPos, destCpt->spColour);
		LODSW(*srcPos, destCpt->spTextId);
		LODSW(*srcPos, destCpt->spTime);
		LODSW(*srcPos, destCpt->arAnimIndex);
		// turnProg
		LODSW(*srcPos, destCpt->waitingFor);
		LODSW(*srcPos, destCpt->arTargetX);
		LODSW(*srcPos, destCpt->arTargetY);
		// animScratch
		LODSW(*srcPos, destCpt->megaSet);
		if (saveType & SAVE_MEGA0)
			importOldMegaSet(srcPos, &(destCpt->megaSet0));
		if (saveType & SAVE_MEGA1)
			importOldMegaSet(srcPos, &(destCpt->megaSet1));
		if (saveType & SAVE_MEGA2)
			importOldMegaSet(srcPos, &(destCpt->megaSet2));
		if (saveType & SAVE_MEGA3)
			importOldMegaSet(srcPos, &(destCpt->megaSet3));
	}
}

uint16 SaveLoad::parseSaveData(uint8 *srcBuf) {
	uint32 reloadList[60];
	uint32 cnt;
	uint8 *srcPos = srcBuf;
	uint32 size;
	uint32 saveRev;
	uint32 gameVersion;
	LODSD(srcPos, size);
	LODSD(srcPos, saveRev);
	if (saveRev > SAVE_FILE_REVISION) {
		//displayMessage(0, "Unknown save file revision (%d)", saveRev);
		printf("Unknown save file revision (%d)\n", saveRev);
		return RESTORE_FAILED;
	} else if (saveRev < OLD_SAVEGAME_TYPE) {
		//displayMessage(0, "This savegame version is unsupported.");
		printf("Savegame version unsupported.\n");
		return RESTORE_FAILED;
	}
	LODSD(srcPos, gameVersion);
	if (gameVersion != SkyEngine::_systemVars.gameVersion) {
		if ((!SkyEngine::isCDVersion()) || (gameVersion < 365)) { // cd versions are compatible
			printf("Savegame version differs! (%d != %d)\n", gameVersion, SkyEngine::_systemVars.gameVersion);
			//displayMessage(NULL, "This savegame was created by\n"
			//	"Beneath a Steel Sky v0.0%03d\n"
			//	"It cannot be loaded by this version (v0.0%3d)",
			//	gameVersion, SkyEngine::_systemVars.gameVersion);
			return RESTORE_FAILED;
		}
	}
	SkyEngine::_systemVars.systemFlags |= SF_GAME_RESTORED;

	LODSW(srcPos, _skySound->_saveSounds[0]);
	LODSW(srcPos, _skySound->_saveSounds[1]);
	_skySound->restoreSfx();

	uint32 music, mouseType, palette;
	uint32 savedCharSet;
	LODSD(srcPos, music);
	LODSD(srcPos, savedCharSet);
	LODSD(srcPos, mouseType);
	LODSD(srcPos, palette);

	_skyLogic->parseSaveData((uint32*)srcPos);
	srcPos += NUM_SKY_SCRIPTVARS * sizeof(uint32);

	for (cnt = 0; cnt < 60; cnt++)
		LODSD(srcPos, reloadList[cnt]);

	if (saveRev == SAVE_FILE_REVISION) {
		for (cnt = 0; cnt < _skyCompact->_numSaveIds; cnt++) {
			uint16 numElems;
			uint16 *rawCpt = (uint16*)_skyCompact->fetchCptInfo(_skyCompact->_saveIds[cnt], &numElems, NULL, NULL);
			for (uint16 elemCnt = 0; elemCnt < numElems; elemCnt++)
				LODSW(srcPos, rawCpt[elemCnt]);
		}
	} else {	// import old savegame revision
		for (cnt = 0; cnt < (uint32)(_skyCompact->_numSaveIds - 2); cnt++) {
			uint16 numElems;
			uint16 type;
			char name[128];
			uint16 *rawCpt = (uint16*)_skyCompact->fetchCptInfo(_skyCompact->_saveIds[cnt], &numElems, &type, name);
			if (type == COMPACT) {
				importOldCompact((Compact*)rawCpt, &srcPos, numElems, type, name);
			} else if (type == ROUTEBUF) {
				assert(numElems == 32);
				for (uint32 elemCnt = 0; elemCnt < numElems; elemCnt++)
					LODSW(srcPos, rawCpt[elemCnt]);
			}
		}
		uint16 *rawCpt = (uint16*)_skyCompact->fetchCpt(0xBF);
		for (cnt = 0; cnt < 3; cnt++)
			LODSW(srcPos, rawCpt[cnt]);
		rawCpt = (uint16*)_skyCompact->fetchCpt(0xC2);
		for (cnt = 0; cnt < 13; cnt++)
			LODSW(srcPos, rawCpt[cnt]);
	}

	/* WORKAROUND:  Since the 'lazer_gun' compact is not saved, it will be in a bad state after you load
				 a save after dying in the first screen (laser animation + sound will not play).
				 Since we'd rather not mess about with SKY.CPT to add this compact ID, just override this
				 specific compact with the known default values. */
	const uint16 lazer_gun_cpt[29] = { 0xF, 0x48, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1024, 0xC12, };
	uint16 numElems;
	uint16 *rawCpt = (uint16*)_skyCompact->fetchCptInfo(ID_LAZER_GUN, &numElems, NULL, NULL);
	if (rawCpt && numElems == ARRAYSIZE(lazer_gun_cpt)) {	//just a very paranoid sanity check...
		for (uint16 i = 0; i < ARRAYSIZE(lazer_gun_cpt); i++) {
			rawCpt[i] = lazer_gun_cpt[i];
		}
	}


	// make sure all text compacts are off
	for (cnt = CPT_TEXT_1; cnt <= CPT_TEXT_11; cnt++)
		_skyCompact->fetchCpt(cnt)->status = 0;

	if (srcPos - srcBuf != (int32)size)
		error("Restore failed! Savegame data = %lu bytes. Expected size: %d", (long)(srcPos-srcBuf), size);

	_skyDisk->refreshFilesList(reloadList);
	SkyEngine::_systemVars.currentMusic = (uint16)music;
	if (!(SkyEngine::_systemVars.systemFlags & SF_MUS_OFF))
		_skyMusic->startMusic((uint16)music, true);
	//_savedMouse = (uint16)mouseType;
	_skyMouse->spriteMouse((uint16)mouseType, 0, 0);
	_skyText->fnSetFont(savedCharSet);
	SkyEngine::_systemVars.currentPalette = palette; // will be set when doSaveLoadPanel ends

	return GAME_RESTORED;
}


bool SaveLoad::restoreGameFromFile(uint16 selectedGame) {
	char fName[20];
	sprintf(fName,"SKY-VM.%03d", selectedGame);

	SaveFile inf(fName, "rb");
	if (!inf.isOpen()) {
		return false;
	}

	uint32 infSize = inf.readU32LE(); //inf->readUint32LE();
	if (infSize < 4) infSize = 4;
	uint8 *saveData = (uint8 *)malloc(infSize);
	*(uint32 *)saveData = TO_LE_32(infSize);

	if (inf.read(saveData+4, infSize-4) != infSize-4) {
		//displayMessage(NULL, "Can't read from file '%s'", fName);
		printf("Can't read from file '%s'\n", fName);
		free(saveData);
		return false;
	}

	/*uint16 res = */parseSaveData(saveData);
	SkyEngine::_systemVars.pastIntro = true;
	free(saveData);

///////////////////////////////////////////////////////////////////////
//	memset(_screenBuf, 0, GAME_SCREEN_WIDTH * FULL_SCREEN_HEIGHT);
	memset(_skyScreen->giveCurrent(), 0, GAME_SCREEN_WIDTH * FULL_SCREEN_HEIGHT);
//	_system->copyRectToScreen(_screenBuf, GAME_SCREEN_WIDTH, 0, 0, GAME_SCREEN_WIDTH, FULL_SCREEN_HEIGHT);
	_system->updateScreen();
	_skyScreen->forceRefresh();

	_skyScreen->setPaletteEndian((uint8 *)_skyCompact->fetchCpt(SkyEngine::_systemVars.currentPalette));
//	_skyMouse->spriteMouse(_savedMouse, 0, 0);
//	_skyText->fnSetFont(_savedCharSet);
///////////////////////////////////////////////////////////////////////

	_system->clearPauseFlag();

	//hints
	restoreHints(selectedGame);

	return true; //res;
}

void SaveLoad::restartGame() {
	if (SkyEngine::_systemVars.gameVersion <= 267)
		return; // no restart for floppy demo

	uint8 *resetData = _skyCompact->createResetData((uint16)SkyEngine::_systemVars.gameVersion);
	parseSaveData((uint8*)resetData);
	free(resetData);
	_skyScreen->forceRefresh();

	memset(_skyScreen->giveCurrent(), 0, GAME_SCREEN_WIDTH * FULL_SCREEN_HEIGHT);
	_skyScreen->showScreen(_skyScreen->giveCurrent());
	_skyScreen->setPaletteEndian((uint8 *)_skyCompact->fetchCpt(SkyEngine::_systemVars.currentPalette));
	_skyMouse->spriteMouse(/*_savedMouse*/ 1, 0, 0);
	SkyEngine::_systemVars.pastIntro = true;
}


} // End of namespace Sky
