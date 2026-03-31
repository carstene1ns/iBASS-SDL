
#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SDL-Renderer.hpp>

#include "gui/panelMan.h"
#include "gui/panel.h"

#include "gui/panels/audio.h"
#include "gui/panels/control.h"
#include "gui/panels/death.h"
#include "gui/panels/load.h"
#include "gui/panels/save.h"
#include "gui/panels/start.h"
#include "gui/panels/language.h"

namespace {
	std::unique_ptr<CPanel> panelDeath, panelStart, panelControl,
		panelAudio, panelLoad, panelSave, panelLanguage;

	CPanel *getPanel(Panel panel) {
		switch(panel) {
		case Panel::Death:
			return panelDeath.get();
		case Panel::Start:
			return panelStart.get();
		case Panel::Control:
			return panelControl.get();
		case Panel::Audio:
			return panelAudio.get();
		case Panel::Load:
			return panelLoad.get();
		case Panel::Save:
			return panelSave.get();
		case Panel::Language:
			return panelLanguage.get();
		default:
			assert(false && "Not implemented Panel");
			return nullptr;
		}
	}
}

CPanelMan::CPanelMan(tgui::Gui &gui) :
	_gui(gui), _want_quit(false) {

	panelDeath = std::make_unique<CPanelDeath>(this);
	panelStart = std::make_unique<CPanelStart>(this);
	panelControl = std::make_unique<CPanelControl>(this);
	panelAudio = std::make_unique<CPanelAudio>(this);
	panelLoad = std::make_unique<CPanelLoad>(this);
	panelSave = std::make_unique<CPanelSave>(this);
	panelLanguage = std::make_unique<CPanelLanguage>(this);
}

CPanelMan::~CPanelMan() {
	// delete the panels before the manager to free gui resources
	panelDeath.reset();
	panelStart.reset();
	panelControl.reset();
	panelAudio.reset();
	panelLoad.reset();
	panelSave.reset();
	panelLanguage.reset();
}

void CPanelMan::ChangePanel(Panel panel) {
	auto changed = getPanel(panel);

	// cleanup the current panel
	if (!_panels.empty()) {
		_panels.back()->Cleanup();
		_panels.pop_back();
	}

	// store and init the new panel
	_panels.push_back(changed);
	_panels.back()->Init();
}

void CPanelMan::PushPanel(Panel panel) {
	auto pushed = getPanel(panel);

	// pause current panel
	if (!_panels.empty()) {
		_panels.back()->Pause();
	}

	// store and init the new panel
	_panels.push_back(pushed);
	_panels.back()->Init();
}

void CPanelMan::PopPanel() {
	// cleanup the current panel
	if (!_panels.empty()) {
		_panels.back()->Cleanup();
		_panels.pop_back();
	}

	// resume previous panel
	if (!_panels.empty()) {
		_panels.back()->Resume();
	}
}

void CPanelMan::PopAllPanels() {
	// cleanup the all panels
	while (!_panels.empty()) {
		_panels.back()->Cleanup();
		_panels.pop_back();
	}
}

void CPanelMan::Quit() {
	_want_quit = true;
	tgui::Timer::scheduleCallback([this](){ this->PopAllPanels(); });
}
