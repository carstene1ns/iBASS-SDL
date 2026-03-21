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


#include "system/common.h"
#include <time.h>

#define	BUF_SIZE	1024

void error(const char *message, ...) {
	char buf[BUF_SIZE];
	va_list va;

	va_start(va, message);
	vsnprintf(buf, BUF_SIZE, message, va);
	va_end(va);

	printf("ERROR: %s\n", buf);

	exit (-1);
}

/*void debug(int level, const char *message, ...) {

}*/

void warning(const char *message, ...) {
	char buf[BUF_SIZE];
	va_list va;

	va_start(va, message);
	vsnprintf(buf, BUF_SIZE, message, va);
	va_end(va);

	printf("WARNING: %s\n", buf);
}

void timestamp(char *buf, size_t buflen) {
	time_t tm = time(NULL);
	strftime(buf, buflen, "%c", localtime(&tm));
}

