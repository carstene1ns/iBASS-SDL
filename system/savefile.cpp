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


#include "system/savefile.h"

char SaveFile::_savePath[MAX_PATH] = "";



SaveFile::SaveFile(const char *filename, const char *mode) {
	open(filename, mode);
}

SaveFile::~SaveFile() {
	close();
}

bool SaveFile::open(const char *filename, const char *mode) {
	char fullpath[MAX_PATH + 16];
	strcpy(fullpath, _savePath);
	strcat(fullpath, filename);

	_fh = fopen(fullpath, mode);
	if (!_fh)
		return false;

	_ioError = false;
	return true;
}

bool SaveFile::isOpen(void) const {
	return _fh != 0;
}

bool SaveFile::close(void) {
	if (_fh) {
		fclose(_fh);
		_fh = 0;
	}
	return true;

}

bool SaveFile::flush(void) {
	assert(_fh);
	return 0 == fflush(_fh);
}

uint32 SaveFile::read(void *buf, uint32 size) {
	if (1 != fread(buf, size, 1, _fh)) {
		_ioError = true;
		return 0;
	}

	return size;
}

byte SaveFile::readByte(void) {
	byte retVal = 0;

	if (1 != fread(&retVal, 1, 1, _fh))
		_ioError = true;

	return retVal;
}

uint16 SaveFile::readU16LE(void) {
	uint16 retVal = 0;

	if (1 != fread(&retVal, 2, 1, _fh))
		_ioError = true;

	return retVal;
}

uint32 SaveFile::readU32LE(void) {
	uint32 retVal = 0;

	if (1 != fread(&retVal, 4, 1, _fh))
		_ioError = true;

	return retVal;
}

uint32 SaveFile::write(const void *buf, uint32 size) {
	if (1 != fwrite(buf, size, 1, _fh)) {
		_ioError = true;
		return 0;
	}

	return size;
}

void SaveFile::writeByte(byte b) {
	if (1 != fwrite(&b, 1, 1, _fh))
		_ioError = true;
}

void SaveFile::writeU16LE(uint16 val) {
	if (1 != fwrite(&val, 2, 1, _fh))
		_ioError = true;
}

void SaveFile::writeU32LE(uint32 val) {
	if (1 != fwrite(&val, 4, 1, _fh))
		_ioError = true;
}

void SaveFile::setSavePath(const char *path) {
	assert(strlen(path) < MAX_PATH);
	strcpy(_savePath, path);
	strcat(_savePath, "/");
}

const char *SaveFile::getSavePath(void) {
	 return _savePath;
}

bool SaveFile::ioFailed(void) const {
	 return _ioError;
}

