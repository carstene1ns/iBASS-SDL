
#ifndef GUI_PANELLANGUAGE_H
#define GUI_PANELLANGUAGE_H

#include "gui/panel.h"

class CPanelLanguage final : public CPanel {
public:
	explicit CPanelLanguage(CPanelMan *mgr);
	~CPanelLanguage();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::Label::Ptr langLabel;
	tgui::GrowVerticalLayout::Ptr langEntries;
	tgui::ToggleButton::Ptr textButton;
	tgui::ToggleButton::Ptr speechButton;

	// helpers
	void refreshGui();

	// gui actions
	void backToPanel();
	void picChangeLanguage(int id);
	void btnChangeLanguage(int id, bool isDown);
	void toggleTextOrSpeech(bool isText, bool isDown);
};

#endif // GUI_PANELLANGUAGE_H
