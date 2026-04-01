
#ifndef GUI_PANELMAN_H
#define GUI_PANELMAN_H

#include <vector>

// forward declarations
class CPanel;

using std::vector;

enum class Panel {
	Start,
	Death,
	Load,
	Save,
	Control,
	Audio,
	Language,
	//Help
};

class CPanelMan {
public:
	explicit CPanelMan(tgui::Gui &gui);
	~CPanelMan();

	void ChangePanel(Panel panel);
	void PushPanel(Panel panel);
	void PopPanel();
	void PopAllPanels();

	tgui::Gui *giveGui() {
		return &_gui;
	}

	void Quit();
	bool WantQuit() const { return _want_quit; }

protected:
	CPanelMan() = default;

private:
	// the stack of panels
	vector<CPanel*> _panels;

	tgui::Gui &_gui;
	bool _want_quit;
};

#endif // GUI_PANELMAN_H
