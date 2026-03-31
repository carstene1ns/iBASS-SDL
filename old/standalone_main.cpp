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



#include <stdio.h>

#include "system/types.h"
#include "common/file.h"
#include "system/othsys.h"
#include "system/othsys_opengl.h"
#include "system/savefile.h"
#include "sky/sky.h"

#include <time.h>
#include <stdlib.h>

extern const char *iPhone_getDocumentsDir();

int standalone_main(void) {
	Common::File::addPath("./");

	srand( (unsigned)time( NULL ) );

	SaveFile::setSavePath(iPhone_getDocumentsDir());

	OtherSystem *system = new OtherSystem_OpenGL(320, 480);
	Sky::SkyEngine *engine = new Sky::SkyEngine(system);

	assert(system);
	assert(engine);

	bool res = engine->init();
	assert(res);

	//while (engine->runGameCycle()) { }

	//delete engine;
	//delete system;

	return 0;
}
