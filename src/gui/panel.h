
#ifndef GUI_PANEL_H
#define GUI_PANEL_H

#include <cassert>

class CPanelMan;

class CPanel {
public:
	CPanel() = delete;
	virtual ~CPanel() = default;
	CPanel(const CPanel&) = delete; // non construction-copyable
	CPanel& operator=(const CPanel&) = delete; // non copyable

	virtual void Init() = 0;
	virtual void Cleanup() = 0;

	virtual void Pause() { hide(); };
	virtual void Resume() { show(); };

	virtual void show() { // default effect
		assert(_panel);
		if(!_panel->isVisible())
			_panel->showWithEffect(tgui::ShowEffectType::Fade, 800);
	}
	virtual void hide() { // default effect
		assert(_panel);
		if(_panel->isVisible())
			_panel->hideWithEffect(tgui::ShowEffectType::Fade, 800);
	}

protected:
	explicit CPanel(CPanelMan *mgr) : _mgr(mgr) {};

	CPanelMan *_mgr;
	tgui::Panel::Ptr _panel;

private:

};

#endif // GUI_PANEL_H
