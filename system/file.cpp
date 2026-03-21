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


#include "system/file.h"

namespace Common {

int File::_numPath = 0;	//the number of extra paths to look in
/* yes, this is static now because I am lazy */
char File::_path[NUM_PATH_MAX][MAX_PATH] = { { 0 } };


File::File() {
	_fp = NULL;
	_ioFailed = false;
	_size = 0;
}

File::File(const char *filename, const char *mode) {
	_fp = NULL;
	_ioFailed = false;
	_size = 0;
	open(filename, mode);
}

File::~File() {
	close();
}


/* add a path to look for files in */
bool File::addPath(const char *path) {
	if (File::_numPath < NUM_PATH_MAX) {
		assert(strlen(path) < MAX_PATH);
		strcpy(File::_path[_numPath++], path);
		return true;
	} else {
		error("Too many paths added!");
	}
	return false;
}

bool File::open(const char *filename, const char *mode) {
	int i = 0;
	char fullpath[MAX_PATH + 12];

	assert(!isOpen());

	//try CWD first.
	_fp = fopen(filename, mode);

	//try the extra paths
	while (!_fp && i < _numPath) {
		//bzero(fullpath, MAX_PATH + 12);
		memset(fullpath, 0, MAX_PATH + 12);
		strcpy(fullpath, _path[i]);
		strcat(fullpath, filename);
		//printf("attempting to open: %s\n", fullpath);
		_fp = fopen(fullpath, mode);
		i++;
	}

	if (_fp) {	//set _size
		fseek(_fp, 0, SEEK_END);
		_size = ftell(_fp);
		fseek(_fp, 0, SEEK_SET);
	}

	return isOpen();
}

bool File::isOpen(void) const {
	 return _fp != NULL;
}

void File::close(void) {
	if (_fp) {
		fclose(_fp);
		_fp = 0;
	}

	_size = 0;
}

uint32 File::read(void *dest, uint32 num) {
	uint32 res = (uint32)fread(dest, 1, num, _fp);
	if (res != num)
		_ioFailed = true;
	return res;
}

void File::seek(int32 ofs, int origin) {
	fseek(_fp, ofs, origin);
}

bool File::ioFailed(void) {
	return _ioFailed;
}

uint16 File::readUint16LE(void) {
	uint16 val16;
	assert(isOpen());
	if (fread(&val16, sizeof(uint16), 1, _fp) != 1)
		_ioFailed = true;
	return val16;
}

uint32 File::readUint32LE(void) {
	uint32 val32;
	assert(isOpen());
	if (fread(&val32, sizeof(uint32), 1, _fp) != 1)
		_ioFailed = true;
	return val32;
}

uint32 File::pos(void) const {
	assert(_fp);
	return ftell(_fp);
}

FILE *File::handle(void) const {
	 return _fp;
}

}

