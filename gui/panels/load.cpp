
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panels/load.h"
#include "gui/panelMan.h"
#include "gui/asciiData.h"
#include "sky/sky.h"
#include "sky/saveload.h"

CPanelLoad::CPanelLoad(CPanelMan *mgr) : CPanel(mgr) {
	_panel = tgui::Panel::create();
	_panel->getRenderer()->setTextureBackground({"gui/bg_plain.png"});

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

	auto makeButton = [&](const char *text, void (CPanelLoad::*func)()) {
		auto btn = tgui::Button::create(text);
		btn->setHeight(40);
		btn->setTextSize(24);
		btn->onPress(func, this);

		vert->add(btn);
		return btn;
	};

	// add 2 buttons
	auto backButton = makeButton("Back", &CPanelLoad::backToPanel);
	confirmButton = makeButton("Load Game", &CPanelLoad::loadGame);
	confirmButton->setEnabled(false);

	_panel->add(savegameTabs);
	_panel->add(vert);
	_panel->setVisible(false);
	_mgr->giveGui()->add(_panel);
}

CPanelLoad::~CPanelLoad() {
	_mgr->giveGui()->remove(_panel);
}

void CPanelLoad::Init() {
	if(Sky::g_engine->autoSaveExists()) {
		savegameTabs->changeText(0, "Autosave");
		savegameTabs->setTabEnabled(0, true);
	}
	for (int i = 1; i < MAX_saves; i++) {
		if(Sky::g_engine->slotUsed(i)) {
			savegameTabs->changeText(i, Sky::g_engine->giveSlotAscii(i));
		} else {
			savegameTabs->changeText(i, asciiData::giveLine(1248));
			savegameTabs->setTabEnabled(i, false);
		}
	}
	savegameTabs->deselect();

	show();
}

void CPanelLoad::Cleanup() {
	hide();
}

void CPanelLoad::backToPanel() {
	_mgr->PopPanel();
}

void CPanelLoad::loadGame() {
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);

	int slot = savegameTabs->getSelectedIndex();

	if (slot == -1) return;

	//load the game
	if (Sky::g_engine->loadGameState(slot)) {
		_mgr->PopAllPanels();// close load + start/control/death
		Sky::g_engine->unPauseEngine(false);//start game doing its thing again
	} else
		warning("Failed to load slot %d\n", slot);
}
