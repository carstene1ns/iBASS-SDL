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

#import "start_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "skydefs.h"
#import <CoreGraphics/CoreGraphics.h>

extern	iBASSAppDelegate *g_AppDelegate;

@implementation StartPanelView

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidBegin:(NSNotification*)notification
{
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerContentPreloadDidFinishNotification object:mMoviePlayer];
	
	printf("** movie begins\n");
	[mMoviePlayer play];

	//non english then subs
	if (Sky::g_engine->giveLanguageFlag()!=SKY_ENGLISH && Sky::g_engine->giveLanguageFlag()!=SKY_USA)
		[self performSelectorInBackground:@selector(movieSubtitles:) withObject:nil];
	
	[apool release];
}

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	printf("** movie ENDs\n");
	//Fix audio output that MPMoviePlayer wrecked...
	Sky::g_engine->giveSystem()->alContextHack();

	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:mMoviePlayer];
	//new game
	[mMoviePlayer release];
	//close view button pressed - transition back to game

	Sky::g_engine->unPauseEngine();
	Sky::g_engine->initNewGame();

	[g_AppDelegate resetSleepFlag];	//sleep mode is broken by movie player
	[g_AppDelegate endStartPanel:false];

}


- (void)setup:(int)init
{

	//load images
	bgImage=	[[UIImage imageNamed:@"bg_w_logo.png"] retain];




	//continue game button
	continueButton= [[UIButton alloc] init];
	[continueButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_continue_on.png"]] forState:UIControlStateNormal];
	[continueButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_continue_press.png"]] forState:UIControlStateHighlighted];
	[continueButton addTarget:self action:@selector(continueButtonPressed) forControlEvents:UIControlEventTouchUpInside];

	if(Sky::g_engine->autoSaveExists())
		continueButton.enabled=YES;
	else
		continueButton.enabled=NO;
		
//	continueButton.frame = CGRectMake(60,305, 200, 32);
	continueButton.transform = TRANS(continueButton);
	continueButton.frame=CGRectMake(YY(70),235, 32, 180);//y,x,h,w
	
	[self addSubview:continueButton];//add to the view


	//load game button
	loadButton= [[UIButton alloc] init];
	[loadButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_restoregame_on.png"] ] forState:UIControlStateNormal];
	[loadButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_restoregame_press.png"] ] forState:UIControlStateHighlighted];
	[loadButton addTarget:self action:@selector(loadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	if(Sky::g_engine->savesExist())
		loadButton.enabled=YES;
	else
		loadButton.enabled=NO;

	loadButton.transform = TRANS(loadButton);
	loadButton.frame=CGRectMake(YY(120),235, 32, 180);//y,x,h,w
	[self addSubview:loadButton];//add to the view
	
	
	

	//new game button
	newGameButton= [[UIButton alloc] init];
	[newGameButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_newgame_on.png"] ] forState:UIControlStateNormal];
	[newGameButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_newgame_press.png"] ] forState:UIControlStateHighlighted];
//	newGameButton.frame = CGRectMake(60,305+80, 200, 32);
	newGameButton.transform = TRANS(newGameButton);
	newGameButton.frame=CGRectMake(YY(170),235, 32, 180);//y,x,h,w
	[newGameButton addTarget:self action:@selector(newButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:newGameButton];//add to the view

	//lang button
	langButton= [[UIButton alloc] init];
	[langButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_langopts_on.png"] ] forState:UIControlStateNormal];
	[langButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_langopts_press.png"] ] forState:UIControlStateHighlighted];
//	langButton.frame = CGRectMake(70,305+120, 180, 28);
	langButton.transform = TRANS(langButton);
	langButton.frame=CGRectMake(YY(220),235, 32, 180);//y,x,h,w

	[langButton addTarget:self action:@selector(langButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:langButton];//add to the view


	//watermark
	m_WaterMarkLabel = [[UILabel alloc]init];
	m_WaterMarkLabel.transform = TRANS(m_WaterMarkLabel);
	m_WaterMarkLabel.frame=CGRectMake(0,5, 15, 270);//y,x,h,w

	m_WaterMarkLabel.textColor = [UIColor grayColor];
	[m_WaterMarkLabel setText:@"v1.0"];//MC-5-120909-487r9ur7
	[m_WaterMarkLabel setFont:[UIFont systemFontOfSize:13]];
	m_WaterMarkLabel.backgroundColor = [UIColor clearColor];
	m_WaterMarkLabel.lineBreakMode = UILineBreakModeWordWrap;
	m_WaterMarkLabel.textAlignment = UITextAlignmentLeft;
	m_WaterMarkLabel.numberOfLines = 0;
	[self addSubview:m_WaterMarkLabel];//add to the view

}



- (void)loadButtonPressed	//tony11june09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate startLoadPanel:1];
//	[g_AppDelegate startControlPanel];
}

- (void)continueButtonPressed	//tony8july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	Sky::g_engine->loadGameState(0);//game slot 0 is the auto-saved game

	Sky::g_engine->unPauseEngine();
	[g_AppDelegate endStartPanel:true];
}



- (void)langButtonPressed	//tony8july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	[g_AppDelegate startLangPanel:1];

}

- (void)newButtonPressed	//tony11june09
{
	newGameButton.enabled=NO;
		
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	Sky::g_engine->giveSystem()->stopMusic();
	
	//reg with us
	[g_AppDelegate etPhoneHome:@"2"];

	//play intro movie
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *moviePath = [bundle pathForResource:@"intro" ofType:@"m4v"];
	mMovieURL = [NSURL fileURLWithPath:moviePath];
	
	mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:mMovieURL];

    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidBegin:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:mMoviePlayer];
											   
	// Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:mMoviePlayer];
	
	
	
	
	//hide control options
	mMoviePlayer.movieControlMode = MPMovieControlModeHidden;
	
	//set orientation
	[mMoviePlayer setOrientation:UIDeviceOrientationLandscapeLeft animated:NO];

	
//	[mMoviePlayer play];
	

    // Add our overlay view to the movie player's subviews so it’s 
    // displayed above it.

	subLabel = [[UILabel alloc]initWithFrame:CGRectMake(-170,220, 410, 40)];
	subLabel.textColor = [UIColor whiteColor];
	[subLabel setText:@"Movie overlay text? Oh yes, blessed is the Lord"];
	[subLabel setFont:[UIFont systemFontOfSize:14]];
	//subLabel.backgroundColor = [UIColor clearColor];
	subLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

	subLabel.lineBreakMode = UILineBreakModeWordWrap;
	subLabel.textAlignment = UITextAlignmentCenter;
	subLabel.numberOfLines = 0;
	
	#define degreesToRadians(x) (M_PI * x / 180.0)
	subLabel.transform = CGAffineTransformRotate(subLabel.transform, degreesToRadians(90));

	
//	[self performSelectorInBackground:@selector(movieSubtitles:) withObject:nil];

	//TODO:  clean up!
}

//---------------------------------------------------------------------------------------------------------------------------------

-(void)movieSubtitles: (int)blah
{
	double	base= CFAbsoluteTimeGetCurrent();	//(int)([[NSDate date] timeIntervalSince1970]);
	double	n;
	int	done=0;

	bool	finished=false;
	label_on=false;

	#define	NUM_SUBS 86
	
	typedef struct
	{
		int	s;//frames in
		int	l;//frames live
	} _sub;
	
	_sub		subs[NUM_SUBS]=
	{
		{275,999},//the old man
		{334,999},//Ohhh, I see evil..."
		{360,999},//Evil born deep beneath the city... far from the light of day."
		{431,999},//I see it growing, safe beneath a sky of steel..."
		{480,999},//Scheming in the dark... gathering strength.
		{519,999},//And now... ohhh.... now the evil spreads...
		{577,999},//It sends deadly feelers over the land above...
		{624,999},//Across the gap... reaching towards this very place!
		{674,999},//Over: I'd seen him do it a hundred times, but I humoured him.
		{720,999},//Over: After all, he'd been like a father to me.
		{754,999},//And what does this evil want here?
		{785,999},//Oh, my son. I fear...
		{806,999},//I fear the evil wants you!
		{845,999},//That was when Joey piped up...
		{870,999},//Foster! Sensors detect incoming audio source!
		{897,999},//The evil! The evil is nearly here...!
		{925,999},//It sounded more like a 'copter than a demon.
		{957,999},//But next thing, all hell let loose anyway...
		{1010,999},//Run, Foster! Run! Hide from the evil!
		{1058,999},//Foster! (zzzt) H-Help!
		{1081,999},//Better (zzzt) make my (zzzt) next body move (zzzt) faster...
		{1120,999},//He was only a robot, but, well, I loved the little guy.
		{1180,999},//Then, as suddenly as it started, the shooting stopped.
		{1225,999},//There was a moment's silence as the copter cut its rotors, then...             
		{1292,999},//Whoever is in charge here, come forward...
		{1332,999},//Only a fool would have argued with that firepower.
		{1360,999},//... I am the leader of these people...
		{1394,999},//We are peaceful...
		{1416,999},//Bring him here.
		{1425,999},//At once, Commander Reich.
		{1445,999},//We're looking for someone...
		{1468,999},//Someone who doesn't belong here...
		{1500,999},//Who wasn't born in this garbage dump...
		{1536,999},//Who came from the city as a child...
		{1564,999},//We want to take him home again.
		{1602,999},//My mind racing, I remembered where I'd seen that symbol before...
		{1644,999},//It was the day the tribe found me...
		{1668,999},//The day of the crash...
		{1680,999},//The day my mother died.
		{1705,999},//You alright, city boy?
		{1725,999},//Got a name, son?
		{1740,999},//R-Robert.
		{1753,999},//Hah! Welcome to the Gap, Robert!
		{1789,999},//As he patched me up, the old man had gently explained that there was no way back into the City...
		{1850,999},//And I already knew there was nothing he could do for mother.
		{1890,999},//His tribe was poor, but they treated me like one of their own...
		{1933,999},//I learned how to survive in the wasteland they called the Gap...
		{1970,999},//And scavenging from the City dumps.
		{2006,999},//As the years passed, I forgot my life in the City.
		{2040,999},//Discovered new talents...
		{2056,999},//I'm your (zzzt) friend... call me (zzzt) Joey.
		{2090,999},//And got a second name.
		{2107,999},//This is what we'll call you now you've come of age, son.
		{2157,999},//We found you... fostered you...
		{2184,999},//So that makes you Robert Foster.
		{2226,999},//...Wasted enough time!
		{2237,999},//Give us the runaway or we'll shoot everyone...
		{2268,999},//Starting with you, grandad!
		{2292,999},//The old man had been right, for once...
		{2316,999},//It was me they wanted.
		{2332,999},//No, my son! Don't let the evil take you! Run!
		{2388,999},//DNA scan confirms it's him, sir.
		{2425,999},//Evil had come to the Gap, just as he said.
		{2461,999},//Take him.
		{2486,999},//But had the old man seen why it wanted me?
		{2518,999},//Or what it would do next?
		{2536,999},//It was too late to ask him now.
		{2559,999},//Leaving destruction zone, Commander Reich.
		{2582,24},//Good. Detonate.
		{2656,999},//Much too late.
		{2672,999},//Why, you murdering...
		{2689,999},//Keep him quiet.
		{2715,999},//All I could do was wait.
		{2736,999},//Just like on a hunt. Just like the old man taught me.
		{2778,999},//Wait... and be ready.
		{2809,999},//It was dawn when we reached the City.
		{2832,999},//Land in the central Security compound.
		{2871,999},//A dawn my tribe would never see.
		{2904,999},//They were no more than a note in Reich's book now.
		{2940,999},//Yes, sir. Locking on automatic landing beacon.
		{2977,999},//But what was I? Why did...
		{3000,999},//Sir! The guidance system! It's gone crazy!
		{3042,999},//We're going to HIT!
		{3061,999},//Maybe I'd get some answers now.
		{3080,36},//If I survived another 'copter crash.
		
		{1000000,0},//end
	};
	
	
	printf("thread start\n");

	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	
	#define	MOFF	12
	
	do
	{
		n=CFAbsoluteTimeGetCurrent();
		n-=base;
//		printf("n=%e\n", [mMoviePlayer currentTime]);
	
	
		if	([g_AppDelegate appIsPaused])
		{
			printf("*Screeching brakes*");
			int	stoppedAt=CFAbsoluteTimeGetCurrent();
			do
			{
				[NSThread sleepForTimeInterval:0.1];
			}
			while ([g_AppDelegate appIsPaused]);
			base+=(CFAbsoluteTimeGetCurrent()-stoppedAt);
			
			finished=true;//drop out of subs - best we can do it seems?
			
			[self performSelectorOnMainThread : @ selector(restartMovie) withObject:nil waitUntilDone:YES];			
			
		}
		if (n>= ((MOFF+subs[done].s)/12))
		{
			NSString	*name = [NSString stringWithFormat:[g_AppDelegate ASCII:(1269+done)]];
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
-(void)restartMovie
{
	printf("** movie begins\n");
	[mMoviePlayer play];
}


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

-(void)drawRect:(CGRect)rect
{
	CGRect	r;

	//draw the background
	r.origin.x=0;
	r.origin.y=0;
	r.size=bgImage.size;
	[bgImage drawInRect:r];
}
- (void)dealloc {

//	if (_endMovie==1)//first outro ending
//		[mOutroPlayer release];

    [super dealloc];
}


@end
