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

#import "hint_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "skydefs.h"
#include "iphone_common.h"

extern	iBASSAppDelegate *g_AppDelegate;
//extern	NSString	*helpQ[];
//extern	NSString	*helpA[];

@implementation HintPanelView


- (void)setup: (Hint*) hint
{
	bool	foundTappable=false;



	
	//the hint in question - hehe, geddit?
	m_hint=hint;
	printf("q=%d %d hints\n", [m_hint giveQ], [m_hint giveNumAnswers]);
		
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"]] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"]] forState:UIControlStateHighlighted];
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w
//	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];//add to the view
	
	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;

	//the hint question
	NSString *name = [[NSString alloc] initWithString:[g_AppDelegate ASCII:[m_hint giveQ]]];					//helpQ[[m_hint giveQ]] ];
	m_label = [[UILabel alloc]init];//WithFrame:CGRectMake(20,25, 280, 45)];
	m_label.transform = TRANS(m_label);
	m_label.frame=CGRectMake(YY(25),20, 45, 440);//y,x,h,w
	
	m_label.font=[UIFont boldSystemFontOfSize:14];
	m_label.textColor = [UIColor whiteColor];
	m_label.backgroundColor = [UIColor clearColor];
	m_label.textAlignment = UITextAlignmentLeft;
	m_label.lineBreakMode = UILineBreakModeWordWrap;
	m_label.numberOfLines=2;
	[m_label setText:name];
	[self addSubview:m_label];
	
	
	
	int	y=50;
	
	
	UIFont *font;
	if	(Sky::g_engine->giveLanguageFlag()==SKY_ENGLISH || Sky::g_engine->giveLanguageFlag()==SKY_USA)
		font = [UIFont systemFontOfSize:13];
	else
		font = [UIFont systemFontOfSize:13];
		
	//now the answers, as buttons
	for(int j=0;j<[m_hint giveNumAnswers];j++)
	{
		NSString *name;

		int	answer=[m_hint giveAnswer:j];//answer number
		
		//opened this answer?
		if ([m_hint answerSeen:answer])
		{
			int	answer=[m_hint giveAnswer:j];
			name = [[NSString alloc] initWithString:[g_AppDelegate ASCII:answer]];					//helpA[ [m_hint giveAnswer:j]] ];
		}
		else
		{
			//nope, so -
			name = [NSString stringWithFormat:[g_AppDelegate ASCII:1254]/*@"Hint %d of %d"*/, (j+1), ([m_hint giveNumAnswers])];
		}
		

		CGSize textSize = [ name sizeWithFont: font constrainedToSize: CGSizeMake(440, 1000.0f) lineBreakMode: UILineBreakModeWordWrap ];
		int	h=(int)(textSize.height);
		
//		printf("height %d==%d y=%d\n", j, h,y);
		
		a_button[j] = [[UIButton alloc]init];

		if	(iPhone_isOS3())
			a_label[j] = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 440, h)];
		else
			a_label[j] = [[UILabel alloc]initWithFrame:CGRectMake(0,0-h, 440, h)];
			
		a_button[j].transform = TRANS(a_button[j]);
		a_button[j].frame=CGRectMake(YY((y+h)),20, h, 440);//y,x,h,w
	
		a_label[j].font=font;//[UIFont systemFontOfSize:12.0];
		a_label[j].backgroundColor = [UIColor clearColor];
		a_label[j].textColor = [UIColor whiteColor];
		a_button[j].backgroundColor = [UIColor clearColor];
		a_label[j].lineBreakMode = UILineBreakModeWordWrap;
		a_label[j].textAlignment = UITextAlignmentLeft;
		a_label[j].numberOfLines = 0;

		if (![m_hint answerSeen:answer])
		{
			//first tappable gets a handler
			if (!foundTappable)
			{
				foundTappable=true;
				
				name = [NSString stringWithFormat:@"• %@", name];
				
				//has a handler
				[a_button[j] addTarget:self action:@selector(clickHint:) forControlEvents:UIControlEventTouchUpInside];
				//a_button[j].frame = CGRectMake(25,y, (320-50), h+16);
				//a_button[j].frame=CGRectMake(YY(y),20, h, 440);//y,x,h,w
				a_label[j].textColor = [UIColor colorWithRed:0.24 green:0.61 blue:1.0 alpha:1.0];//ibass-blue
			}
			else
			{
				break;
				//can't select, so grEy and italic
//				a_label[j].textColor = [UIColor grayColor];
//				a_label[j].font=[UIFont italicSystemFontOfSize:13.0];
			}
		}

	
		[a_label[j] setText:name];
		//set button id that will be passed with the event - ahh, so this is the proper way to do it :)
		a_button[j].tag=j;
		
		//a_button[j].contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
		
		//[a_button[j] setBackgroundColor: [UIColor blackColor] ];
		[a_button[j] addSubview:a_label[j]];
		
		[self addSubview:a_button[j]];
		
		
		y+=(h+12);
		
	}


	//load images
	bgImage=	[[UIImage imageNamed:@"bg_plain.png"] retain];
//	boxImage=	[[UIImage imageNamed:[g_AppDelegate BUTTON:@"hints_txtbox.png"]] retain];
	
}



-(void)drawRect:(CGRect)rect
{
	CGRect	r;

	//draw the background
	r.origin.x=0;
	r.origin.y=0;
	r.size=bgImage.size;
	[bgImage drawInRect:r];
	
	//draw the box
//	r.size=boxImage.size;
//	r.origin.x=160-(r.size.width/2);
//	r.origin.y=100;
//	[boxImage drawInRect:r];
}

- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate endHintPanel];
}
- (void)clickHint:(id)sender	//tony18june09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	printf("Clicked %d", [sender tag]);
	
	int	answer=[m_hint giveAnswer:[sender tag]];//answer number
	
	//set seen it
	[m_hint setAnswerSeen:answer];
	
	//remove existing buttons
	for(int j=0;j<[m_hint giveNumAnswers];j++)
	{
		[ a_button[j] removeFromSuperview ];
//		[ a_button[j] dealloc ];
	}
	
	//rebuild the screen
	[self setup:m_hint];
}

@end
