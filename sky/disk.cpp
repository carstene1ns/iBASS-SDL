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


#include "common/file.h"

#include "sky/disk.h"
#include "sky/sky.h"
#include "sky/struc.h"

namespace Sky {

#define	READ_SUCCEEDED	(1 == result)
#define ASSERT(x) assert(x)

Disk::Disk() {
	_fp = fopen("./bass.dat", "rb");
	ASSERT(_fp);

	char magic[4];
	int result = fread(magic, 4, 1, _fp);
	ASSERT(READ_SUCCEEDED);
	ASSERT(0 == strncmp("HSFS", magic, 4));
	uint32 numFiles;
	result = fread(&numFiles, sizeof(uint32), 1, _fp);
	ASSERT(READ_SUCCEEDED);

#ifdef SCUMM_BIG_ENDIAN
	// untested
	numFiles = FROM_LE_32(numFiles);
#endif

	_entries.reserve(numFiles);

	//now populate the entry table
	uint32 filenum, offset, size, compressed_size;
	for (uint32 i = 0; i < numFiles; i++) {
		result = fread(&filenum, sizeof(uint32), 1, _fp);
		ASSERT(READ_SUCCEEDED);
		result = fread(&offset, sizeof(uint32), 1, _fp);
		ASSERT(READ_SUCCEEDED);
		result = fread(&size, sizeof(uint32), 1, _fp);
		ASSERT(READ_SUCCEEDED);
		result = fread(&compressed_size, sizeof(uint32), 1, _fp);
		ASSERT(READ_SUCCEEDED);

#ifdef SCUMM_BIG_ENDIAN
		// untested
		filenum = FROM_LE_32(filenum);
		offset = FROM_LE_32(offset);
		size = FROM_LE_32(size);
		compressed_size = FROM_LE_32(compressed_size);
#endif

		_entries.emplace(filenum,
			FileEntry{filenum, offset, size, compressed_size});
	}

	debug("Found iBASS version v0.0%d (%d data entries)", determineGameVersion(), numFiles);

	memset(_buildList, 0, 60 * 2);
	memset(_loadedFilesList, 0, 60 * 4);
}

Disk::~Disk() {
	_entries.clear();

	if (_fp) {
		fclose(_fp);
	}

	_fp = 0;
}

bool Disk::fileExists(uint16 fileNr) {
	return (_entries.count(fileNr) != 0);
}

// allocate memory, load the file and return a pointer
uint8 *Disk::loadFile(uint16 fileNr) {
	if (fileExists(fileNr)) {
		FileEntry entry = _entries.at(fileNr);

		uint8 *compressedData = (uint8 *)malloc(entry.compressed_size);
		uint8 *uncompressedData = (uint8 *)malloc(entry.size);
		fseek(_fp, entry.offset, SEEK_SET);
		int result = fread(compressedData, entry.compressed_size, 1, _fp);
		ASSERT(READ_SUCCEEDED);

		uLongf destLen = entry.size;
		result = uncompress(uncompressedData, &destLen, compressedData, entry.compressed_size);

		ASSERT(Z_OK == result);

		free(compressedData);

		_lastLoadedFileSize = entry.size;

		return uncompressedData;
	}

	_lastLoadedFileSize = 0;
	return nullptr; //not found
}

uint16 *Disk::loadScriptFile(uint16 fileNr) {
	uint16 *buf = (uint16 *)loadFile(fileNr);
#ifdef SCUMM_BIG_ENDIAN
	for (uint i = 0; i < _lastLoadedFileSize / 2; i++)
		buf[i] = FROM_LE_16(buf[i]);
#endif
	return buf;
}


void Disk::fnCacheChip(uint16 *fList) {
	// fnCacheChip is called after fnCacheFast
	uint16 cnt = 0;
	while (_buildList[cnt])
		cnt++;
	uint16 fCnt = 0;
	do {
		_buildList[cnt + fCnt] = fList[fCnt] & 0x7FFFU;
		fCnt++;
	} while (fList[fCnt-1]);
	fnCacheFiles();
}

void Disk::fnCacheFast(uint16 *fList) {
	if (fList != NULL) {
		uint8 cnt = 0;
		do {
			_buildList[cnt] = fList[cnt] & 0x7FFFU;
			cnt++;
		} while (fList[cnt-1]);
	}
}

void Disk::fnCacheFiles() {
	uint16 lCnt, bCnt, targCnt;
	targCnt = lCnt = 0;
	bool found;
	while (_loadedFilesList[lCnt]) {
		bCnt = 0;
		found = false;
		while (_buildList[bCnt] && (!found)) {
			if ((_buildList[bCnt] & 0x7FFFU) == _loadedFilesList[lCnt])
				found = true;
			else
				bCnt++;
		}
		if (found) {
			_loadedFilesList[targCnt] = _loadedFilesList[lCnt];
			targCnt++;
		} else {
			free(SkyEngine::_itemList[_loadedFilesList[lCnt] & 2047]);
			SkyEngine::_itemList[_loadedFilesList[lCnt] & 2047] = NULL;
		}
		lCnt++;
	}
	_loadedFilesList[targCnt] = 0; // mark end of list
	bCnt = 0;
	while (_buildList[bCnt]) {
		if ((_buildList[bCnt] & 0x7FF) == 0x7FF) {
			// amiga dummy files
			bCnt++;
			continue;
		}
		lCnt = 0;
		found = false;
		while (_loadedFilesList[lCnt] && (!found)) {
			if (_loadedFilesList[lCnt] == (_buildList[bCnt] & 0x7FFFU))
				found = true;
			lCnt++;
		}
		if (found) {
			bCnt++;
			continue;
		}
		// ok, we really have to load the file.
		_loadedFilesList[targCnt] = _buildList[bCnt] & 0x7FFFU;
		targCnt++;
		_loadedFilesList[targCnt] = 0;
		SkyEngine::_itemList[_buildList[bCnt] & 2047] = (void**)loadFile(_buildList[bCnt] & 0x7FFF);
		if (!SkyEngine::_itemList[_buildList[bCnt] & 2047])
			warning("fnCacheFiles: Disk::loadFile() returned NULL for file %d",_buildList[bCnt] & 0x7FFF);
		bCnt++;
	}
	_buildList[0] = 0;
}

void Disk::refreshFilesList(uint32 *list) {
	uint8 cnt = 0;
	while (_loadedFilesList[cnt]) {
		if (SkyEngine::_itemList[_loadedFilesList[cnt] & 2047])
			free(SkyEngine::_itemList[_loadedFilesList[cnt] & 2047]);
		SkyEngine::_itemList[_loadedFilesList[cnt] & 2047] = NULL;
		cnt++;
	}
	cnt = 0;
	while (list[cnt]) {
		_loadedFilesList[cnt] = list[cnt];
		SkyEngine::_itemList[_loadedFilesList[cnt] & 2047] = (void**)loadFile((uint16)(_loadedFilesList[cnt] & 0x7FFF));
		cnt++;
	}
	_loadedFilesList[cnt] = 0;
}

void Disk::fnMiniLoad(uint16 fileNum) {
	uint16 cnt = 0;
	while (_loadedFilesList[cnt]) {
		if (_loadedFilesList[cnt] == fileNum)
			return;
		cnt++;
	}
	_loadedFilesList[cnt] = fileNum & 0x7FFFU;
	_loadedFilesList[cnt + 1] = 0;
	SkyEngine::_itemList[fileNum & 2047] = (void**)loadFile(fileNum);
}

void Disk::fnFlushBuffers() {
	// dump all loaded sprites
	uint8 lCnt = 0;
	while (_loadedFilesList[lCnt]) {
		free(SkyEngine::_itemList[_loadedFilesList[lCnt] & 2047]);
		SkyEngine::_itemList[_loadedFilesList[lCnt] & 2047] = NULL;
		lCnt++;
	}
	_loadedFilesList[0] = 0;
}


uint32 Disk::determineGameVersion() {
	//iBASS
	return 372;

#if 0
	//determine game version based on number of entries in dinner table
	switch (_dinnerTableEntries) {
	case 232:
		// German floppy demo (v0.0272)
		return 272;
	case 243:
		// pc gamer demo (v0.0109)
		return 109;
	case 247:
		// English floppy demo (v0.0267)
		return 267;
	case 1404:
		//floppy (v0.0288)
		return 288;
	case 1413:
		//floppy (v0.0303)
		return 303;
	case 1445:
		//floppy (v0.0331 or v0.0348)
		if (_dataDiskHandle->size() == 8830435)
			return 348;
		else
			return 331;
	case 1711:
		//cd demo (v0.0365)
		return 365;
	case 5099:
		//cd (v0.0368)
		return 368;
	case 5097:
		//cd (v0.0372)
		return 372;
	default:
		//unknown version
		error("Unknown game version! %d dinner table entries", _dinnerTableEntries);
		break;
	}
#endif
}

} // End of namespace Sky
