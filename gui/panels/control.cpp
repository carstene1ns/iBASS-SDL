
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panels/control.h"
#include "gui/panelMan.h"
#include "sky/sky.h"
#include "sky/saveload.h"

CPanelControl::CPanelControl(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setBackgroundColor({0, 0, 0, 175});
	//_panel->getRenderer()->setTextureBackground({"gui/bg_plain.png"});

	auto horz1 = tgui::GrowHorizontalLayout::create("80%");
	horz1->setOrigin(0.5f, 0.5f);
	horz1->setPosition("50%", "20%");
	horz1->setHeight(50);
	horz1->getRenderer()->setSpaceBetweenWidgets(20);

	auto horz2 = tgui::GrowHorizontalLayout::create("80%");
	horz2->setOrigin(0.5f, 0.5f);
	horz2->setPosition("50%", "80%");
	horz2->setHeight(50);
	horz2->getRenderer()->setSpaceBetweenWidgets(40);

	auto makeButton = [&](const char *text, const tgui::Container::Ptr &parent, void (CPanelControl::*func)()) {
		auto btn = tgui::Button::create(text);
		btn->setTextSize(36);
		btn->onPress(func, this);

		parent->add(btn);
		return btn;
	};

	loadButton = makeButton("Load Game", horz1, &CPanelControl::showLoadPanel);
	saveButton = makeButton("Save Game", horz1, &CPanelControl::showSavePanel);
	auto backButton = makeButton("Back", horz1, &CPanelControl::backToGame);
	auto audioButton = makeButton("Audio", horz2, &CPanelControl::showAudioPanel);
	auto langButton = makeButton("Language", horz2, &CPanelControl::showLanguagePanel);
	auto creditsButton = makeButton("Credits", horz2, &CPanelControl::showCredits);
	creditsButton->setEnabled(false); // TODO
	auto quitButton = makeButton("Quit", horz2, &CPanelControl::quitGame);

	_panel->add(horz1, "topbar");
	_panel->add(horz2, "bottombar");
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelControl::~CPanelControl() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelControl::Init() {
	if (!Sky::g_engine->canLoadGameStateCurrently()) {
		//switch off save and load menu buttons
		saveButton->setEnabled(false);
		loadButton->setEnabled(false);
	} else {
		saveButton->setEnabled(true);
		//switch off load button if no saves
		loadButton->setEnabled(Sky::g_engine->savesExist());
	}

	_panel->get<tgui::GrowHorizontalLayout>("topbar")->showWithEffect(tgui::ShowEffectType::SlideFromTop, 800);
	_panel->get<tgui::GrowHorizontalLayout>("bottombar")->showWithEffect(tgui::ShowEffectType::SlideFromBottom, 800);

	show();
}

void CPanelControl::Cleanup() {
	_panel->get<tgui::GrowHorizontalLayout>("topbar")->hideWithEffect(tgui::ShowEffectType::SlideToTop, 800);
	_panel->get<tgui::GrowHorizontalLayout>("bottombar")->hideWithEffect(tgui::ShowEffectType::SlideToBottom, 800);

	hide();
}

void CPanelControl::backToGame() {
	_mgr->PopPanel();
	Sky::g_engine->unPauseEngine();
}

void CPanelControl::showLoadPanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Load);
}

void CPanelControl::showSavePanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Save);
}

void CPanelControl::showAudioPanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Audio);
}

void CPanelControl::showLanguagePanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->PushPanel(Panel::Language);
}

void CPanelControl::showCredits() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	// TODO
}

void CPanelControl::quitGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	_mgr->Quit();
}
