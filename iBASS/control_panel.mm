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

#include "control_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "iphone_common.h"
#import <MessageUI/MessageUI.h>

extern	iBASSAppDelegate *g_AppDelegate;




@implementation ControlPanelView

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{

	//Fix audio output that MPMoviePlayer wrecked...
	Sky::g_engine->giveSystem()->alContextHack();
	


//	mCreditsPlayer = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:mCreditsPlayer];
		
	[mCreditsPlayer release];
	
	[g_AppDelegate resetSleepFlag];	//sleep mode is broken by movie player
	
	iPhone_playMusic(8, 1);
}

- (void)setup
{

	//replace the view controllers default UIView
	IView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
		//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	IView.userInteractionEnabled=YES;
	self.view=IView;


	//Restore
	UIButton *myButton2= [[UIButton alloc] init];
//	myButton2.frame = CGRectMake(26,20, 268, 42);
	myButton2.transform = TRANS(myButton2);
	myButton2.frame=CGRectMake(YY(50),20, 42, 258);//y,x,h,w
	myButton2.backgroundColor = [UIColor clearColor];
	[myButton2 addTarget:self action:@selector(loadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:myButton2];//add to the view
	myButton2.enabled=NO;
	//switch off restore button if no saves
	for (int j=0;j<MAX_saves;j++)
		if(Sky::g_engine->slotUsed(j))
		{	myButton2.enabled=YES;
			break;
		}



	//Save
	UIButton *myButton3= [[UIButton alloc] init];
//	myButton3.frame = CGRectMake(26,70, 268, 42);
	myButton3.transform = TRANS(myButton3);
	myButton3.frame=CGRectMake(YY(100),20, 42, 258);//y,x,h,w

	myButton3.backgroundColor = [UIColor clearColor];
	[myButton3 addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:myButton3];//add to the view

	[myButton2 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_restoregame_on.png"] ] forState:UIControlStateNormal];
	[myButton2 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_restoregame_press.png"] ] forState:UIControlStateHighlighted];
	[myButton3 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_savegame_on.png"] ] forState:UIControlStateNormal];
	[myButton3 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_savegame_press.png"] ] forState:UIControlStateHighlighted];
	
	if (Sky::g_engine->canLoadGameStateCurrently()==false)
	{		printf("Load not allowed\n");
		//switch off save and restore menu buttons
		myButton2.enabled = NO;
		myButton3.enabled = NO;
//		[myButton2 setBackgroundImage:[UIImage imageNamed:@"btn_restoregame_off.png" ] forState:UIControlStateNormal];
//		[myButton3 setBackgroundImage:[UIImage imageNamed:@"btn_savegame_off.png" ] forState:UIControlStateNormal];
	}
	else
	{
	}

	
	//Audio
	UIButton *myButton4= [[UIButton alloc] init];
//	myButton4.frame = CGRectMake(26,120, 268, 42);
	myButton4.transform = TRANS(myButton4);
	myButton4.frame=CGRectMake(YY(150),20, 42, 258);//y,x,h,w

	myButton4.backgroundColor = [UIColor clearColor];
	[myButton4 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_audio_on.png"] ] forState:UIControlStateNormal];
	[myButton4 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_audio_press.png"] ] forState:UIControlStateHighlighted];
	[myButton4 addTarget:self action:@selector(audioButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:myButton4];//add to the view
	
	//languages
	UIButton *langButton= [[UIButton alloc] init];
//	langButton.frame = CGRectMake(26,170, 268, 42);
	langButton.transform = TRANS(langButton);
	langButton.frame=CGRectMake(YY(200),20, 42, 258);//y,x,h,w

	langButton.backgroundColor = [UIColor clearColor];
	[langButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_langopts_on.png"]] forState:UIControlStateNormal];
	[langButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_langopts_on.png"]] forState:UIControlStateHighlighted];
	[langButton addTarget:self action:@selector(langButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:langButton];//add to the view
	
	
	
	//small ones
	//Twitter
	UIButton *twitterButton= [[UIButton alloc] init];
//	twitterButton.frame = CGRectMake(74,310-39, 176, 30);
	twitterButton.transform = TRANS(twitterButton);
	twitterButton.frame=CGRectMake(YY(128+47),290, 30, 176);//y,x,h,w
	
	twitterButton.backgroundColor = [UIColor clearColor];
	[twitterButton setBackgroundImage:[UIImage imageNamed:@"btn_twitter_on.png" ] forState:UIControlStateNormal];
	[twitterButton setBackgroundImage:[UIImage imageNamed:@"btn_twitter_press.png" ] forState:UIControlStateHighlighted];
	[twitterButton addTarget:self action:@selector(twitterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:twitterButton];//add to the view

	//Credits
	UIButton *myButton5= [[UIButton alloc] init];
//	myButton5.frame = CGRectMake(74,310, 176, 30);
	myButton5.transform = TRANS(myButton5);
	myButton5.frame=CGRectMake(YY(165+47),290, 30, 176);//y,x,h,w

	myButton5.backgroundColor = [UIColor clearColor];
	[myButton5 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_credits_on.png"] ] forState:UIControlStateNormal];
	[myButton5 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_credits_press.png"] ] forState:UIControlStateHighlighted];
	[myButton5 addTarget:self action:@selector(creditsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:myButton5];//add to the view
	
	//Tell a friend
	UIButton *myButton6= [[UIButton alloc] init];
//	myButton6.frame = CGRectMake(74,349, 176,30);
	myButton6.transform = TRANS(myButton6);
	myButton6.frame=CGRectMake(YY(199+45),290, 30, 176);//y,x,h,w
	myButton6.backgroundColor = [UIColor clearColor];
	[myButton6 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_tellafriend_on.png"] ] forState:UIControlStateNormal];
	[myButton6 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_tellafriend_press.png"] ] forState:UIControlStateHighlighted];
	myButton6.enabled=NO;
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		//3.0
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[myButton6 addTarget:self action:@selector(friendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
			myButton6.enabled=YES;
		}
	}
    else
    {
		//<3.0
		myButton6.enabled=YES;
		[myButton6 addTarget:self action:@selector(launchMailAppOnDevice) forControlEvents:UIControlEventTouchUpInside];
    }

	[self.view addSubview:myButton6];//add to the view
	
	
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png" ]] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png" ]] forState:UIControlStateHighlighted];
//	backButton.frame = CGRectMake((160-(176>>1)),420, 176, 29);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w
	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:backButton];//add to the view



	
}

//----------------------------------------------------------------------------------------------------------------------------------

- (void)friendButtonPressed	//tony27may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	[controller setSubject:[g_AppDelegate ASCII:1260]];
	
    NSString *body = [NSString stringWithFormat: @"<html><body>%@<br><br>%@<br><br>%@<br><br>%@<br><br>%@<br><br><img src='http://www.revolution.co.uk/bass_g/SteelSkyLogo.png'/><br><b><font size=\"-2\">Beneath A Steel Sky &copy;2009 Revolution Software Ltd</font></b></body></html>", [g_AppDelegate ASCII:1261], [g_AppDelegate ASCII:1262], [g_AppDelegate ASCII:1263], [g_AppDelegate ASCII:1264], [g_AppDelegate ASCII:1265]];
	
	[controller setMessageBody:body isHTML:YES];
//	[controller setMessageBody:@"<html><body>Hey!<br><br>I'm playing the classic adventure 'Beneath a Steel Sky', revamped and updated exclusively for iPhone and iPod Touch.<br><br>Considered once of the best adventures ever written, the game now includes stunning new animated movies from Dave Gibbons, co-creator of ‘Watchmen’, a context-sensitive help system, a special new touch interface, improved audio and - well, lots of cool stuff.<br><br>Being such a wonderful, caring person, I wanted to share this with you. Just click on this link to see more about the game: http://appstore.revolution.co.uk/BASS<br><br>Check it out! And, be vigilant.<br><br><img src='http://www.revolution.co.uk/bass_g/SteelSkyLogo.png'/><br><b><font size=\"-2\">Beneath A Steel Sky &copy;2009 Revolution Software Ltd</font></b></body></html>" isHTML:YES];
	[self presentModalViewController:controller animated:YES];
	controller.mailComposeDelegate = self;
	[controller release];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}
//----------------------------------------------------------------------------------------------------------------------------------
// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    NSString *eMailBody = [NSString stringWithFormat: @"<html><body>%@<br><br>%@<br><br>%@<br><br>%@<br><br>%@<br><br><img src='http://www.revolution.co.uk/bass_g/SteelSkyLogo.png'/><br><b><font size=\"-2\">Beneath A Steel Sky &copy;2009 Revolution Software Ltd</font></b></body></html>", [g_AppDelegate ASCII:1261], [g_AppDelegate ASCII:1262], [g_AppDelegate ASCII:1263], [g_AppDelegate ASCII:1264], [g_AppDelegate ASCII:1265]];
 
	NSString *encodedBody = [eMailBody stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
	NSString *urlString = [NSString stringWithFormat:@"mailto:friend@friend.com?subject=iBASS&body=%@", encodedBody];

	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[[UIApplication sharedApplication] openURL:url];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)creditsButtonPressed	//tony27may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//play outro movie
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"credits" ofType:@"m4v"];
	mMovieURL = [NSURL fileURLWithPath:moviePath];
	
	mCreditsPlayer = [[MPMoviePlayerController alloc] initWithContentURL:mMovieURL];
	
	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:mCreditsPlayer];
	
	//hide control options
	mCreditsPlayer.movieControlMode = MPMovieControlModeHidden;
	
	//set orientation
	//[mCreditsPlayer setOrientation:UIDeviceOrientationPortrait animated:NO];
	
	[mCreditsPlayer play];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)twitterButtonPressed	//tony6aug09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	printf("twitter button\n");
	[g_AppDelegate startTwitterPanel];
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------

- (void)langButtonPressed	//tony28july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	printf("Lang button\n");
	[g_AppDelegate startLangPanel:0];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)backButtonPressed	//tony27may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate endControlPanel];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)audioButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate startAudioPanel];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)saveButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate startSavePanel];
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)loadButtonPressed	//tony2june09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate startLoadPanel:0];
}

//----------------------------------------------------------------------------------------------------------------------------------


- (void)dealloc
{
    [super dealloc];
}
//----------------------------------------------------------------------------------------------------------------------------------


@end
