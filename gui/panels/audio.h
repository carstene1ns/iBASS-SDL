
#ifndef GUI_PANELAUDIO_H
#define GUI_PANELAUDIO_H

#include "gui/panel.h"

class CPanelAudio final : public CPanel {
public:
	explicit CPanelAudio(CPanelMan *mgr);
	~CPanelAudio();

	void Init() override;
	void Cleanup() override;

private:
	// acessible gui elements
	tgui::Slider::Ptr sfxSlider;
	tgui::Slider::Ptr musicSlider;
	tgui::Slider::Ptr speechSlider;

	// gui actions
	void backToSettings();

	void sfxVolumeChanged(float val);
	void musicVolumeChanged(float val);
	void speechVolumeChanged(float val);
};

#endif // GUI_PANELAUDIO_H
