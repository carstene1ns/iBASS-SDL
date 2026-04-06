
#include <locale>

#include "runtime.h"
#include "sky/skydefs.h"

int returnSystemLanguage() {
	auto loc = std::locale("").name();
	std::string name;

	if(loc.size() > 2) {
		name = loc.substr(0, 2);
	} else {
		printf("Unable to determine locale: %s, using english\n", loc.c_str());
		return SKY_ENGLISH;
	}

	// this likely only works reliably under Linux
	if(name == "de") {
		return SKY_GERMAN;
	} else if (name == "fr") {
		return SKY_FRENCH;
	} else if (name == "se") {
		return SKY_SWEDISH;
	} else if (name == "it") {
		return SKY_ITALIAN;
	} else if (name == "pt") {
		return SKY_PORTUGUESE;
	} else if (name == "es") {
		return SKY_SPANISH;
	}

	// default is english
	return SKY_ENGLISH;
}

bool isUSA() {
	auto loc = std::locale("").name();

	// USA
	return (loc.substr(0, 5) == "en_US");
}
