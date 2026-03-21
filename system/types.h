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


#ifndef TYPES_H
#define TYPES_H

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>


#define MAX_PATH       512

#include <zlib.h>

#include "system/common.h"

typedef 	signed char 	int8;
typedef 	unsigned char 	uint8;
typedef		unsigned char	byte;

typedef 	signed short 	int16;
typedef 	unsigned short 	uint16;

typedef		signed int	int32;
typedef		unsigned int	uint32;

typedef		long long	int64;
typedef		unsigned long long	uint64;

typedef		unsigned int uint;

#ifdef __GNUC__
#define GCC_PACK __attribute__((packed))
#else
#define	GCC_PACK
#endif

#define ARRAYSIZE(x) ((int)(sizeof(x) / sizeof(x[0])))

#undef ABS
#undef MIN
#undef MAX

#define ABS(x)	(((x) < 0) ? (-(x)) : (x))
#define MIN(a, b) (((a) < (b)) ? (a) : (b))
#define MAX(a, b) (((a) < (b)) ? (b) : (a))

#define FROM_LE_16(a)	(a)
#define TO_LE_16(a)		(a)
#define FROM_LE_32(a)	(a)
#define TO_LE_32(a)		(a)

inline uint16 READ_LE_UINT16(const void *p) {
	uint8 *b = (uint8 *)p;
	return ((b[1] << 8) | b[0]);
}

inline uint32 READ_LE_UINT24(const void *p) {
	uint8 *b = (uint8 *)p;
	return ((b[2] << 16) | (b[1] << 8) | b[0]);
}

inline uint32 READ_LE_UINT32(const void *p) {
	uint8 *b = (uint8 *)p;
	return ((b[3] << 24) | (b[2] << 16) | (b[1] << 8) | b[0]);
}

inline uint16 READ_BE_UINT16(const void *p) {
	uint8 *b = (uint8 *)p;
	return ((b[0] << 8) | b[1]);
}

inline uint32 READ_BE_UINT32(const void *p) {
	uint8 *b = (uint8 *)p;
	return ((b[0] << 24) | (b[1] << 16) | (b[2] << 8) | b[3]);
}

inline double endian_swap_double(double d) {
	double a;
	uint8 *dst = (unsigned char *)&a;
	const uint8 *src = (unsigned char *)&d;

	dst[0] = src[7];
	dst[1] = src[6];
	dst[2] = src[5];
	dst[3] = src[4];
	dst[4] = src[3];
	dst[5] = src[2];
	dst[6] = src[1];
	dst[7] = src[0];

	return a;
}

#define endian_swap_64(x) \
     ((((x) & 0xff00000000000000ull) >> 56)                                   \
      | (((x) & 0x00ff000000000000ull) >> 40)                                 \
      | (((x) & 0x0000ff0000000000ull) >> 24)                                 \
      | (((x) & 0x000000ff00000000ull) >> 8)                                  \
      | (((x) & 0x00000000ff000000ull) << 8)                                  \
      | (((x) & 0x0000000000ff0000ull) << 24)                                 \
      | (((x) & 0x000000000000ff00ull) << 40)                                 \
      | (((x) & 0x00000000000000ffull) << 56))

#endif
