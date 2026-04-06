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

#ifndef SAVEFILE_H
#define	SAVEFILE_H

#include "system/types.h"



class SaveFile {
public:
	SaveFile();
	SaveFile(const char *filename, const char *mode);
	~SaveFile();

	bool open(const char *filename, const char *mode);
	bool close(void);
	bool flush(void);
	bool ioFailed(void) const;
	bool isOpen(void) const;

	uint32 read(void *buf, uint32 size);
	byte readByte(void);
	uint16 readU16LE(void);
	uint32 readU32LE(void);

	uint32 write(const void *buf, uint32 size);
	void writeByte(byte b);
	void writeU16LE(uint16 val);
	void writeU32LE(uint32 val);

	static void setSavePath(const char *path);
	static const char *getSavePath(void);

protected:
	FILE *_fh;
	bool _ioError;
	static char _savePath[MAX_PATH];
};

#endif
