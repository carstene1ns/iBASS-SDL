# Files

These are the tested files with hashes, they seem to be the same for all
released iBASS versions.

| file         | sha256sum                                                          |
|--------------|--------------------------------------------------------------------|
| `bass.dat`   | `7553fad77091eb9f87990ccaf513c328a7732feb32e0540332adf224e615a82a` |
| `sky.cpt`    | `9f41a3be39db91391400401152bd62435500b772bc92613d2c2eea0eb816982f` |
| `speech.dat` | `371c96f73513645fd7844662f3e2bb1357f510c9345fb71e0606ad7e6a20fd93` |

## bass.dat

This file contains (e.g. graphics) data.

## music_XYY.mp3

These files contain the game music corresponding to section X, music Y.
The menu and credits music has been added for iBASS.

## sky.cpt

This file contains structures of the original executable and is part of ScummVM.
It can be downloaded here: <https://www.scummvm.org/games/#games-sky:sky>
The file contains one adress fix related to Officer Blunt on ground level, so
the checksum is different, apart from this it is identical:
`4c457373415325ea039d7a3d4f1211f7bbedd83d5bf85b94afd14cb4bdd263d2`

## speech.dat

This file contains IMA4-ADPCM compressed speech data.

## sfx_XYY.caf

These files contain IMA4-ADPCM compressed sound data corresponding to section X,
sound Y.
