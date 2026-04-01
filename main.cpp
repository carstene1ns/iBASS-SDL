/*
 * Copyright (C) 2026 carstene1ns
 * Portions Copyright (C) 2009 Revolution Software Ltd.
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
#include <ctime>
#include <cstdlib>
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>
#include <memory>
#include <scope_guard.hpp>
#include <cute_png.h>

#include "system/types.h"
#include "common/file.h"
#include "system/othsys.h"
#include "system/othsys_sdl.h"
#include "system/savefile.h"
#include "sky/sky.h"
#include "gui/panelMan.h"

// FIXME: globals
volatile int g_xCoord = 0;
volatile int g_yCoord = 0;
volatile bool g_mouseDown = false;

namespace {
	SDL_Window *window = nullptr;
	SDL_Renderer *renderer = nullptr;
	SDL_Texture *splash = nullptr;

	bool appPaused = false;
	std::unique_ptr<CPanelMan> panelMgr;
	float scale = 3.0f;
	SDL_Rect windowRect = {0};

	uint32_t gameTickCallback(uint32_t interval, void */*param*/) {
		Sky::g_engine->gotTimerTick();

		return 1000 / 50;
	}
}

extern "C" {
	bool CPP_appIsPaused() {
		return appPaused;
	}

	void CPP_startStartPanel(bool movies) {
		//stop the game doing much
		Sky::g_engine->pauseEngine();
		panelMgr->ChangePanel(Panel::Start);
	}

	void CPP_startDeathPanel() {
		//stop the game doing much // false -> no menu music
		Sky::g_engine->pauseEngine(false);
		panelMgr->ChangePanel(Panel::Death);
	}

	void CPP_startControlPanel() {
		//stop the game doing much
		Sky::g_engine->pauseEngine();
		panelMgr->ChangePanel(Panel::Control);
	}

	void CPP_endMovie() {
		// TODO: skipping the movie here

		panelMgr->ChangePanel(Panel::Start);
	}

	void CPP_startHelpPanel() {
		//stop the game doing much
		//Sky::g_engine->pauseEngine();
		//panelMgr->PushPanel(Panel::Help);
	}
}

void updateWinAndScale() {
	float xScale = windowRect.w / (float)GAME_W;
	float yScale = windowRect.h / (float)GAME_H;
	scale = xScale > yScale ? yScale : xScale;
	assert(scale > 0 && "invalid scale");

	const int screenWidth = GAME_W * scale;
	const int screenHeight = GAME_H * scale;
	windowRect.x = (windowRect.w - screenWidth) / 2;
	windowRect.y = (windowRect.h - screenHeight) / 2;
}

void mainLoop() {
	tgui::Gui gui{window, renderer};

	// we draw the game content to the canvas
	auto canvas = tgui::CanvasSDL::create();
	canvas->setIgnoreMouseEvents(true);
	gui.add(canvas);

	panelMgr = std::make_unique<CPanelMan>(gui);

	Common::File::addPath("./");
	SaveFile::setSavePath(".");

	auto system = std::make_unique<OtherSystem_SDL>(window, renderer);
	assert(system);
	auto engine = std::make_unique<Sky::SkyEngine>(system.get());
	assert(engine);

	bool res = engine->init();
	assert(res);

	auto gameTick = SDL_AddTimer(1000 / 50, gameTickCallback, nullptr);

	if(splash)
		SDL_DestroyTexture(splash);

	appPaused = false;
	while (!panelMgr->WantQuit()) {
		SDL_Event event;
		while (SDL_PollEvent(&event) != 0) {
			bool wasHandled = gui.handleEvent(event);

			switch(event.type) {
			case SDL_QUIT:
				panelMgr->Quit();
				break;

#if 0
			case SDL_MOUSEMOTION:
				if (wasHandled) break;

				g_xCoord = event.motion.x / scale;
				g_yCoord = event.motion.y / scale;
				break;

			case SDL_MOUSEBUTTONDOWN:
			case SDL_MOUSEBUTTONUP:
				if (wasHandled) break;

				g_xCoord = event.button.x / scale;
				g_yCoord = event.button.y / scale;
				if (event.button.button == 1)
					g_mouseDown = (event.button.state == SDL_PRESSED);
				break;
#endif

			case SDL_WINDOWEVENT:
				switch(event.window.event) {
					case SDL_WINDOWEVENT_FOCUS_GAINED:
					case SDL_WINDOWEVENT_FOCUS_LOST:
						appPaused = (event.window.event == SDL_WINDOWEVENT_FOCUS_LOST);
						break;

					case SDL_WINDOWEVENT_RESIZED:
						windowRect.w = event.window.data1;
						windowRect.h = event.window.data2;
						updateWinAndScale();
						system->updateWindow(windowRect, scale);
						break;
				}
				break;
			}
		}

		SDL_RenderClear(renderer);
		SDL_SetRenderTarget(renderer, canvas->getTextureTarget());
		engine->runGameCycle();
		SDL_SetRenderTarget(renderer, nullptr);
		gui.draw();
		SDL_RenderPresent(renderer);
	}

	SDL_RemoveTimer(gameTick);

	panelMgr.reset(); // delete all panels before gui destruction
}

