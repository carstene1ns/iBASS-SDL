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


#import "iBASSAppDelegate.h"
#import "iphone_util.h"
#include <dlfcn.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#include "sky.h"
#include "skydefs.h"

iBASSAppDelegate *g_AppDelegate;

extern void standalone_main(void);

@implementation iBASSAppDelegate

//@synthesize window;
//@synthesize glView;
@synthesize animationTimer;
@synthesize animationInterval;
@synthesize gameTimer;
@synthesize gameTimerInterval;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	//hide the status bar
	[application setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
	[application setStatusBarHidden:YES animated:YES];
	application.idleTimerDisabled = YES;

	//global pointer this ap delegate
	g_AppDelegate=self;
	
	//tony's global ascii stuff
	_ascii = [ascii alloc];
	
	
	//simulator starts rotated!!
	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;

	
	/* Set working directory to resource path */
	[[NSFileManager defaultManager] changeCurrentDirectoryPath: [[NSBundle mainBundle] resourcePath]];
	
	
	//init the window programmatically.
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
	window.backgroundColor = [UIColor blackColor];  
	[window makeKeyAndVisible];  
	
	glView = [[iPhoneView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	[window addSubview:glView];

	m_transitioning=false;
	_paused=false;
	
	//reg with us
	if	(!dlsym(RTLD_DEFAULT, "MFMailComposeErrorDomain"))
		[self performSelectorInBackground:@selector(phoneHome:) withObject:@"0"];
	else
		[self performSelectorInBackground:@selector(phoneHome:) withObject:@"3"];
	
	
	//call our main
	standalone_main();

	//50hz timer
	self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.020 target:self selector:@selector(gameTimerTick) userInfo:nil repeats:YES];
	
	//set up timer for main game
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.032 target:self selector:@selector(runGameCycle) userInfo:nil repeats:YES];
}

- (void)gameTimerTick
{
	Sky::g_engine->gotTimerTick();
}

