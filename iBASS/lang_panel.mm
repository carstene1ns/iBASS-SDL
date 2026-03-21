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

#import "lang_panel.h"
#include "iBASSAppDelegate.h"
#include "iphone_common.h"
#include "sky.h"
#include "skydefs.h"

extern	iBASSAppDelegate *g_AppDelegate;

#ifdef IPHONE
	extern "C"	int	returnIPhoneLanguage();//tony28july09
	extern "C"	bool	isUSA();//tony28july09
#endif

@implementation LangPanelView


- (void)setup:(bool)fromControlPanel
{
	int	phoneLang=returnIPhoneLanguage();
	
	_fromControlPanel=fromControlPanel;
	
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


	//get status
    flags = Sky::g_engine->giveSystemFlags();

//	flags &= TEXT_FLAG_MASK;
//	printf("text flag = %x lang=%d\n", flags, lang);



	//text switch
	textSwitch = [[UIButton alloc] init];//WithFrame:CGRectMake(160.0, 35.0,0.0,0.0)];
	textSwitch.transform = TRANS(textSwitch);
	textSwitch.frame=CGRectMake(YY(115),120, 46, 46);//y,x,h,w
	[textSwitch addTarget:self action:@selector(textSwitchPressed:) forControlEvents:UIControlEventTouchUpInside];
	textSwitch.tag=1;

	//text
	m_TextSwitchLabel = [[UILabel alloc]init];//WithFrame:CGRectMake(50,30, 270, 35)];
	m_TextSwitchLabel.transform = TRANS(m_TextSwitchLabel);
	m_TextSwitchLabel.frame=CGRectMake(YY(100),40, 20, 180);//y,x,h,w
	m_TextSwitchLabel.textColor = [UIColor whiteColor];
	[m_TextSwitchLabel setText:[g_AppDelegate ASCII:1245]];
	[m_TextSwitchLabel setFont:[UIFont systemFontOfSize:16]];
	m_TextSwitchLabel.backgroundColor = [UIColor clearColor];
	m_TextSwitchLabel.lineBreakMode = UILineBreakModeWordWrap;
	m_TextSwitchLabel.textAlignment = UITextAlignmentLeft;
	m_TextSwitchLabel.numberOfLines = 0;
	[self addSubview:m_TextSwitchLabel];//add to the view


	//---------------------

	//speech switch
	speechSwitch = [[UIButton alloc] init];//WithFrame:CGRectMake(160.0, 75.0,46,46)];
	speechSwitch.transform = TRANS(speechSwitch);
	speechSwitch.frame=CGRectMake(YY(175),120, 46, 46);//y,x,h,w
	[speechSwitch addTarget:self action:@selector(textSwitchPressed:) forControlEvents:UIControlEventTouchUpInside];
	speechSwitch.tag=2;

	[self setSwitchButtons];
	[self addSubview:speechSwitch];//add to the view
	[self addSubview:textSwitch];//add to the view


	//speech
	m_SpeechSwitchLabel = [[UILabel alloc]init];//WithFrame:CGRectMake(50,70, 270, 35)];
	m_SpeechSwitchLabel.transform = TRANS(m_SpeechSwitchLabel);
	m_SpeechSwitchLabel.frame=CGRectMake(YY(160),40, 20, 180);//y,x,h,w
	m_SpeechSwitchLabel.textColor = [UIColor whiteColor];
	[m_SpeechSwitchLabel setText:[g_AppDelegate ASCII:1244]];
	[m_SpeechSwitchLabel setFont:[UIFont systemFontOfSize:16]];
	m_SpeechSwitchLabel.backgroundColor = [UIColor clearColor];
	m_SpeechSwitchLabel.lineBreakMode = UILineBreakModeWordWrap;
	m_SpeechSwitchLabel.textAlignment = UITextAlignmentLeft;
	m_SpeechSwitchLabel.numberOfLines = 0;
	[self addSubview:m_SpeechSwitchLabel];//add to the view




	//--------------------------------------------------------------------------------------------------------

	//text
	m_TextLanguageLabel = [[UILabel alloc]init];//WithFrame:CGRectMake(50,130, 270, 35)];
	m_TextLanguageLabel.transform = TRANS(m_TextLanguageLabel);
	m_TextLanguageLabel.frame=CGRectMake(YY(24),244, 18, 270);//y,x,h,w

	m_TextLanguageLabel.textColor = [UIColor whiteColor];
	[m_TextLanguageLabel setText:[g_AppDelegate ASCII:1257]];
	[m_TextLanguageLabel setFont:[UIFont systemFontOfSize:16]];
	m_TextLanguageLabel.backgroundColor = [UIColor clearColor];
	m_TextLanguageLabel.lineBreakMode = UILineBreakModeWordWrap;
	m_TextLanguageLabel.textAlignment = UITextAlignmentLeft;
	m_TextLanguageLabel.numberOfLines = 0;
	[self addSubview:m_TextLanguageLabel];//add to the view
	


	//basic button init
	for	(int	j=0;j<MAX_langs;j++)
	{
		//default order
		_flagList[j]=j;

		flagButton[j] = [[UIButton alloc] init];
		flagButton[j].backgroundColor = [UIColor clearColor];
		[flagButton[j] addTarget:self action:@selector(flagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

		flagButton[j].tag=j;
	}

	//swap german and usa
//	_flagList[SKY_GERMAN]=SKY_USA;
//	_flagList[SKY_USA]=SKY_GERMAN;

	//now put the machine language flag at the top, if not uk
	if	(isUSA())
	{
		printf("Is USA\n");
		_flagList[SKY_ENGLISH]=SKY_USA;
		_flagList[SKY_USA]=SKY_ENGLISH;
	}
	else if	(phoneLang)
	{
		printf("swapping lang to %d\n", phoneLang);
		_flagList[0]=phoneLang;
		_flagList[phoneLang]=0;	//swap with english, with is language 0
	}
	//if we're in the usa then put usa first


	//build the flags according to which is chosen
	[self initFlagButtons];


	//load images
	bgImage=	[[UIImage imageNamed:@"bg_plain.png"] retain];

}
//----------------------------------------------------------------------------------------------------------------------------------

NSString	*langButtons[]=
{
	@"flag_uk.png",
	@"flag_ger.png",
	@"flag_fra.png",
	@"flag_us.png",
	@"flag_swe.png",
	@"flag_ita.png",
	@"flag_por.png",
	@"flag_spa.png"
};
NSString	*langButtonsOn[]=
{
	@"flag_uk_hilite.png",
	@"flag_ger_hilite.png",
	@"flag_fra_hilite.png",
	@"flag_us_hilite.png",
	@"flag_swe_hilite.png",
	@"flag_ita_hilite.png",
	@"flag_por_hilite.png",
	@"flag_spa_hilite.png"
};
//----------------------------------------------------------------------------------------------------------------------------------
- (void)initFlagButtons//tony29july09
{
	//flags
	//back button
	int	x=0;
	int	y=0;
	int	lang = Sky::g_engine->giveLanguageFlag();
	int	index;
	
	for	(int	j=0;j<MAX_langs;j++)
	{
		//which flag in which position
		index=_flagList[j];
		
	//	flagButton[index].frame = CGRectMake(70+(x*100),165+(y*60), 80, 40);
		flagButton[index].transform = TRANS(flagButton[index]);
		flagButton[index].frame=CGRectMake(YY((70+(y*60))), 240+(x*100), 40, 80);//y,x,h,w
		
		if	(lang!=index)
			[flagButton[index] setBackgroundImage:[UIImage imageNamed:langButtons[index] ] forState:UIControlStateNormal];		
		else
			[flagButton[index] setBackgroundImage:[UIImage imageNamed:langButtonsOn[index] ] forState:UIControlStateNormal];		

		[self addSubview:flagButton[index]];//add to the view
		
		x++;
		if	(x==2)
		{
			x=0;
			y++;
		}
	}

	//renew subtitles label
	[m_TextSwitchLabel setText:[g_AppDelegate ASCII:1245]];
	//renew speech label
	[m_SpeechSwitchLabel setText:[g_AppDelegate ASCII:1244]];
	//renew text language label
	[m_TextLanguageLabel setText:[g_AppDelegate ASCII:1257]];

	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"] ] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"] ] forState:UIControlStateHighlighted];



}

