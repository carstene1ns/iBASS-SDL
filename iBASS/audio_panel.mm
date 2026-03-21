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

#import "audio_panel.h"
#include "iBASSAppDelegate.h"
#include "iphone_common.h"
#include "sky.h"

extern	iBASSAppDelegate *g_AppDelegate;

@implementation AudioPanelView



- (void)setup
{
	#define SLIDER_OFF 100.0	//distance between sliders
	#define SLIDER_BASE 120.0
	#define SLIDER_SBASE (SLIDER_BASE+35.0)
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"] ] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"] ] forState:UIControlStateHighlighted];
//	backButton.frame = CGRectMake((160-(176>>1)),420, 176, 29);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w
	
	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];//add to the view


	UIImage* img = [[UIImage imageNamed:@"vol_min.png"] stretchableImageWithLeftCapWidth:1.0 topCapHeight:0.0];
	UIImage* img2 = [[UIImage imageNamed:@"vol_max.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];

	//sfx volume slider
	if	(iPhone_isOS3())
	{
		sfxSlider = [[UISlider alloc] init];//WithFrame: CGRectMake(32.0, 106.0, 253.0, 0.0)];
		sfxSlider.transform = TRANS(sfxSlider);
		sfxSlider.frame=CGRectMake(YY(52),114, 20.0, 253);//y,x,h,w
	}
	else
	{
		sfxSlider = [[UISlider alloc] initWithFrame: CGRectMake(32, 220.0, 253.0, 0.0)];
	}
	
	[sfxSlider setThumbImage:[UIImage imageNamed:@"audiobar_slider.png" ] forState:UIControlStateNormal];
	[sfxSlider setMinimumTrackImage:img forState:UIControlStateNormal];
	[sfxSlider setMaximumTrackImage:img2 forState:UIControlStateNormal];
	sfxSlider.minimumValue=0.0;
	sfxSlider.maximumValue=1.0;
	sfxSlider.value=Sky::g_engine->giveSystem()->getSFXVolume();
	[sfxSlider addTarget:self action:@selector(setSFXVol:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:sfxSlider];
	
	
	
	
	

	//music volume slider
	if	(iPhone_isOS3())
	{
		sfxSlider2 = [[UISlider alloc] init];//WithFrame: CGRectMake(32.0, 106.0, 253.0, 0.0)];
		sfxSlider2.transform = TRANS(sfxSlider2);
		sfxSlider2.frame=CGRectMake(YY(122),114, 20.0, 253);//y,x,h,w
	}
	else
	{
		sfxSlider2 = [[UISlider alloc] initWithFrame: CGRectMake(32, 300, 253.0, 0.0)];
	}
//	sfxSlider2 = [[UISlider alloc] init];//WithFrame: CGRectMake(32.0, 175.0, 253.0, 0.0)];
//	sfxSlider2.transform = TRANS(sfxSlider2);
//	if	(iPhone_isOS3())
//		sfxSlider2.frame=CGRectMake(YY(122),114, 20.0, 253);//y,x,h,w
//	else
//		sfxSlider2.frame=CGRectMake(YY(122+20),114, 20.0, 253);//y,x,h,w
	[sfxSlider2 setThumbImage:[UIImage imageNamed:@"audiobar_slider.png" ] forState:UIControlStateNormal];
	[sfxSlider2 setMinimumTrackImage:img forState:UIControlStateNormal];
	[sfxSlider2 setMaximumTrackImage:img2 forState:UIControlStateNormal];
	sfxSlider2.minimumValue=0.0;
	sfxSlider2.maximumValue=1.0;
	sfxSlider2.value=Sky::g_engine->giveSystem()->getMusicVolume();
	[sfxSlider2 addTarget:self action:@selector(setMusicVol:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:sfxSlider2];

	//speech volume slider
//	sfxSlider3 = [[UISlider alloc] init];//WithFrame: CGRectMake(32.0, 244.0, 253.0, 0.0)];
//	sfxSlider3.transform = TRANS(sfxSlider3);
//	if	(iPhone_isOS3())
//		sfxSlider3.frame=CGRectMake(YY(192),114, 20.0, 253);//y,x,h,w
//	else
//		sfxSlider3.frame=CGRectMake(YY(192+20),114, 20.0, 253);//y,x,h,w
	if	(iPhone_isOS3())
	{
		sfxSlider3 = [[UISlider alloc] init];//WithFrame: CGRectMake(32.0, 106.0, 253.0, 0.0)];
		sfxSlider3.transform = TRANS(sfxSlider3);
		sfxSlider3.frame=CGRectMake(YY(192),114, 20.0, 253);//y,x,h,w
	}
	else
	{
		sfxSlider3 = [[UISlider alloc] initWithFrame: CGRectMake(32, 380, 253.0, 0.0)];
	}

	
	[sfxSlider3 setThumbImage:[UIImage imageNamed:@"audiobar_slider.png" ] forState:UIControlStateNormal];
	[sfxSlider3 setMinimumTrackImage:img forState:UIControlStateNormal];
	[sfxSlider3 setMaximumTrackImage:img2 forState:UIControlStateNormal];
	sfxSlider3.minimumValue=0.0;
	sfxSlider3.maximumValue=1.0;
	sfxSlider3.value=Sky::g_engine->giveSystem()->getSpeechVolume();
	[sfxSlider3 addTarget:self action:@selector(setSpeechVol:) forControlEvents:UIControlEventValueChanged];
	[self addSubview:sfxSlider3];

/*

     uint32 flags = SkyEngine::_systemVars.systemFlags & TEXT_FLAG_MASK;
       SkyEngine::_systemVars.systemFlags &= ~TEXT_FLAG_MASK;

       if (flags == SF_ALLOW_TEXT) {
               flags = SF_ALLOW_SPEECH;  //speech only
       } else if (flags == SF_ALLOW_SPEECH) {
               flags = SF_ALLOW_SPEECH | SF_ALLOW_TEXT; //text and speech
       } else {
               flags = SF_ALLOW_TEXT;  //text only
       }

       SkyEngine::_systemVars.systemFlags |= flags;
*/




	
	//load images
	bgImage=	[[UIImage imageNamed:@"bg_plain.png"] retain];
	
	if	(iPhone_isOS3())
	{
		sfxImage=	[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_soundeffects.png"]] retain];
		musicImage=	[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_musicvol.png"]] retain];
		speechImage=[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_speechvol.png"]] retain];
	}
	else//argh, got those 2.2 blues
	{
		sfxImage=	[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_soundeffects_h.png"]] retain];
		musicImage=	[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_musicvol_h.png"]] retain];
		speechImage=[[UIImage imageNamed:[g_AppDelegate BUTTON:@"audiobar_speechvol_h.png"]] retain];
	}

	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
}


- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//save the states
	Sky::g_engine->writeExtraData();
	//close view button pressed - transition back to game
	[g_AppDelegate endAudioPanel];
}


-(void)setMusicVol:(id)sender
{
	UISlider *slider=(UISlider*)sender;
//	printf("vol %f", slider.value);
	Sky::g_engine->giveSystem()->setMusicVolume(slider.value);
}
-(void)setSpeechVol:(id)sender
{
	UISlider *slider=(UISlider*)sender;
	//	printf("vol %f", slider.value);
	Sky::g_engine->giveSystem()->setSpeechVolume(slider.value);
}
-(void)setSFXVol:(id)sender
{
	UISlider *slider=(UISlider*)sender;
	//	printf("sfx vol %f\n", slider.value);
	Sky::g_engine->giveSystem()->setSFXVolume(slider.value);
}
-(void)drawRect:(CGRect)rect
{
	CGRect	r;

	//draw the background
	r.origin.x=0;
	r.origin.y=0;
	r.size=bgImage.size;
	[bgImage drawInRect:r];

	if	(iPhone_isOS3())
	{
		//draw the sfx label
		r.origin.x=YY(62);
		r.origin.y=108;
		r.size=sfxImage.size;
		[sfxImage drawInRect:r];

		//draw the music label
		r.origin.x=YY(132);
		r.origin.y=108;
		r.size=musicImage.size;
		[musicImage drawInRect:r];

		//draw the speech label
		r.origin.x=YY(202);
		r.origin.y=108;
		r.size=speechImage.size;
		[speechImage drawInRect:r];
	}
	else//argh, the agony
	{
		//draw the sfx label
		r.origin.x=26;
		r.origin.y=206;
		r.size=sfxImage.size;
		[sfxImage drawInRect:r];
		
		//draw the music label
		r.origin.x=26;
		r.origin.y=300-14;
		r.size=musicImage.size;
		[musicImage drawInRect:r];

		//draw the speech label
		r.origin.x=26;
		r.origin.y=380-14;
		r.size=speechImage.size;
		[speechImage drawInRect:r];
	}

}


- (void)dealloc
{
    [super dealloc];
}


@end
