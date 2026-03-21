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

#import "load_panel.h"
#include "iphone_common.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "saveload.h"

extern	iBASSAppDelegate *g_AppDelegate;

@implementation LoadPanelView

- (void)setup
{
	int	j,y;
	
	fakeHeaderButton= [[UIButton alloc] init];
	fakeHeaderButton.frame = CGRectMake(0,0, 320, 39);
	[fakeHeaderButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"header_restore.png"] ] forState:UIControlStateDisabled];
//	[self addSubview:fakeHeaderButton];
	fakeHeaderButton.enabled = NO;
	
	//back button
	backButton= [[UIButton alloc] init];
	//backButton.frame = CGRectMake((320-120-13),68, 120, 25);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w

	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"] ] forState:UIControlStateNormal];;
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"] ] forState:UIControlStateHighlighted];;
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];	//action:@selector(action:)
	[self addSubview:backButton];

	//confirm button
	confirmButton= [[UIButton alloc] init];
//	confirmButton.frame = CGRectMake(13,68, 120, 25);
	confirmButton.transform = TRANS(confirmButton);
	confirmButton.frame=CGRectMake(YY(10),20, 25, 120);//y,x,h,w

	[confirmButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_confirm_on.png"] ] forState:UIControlStateNormal];;
	[confirmButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_confirm_press.png"] ] forState:UIControlStateHighlighted];;
//	[confirmButton setBackgroundImage:[UIImage imageNamed:@"btn_sml_confirm_off.png" ] forState:UIControlStateDisabled];;
	
	[confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchDown];	//action:@selector(action:)
	[self addSubview:confirmButton];
	confirmButton.enabled = NO;


	//indent da text on da button
	UIEdgeInsets	e;
	e.left=16;
	e.right=0;
	e.top=-2;
	e.bottom=0;
	
	for (j=0;j<MAX_saves;j++)
	{
		slotText[j] = [[UIButton alloc]init];
		
		y=(SAVE_text_y+(j*SAVE_text_spacing));
		
		slotText[j].transform = TRANS(slotText[j]);
		slotText[j].frame=CGRectMake(YY(y),160, 30, 300);//y,x,h,w
	
		//slotText[j].frame = CGRectMake(10,y, 300, 35);

		if	(iPhone_isOS3())
		{
			//can't get inset to work (properly) on <3.0
			slotText[j].contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			slotText[j].titleEdgeInsets =e;
			slotText[j].titleLabel.font = [UIFont systemFontOfSize: 14];
		}
		else
		{
			slotText[j].font=[UIFont systemFontOfSize:14];
		}
		
		[slotText[j] setBackgroundImage:[UIImage imageNamed:@"saveres_bar.png" ] forState:UIControlStateNormal];
		
		//get text from the slot, if it's been used
		if(!Sky::g_engine->slotUsed(j))
		{
			[slotText[j] setTitle:[g_AppDelegate ASCII:1248] forState:UIControlStateNormal];
			[slotText[j] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
			slotText[j].enabled=NO;
		}
		else
		{
//			NSString *name = [[NSString alloc] initWithUTF8String:(Sky::g_engine->giveSlotAscii(j))];
			NSString *name = [[NSString alloc] initWithCString:(Sky::g_engine->giveSlotAscii(j)) encoding:NSMacOSRomanStringEncoding];

			[slotText[j] setTitle:name forState:UIControlStateNormal];

			[slotText[j] setTitleColor:[UIColor colorWithRed:0.24 green:0.61 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
			//has a handler
			[slotText[j] addTarget:self action:@selector(slotSelected:) forControlEvents:UIControlEventTouchDown];
			//set button id that will be passed with the event - ahh, so this is the proper way to do it :)
			slotText[j].tag=j;

		}
		
		slotText[j].backgroundColor = [UIColor clearColor];
		[self addSubview:slotText[j]];//add to the view
	}
	
	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
	

	
}
- (void)slotSelected:(id)sender //tony2june09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	printf("Selected slot %d", [sender tag]);
	
	//remember for confirm button
	m_selectedSlot=[sender tag];

	//switch confirm button on
	confirmButton.enabled = YES;
	
	//reset highlight - all white
	for (int j=0;j<MAX_saves;j++)
	{
		if(Sky::g_engine->slotUsed(j))
			[slotText[j] setTitleColor:[UIColor colorWithRed:0.24 green:0.61 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
	}

	//and highlight selected
	[slotText[m_selectedSlot] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	NSString *name = [[NSString alloc] initWithCString:(Sky::g_engine->giveSlotAscii(m_selectedSlot)) encoding:NSMacOSRomanStringEncoding];
//	name = [NSString stringWithFormat:@"• %@ •", name];
//	[slotText[m_selectedSlot] setTitle:name forState:UIControlStateNormal];


		
}


- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate endLoadPanel];
}
- (void)confirmButtonPressed	//tony5june09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	printf("Restore slot %d\n",m_selectedSlot);
	
	//load the game
	if	(Sky::g_engine->loadGameState(m_selectedSlot+1))
	{
		//go back to game
		[g_AppDelegate uberEndLoadPanel];
	}
	else
		printf("Load Failed\n");
}


- (void)dealloc
{
    [super dealloc];
}
@end
