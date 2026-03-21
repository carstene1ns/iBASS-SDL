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

#import "instruct_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "text.h"
#include "skydefs.h"
#include "iphone_common.h"

@implementation InstructPanelView

extern	iBASSAppDelegate *g_AppDelegate;


//----------------------------------------------------------------------------------------------------------------------------------

- (void)setup:(int) which//tony4aug09
{
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"]] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"]] forState:UIControlStateHighlighted];
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w
	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];//add to the view
	
	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
	
	
	
	printf("Which: %d\n", which);
	
	_numTexts=0;
	_y=-20;
	
	//ui help
	if	(!which)
	{
		[self addLine:1217 title:true];
		[self addLine:1218 title:false];
		[self addLine:1219 title:true];
		[self addLine:1220 title:false];
//		[self addLine:1267 title:true];
//		[self addLine:1268 title:false];
	}
	else if	(which==1)//inv help
	{
		[self addLine:1222 title:true];//4 is a gap in the ascii
		[self addLine:1223 title:false];
		[self addLine:1224 title:true];
		[self addLine:1225 title:false];
		[self addLine:1226 title:true];
		[self addLine:1227 title:false];
	}
	else//walk through
	{
		[self addLine:1228 title:true];
		[self addLine:1229 title:false];
	//	[self addLine:13 title:false];
		[self addLine:1231 title:false];

	}
	
	
	
}
//----------------------------------------------------------------------------------------------------------------------------------

-(void)addLine:(int)line title:(bool)b
{
	UIFont *font;
	
//	NSString *name = [[NSString alloc] initWithString:uiASCII[Sky::g_engine->giveLanguageFlag()][line] ];
	NSString *name = [[NSString alloc] initWithString:[g_AppDelegate ASCII:line] ];
	

	_but[_numTexts] = [[UIButton alloc]init];	
	
	if	(b)		{font=[UIFont boldSystemFontOfSize:14];/*_y+=14;*/	_but[_numTexts].backgroundColor = [UIColor clearColor];}
	else
	{
		_but[_numTexts].backgroundColor = [UIColor clearColor];
		
		if	(Sky::g_engine->giveLanguageFlag()==SKY_ENGLISH || Sky::g_engine->giveLanguageFlag()==SKY_USA)
			font=[UIFont systemFontOfSize:13];
		else
			font=[UIFont systemFontOfSize:12];
	}

	//plus height
	CGSize textSize = [ name sizeWithFont: font constrainedToSize: CGSizeMake(460, 1000.0f) lineBreakMode: UILineBreakModeWordWrap ];
	printf("y=%d, h==%d\n", _y, (int)(textSize.height));

	if	(iPhone_isOS3())
		_text[_numTexts] = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 460, textSize.height)];
	else
		_text[_numTexts] = [[UILabel alloc]initWithFrame:CGRectMake(0, 0-textSize.height, 460, textSize.height)];

	_but[_numTexts].transform = TRANS(_but[_numTexts]);
	_but[_numTexts].frame=CGRectMake(YY((_y+(textSize.height))), 10, textSize.height, 460);//y,x,h,w (textSize.height)
	
	_text[_numTexts].backgroundColor = [UIColor clearColor];
	_text[_numTexts].textColor = [UIColor whiteColor];
	[_text[_numTexts] setText:name];
	[_text[_numTexts] setFont:font];

	_text[_numTexts].lineBreakMode = UILineBreakModeWordWrap;
	_text[_numTexts].textAlignment = UITextAlignmentLeft;
	_text[_numTexts].baselineAdjustment=UIBaselineAdjustmentNone;
	_text[_numTexts].numberOfLines = 0;

	[_but[_numTexts] addSubview:_text[_numTexts]];
	[self addSubview:_but[_numTexts]];


	_numTexts++;

	_y+=(int)(textSize.height);
	
//	if	(b)
//		_y+=4;
//	else//bigger gap btween sections of normal text
	if	(!b)
	{
		if	(Sky::g_engine->giveLanguageFlag()==SKY_ENGLISH || Sky::g_engine->giveLanguageFlag()==SKY_USA)
			_y+=10;
		else
			_y+=6;
	}

}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)backButtonPressed	//tony4aug09
{
	//close view button pressed - transition back to game
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	[g_AppDelegate endInstructPanel];
}
//----------------------------------------------------------------------------------------------------------------------------------

@end