- (void)runGameCycle
{
	Sky::g_engine->runGameCycle();
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startControlPanel: (int) dir;
{
	//this wont berequired when we tell the game engine to stop processing when not in game mode
	if	(m_transitioning)	return;
	
	m_transitioning=true;

	//printf("startControlPanel\n");
	
	//create the sub views
	controlPanel = [[ControlPanelView alloc] init];//WithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[controlPanel setup];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	
	if	(!dir)
		myTrans.subtype=kCATransitionFromLeft;
	else
		myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[window addSubview:controlPanel.view];
	
//	[glView removeFromSuperview];	//this stops the mouse working on the new view! Why???!
	glView.hidden=YES;
	Sky::g_engine->pauseEngine();

	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)endControlPanel
{
//	printf("End Control Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	
	[[window layer] addAnimation:myTrans forKey:nil];
	
	//remove control panel
	[controlPanel.view removeFromSuperview];
	[controlPanel dealloc];//kill it

	//back to game
	m_transitioning=false;
	glView.hidden=NO;
	Sky::g_engine->unPauseEngine();

}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startAudioPanel
{
//	printf("startAudioPanel\n");
	
	//create the control panel
	audioPanel = [[AudioPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];// initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[audioPanel setup];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[controlPanel.view removeFromSuperview];	//remove the control panel, but dont kill it
	[window addSubview:audioPanel];
	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)endAudioPanel
{
//	printf("End Audio Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[audioPanel removeFromSuperview];
	[audioPanel dealloc];//kill it

	//bring back the control panel
	[window addSubview:controlPanel.view];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startSavePanel
{
//	printf("startSavePanel\n");
	
	//create the control panel
	savePanel = [[SavePanelView alloc]  initWithFrame:[[UIScreen mainScreen] bounds]];//WithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[savePanel setup];

	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];

	[[window layer] addAnimation:myTrans forKey:nil];
	[controlPanel.view removeFromSuperview];	//remove the control panel, but dont kill it
	[window addSubview:savePanel];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)endSavePanel
{
//	printf("End Save Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[savePanel removeFromSuperview];
	[savePanel dealloc];//kill it
	
	//bring back the control panel
	[window addSubview:controlPanel.view];
}
- (void)uberEndSavePanel
{
//	printf("End Save Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[savePanel removeFromSuperview];
	[savePanel dealloc];//kill it
	
	//remove control panel
	[controlPanel.view removeFromSuperview];
	[controlPanel dealloc];//kill it

	//back to game
	m_transitioning=false;
	glView.hidden=NO;
	Sky::g_engine->unPauseEngine();

}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startLoadPanel: (int) who;
{
//	printf("startLoadPanel %d\n", who);
	
	//remember who asked for the Load screen
	_Restore_panel_caller=who;
	
	//create the control panel
	loadPanel = [[LoadPanelView alloc] initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[loadPanel setup];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	
	//remove calling view
	if (!who)
	{
		[controlPanel.view removeFromSuperview];	//remove the control panel, but dont kill it
	}
	else if (who==1)//start menu
	{
		[startPanel removeFromSuperview];	//remove the start panel, but dont kill it
	}
	else if (who==2)//death screen
	{
		[deathPanel removeFromSuperview];	//remove the death panel, but dont kill it
	}

	[window addSubview:loadPanel];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)endLoadPanel
{
//printf("End Load Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[loadPanel removeFromSuperview];
	[loadPanel dealloc];//kill it
	
	//bring back the calling panel - in a really poor way
	if (!_Restore_panel_caller)
	{
		[window addSubview:controlPanel.view];
	}
	else if (_Restore_panel_caller==1)
	{
		[window addSubview:startPanel];
	}
	else
	{
		[window addSubview:deathPanel];
	}
	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)uberEndLoadPanel//tony5june09
{
	//called after game restore to go straight back to game
//	printf("Uber End Load Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];

	//always remove load panel view
	[loadPanel removeFromSuperview];
	[loadPanel dealloc];//kill it
	
	//remove parent view
	if (_Restore_panel_caller==1)
	{
		[startPanel removeFromSuperview];
		[startPanel dealloc];//kill it
	}
	else if (_Restore_panel_caller==2)
	{
		[deathPanel removeFromSuperview];
		[deathPanel dealloc];//kill it
	}
	else
	{
		//remove control panel
		[controlPanel.view removeFromSuperview];
		[controlPanel dealloc];//kill it
	}
	//back to game
	m_transitioning=false;
	glView.hidden=NO;
	Sky::g_engine->unPauseEngine(false);//start game doing its thing again
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startHelpPanel
{
	//this wont berequired when we tell the game engine to stop processing when not in game mode
	if	(m_transitioning)	return;
	
	m_transitioning=true;
//	printf("startHelpPanel\n");
	
	//create the sub views
	helpPanel = [[HelpPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[helpPanel setup];
		
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		
	[[window layer] addAnimation:myTrans forKey:nil];
	[window addSubview:helpPanel];

	glView.hidden=YES;
	Sky::g_engine->pauseEngine();	//stop the game doing much
}
- (void)endHelpPanel
{
//	printf("End Help Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[helpPanel removeFromSuperview];
	[helpPanel dealloc];//kill it
	
	//back to game
	m_transitioning=false;
	glView.hidden=NO;
	Sky::g_engine->unPauseEngine();
	//Sky::g_engine->giveSystem()->pauseAudioForMenu(false);

}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startStartPanel
{
	printf("startStartPanel\n");
	
	//create the sub views
	startPanel = [[StartPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//initWithImage:[UIImage imageNamed:@"bg_w_logo.png"]];

	if	(Sky::g_engine->giveScriptVar(23)==42)
		[startPanel setup:1];
	else
		[startPanel setup:0];
		
	[window addSubview:startPanel];
	glView.hidden=YES;
	Sky::g_engine->pauseEngine();	//stop the game doing much
}
- (void)endStartPanel: (bool)transition
{
//	printf("End Start Panel\n");
	
	if(transition)
	{
		//transition animation
		CATransition	*myTrans = [ CATransition animation ];
		myTrans.type=kCATransitionPush;
		myTrans.subtype=kCATransitionFromRight;
		[myTrans setDuration:0.5];
		[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		[[window layer] addAnimation:myTrans forKey:nil];
	}
	[startPanel removeFromSuperview];
	[startPanel dealloc];//kill it
	
	//back to game
	m_transitioning=false;
	glView.hidden=NO;
}
- (void)restartStartPanel:(int)n;
{
//	printf("RESTART Start Panel\n");
	
	[startPanel removeFromSuperview];
	[startPanel dealloc];//kill it
	
	startPanel = [[StartPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[startPanel setup:n];
	[window addSubview:startPanel];
	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startHintPanel: (Hint*) hint;
{

//	printf("startHintPanel\n");
	
	//create the sub views
	hintPanel = [[HintPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];;//initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[hintPanel setup:hint];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[window addSubview:hintPanel];
}
- (void)endHintPanel
{
//	printf("End Hint Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[hintPanel removeFromSuperview];
	[hintPanel dealloc];//kill it

	//bring back the help screen
	[window addSubview:helpPanel];
	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startDeathPanel
{
//	printf("startDeathPanel\n");
	

	
	//create the sub views
	deathPanel = [[DeathPanelView alloc] initWithImage:[UIImage imageNamed:@"bg_death.png"]];
	[deathPanel setup];
	
	//transition animation
/*	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:10.2];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	[[window layer] addAnimation:myTrans forKey:nil];
*/
	[window addSubview:deathPanel];

	glView.hidden=YES;
	Sky::g_engine->pauseEngine(false);	//stop the game doing much // false==no menu music
}
- (void)endDeathPanel
{
	//printf("End Death Panel\n");
	
	[deathPanel removeFromSuperview];
	[deathPanel dealloc];//kill it
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	[[window layer] addAnimation:myTrans forKey:nil];
	

	//back to game
	m_transitioning=false;
	glView.hidden=NO;
	Sky::g_engine->unPauseEngine();

//	Sky::g_engine->giveSystem()->pauseAudioForMenu(false);

	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startLangPanel:(int)from;//tony28july09
{
	printf("startLangPanel\n");
	_Restore_panel_caller=from;
	
	//create
	langPanel = [[LangPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];// initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[langPanel setup:YES];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[controlPanel.view removeFromSuperview];	//remove the control panel, but dont kill it
	[window addSubview:langPanel];
}
- (void)endLangPanel//tony28july09
{
	//printf("End Lang Panel\n");
	


	[langPanel removeFromSuperview];
	[langPanel dealloc];//kill it

	//bring back the control panel
	if	(!_Restore_panel_caller)//control
	{
		m_transitioning=false;
		
		//remove the old one completely, and re-init, this way we get the buttons rebuild in a potentially new language
		[controlPanel.view removeFromSuperview];
		[controlPanel dealloc];//kill it
		[self startControlPanel:1];
		//[window addSubview:controlPanel.view];
	}
	else//bring back the start menu
	{
		//transition animation
		CATransition	*myTrans = [ CATransition animation ];
		myTrans.type=kCATransitionPush;
		myTrans.subtype=kCATransitionFromRight;
		[myTrans setDuration:0.5];
		[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		[[window layer] addAnimation:myTrans forKey:nil];

		//remove the old one completely, and re-init, this way we get the buttons rebuild in a potentially new language
		[startPanel removeFromSuperview];
		[startPanel dealloc];
		[self startStartPanel];
	}
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startInstructPanel: (int) which//tony4aug09
{
	//printf("startInstructPanel %d\n", which);
	
	//create the sub views
	instructPanel = [[InstructPanelView alloc] initWithImage:[UIImage imageNamed:@"bg_plain.png"]];
	[instructPanel setup:which];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	[[window layer] addAnimation:myTrans forKey:nil];

	[window addSubview:instructPanel];
}
- (void)endInstructPanel;//tony4aug09
{
	//printf("End InstructPanel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[instructPanel removeFromSuperview];
	[instructPanel dealloc];//kill it

	//bring back the help screen
	[window addSubview:helpPanel];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startTwitterPanel
{
//	printf("startTwitterPanel\n");
	
	//create the control panel
	twitterPanel = [[TwitterPanelView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[twitterPanel setup];
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromLeft;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[controlPanel.view removeFromSuperview];	//remove the control panel, but dont kill it
	[window addSubview:twitterPanel];
	
}
//~~~
- (void)endTwitterPanel
{
//	printf("End Twitter Panel\n");
	
	//transition animation
	CATransition	*myTrans = [ CATransition animation ];
	myTrans.type=kCATransitionPush;
	myTrans.subtype=kCATransitionFromRight;
	[myTrans setDuration:0.5];
	[myTrans setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:myTrans forKey:nil];
	[twitterPanel removeFromSuperview];
	[twitterPanel dealloc];//kill it

	//bring back the control panel
	[window addSubview:controlPanel.view];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(void)sendTweet:(int)which//tony7aug09
{
	//has user, pw and is switched on
	if	(Sky::g_engine->hasTwitterPassword() && Sky::g_engine->hasTwitterUsername() && Sky::g_engine->giveTwitterOnOff())
	{
		//rotate to landscape for upcoming in-game tweet alert box
		//[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;

		//get message
		NSString	*message=[[NSString alloc] initWithString:[self ASCII:which] ];;
		//start thread
		[self performSelectorInBackground:@selector(tweetAction:) withObject:message];
	}
}
-(void)sendTestTweet
{
	NSString	*message=[[NSString alloc] initWithString:[self ASCII:1234] ];;

	[self performSelectorInBackground:@selector(tweetAction:) withObject:message];

}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)tweetAction: (NSString*)message	//tony5aug09
{
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];




	//****
    // Convert the C-String arguments into Twitter-happy escaped format
    NSString *unpw = [[NSString stringWithFormat:@"%@:%@", [NSString stringWithCString:(Sky::g_engine->giveTwitterUsername()) encoding:NSUTF8StringEncoding],
                         [NSString stringWithCString:(Sky::g_engine->giveTwitterPassword()) encoding:NSUTF8StringEncoding]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		 
    //NSString *tweet = [[NSString stringWithCString:"Hello from iBASS :) - be vigilant!" encoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *body = [NSString stringWithFormat: @"source=iBASS&status=%@", message];

    // Establish the Twitter API request
    id baseurl = [NSString stringWithFormat:@"http://%@@twitter.com/statuses/update.xml", unpw];
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    if (urlRequest)
    {
		[urlRequest setHTTPMethod: @"POST"];
		[urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
		[urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[urlRequest setValue:@"iBASS" forHTTPHeaderField:@"X-Twitter-Client"];

		// Contact Twitter and recover its response
	//	printf("Contacting Twitter Server. pw=[%s]\n",(Sky::g_engine->giveTwitterPassword()));

		NSError *error;
		NSURLResponse *response;
		NSData* result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];

		if (!result)
		{
	//		printf("Submission Error : %s\n", [[error localizedDescription] UTF8String]);
			
			alert=[[UIAlertView alloc] initWithTitle:@"twitter" message:[self ASCII:1236] delegate:self cancelButtonTitle:nil otherButtonTitles:[self ASCII:1256], nil];			 
			[alert show];

			[apool release];
			return;
		}

		// Check to see if there was an authentication error. If so, report it.
		NSString *outstring = [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease];

		if ([outstring rangeOfString:@"authenticate"].location != NSNotFound)
		{
	//		 printf("Fail [%s]\n", [outstring UTF8String]);
			alert=[[UIAlertView alloc] initWithTitle:@"twitter" message:[self ASCII:1237] delegate:self cancelButtonTitle:nil otherButtonTitles:[self ASCII:1256], nil];			 
			[alert show];
		}
		else 
		{
	//		printf("Done [%s]\n",[outstring UTF8String]);
			alert=[[UIAlertView alloc] initWithTitle:@"twitter" message:[self ASCII:1235] delegate:self cancelButtonTitle:nil otherButtonTitles:[self ASCII:1256], nil];			 
			[alert show];
		}
	}
	else
	{
//		printf("Error creating URL Request.\n");
	}
	//****

	
	[apool release];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)etPhoneHome:(NSString*)n	//tony6sep09
{
	[self performSelectorInBackground:@selector(phoneHome:) withObject:n];
}
- (void)phoneHome:(NSString*)n	//tony6sep09
{
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];

    // Establish the Twitter API request
    id baseurl = [NSString stringWithFormat:@"http://revolution.co.uk/ibreg.php?n=%@",n];
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    if (urlRequest)
    {
		[urlRequest setHTTPMethod: @"POST"];
		[urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

		NSError *error;
		NSURLResponse *response;
		[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	}
	else
	{
//		printf("Error creating URL Request.\n");
	}
	//****

	[apool release];
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
-(void)savedOK
{
	alert=[[UIAlertView alloc] initWithTitle:[g_AppDelegate ASCII:1250] message:[g_AppDelegate ASCII:1251] delegate:self cancelButtonTitle:nil otherButtonTitles:[g_AppDelegate ASCII:1256], nil];
	[alert show];
}
//----------------------------------------------------------------------------------------------------------------------------------
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[ alert release];
	//rotate up
	//[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
}
//------------------------------------------------------------------
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-(void)newGameAlert:(bool)on
{
	//rotate!!
	//[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;

//	alert=[[UIAlertView alloc] initWithTitle:[self ASCII:1255] message:[_ascii giveLine:1243] delegate:self cancelButtonTitle:nil otherButtonTitles:[_ascii giveLine:1256], nil];			 
//	[alert show];

	if	(on)
	{
		revAlert = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 360, 40)];
		revAlert.textColor = [UIColor whiteColor];
		[revAlert setText:[_ascii giveLine:1243]];
		[revAlert setFont:[UIFont systemFontOfSize:16]];
		revAlert.backgroundColor = [UIColor clearColor];
		revAlert.lineBreakMode = UILineBreakModeWordWrap;
		revAlert.textAlignment = UITextAlignmentLeft;
		revAlert.numberOfLines = 0;
		
		#define degreesToRadians(x) (M_PI * x / 180.0)
		revAlert.transform = CGAffineTransformRotate(revAlert.transform, degreesToRadians(90));
		
		revAlert.frame=CGRectMake(-20,70, 360, 340);//y(0=centre),x,w,h
		
		[glView addSubview:revAlert];//add to the view
	}
	else
	{
		//remove
		[revAlert removeFromSuperview];
		[revAlert dealloc];
	}
}

- (void)applicationWillResignActive:(UIApplication*)application
{
	printf("INTERUPTED\n");
	_paused=true;
}
- (void)applicationDidBecomeActive:(UIApplication*)application
{
	printf("RESUMED\n");
	_paused=false;
}
- (bool)appIsPaused
{
	return	_paused;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)resetSleepFlag//meh
{
	[UIApplication sharedApplication].idleTimerDisabled = NO;
	[UIApplication sharedApplication].idleTimerDisabled = YES;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (NSString	*)ASCII: (int) line
{
	return	[_ascii giveLine:line];
}

- (NSString	*)BUTTON: (NSString *) button
{
	return	[_ascii giveButton:button];
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
- (void) moviePlayBackDidBegin:(NSNotification*)notification
{
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerContentPreloadDidFinishNotification object:mOutroPlayer];
	
	printf("** movie begins\n");
	[mOutroPlayer play];

	//non english then subs
	if (Sky::g_engine->giveLanguageFlag()!=SKY_ENGLISH && Sky::g_engine->giveLanguageFlag()!=SKY_USA)
		[self performSelectorInBackground:@selector(movieSubtitles:) withObject:nil];
	
	[apool release];
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	printf("** movie ENDs\n");
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:mOutroPlayer];
	[mOutroPlayer release];

	//as we cant safety restart this game ...
	exit(0);
}
- (void)endMovie//tony1sep09
{
	Sky::g_engine->giveSystem()->stopMusic();
	Sky::g_engine->giveSystem()->clearPauseFlag();

	printf("END movie!\n");
	
	//reg with us
	[self performSelectorInBackground:@selector(phoneHome:) withObject:@"1"];


    NSURL *mMovieURL;
	
	//play outro movie
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"outro" ofType:@"m4v"];
	mMovieURL = [NSURL fileURLWithPath:moviePath];
	
	mOutroPlayer = [[MPMoviePlayerController alloc] initWithContentURL:mMovieURL];
	
	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(endMoviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:mOutroPlayer];

    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidBegin:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:mOutroPlayer];
											   	
	//hide control options
	mOutroPlayer.movieControlMode = MPMovieControlModeHidden;
	
	//set orientation
	[mOutroPlayer setOrientation:UIDeviceOrientationLandscapeLeft animated:NO];

    // Add our overlay view to the movie player's subviews so it’s 
    // displayed above it.
	subLabel = [[UILabel alloc]initWithFrame:CGRectMake(-170,220, 410, 40)];
	subLabel.textColor = [UIColor whiteColor];
	[subLabel setFont:[UIFont systemFontOfSize:14]];
//	subLabel.backgroundColor = [UIColor blackColor];
	subLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	subLabel.lineBreakMode = UILineBreakModeWordWrap;
	subLabel.textAlignment = UITextAlignmentCenter;
	subLabel.numberOfLines = 0;
	
	#define degreesToRadians(x) (M_PI * x / 180.0)
	subLabel.transform = CGAffineTransformRotate(subLabel.transform, degreesToRadians(90));
}
//--------------------------
-(void)movieSubtitles: (int)blah
{
	double	base= CFAbsoluteTimeGetCurrent();	//(int)([[NSDate date] timeIntervalSince1970]);
	double	n;
	int	done=0;

	bool	finished=false;
	label_on=false;

	#define	NUM_SUBS 4
	
	typedef struct
	{
		int	s;//frames in
		int	l;//frames live
	} _sub;
	
	_sub		subs[NUM_SUBS]=
	{
		{600,38},//A few years later…", //1488
		{1122,48},//In a world were all are free, the price of liberty is enslavement.", //1489
		{1180,43},//Be Vigilant", //1490
		{1000000,0},//end
	};
	
	
	printf("thread start\n");

	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	
	#define	MOFF	12
	
	do
	{
		n=CFAbsoluteTimeGetCurrent();
		n-=base;
	//	printf("n=%f\n", n);
		
		if (n>= ((MOFF+subs[done].s)/12))
		{
			NSString	*name = [NSString stringWithFormat:[g_AppDelegate ASCII:(1354+done)]];
			[self performSelectorOnMainThread : @ selector(setSubtitle: ) withObject:name waitUntilDone:YES];
			done++;
		}
		else if (label_on && (n>= ((MOFF+subs[done-1].s)+subs[done-1].l)/12))//no subtitle, remove current if there is one, then sleep a bit
		{
			//remove label
			[self performSelectorOnMainThread : @ selector(removeSubtitle) withObject:nil waitUntilDone:YES];
			
			//finished?
			if	(1000000==subs[done].s)
				finished=true;
		}
		[NSThread sleepForTimeInterval:0.1];
	}
	while(!finished);

	if(label_on)
		[self performSelectorOnMainThread : @ selector(removeSubtitle) withObject:nil waitUntilDone:YES];
	
	[apool release];
	printf("thread end\n");
}
//-------------------------------

-(void)setSubtitle:(NSString*)text
{
	//welcome back to the main thread!!
	
	NSLog(text);
	
	[subLabel setText:text];
	
	if (!label_on)
	{
		NSArray *windows = [[UIApplication sharedApplication] windows];
		// Locate the movie player window
		UIWindow *moviePlayerWindow = [windows objectAtIndex:1];
		[moviePlayerWindow addSubview:subLabel];//add to the view

		label_on=true;
	}
}
-(void)removeSubtitle
{
	//welcome back to the main thread!!
	
	printf("remove\n");
	label_on=false;
	//remove label
	[subLabel removeFromSuperview];
	//[subLabel setText:@""];
}
//---------------------------------------------------------------------------------------------------------------------------------


@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
const char *iPhone_getDocumentsDir() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory UTF8String];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int	returnIPhoneLanguage()//tony28july09
{
	//return the language iphone is set to - or english if not supported

	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	NSArray* languages = [defs objectForKey:@"AppleLanguages"];
	NSString* preferredLang = [languages objectAtIndex:0];

	if([preferredLang compare:@"fr"] == NSOrderedSame)
		return	SKY_FRENCH;

	if([preferredLang compare:@"de"] == NSOrderedSame)
		return	SKY_GERMAN;

	if([preferredLang compare:@"it"] == NSOrderedSame)
		return	SKY_ITALIAN;

	if([preferredLang compare:@"es"] == NSOrderedSame)
		return	SKY_SPANISH;

	if([preferredLang compare:@"pt"] == NSOrderedSame)
		return	SKY_PORTUGUESE;

	if([preferredLang compare:@"sv"] == NSOrderedSame)
		return	SKY_SWEDISH;

/*	if([preferredLang compare:@"us"] == NSOrderedSame)
	{
		printf("U S  of A\n");
		return	SKY_USA;
	}*/
		
	return	SKY_ENGLISH;

}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bool	isUSA()//tony28july09
{
	NSLocale *currentLocale = [NSLocale currentLocale];
	NSString *localeString = [currentLocale localeIdentifier];
	
	if([localeString compare:@"en_US"] == NSOrderedSame)
		return	true;
		
	return	false;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void	CPP_sendTweet(int which)//tony8aug09
{
	[g_AppDelegate sendTweet:which];
}
void	CPP_newGameAlert(bool	on)//tony11aug09
{
	[g_AppDelegate newGameAlert:on];
}
//CPP glue
void CPP_startControlPanel(void)
{
//	Sky::g_engine->giveSystem()->pauseAudioForMenu(true);
	[g_AppDelegate startControlPanel:0];
}
void CPP_startHelpPanel(void)
{
//	Sky::g_engine->giveSystem()->pauseAudioForMenu(true);
	[g_AppDelegate startHelpPanel];
}
void CPP_startStartPanel(bool	language)
{
//	Sky::g_engine->giveSystem()->pauseAudioForMenu(true);

	//language?
/*	if	(!language)
	{
		printf("FIRST time - give lang options\n");
		[g_AppDelegate startInitialLangPanel];
	}
	else
	{
*/
		[g_AppDelegate startStartPanel];
//	}
}

void CPP_startDeathPanel(void)
{
//	Sky::g_engine->giveSystem()->pauseAudioForMenu(false);
	[g_AppDelegate startDeathPanel];
}

void CPP_endMovie()
{
	[g_AppDelegate endMovie];
}

bool	CPP_appIsPaused()//tony3sep09
{
	return	[g_AppDelegate appIsPaused];
}