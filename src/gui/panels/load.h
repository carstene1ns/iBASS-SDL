
#ifndef GUI_PANELLOAD_H
#define GUI_PANELLOAD_H

#include "gui/panel.h"

class CPanelLoad final : public CPanel {
public:
	explicit CPanelLoad(CPanelMan *mgr);
	~CPanelLoad();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::VerticalTabs::Ptr savegameTabs;
	tgui::Button::Ptr confirmButton;

	// gui actions
	void backToPanel();
	void loadGame();
};

#endif // GUI_PANELLOAD_H
