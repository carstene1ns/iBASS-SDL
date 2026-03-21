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



#include <cstdio>

#include "system/types.h"
#include "system/file.h"
#include "system/othsys.h"
#include "system/othsys_sdl.h"
#include "system/savefile.h"
#include "sky/sky.h"

#include <time.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{
	Common::File::addPath("./");

	srand( (unsigned)time( NULL ) );

	SaveFile::setSavePath(".");

	OtherSystem *system = new OtherSystem_SDL(480, 320);
	Sky::SkyEngine *engine = new Sky::SkyEngine(system);

	assert(system);
	assert(engine);

	bool res = engine->init();
	assert(res);

	while (engine->runGameCycle()) { }

	delete engine;
	delete system;

	return 0;
}
