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

#import "twitter_panel.h"
#include "iBASSAppDelegate.h"
#include "sky.h"
#include "saveload.h"

@implementation TwitterPanelView

extern	iBASSAppDelegate *g_AppDelegate;


//----------------------------------------------------------------------------------------------------------------------------------

- (void)setup//tony6aug09
{
	//int	lang = Sky::g_engine->giveLanguageFlag();
	
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"]] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"]] forState:UIControlStateHighlighted];
	//backButton.frame = CGRectMake((160-(176>>1)),430, 176, 29);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(278),20, 25, 120);//y,x,h,w
	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];//add to the view
	
	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
	

	//plus height
//	CGSize textSize = [ name sizeWithFont: font constrainedToSize: CGSizeMake(300.0f, 1000.0f) lineBreakMode: UILineBreakModeWordWrap ];
	//_text[_numTexts] = [[UILabel alloc]initWithFrame:CGRectMake(10, _y, 300, textSize.height)];
//	NSLog(twitterASCII[lang]);
	
	_text1 = [[UILabel alloc]init];//WithFrame:CGRectMake(20,20, 280, 100)];
	_text1.transform = TRANS(_text1);
	_text1.frame=CGRectMake(YY(60),20, 100, 440);//y,x,h,w
	_text1.textColor = [UIColor whiteColor];
	[_text1 setText:[g_AppDelegate ASCII:1233]];//@"There are several special interactions hidden throughout the game for you to find. Setup your twitter details so Beneath a Steel Sky can post to twitter as you discover them.", //1233
	
	[_text1 setFont:[UIFont systemFontOfSize:14]];
	_text1.backgroundColor = [UIColor clearColor];
	_text1.lineBreakMode = UILineBreakModeWordWrap;
	_text1.textAlignment = UITextAlignmentLeft;
	_text1.numberOfLines = 0;
	[self addSubview:_text1];//add to the view
	
	
	

	//username
	_username = [[UITextField alloc]init];//WithFrame:CGRectMake(25,150, 270, 25)];
	_username.transform = TRANS(_username);
	_username.frame=CGRectMake(YY(80),24, 25, 270);//y,x,h,w
	
	[_username setFont:[UIFont systemFontOfSize:14]];
	_username.textAlignment = UITextAlignmentLeft;
	//get text from the slot, if it's been used
	if(!Sky::g_engine->hasTwitterUsername())
		[_username setPlaceholder:[g_AppDelegate ASCII:1246]];
	else
	{
		NSString *name = [[NSString alloc] initWithUTF8String:(Sky::g_engine->giveTwitterUsername())];
		[_username setText:name];
	}
	_username.textColor = [UIColor greenColor];
	_username.backgroundColor = [UIColor clearColor];
	_username.delegate=self;
	_username.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	_username.autocapitalizationType=UITextAutocapitalizationTypeNone;
	_username.returnKeyType = UIReturnKeyDone;
	_username.clearButtonMode = UITextFieldViewModeWhileEditing;
	_username.tag=0;//which
	[self addSubview:_username];//add to the view


	//password
	_password = [[UITextField alloc]init];//WithFrame:CGRectMake(25,200, 270, 25)];
	_password.transform = TRANS(_password);
	_password.frame=CGRectMake(YY(120),24, 25, 270);//y,x,h,w
	[_password setFont:[UIFont systemFontOfSize:14]];
	_password.textAlignment = UITextAlignmentLeft;
	//get text from the slot, if it's been used
	if(!Sky::g_engine->hasTwitterPassword())
		[_password setPlaceholder:[g_AppDelegate ASCII:1247]];
	else
	{
		NSString *name = [[NSString alloc] initWithUTF8String:(Sky::g_engine->giveTwitterPassword())];
		[_password setText:name];
	}
	_password.textColor = [UIColor greenColor];
	_password.backgroundColor = [UIColor clearColor];
	_password.delegate=self;
	_password.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	_password.autocapitalizationType=UITextAutocapitalizationTypeNone;
	_password.returnKeyType = UIReturnKeyDone;
	_password.clearButtonMode = UITextFieldViewModeWhileEditing;
	_password.secureTextEntry = YES;
	_password.tag=1;//which
	[self addSubview:_password];//add to the view



	//extra stuff if details setup
	_displayingTest=false;

	if (Sky::g_engine->hasTwitterPassword() && Sky::g_engine->hasTwitterUsername())
		[self initTwitterTest];


		
	//load images
	bgImage=	[[UIImage imageNamed:@"bg_plain.png"] retain];
	slotImage=	[[UIImage imageNamed:@"saveres_bar_h.png"] retain];
	
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
	
	//text bgs
	r.size.width=35;
	r.size.height=300;
	r.origin.x=YY(80);
	r.origin.y=8;
	[slotImage drawInRect:r];

	r.origin.x=YY(120);
	[slotImage drawInRect:r];

}
//----------------------------------------------------------------------------------------------------------------------------------
//lock other edits out
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	printf("Should Begin?\n");
	
	if(!m_editing)
	{
		m_editing=true;
		return YES;
	}
	
	return NO;
	
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	//check for no current text, only placeholder, which we'll remove now as it's confusing at edit time
	if (textField.text.length==0)
		[textField setPlaceholder:@""];
}
//----------------------------------------------------------------------------------------------------------------------------------
//limit editing length
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	//user
	if (textField.tag==0 && textField.text.length >= TWITTER_username_len-1 && range.length == 0)
		return NO;
	//pw
	if (textField.tag==1 && textField.text.length >= TWITTER_password_len-1 && range.length == 0)
		return NO;
		
	return YES;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	m_editing=false;
	
	//check for 0 length string
	if (textField.text.length==0)
	{
		[textField setText:[g_AppDelegate ASCII:1249]];
	}
	
	if	(textField.tag==0)
	{
		Sky::g_engine->setTwitterUsername([textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	}
	else
	{
		Sky::g_engine->setTwitterPassword([textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	}
	

//	printf("end [%s]\n", [textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	//goodbye, goodbye, it's time to say... goodbye
	[textField resignFirstResponder];
	
	
	//both now set, then display further options
	if (Sky::g_engine->hasTwitterPassword() && Sky::g_engine->hasTwitterUsername())
		[self initTwitterTest];

	//test button back on
	if	(Sky::g_engine->giveTwitterOnOff())
		testButton.enabled=YES;
	
	//yep, yep, goodbye
	return YES;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)backButtonPressed	//tony4aug09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//save the states
	Sky::g_engine->writeExtraData();
	//close view button pressed - transition back to game
	[g_AppDelegate endTwitterPanel];
}
//----------------------------------------------------------------------------------------------------------------------------------
-(void)initTwitterTest//tony7aug09
{
	//already visible
	if	(_displayingTest)
		return;
		
	//set displayed
	_displayingTest=true;

	_text2 = [[UILabel alloc]init];//WithFrame:CGRectMake(20,255, 250, 20)];
	_text2.transform = TRANS(_text2);
	_text2.frame=CGRectMake(YY(160),20, 20, 270);//y,x,h,w

	_text2.textColor = [UIColor whiteColor];
	[_text2 setText:[g_AppDelegate ASCII:1266]];
	[_text2 setFont:[UIFont systemFontOfSize:14]];
	_text2.backgroundColor = [UIColor clearColor];
	_text2.lineBreakMode = UILineBreakModeWordWrap;
	_text2.textAlignment = UITextAlignmentLeft;
	_text2.numberOfLines = 0;
	[self addSubview:_text2];//add to the view


	//on/off switch
/*	twitterSwitch = [[UISwitch alloc] init];//WithFrame:CGRectMake(160.0, 250,0.0,0.0)];
	twitterSwitch.transform = TRANS(twitterSwitch);
	twitterSwitch.frame=CGRectMake(YY(150),120, 20, 270);//y,x,h,w

	[twitterSwitch addTarget:self action:@selector(twitterSwitchPressed:) forControlEvents:UIControlEventValueChanged];
	twitterSwitch.tag=2;

	if	(Sky::g_engine->giveTwitterOnOff())
		[twitterSwitch setOn:YES animated:YES];
	else
		[twitterSwitch setOn:NO animated:YES];
	
	[self addSubview:twitterSwitch];//add to the view
*/
	twitterSwitch = [[UIButton alloc] init];//WithFrame:CGRectMake(160.0, 250,0.0,0.0)];
	twitterSwitch.transform = TRANS(twitterSwitch);
	twitterSwitch.frame=CGRectMake(YY(175),140, 46, 46);//y,x,h,w

	twitterSwitch.backgroundColor = [UIColor clearColor];
	[twitterSwitch addTarget:self action:@selector(twitterSwitchPressed:) forControlEvents:UIControlEventTouchUpInside];

	if	(Sky::g_engine->giveTwitterOnOff())//on
	{
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_on.png" ] forState:UIControlStateNormal];
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_press.png" ] forState:UIControlStateHighlighted];
	}
	else
	{
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_on.png" ] forState:UIControlStateNormal];
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_press.png" ] forState:UIControlStateHighlighted];
	}
	[self addSubview:twitterSwitch];//add to the view






	//test message
	_text3 = [[UILabel alloc]init];//WithFrame:CGRectMake(20,290, 230, 100)];
	_text3.transform = TRANS(_text3);
	_text3.frame=CGRectMake(YY(250),20, 100, 400);//y,x,h,w

	_text3.textColor = [UIColor whiteColor];
	[_text3 setText:[g_AppDelegate ASCII:1232]];
	[_text3 setFont:[UIFont systemFontOfSize:14]];
	_text3.backgroundColor = [UIColor clearColor];
	_text3.lineBreakMode = UILineBreakModeWordWrap;
	_text3.textAlignment = UITextAlignmentLeft;
	_text3.numberOfLines = 0;
	[self addSubview:_text3];//add to the view
	
	testButton= [[UIButton alloc] init];
	[testButton setBackgroundImage:[UIImage imageNamed:@"squarebtn_on.png" ] forState:UIControlStateNormal];
	[testButton setBackgroundImage:[UIImage imageNamed:@"squarebtn_press.png" ] forState:UIControlStateHighlighted];
	testButton.transform = TRANS(testButton);
	testButton.frame = CGRectMake(YY(224),420, 46, 46);
	testButton.backgroundColor = [UIColor clearColor];
	[testButton addTarget:self action:@selector(testButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:testButton];//add to the view
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)twitterSwitchPressed: (id)sender	//tony7aug09
{
//	UISwitch *Switch=(UISwitch*)sender;
	
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	
/*	if	(Switch.on)
	{
		//test button back on
		testButton.enabled=YES;

		Sky::g_engine->setTwitterOnOff(true);
	}
	else
	{
		//test button off
		testButton.enabled=NO;

		Sky::g_engine->setTwitterOnOff(false);
	}
*/	
	if	(!Sky::g_engine->giveTwitterOnOff())//currently off
	{
		//test button off
		testButton.enabled=YES;
		Sky::g_engine->setTwitterOnOff(true);

		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_on.png" ] forState:UIControlStateNormal];
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_tick_press.png" ] forState:UIControlStateHighlighted];
	}
	else//cur on
	{
			//test button off
		testButton.enabled=NO;
		Sky::g_engine->setTwitterOnOff(false);

		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_on.png" ] forState:UIControlStateNormal];
		[twitterSwitch setBackgroundImage:[UIImage imageNamed:@"squarebtn_cross_press.png" ] forState:UIControlStateHighlighted];
	}

}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)testButtonPressed	//tony7aug09
{
//	[self sendTweet:0];
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	[g_AppDelegate	sendTestTweet];
	testButton.enabled=NO;

}
//----------------------------------------------------------------------------------------------------------------------------------

@end

