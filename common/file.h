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


#ifndef FILE_H
#define	FILE_H

#include "system/types.h"

#define	NUM_PATH_MAX	8

namespace Common {

class File {
public:
	File();
	File(const char *filename, const char *mode = "rb");
	~File();

	static bool addPath(const char *path);
	bool open(const char *filename, const char *mode = "rb");
	void close(void);
	bool isOpen(void) const;
	uint32 read(void *dest, uint32 size);
	void seek(int32 ofs, int origin = SEEK_SET);
	bool ioFailed(void);
	uint16 readUint16LE(void);
	uint32 readUint32LE(void);
	uint32 pos(void) const;
	uint32 size(void) const { return _size; }

	FILE *handle() const;

protected:
	FILE *_fp;
	bool _ioFailed;
	uint32 _size;

	static int _numPath;
	/* yes, this is static now because I am lazy */
	static char _path[NUM_PATH_MAX][MAX_PATH];
};

}

#endif

