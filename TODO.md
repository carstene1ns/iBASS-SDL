# TODO

## GUI

- Implement Help and Hint panels
- Allow changing of Savegame file names

## Savegames

- Revert the split between SKY-VM files (old) and SAVESLOTS.ADW (new) saving or
  improve the failure tolerance between them. Currently it breaks when there is
  a mismatch (e.g. name written in ADW and no corresponding VM file)

## Game Data

- Allow using the older (freeware!) data files:
  Dinner Table (dnr) and encrypted disk (dsk) format is not used in this
  version, instead data is DEFLATE(zlib) compressed. Find out if data is the
  same, maybe write a converter
- Speech is in CAF format (IMA4-ADPCM) for smaller size and easy playback on
  iOS, investigate if the DSK file contains the same files as WAVE/PCM and
  use (or maybe OGG convert) that.
- Music is in MP3 format, sounds like recorded from MIDI, investigate the
  possibility to use the Enhanced Soundtrack by James Woodcock, at least the
  file names match.

## Engine

- Import bugfixes from newer scummvm versions since 2009
- Reimplement EventManager, PaletteManager, etc. APIs:
  - EventManager hopefully fixes the lockups when using the inventory
    (busy loop in `waitMouseNotPressed()`)
- Make frame-rate independent, currently the gui stutters when the engine runs
  at native 12fps, this will also be needed for "fast mode"
  (see `SkyEngine::runGameCycle()`)
- Inventory is maximum 11 objects in iBASS it seems, investigate if scrolling is
  needed somewhere.

## SDL Port

- Aspect ratio correction: scale height nearest neigbor by 6 and then downscale
  bilinear down to render size
- Render ingame touch gui outside game canvas, if screen is wide enough
- Restore compatibility with big endian platforms
