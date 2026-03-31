
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panels/audio.h"
#include "gui/panelMan.h"
#include "sky/sky.h"

CPanelAudio::CPanelAudio(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setBackgroundColor({0, 0, 0, 175});
	//_panel->getRenderer()->setTextureBackground({"gui/bg_plain.png"});

	// position on left side
	auto vert = tgui::GrowVerticalLayout::create("50%");
	vert->setOrigin(0.5f, 0.5f);
	vert->setPosition("33%", "50%");
	vert->setHeight(46);
	vert->getRenderer()->setSpaceBetweenWidgets(20);

	// factory
	auto makeSlider = [&](const char *text, void (CPanelAudio::*func)(float)) {
		auto lbl = tgui::Label::create(text);
		lbl->setTextSize(36);
		lbl->getRenderer()->setTextColor(tgui::Color::White);
		vert->add(lbl);

		auto sld = tgui::Slider::create(0.5f);
		sld->setMinimum(0);
		sld->setMaximum(1);
		sld->setStep(0.005f);
		sld->setHeight(36);
		sld->onValueChange(func, this);

		vert->add(sld);
		return sld;
	};

	// add 3 sliders
	sfxSlider = makeSlider("Sound Effects Volume", &CPanelAudio::sfxVolumeChanged);
	musicSlider = makeSlider("Music Volume", &CPanelAudio::musicVolumeChanged);
	speechSlider = makeSlider("Speech Volume", &CPanelAudio::speechVolumeChanged);

	// and a button
	auto backButton = tgui::Button::create("Back");
	backButton->setTextSize(36);
	backButton->setPosition("66%", "50%");
	backButton->onPress(&CPanelAudio::backToSettings, this);

	_panel->add(vert);
	_panel->add(backButton);
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelAudio::~CPanelAudio() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelAudio::Init() {
	sfxSlider->setValue(Sky::g_engine->giveSystem()->getSFXVolume());
	musicSlider->setValue(Sky::g_engine->giveSystem()->getMusicVolume());
	speechSlider->setValue(Sky::g_engine->giveSystem()->getSpeechVolume());

	show();
}

void CPanelAudio::Cleanup() {
	hide();
}

void CPanelAudio::backToSettings() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	Sky::g_engine->writeExtraData(); //save the states
	_mgr->PopPanel();
}

void CPanelAudio::sfxVolumeChanged(float val) {
	Sky::g_engine->giveSystem()->setSFXVolume(val);
}

void CPanelAudio::musicVolumeChanged(float val) {
	Sky::g_engine->giveSystem()->setMusicVolume(val);
}

void CPanelAudio::speechVolumeChanged(float val) {
	Sky::g_engine->giveSystem()->setSpeechVolume(val);
}

/*
uint32 flags = SkyEngine::_systemVars.systemFlags & TEXT_FLAG_MASK;
SkyEngine::_systemVars.systemFlags &= ~TEXT_FLAG_MASK;

if (flags == SF_ALLOW_TEXT) {
	flags = SF_ALLOW_SPEECH;  //speech only
} else if (flags == SF_ALLOW_SPEECH) {
	flags = SF_ALLOW_SPEECH | SF_ALLOW_TEXT; //text and speech
} else {
	flags = SF_ALLOW_TEXT;  //text only
}

SkyEngine::_systemVars.systemFlags |= flags;
*/
