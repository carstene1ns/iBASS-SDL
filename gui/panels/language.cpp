
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>
#include <array>

#include "gui/panels/language.h"
#include "gui/panelMan.h"
#include "gui/asciiData.h"
#include "sky/sky.h"
#include "sky/skydefs.h"

CPanelLanguage::CPanelLanguage(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setTextureBackground({"gui/bg_plain.png"});

	// position flags on left side
	langEntries = tgui::GrowVerticalLayout::create("50%");
	langEntries->setOrigin(0.5f, 0.5f);
	langEntries->setPosition("40%", "50%");
	langEntries->getRenderer()->setSpaceBetweenWidgets(4);

	langLabel = tgui::Label::create("Language");
	langLabel->setTextSize(36);
	langLabel->getRenderer()->setTextColor(tgui::Color::White);
	langEntries->add(langLabel);

	auto makeLangFields = [&](const char *text, const char *tag, int id) {
		auto horz = tgui::GrowHorizontalLayout::create("100%");
		horz->setHeight(40);
		horz->getRenderer()->setSpaceBetweenWidgets(2);

		std::string filename = "gui/" + std::string(tag) + std::string(".svg");
		auto pic = tgui::Picture::create({filename});
		pic->setSize({1500/(1000/40), 40});
		pic->onClick(&CPanelLanguage::picChangeLanguage, this, id);
		horz->add(pic);

		auto btn = tgui::ToggleButton::create(text);
		btn->setTextSize(28);
		btn->setWidth(280);
		btn->onToggle(&CPanelLanguage::btnChangeLanguage, this, id);
		horz->add(btn);

		langEntries->add(horz);
	};

	// add in order to allow easy indexing
	makeLangFields("English (UK)", "gb", SKY_ENGLISH);
	makeLangFields("German", "de", SKY_GERMAN);
	makeLangFields("French", "fr", SKY_FRENCH);
	makeLangFields("English (US)", "us", SKY_USA);
	makeLangFields("Swedish", "se", SKY_SWEDISH);
	makeLangFields("Italian", "it", SKY_ITALIAN);
	makeLangFields("Portugese", "pt", SKY_PORTUGUESE);
	makeLangFields("Spanish", "es", SKY_SPANISH);

	// position buttons on right side
	auto vert2 = tgui::GrowVerticalLayout::create("30%");
	vert2->setOrigin(0.5f, 0.5f);
	vert2->setPosition("75%", "50%");
	vert2->setHeight(36);
	vert2->getRenderer()->setSpaceBetweenWidgets(20);

	auto makeToggleButton = [&](const char *text, void (CPanelLanguage::*func)(bool, bool), bool param) {
		auto btn = tgui::ToggleButton::create(text);
		btn->setTextSize(36);
		btn->onToggle(func, this, param);

		vert2->add(btn);
		return btn;
	};

	textButton = makeToggleButton("Text", &CPanelLanguage::toggleTextOrSpeech, true);
	speechButton = makeToggleButton("Speech", &CPanelLanguage::toggleTextOrSpeech, false);

	// back button
	auto backButton = tgui::Button::create("Back");
	backButton->setTextSize(36);
	backButton->onPress(&CPanelLanguage::backToPanel, this);
	vert2->add(backButton);

	_panel->add(langEntries);
	_panel->add(vert2);
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelLanguage::~CPanelLanguage() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelLanguage::refreshGui() {
	// select current language
	int lang = Sky::g_engine->giveLanguageFlag();
	for(int i = SKY_ENGLISH; i <= SKY_SPANISH; i++) {
		auto horz = langEntries->get(i + 1)->cast<tgui::GrowHorizontalLayout>();
		if(horz) {
			auto btn = horz->get(1)->cast<tgui::ToggleButton>();
			if(btn) {
				btn->onToggle.setEnabled(false);
				btn->setDown(i == lang);
				btn->onToggle.setEnabled(true);
			}
		}
	}

	//renew subtitles label
	langLabel->setText(asciiData::giveLine(1257));
	//renew speech label
	textButton->setText(asciiData::giveLine(1245));
	//renew text language label
	speechButton->setText(asciiData::giveLine(1244));

	int flags = Sky::g_engine->giveSystemFlags();
	textButton->setDown(flags & SF_ALLOW_TEXT);
	speechButton->setDown(flags & SF_ALLOW_SPEECH);
}

void CPanelLanguage::Init() {
	refreshGui();

	show();
}

void CPanelLanguage::Cleanup() {
	hide();
}

void CPanelLanguage::backToPanel() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	//save the states
	Sky::g_engine->writeExtraData();

	_mgr->PopPanel();
}

void CPanelLanguage::picChangeLanguage(int id) {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	Sky::g_engine->setLanguageFlag(id);

	refreshGui();
}

void CPanelLanguage::btnChangeLanguage(int id, bool isDown) {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	if(isDown)
		Sky::g_engine->setLanguageFlag(id);

	refreshGui();
}

void CPanelLanguage::toggleTextOrSpeech(bool isText, bool isDown) {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	// there are 3 cases: one of text/speech or both
	int flags = Sky::g_engine->giveSystemFlags();

	// first check for disabling
	if(isText && !isDown)
		flags &= ~SF_ALLOW_TEXT;
	if(!isText && !isDown)
		flags &= ~SF_ALLOW_SPEECH;

	// then check for enabling or re-enabling the other
	if((isText && isDown) || (!isText && !isDown))
		flags |= SF_ALLOW_TEXT;
	if((!isText && isDown) || (isText && !isDown))
		flags |= SF_ALLOW_SPEECH;

	Sky::g_engine->setSystemFlags(flags);
	refreshGui();
}
