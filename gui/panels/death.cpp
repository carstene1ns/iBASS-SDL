
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panels/death.h"
#include "gui/panelMan.h"
#include "sky/sky.h"
#include "sky/saveload.h"

CPanelDeath::CPanelDeath(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setTextureBackground({"gui/bg_death.png"});

	auto horz = tgui::GrowHorizontalLayout::create("80%");
	horz->setOrigin(0.5f, 0.5f);
	horz->setPosition("50%", "20%");
	horz->setHeight(50);
	horz->getRenderer()->setSpaceBetweenWidgets(40);

	auto makeButton = [&](const char *text, void (CPanelDeath::*func)()) {
		auto btn = tgui::Button::create(text);
		btn->setTextSize(36);
		btn->onPress(func, this);

		horz->add(btn);
		return btn;
	};

	continueButton = makeButton("Continue Game", &CPanelDeath::continueGame);
	loadButton = makeButton("Load Game", &CPanelDeath::loadGame);
	auto quitButton = makeButton("Quit", &CPanelDeath::quitGame);

	_panel->add(horz, "buttonbar");
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelDeath::~CPanelDeath() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelDeath::Init() {
	continueButton->setEnabled(Sky::g_engine->autoSaveExists());
	//switch off load button if no saves
	loadButton->setEnabled(Sky::g_engine->savesExist());

	_panel->get<tgui::GrowHorizontalLayout>("buttonbar")->showWithEffect(tgui::ShowEffectType::SlideFromTop, 800);

	show();
}

void CPanelDeath::Cleanup() {
	hide();
}

void CPanelDeath::continueGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PopPanel();
	Sky::g_engine->loadGameState(0);//game slot 0 is the auto-saved game
	Sky::g_engine->unPauseEngine();
}

void CPanelDeath::loadGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Load);
}

void CPanelDeath::quitGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->Quit();
}
