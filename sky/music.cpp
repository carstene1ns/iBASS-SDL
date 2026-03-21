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


#include "sky/music.h"
#include "sky/sky.h"

#include "iphone_common.h"

namespace Sky {

Music::Music(OSystem *system) : _section(0), _currentMusic(0) {
	_system = system;
}

Music::~Music() {
}

void Music::loadSection(int section) {
	if (section != _section) {
		_currentMusic = 0;	//make sure we don't confuse song of old and new sections
	}
	
	const int room = g_engine ? g_engine->giveCurrentScreen() : 0;
	
	//special fix for stopping music in security room - normally this stopMusic() call would be
	//unconditional but then we won't have cross-fading across sections, which is kinda nice to have.
	if ((3 == section) && ((2 == _section && 10 == room) || (6 == _section))) {
		stopMusic();
	}

	_section = section;
}

void Music::playMusic(int song, bool forcePlay) {
	song &= 0xF;

	if ((song == _currentMusic) && !forcePlay)
		return;

	_currentMusic = song;

	if (0 == song) {
		_system->stopMusic();
	} else {
		_system->playMusic(_section, song);
	}
}

void Music::stopMusic(void) {
	_currentMusic = 0;
	_system->stopMusic();
}

int Music::giveCurrentMusic(void) const {
	return _currentMusic;
}

} // End of namespace Sky
