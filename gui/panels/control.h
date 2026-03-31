
#ifndef GUI_PANELCONTROL_H
#define GUI_PANELCONTROL_H

#include "gui/panel.h"

class CPanelControl final : public CPanel {
public:
	explicit CPanelControl(CPanelMan *mgr);
	~CPanelControl();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::Button::Ptr loadButton;
	tgui::Button::Ptr saveButton;

	// gui actions
	void backToGame();
	void showLoadPanel();
	void showSavePanel();
	void showAudioPanel();
	void showLanguagePanel();
	void showCredits();
	void quitGame();
};

#endif // GUI_PANELCONTROL_H
