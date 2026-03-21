
#include <stdio.h>
#include <stdbool.h>
#include "sky/sky.h"

extern "C" {

	void CPP_sendTweet(int which) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	void CPP_newGameAlert(bool on) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	void CPP_startStartPanel(bool movies) {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);

		// engine will crash trying to step without a loaded game
		Sky::g_engine->initNewGame();
	}
	void CPP_startDeathPanel() {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);

		// engine will deadlock otherwise
		exit(0);
	}
	void CPP_endMovie() { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	bool CPP_appIsPaused() {
		//printf("FAKE: %s\n", __PRETTY_FUNCTION__);
		return false;
	}
	int	returnIPhoneLanguage() {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);
		return 0; //SKY_ENGLISH = 0, SKY_GERMAN = 1
	}
	bool isUSA() {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);
		return (returnIPhoneLanguage() == 0);
	}
	void CPP_startControlPanel() { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	void CPP_startHelpPanel() { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }

}