bool startSDL() {
	// main library
	if(SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO|SDL_INIT_TIMER) != 0)
		return false;
	auto sg_sdl = sg::make_scope_guard([]() noexcept { SDL_Quit(); });

	// window
	window = SDL_CreateWindow("iBASS-SDL",
		SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
		windowRect.w, windowRect.h, SDL_WINDOW_RESIZABLE);
	if(!window)
		return false;
	auto sg_window = sg::make_scope_guard([&]() noexcept {
		SDL_DestroyWindow(window);
		window = nullptr;
	});

	// window icon
	cp_image_t img = cp_load_png("icon.png");
	if(img.pix) {
		SDL_Surface *icon = SDL_CreateRGBSurfaceWithFormatFrom(img.pix,
			img.w, img.h, 0, img.w * 4, SDL_PIXELFORMAT_RGBA32);
		if(icon) {
			SDL_SetWindowIcon(window, icon);
			SDL_FreeSurface(icon);
		}
		free(img.pix);
		img.pix = nullptr;
	}

	// renderer
	renderer = SDL_CreateRenderer(window, -1,
		SDL_RENDERER_ACCELERATED|SDL_RENDERER_TARGETTEXTURE);
	if(!renderer)
		return false;
	auto sg_renderer = sg::make_scope_guard([&]() noexcept {
		SDL_DestroyRenderer(renderer);
		renderer = nullptr;
	});

	// splash image
	img = cp_load_png("splash.png");
	if(img.pix) {
		SDL_Surface *tmp = SDL_CreateRGBSurfaceWithFormatFrom(img.pix,
			img.w, img.h, 0, img.w * 4, SDL_PIXELFORMAT_RGBA32);
		if(tmp) {
			splash = SDL_CreateTextureFromSurface(renderer, tmp);
			SDL_FreeSurface(tmp);
		}
		free(img.pix);
		img.pix = nullptr;
	}
	if(splash) {
		SDL_RenderClear(renderer);
		SDL_RenderCopy(renderer, splash, nullptr, nullptr);
		SDL_RenderPresent(renderer);
	}

	// ttf library
	if(TTF_Init() != 0)
		return false;

	sg_sdl.dismiss();
	sg_window.dismiss();
	sg_renderer.dismiss();
	return true;
}

int main(int argc, char *argv[]) {
	(void) argc;
	(void) argv;

	srand((unsigned)time(nullptr));

	windowRect = { 0, 0, (int)(GAME_W * scale), (int)(GAME_H * scale)};

	if(!startSDL()) {
		printf("Failed to initialize!\n");
		return 1;
	}

	mainLoop();

	// quit SDL
	TTF_Quit();
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(window);
	SDL_Quit();

	return EXIT_SUCCESS;
}
