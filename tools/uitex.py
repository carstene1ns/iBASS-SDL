#!/bin/env python3

import sys
import argparse
from PIL import Image
from dataclasses import dataclass
from pathlib import PurePath

@dataclass
class texInfoUI:
	col: int
	name: str
	width: int
	height: int
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

	sheet = Image.new('RGBA', (len(args.file) * 64, args.count * 64), (0,0,0,0))
	info = []

	col = 0
	for tex in args.file:
		with open(tex, 'rb') as file:
			magic = file.read(4)
			assert(magic == b'JPTX')

			frames = int.from_bytes(file.read(4), byteorder='little')
			width = int.from_bytes(file.read(4), byteorder='little')
			height = int.from_bytes(file.read(4), byteorder='little')

			i = texInfoUI(col, PurePath(tex).stem, width, height, frames)
			info.append(i)
			#print(i)

			pos_y = 0
			for f in range(frames):
				image = Image.frombytes('RGBA', (width, height), file.read(height * width * 4))
				image = image.transpose(Image.Transpose.FLIP_TOP_BOTTOM)

				sheet.paste(image, (col * 64, pos_y * 64))
				pos_y = pos_y + 1

		col = col + 1

	sheet.save(args.output)

	print("const struct {")
	print("\tint col;")
	print("\tint width;")
	print("\tint height;")
	print("\tint frames;")
	print("} texInfoUI[] = {")
	for i in info:
		print(f'\t{{{i.col}, {i.width}, {i.height}, {i.frames} }}, // {i.name}')
	print("};")
