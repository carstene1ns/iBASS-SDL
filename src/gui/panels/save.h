
#ifndef GUI_PANELSAVE_H
#define GUI_PANELSAVE_H

#include "gui/panel.h"

class CPanelSave final : public CPanel {
public:
	explicit CPanelSave(CPanelMan *mgr);
	~CPanelSave();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::VerticalTabs::Ptr savegameTabs;
	tgui::Button::Ptr confirmButton;

	// gui actions
	void backToPanel();
	void saveGame();
};

#endif // GUI_PANELSAVE_H
