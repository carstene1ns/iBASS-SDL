
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panels/start.h"
#include "gui/panelMan.h"
#include "sky/sky.h"

CPanelStart::CPanelStart(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setTextureBackground({"gui/bg_w_logo.png"});

	auto vert = tgui::GrowVerticalLayout::create("33%");
	vert->setOrigin(0.5f, 0.5f);
	vert->setPosition("66%", "50%");
	vert->setHeight(50);
	vert->getRenderer()->setSpaceBetweenWidgets(20);

	// factory
	auto makeButton = [&](const char *text, void (CPanelStart::*func)()) {
		auto btn = tgui::Button::create(text);
		btn->setTextSize(32);
		btn->onPress(func, this);

		vert->add(btn);
		return btn;
	};

	// add 5 menu buttons
	auto newGameButton = makeButton("New Game", &CPanelStart::newGame);
	loadButton = makeButton("Load Game", &CPanelStart::showLoadPanel);
	continueButton = makeButton("Continue Game", &CPanelStart::continueGame);
	auto langButton = makeButton("Language", &CPanelStart::showLanguagePanel);
	auto quitButton = makeButton("Quit", &CPanelStart::quitGame);

	_panel->add(vert);
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelStart::~CPanelStart() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelStart::Init() {
	continueButton->setEnabled(Sky::g_engine->autoSaveExists());
	loadButton->setEnabled(Sky::g_engine->savesExist());

	show();
}

void CPanelStart::Cleanup() {
	hide();
}

void CPanelStart::show() {
	_panel->setVisible(true);
}

void CPanelStart::newGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	// TODO: skiping the movie here

	_mgr->PopPanel();
	Sky::g_engine->unPauseEngine();
	Sky::g_engine->initNewGame();
}

void CPanelStart::showLoadPanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Load);
}

void CPanelStart::showLanguagePanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Language);
}

void CPanelStart::continueGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	Sky::g_engine->loadGameState(0); //game slot 0 is the auto-saved game
	_mgr->PopPanel();
	Sky::g_engine->unPauseEngine();
}

void CPanelStart::quitGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->Quit();
}
