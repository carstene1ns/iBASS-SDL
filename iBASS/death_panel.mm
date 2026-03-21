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

#import "death_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"

extern	iBASSAppDelegate *g_AppDelegate;

@implementation DeathPanelView




- (void)setup//tony8july09
{

	//continue game button
	continueButton= [[UIButton alloc] init];
	[continueButton setBackgroundImage:[UIImage imageNamed:@"btn_continue_on.png" ] forState:UIControlStateNormal];
	[continueButton setBackgroundImage:[UIImage imageNamed:@"btn_continue_press.png" ] forState:UIControlStateHighlighted];
//	continueButton.frame = CGRectMake(26,50, 268, 42);
	continueButton.transform = TRANS(continueButton);
	continueButton.frame=CGRectMake(YY(50),50, 42, 268);//y,x,h,w

	[continueButton addTarget:self action:@selector(continueButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:continueButton];//add to the view


	//load game button
	loadButton= [[UIButton alloc] init];

	[loadButton setBackgroundImage:[UIImage imageNamed:@"btn_restoregame_on.png" ] forState:UIControlStateNormal];
	[loadButton setBackgroundImage:[UIImage imageNamed:@"btn_restoregame_press.png" ] forState:UIControlStateHighlighted];
	[loadButton addTarget:self action:@selector(loadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	loadButton.transform = TRANS(loadButton);
	loadButton.frame=CGRectMake(YY(110),50, 42, 268);//y,x,h,w
	[self addSubview:loadButton];//add to the view

	//switch off restore button if no saves
	loadButton.enabled=NO;
	for (int j=0;j<MAX_saves;j++)
		if(Sky::g_engine->slotUsed(j))
		{	loadButton.enabled=YES;
			break;
		}
		

	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
}


- (void)loadButtonPressed	//tony8july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate startLoadPanel:2];
}

- (void)quitButtonPressed	//tony8july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	exit(1);//close this ap!
}

- (void)continueButtonPressed	//tony8july09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	
	Sky::g_engine->loadGameState(0);//game slot 0 is the auto-saved game
	[g_AppDelegate endDeathPanel];
}

- (void)dealloc {
	printf("dealloc deathPanel\n");
    [super dealloc];
}


@end
