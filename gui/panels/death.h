
#ifndef GUI_PANELDEATH_H
#define GUI_PANELDEATH_H

#include "gui/panel.h"

class CPanelDeath final : public CPanel {
public:
	explicit CPanelDeath(CPanelMan *mgr);
	~CPanelDeath();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::Button::Ptr loadButton;
	tgui::Button::Ptr continueButton;

	// gui actions
	void continueGame();
	void loadGame();
	void quitGame();
};

#endif // GUI_PANELDEATH_H