//----------------------------------------------------------------------------------------------------------------------------------
- (void)flagButtonPressed: (id)sender	//tony28july09
{
	int	x=0;
	int	y=0;

	int	index;
	
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	
	printf("set lang=%d\n", [sender tag]);
	Sky::g_engine->setLanguageFlag([sender tag]);

	int	lang = Sky::g_engine->giveLanguageFlag();
	
/*	for	(int	j=0;j<MAX_langs;j++)
	{
		UIButton	*b=(UIButton*)sender;
		[b removeFromSuperview];
	}*/
//	[self initFlagButtons];

	for	(int	j=0;j<MAX_langs;j++)
	{
		//which flag in which position
		index=_flagList[j];
		
		if	(lang!=index)
			[flagButton[index] setBackgroundImage:[UIImage imageNamed:langButtons[index] ] forState:UIControlStateNormal];		
		else
			[flagButton[index] setBackgroundImage:[UIImage imageNamed:langButtonsOn[index] ] forState:UIControlStateNormal];		
		
		x++;
		if	(x==2)
		{
			x=0;
			y++;
		}
	}

	//renew subtitles label
	[m_TextSwitchLabel setText:[g_AppDelegate ASCII:1245]];
	//renew speech label
	[m_SpeechSwitchLabel setText:[g_AppDelegate ASCII:1244]];
	//renew text language label
	[m_TextLanguageLabel setText:[g_AppDelegate ASCII:1257]];

	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"] ] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"] ] forState:UIControlStateHighlighted];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)textSwitchPressed: (id)sender	//tony28july09
{
	//printf("tag=%d\n", [sender tag]);
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_ACK);
	
