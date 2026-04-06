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



#include <system/types.h>

static const int32 ima_index_table[16] = {
		-1, -1, -1, -1, 2, 4, 6, 8,
		-1, -1, -1, -1, 2, 4, 6, 8
};

static const int32 ima_step_table[89] = {
		7, 8, 9, 10, 11, 12, 13, 14, 16, 17,
		19, 21, 23, 25, 28, 31, 34, 37, 41, 45,
		50, 55, 60, 66, 73, 80, 88, 97, 107, 118,
		130, 143, 157, 173, 190, 209, 230, 253, 279, 307,
		337, 371, 408, 449, 494, 544, 598, 658, 724, 796,
		876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066,
		2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358,
		5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899,
		15289, 16818, 18500, 20350,  22385, 24623, 27086, 29794, 32767
};

void ima_decompress_packet( const uint8 *pSrc, int16 *pDst, int32 stride ) {
    // Read packet header
    uint16 value  = *(uint16 *)pSrc;
    uint16 header = ( value >> 8 ) | ( value << 8 );
    int32 predictor  = header & 0xff80;
    int32 step_index = header & 0x007f;
    int32 step, nibble, diff;

    // Sign extend predictor
    if( predictor & 0x8000 )
        predictor |= 0xffff0000;

    // Skip header
    pSrc += 2;

    // Read 64 nibbles, 2 at a time
    uint32 byteCount = 32;
    while( byteCount-- )
    {
        // Read 2 nibbles
        uint8 byte = *pSrc++;

        // Process low nibble
        nibble = byte & 0x0f;
        if( step_index < 0 ) step_index = 0;
        else if( step_index > 88 ) step_index = 88;
        step = ima_step_table[ step_index ];
        step_index += ima_index_table[ nibble ];
        diff = step >> 3;
        if (nibble & 4) diff += step;
        if (nibble & 2) diff += (step >> 1);
        if (nibble & 1) diff += (step >> 2);
        if (nibble & 8) predictor -= diff;
        else predictor += diff;
        if( predictor < -32768 ) predictor = -32768;
        else if( predictor > 32767 ) predictor = 32767;
        *pDst = predictor;
        pDst += stride;

        // Process high nibble
        nibble = byte >> 4;
        if( step_index < 0 ) step_index = 0;
        else if( step_index > 88 ) step_index = 88;
        step = ima_step_table[ step_index ];
        step_index += ima_index_table[ nibble ];
        diff = step >> 3;
        if (nibble & 4) diff += step;
        if (nibble & 2) diff += (step >> 1);
        if (nibble & 1) diff += (step >> 2);
        if (nibble & 8) predictor -= diff;
        else predictor += diff;
        if( predictor < -32768 ) predictor = -32768;
        else if( predictor > 32767 ) predictor = 32767;
        *pDst = predictor;
        pDst += stride;
    }
}

void ima_decompress( uint32 packetCount, bool isStereo, const uint8 *pSrc, int16 *pDst ) {
    // Stereo?
    if ( isStereo ) {
        // Decompress all stereo packets
        while ( packetCount > 0 ) {
            // Decompress channel0 and channel1 interleaved
            ima_decompress_packet( &pSrc[0],  &pDst[0], 2 );
            ima_decompress_packet( &pSrc[34], &pDst[1], 2 );

            // Next 2 channel packets
            pSrc += 34*2;
            pDst += 64*2;
            packetCount -= 2;
        }
    } else {
        // Decompress all mono packets
        while ( packetCount-- ) {
            // Decompress single channel
            ima_decompress_packet( pSrc, pDst, 1 );

            // Next channel packet
            pSrc += 34;
            pDst += 64;
        }
    }
}
