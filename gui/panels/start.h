
#ifndef GUI_PANELSTART_H
#define GUI_PANELSTART_H

#include "gui/panel.h"

class CPanelStart final : public CPanel {
public:
	explicit CPanelStart(CPanelMan *mgr);
	~CPanelStart();

	void Init() override;
	void Cleanup() override;

	void show() override;

private:
	// acessible gui elements
	tgui::Button::Ptr loadButton;
	tgui::Button::Ptr continueButton;

	// gui actions
	void newGame();
	void showLoadPanel();
	void showLanguagePanel();
	void continueGame();
	void quitGame();
};

#endif // GUI_PANELSTART_H
