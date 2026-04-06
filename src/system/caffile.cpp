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



#include "system/types.h"


struct CAFFileHeader {
    //uint32  mFileType;
	char    mFileType[4];
    uint16  mFileVersion;
    uint16  mFileFlags;
} __attribute__((packed));

struct CAFChunkHeader {
	//uint32  mChunkType;
	char mChunkType[4];
	int64  mChunkSize;
} __attribute__((packed));

struct CAFAudioFormat {
	double mSampleRate;
	//uint32  mFormatID;
	char mFormatID[4];
	uint32  mFormatFlags;
	uint32  mBytesPerPacket;
	uint32  mFramesPerPacket;
	uint32  mChannelsPerFrame;
	uint32  mBitsPerChannel;
} __attribute__((packed));

struct CAFPacketTableHeader {
	int64  mNumberPackets;
    int64  mNumberValidFrames;
    int32  mPrimingFrames;
    int32  mRemainderFrames;
} __attribute__((packed));


enum CafChunkType {
	CAF_CHUNK_UNKNOWN  = 0,
	CAF_CHUNK_DESC,
	CAF_CHUNK_PAKT,
	CAF_CHUNK_FREE,
	CAF_CHUNK_DATA
};

CafChunkType getChunkType(CAFChunkHeader *header) {
	//printf("--CAFChunkHeader--\n");
	//printf("%c%c%c%c -- %lld bytes\n", header->mChunkType[0], header->mChunkType[1], header->mChunkType[2], header->mChunkType[3], endian_swap_64(header->mChunkSize));

	if (0 == strncmp(header->mChunkType, "desc", 4)) {
		return CAF_CHUNK_DESC;
	} else if (0 == strncmp(header->mChunkType, "pakt", 4)) {
		return CAF_CHUNK_PAKT;
	} else if (0 == strncmp(header->mChunkType, "free", 4)) {
		return CAF_CHUNK_FREE;
	} else if (0 == strncmp(header->mChunkType, "data", 4)) {
		return CAF_CHUNK_DATA;
	}

	return CAF_CHUNK_UNKNOWN;
}

uint64 getChunkSize(CAFChunkHeader *header) {
	return endian_swap_64(header->mChunkSize);
}

extern void ima_decompress( uint32 packetCount, bool isStereo, const uint8 *pSrc, int16 *pDst );

int16 *ima4CAFToPCM(const void *srcBuf, bool &isStereo, int &uncompressed_size, int &sampleRate) {
	if (!srcBuf) {
		return 0;
	}

	uint8 *data = (uint8 *)srcBuf;

	CafChunkType chunkType = CAF_CHUNK_UNKNOWN;


	CAFFileHeader *cafFileHeader = (CAFFileHeader *)data;

	//check if this is a caff file
	if (0 != strncmp(cafFileHeader->mFileType, "caff", 4)) {
		return 0;
	}

	data += sizeof(CAFFileHeader);

	//desc
	chunkType = getChunkType((CAFChunkHeader *)data);
	assert(CAF_CHUNK_DESC == chunkType);

	CAFAudioFormat *cafAudioFormat = (CAFAudioFormat *)(data + sizeof(CAFChunkHeader));
	sampleRate = (int)endian_swap_double(cafAudioFormat->mSampleRate);
	const int bytesPerPacket = READ_BE_UINT32(&cafAudioFormat->mBytesPerPacket);
	const int numChannels = READ_BE_UINT32(&cafAudioFormat->mChannelsPerFrame);
	isStereo = (numChannels > 1);

	data += sizeof(CAFChunkHeader) + getChunkSize((CAFChunkHeader *)data);

	//pakt
	chunkType = getChunkType((CAFChunkHeader *)data);
	assert(CAF_CHUNK_PAKT == chunkType);

	CAFPacketTableHeader *cafPacketTableHeader = (CAFPacketTableHeader *)(data + sizeof(CAFChunkHeader));
	const int numberPackets = endian_swap_64(cafPacketTableHeader->mNumberPackets);
	assert(numberPackets == 0);
	const int numberValidFrames = endian_swap_64(cafPacketTableHeader->mNumberValidFrames);
	const int remainderFrames = READ_BE_UINT32(&cafPacketTableHeader->mRemainderFrames);
	uncompressed_size = (numberValidFrames + remainderFrames) * (2 * numChannels);

	data += sizeof(CAFChunkHeader) + getChunkSize((CAFChunkHeader *)data);

	//free
	chunkType = getChunkType((CAFChunkHeader *)data);
	assert(CAF_CHUNK_FREE == chunkType);

	data += sizeof(CAFChunkHeader) + getChunkSize((CAFChunkHeader *)data);

	//data
	chunkType = getChunkType((CAFChunkHeader *)data);
	assert(CAF_CHUNK_DATA == chunkType);
	const int data_chunk_size = getChunkSize((CAFChunkHeader *)data);
	const uint32 packetCount = data_chunk_size / bytesPerPacket;

	data += sizeof(CAFChunkHeader);

	//allocate buffer
	int16 *pcm16 = (int16 *)calloc(uncompressed_size, 1);

	//decompress speech
	ima_decompress(packetCount, isStereo, data + 4, pcm16 );

	return pcm16;
}
