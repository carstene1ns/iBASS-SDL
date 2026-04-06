
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>
#include <string>

#include "gui/panels/save.h"
#include "gui/panelMan.h"
#include "gui/asciiData.h"
#include "sky/sky.h"
#include "sky/saveload.h"

CPanelSave::CPanelSave(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	//_panel->getRenderer()->setBackgroundColor({0, 0, 0, 175});
	_panel->getRenderer()->setTextureBackground({"data/gui/bg_plain.png"});

	// add save game selection
	savegameTabs = tgui::VerticalTabs::create();
	for (int i = 0; i < MAX_saves; i++)
		savegameTabs->add("unknown");
	savegameTabs->setOrigin(0.5f, 0.5f);
	savegameTabs->setPosition("33%", "50%");
	savegameTabs->setTabWidth(180);
	savegameTabs->setTabHeight(40);
	savegameTabs->setTextSize(20);
	savegameTabs->onTabSelect([this](){ confirmButton->setEnabled(true); });

	auto vert = tgui::GrowVerticalLayout::create("25%");
	vert->setOrigin(0.5f, 0.5f);
	vert->setPosition("66%", "50%");
	vert->getRenderer()->setSpaceBetweenWidgets(80);

	// factory
	auto makeButton = [&](const char *text, void (CPanelSave::*func)()) {
		auto btn = tgui::Button::create(text);
		btn->setHeight(40);
		btn->setTextSize(24);
		btn->onPress(func, this);

		vert->add(btn);
		return btn;
	};

	// add 2 buttons
	confirmButton = makeButton("Save Game", &CPanelSave::saveGame);
	auto backButton = makeButton("Back", &CPanelSave::backToPanel);

	_panel->add(savegameTabs);
	_panel->add(vert);
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelSave::~CPanelSave() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelSave::Init() {
	if(Sky::g_engine->autoSaveExists()) {
		savegameTabs->changeText(0, "Autosave");
		savegameTabs->setTabEnabled(0, false);
	}
	for (int i = 1; i < MAX_saves; i++) {
		if(Sky::g_engine->slotUsed(i)) {
			savegameTabs->changeText(i, Sky::g_engine->giveSlotAscii(i));
		} else {
			savegameTabs->changeText(i, asciiData::giveLine(1248));
		}
	}
	confirmButton->setEnabled(false);
	savegameTabs->deselect();

	show();
}

void CPanelSave::Cleanup() {
	hide();
}

void CPanelSave::backToPanel() {
	_mgr->PopPanel(this);
}

void CPanelSave::saveGame() {
	int slot = savegameTabs->getSelectedIndex();

	if (slot == -1) { // this should not happen
		Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_BLEEP_FAIL);
		return;
	}

	//save the game
	if (Sky::g_engine->saveGameState(slot)) {
		Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);
		std::string placeholder = asciiData::giveLine(1249);
		placeholder += " " + std::to_string(slot + 1);
		Sky::g_engine->setSlotAscii(slot, placeholder.c_str());
		savegameTabs->changeText(slot, Sky::g_engine->giveSlotAscii(slot));
	} else {
		Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_BLEEP_FAIL);
		warning("Failed to save slot %d\n", slot);
	}
}
