/*
 * Copyright (C) 2009 Revolution Software Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#import <UIKit/UIKit.h>
#import "control_panel.h"
#import "audio_panel.h"
#import "save_panel.h"
#import "load_panel.h"
#import "help_panel.h"
#import "hint_panel.h"
#import "start_panel.h"
#import "death_panel.h"
#import "lang_panel.h"
#import "instruct_panel.h"
#import "twitter_panel.h"
#import "ascii.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define YY(y) (290-y)
#define TRANS(b) CGAffineTransformRotate(b.transform, (M_PI * 90 / 180.0))

@class iPhoneView;//or #import "EAGLView.h"

@interface iBASSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iPhoneView *glView;

	ControlPanelView	*controlPanel;
	AudioPanelView		*audioPanel;
	SavePanelView		*savePanel;
	LoadPanelView		*loadPanel;
	HelpPanelView		*helpPanel;
	HintPanelView		*hintPanel;
	StartPanelView		*startPanel;
	DeathPanelView		*deathPanel;
	LangPanelView		*langPanel;
	InstructPanelView	*instructPanel;
	TwitterPanelView	*twitterPanel;
	int					_Restore_panel_caller;
	
	NSTimer *animationTimer;
	NSTimeInterval animationInterval;

	NSTimer *gameTimer;
	NSTimeInterval gameTimerInterval;
	
	bool m_transitioning;
	
	UIAlertView *alert;//tweet popup
	UILabel		*revAlert;//new game message not a system alert
	ascii	*_ascii;
	
	MPMoviePlayerController *mOutroPlayer;
	UILabel	*subLabel;
	bool	label_on;
	
	bool	_paused;//popup sets this
}

@property (nonatomic, assign) NSTimer *animationTimer;
@property NSTimeInterval animationInterval;
@property (nonatomic, assign) NSTimer *gameTimer;
@property NSTimeInterval gameTimerInterval;


- (void)gameTimerTick;
- (void)runGameCycle;
- (void)startControlPanel: (int) dir;
- (void)endControlPanel;
- (void)startAudioPanel;
- (void)endAudioPanel;
- (void)startSavePanel;
- (void)endSavePanel;
- (void)uberEndSavePanel;
- (void)startLoadPanel: (int) who;
- (void)endLoadPanel;
- (void)uberEndLoadPanel;//tony5june09
- (void)startHelpPanel;//tony6june09
- (void)endHelpPanel;//tony6june09
- (void)startHintPanel: (Hint*) hint;//tony18june09
- (void)endHintPanel;//tony18june09
- (void)startStartPanel;//tony11june09
- (void)endStartPanel: (bool)transition;//haha-tony11june09
- (void)restartStartPanel:(int)n;//12aug09
- (void)startDeathPanel;//tony8july09
- (void)endDeathPanel;//tony8july09
- (void)startLangPanel:(int)from;//tony28july09
- (void)endLangPanel;//tony28july09
- (void)startInstructPanel: (int) which;//tony4aug09
- (void)endInstructPanel;//tony4aug09
- (void)startTwitterPanel;//tony6aug09
- (void)endTwitterPanel;//tony6aug09
- (void)endMovie;//tony1sep09
- (void)setSubtitle:(NSString*)text;
- (void)removeSubtitle;
- (void)movieSubtitles: (int)blah;

- (void)sendTweet: (int)which;	//tony5aug09
- (void)tweetAction: (NSString*)message;	//tony5aug09
- (void)sendTestTweet;//tony8aug09
- (void)newGameAlert:(bool)on;//11aug
- (NSString	*)ASCII: (int) line;
- (NSString	*)BUTTON: (NSString *) button;
- (bool)appIsPaused;
- (void)phoneHome:(NSString*)n;	//tony6sep09
- (void)etPhoneHome:(NSString*)n;	//tony6sep09
- (void)savedOK;
- (void)resetSleepFlag;//meh


@end

extern "C"
{
	void CPP_startControlPanel(void);
	void CPP_startHelpPanel(void);
	void CPP_startStartPanel(bool movies);
	void CPP_startDeathPanel(void);
	void CPP_endMovie();
	bool	isUSA();//tony28july09
	int	returnIPhoneLanguage();//tony28july09
	void	CPP_sendTweet(int which);//tony8aug09
	void	CPP_newGameAlert(bool	on);//tony11aug09
	bool	CPP_appIsPaused();//tony3sep09
	}
