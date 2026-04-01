
#include <stdio.h>
#include <stdbool.h>
#include "sky/sky.h"

extern "C" {
	void CPP_sendTweet(int which) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	void CPP_newGameAlert(bool on) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	int	returnIPhoneLanguage() {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);
		return 0; //SKY_ENGLISH = 0, SKY_GERMAN = 1
	}
	bool isUSA() {
		printf("FAKE: %s\n", __PRETTY_FUNCTION__);
		return (returnIPhoneLanguage() == 0);
	}
}
