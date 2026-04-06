
#include <stdio.h>
#include <stdbool.h>
#include "sky/sky.h"

extern "C" {
	void CPP_sendTweet(int which) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
	void CPP_newGameAlert(bool on) { printf("FAKE: %s\n", __PRETTY_FUNCTION__); }
}
