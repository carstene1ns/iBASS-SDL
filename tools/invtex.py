#!/bin/env python3

import sys
import argparse
from PIL import Image
from dataclasses import dataclass
from pathlib import PurePath

@dataclass
class texInfoInv:
	row: int
	col: int
	name: str
	frames: int

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('file', nargs='+')
	parser.add_argument('-c', '--count', type=int, default=0)
	parser.add_argument('-o', '--output', default="output.png")

	args = parser.parse_args()

	if args.count < 1:
		print ('Error: invalid count')
		sys.exit(1)

	if args.count % 2 != 0:
		print ('Error: invalid count')
		sys.exit(1)

	sheet = Image.new('RGBA', (args.count * 48, args.count * 48), (0,0,0,0))
	info = []

	col = 0
	row = 0
	for tex in args.file:
		with open(tex, 'rb') as file:
			magic = file.read(4)
			assert(magic == b'JPTX')

			frames = int.from_bytes(file.read(4), byteorder='little')
			width = int.from_bytes(file.read(4), byteorder='little')
			height = int.from_bytes(file.read(4), byteorder='little')

			i = texInfoInv(row, col, PurePath(tex).stem, frames)
			info.append(i)
			#print(i)

			for f in range(frames):
				image = Image.frombytes('RGBA', (width, height), file.read(height * width * 4))
				image = image.transpose(Image.Transpose.FLIP_TOP_BOTTOM)

				sheet.paste(image, (col * 48, row * 48))
				col = col + 1
				if col >= args.count:
					col = 0
					row = row +1

	sheet.save(args.output)

	print("const struct {")
	print("\tint id;")
	print("\tint row;")
	print("\tint col;")
	print("\tint frames;")
	print("} texInfoInv[] = {")
	for i in info:
		print(f'\t{{{i.name}, {i.row}, {i.col}, {i.frames} }},')
	print("};")