//	UISwitch *Switch=(UISwitch*)sender;
	//get status
 //   flags = Sky::g_engine->giveSystemFlags();
	
	if	([sender tag]==1)
	{
		if	(!(flags&SF_ALLOW_TEXT)/*Switch.on*/)
		{	printf("switch text on\n");
			flags|=SF_ALLOW_TEXT;
			Sky::g_engine->setSystemFlags(flags);
			
		}
		else
		{	printf("switch text off\n");
			flags|=SF_ALLOW_TEXT;
			flags-=SF_ALLOW_TEXT;;
			flags|=SF_ALLOW_SPEECH;	//force speech back on!
			Sky::g_engine->setSystemFlags(flags);
			
			//lol, remove speech switch
//			[speechSwitch removeFromSuperview];
//			speechSwitch.on=YES;
//			[self addSubview:speechSwitch];//add to the view
		}
	}
	else
	{
		if	(!(flags&SF_ALLOW_SPEECH)/*Switch.on*/)
		{	printf("switch speech on\n");
			flags|=SF_ALLOW_SPEECH;
			Sky::g_engine->setSystemFlags(flags);
		}
		else
		{	printf("switch speech off\n");
			flags|=SF_ALLOW_SPEECH;
			flags-=SF_ALLOW_SPEECH;
			flags|=SF_ALLOW_TEXT;	//force text back on
			Sky::g_engine->setSystemFlags(flags);

			//lol, remove speech switch
//			[textSwitch removeFromSuperview];
//			textSwitch.on=YES;
//			[self addSubview:textSwitch];//add to the view			
		}
	}
	//reinit buttons
	[self setSwitchButtons];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setSwitchButtons
{
	//get status
 //   flags = Sky::g_engine->giveSystemFlags();
	
	if	(flags&SF_ALLOW_TEXT)
	{
		[textSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_on.png" ] forState:UIControlStateNormal];
		[textSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_press.png" ] forState:UIControlStateHighlighted];
	}
	else
	{
		[textSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_on.png" ] forState:UIControlStateNormal];
		[textSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_press.png" ] forState:UIControlStateHighlighted];
	}

	if	(flags&SF_ALLOW_SPEECH)
	{
		[speechSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_on.png" ] forState:UIControlStateNormal];
		[speechSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_press.png" ] forState:UIControlStateHighlighted];
	}
	else
	{
		[speechSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_on.png" ] forState:UIControlStateNormal];
		[speechSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_press.png" ] forState:UIControlStateHighlighted];
	}
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	
	//cheeky check for both being switched off - why can't we disable buttons, or change them in code?
	if	(!(flags&TEXT_FLAG_MASK))
		Sky::g_engine->setSystemFlags(flags+SF_ALLOW_TEXT);

	//save the states
	Sky::g_engine->writeExtraData();

	//close view button pressed - transition back to game
//	if (_fromControlPanel)
		[g_AppDelegate endLangPanel];
//	else
// b		[g_AppDelegate switchToStartPanel];
}


//----------------------------------------------------------------------------------------------------------------------------------
-(void)drawRect:(CGRect)rect
{
	CGRect	r;

	//draw the background
	r.origin.x=0;
	r.origin.y=0;
	r.size=bgImage.size;
	[bgImage drawInRect:r];
	

	
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)dealloc
{
    [super dealloc];
}

@end
