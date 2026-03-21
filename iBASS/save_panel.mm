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

#import "save_panel.h"
#include "iphone_common.h"
#include "sky.h"
#include "iBASSAppDelegate.h"
#include "saveload.h"



extern	iBASSAppDelegate *g_AppDelegate;

@implementation SavePanelView


//----------------------------------------------------------------------------------------------------------------------------------

- (void)setup
{
	int	j,y;
	
/*	fakeHeaderButton= [[UIButton alloc] init];
	fakeHeaderButton.frame = CGRectMake(0,0, 320, 39);
	[fakeHeaderButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"header_save.png"] ] forState:UIControlStateDisabled];
	[self addSubview:fakeHeaderButton];
	fakeHeaderButton.enabled = NO;
*/
	//back button
	backButton= [[UIButton alloc] init];
//	myButton.frame = CGRectMake((160-60),63, 120, 25);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(274),20, 25, 120);//y,x,h,w
	
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"] ] forState:UIControlStateNormal];;
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"] ] forState:UIControlStateHighlighted];;
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];

	
	
	for (j=0;j<MAX_saves;j++)
	{
		slotText[j] = [[UITextField alloc]init];
		
		y=(SAVE_text_y+(j*SAVE_text_spacing));
		y-=2;
//		slotText[j].frame = CGRectMake(25,y, 270, 25);
		slotText[j].transform = TRANS(slotText[j]);
		slotText[j].frame=CGRectMake(YY(y),160+16, 30, 300);//y,x,h,w
		
		slotText[j].tag=j;
		
		m_yids[j]=y;

		[slotText[j] setFont:[UIFont systemFontOfSize:14]];
		
		if	(iPhone_isOS3())
			slotText[j].textAlignment = UITextAlignmentLeft;
		else//match Load panel on <3 where it is also central due to issues getting inset to work
			slotText[j].textAlignment = UITextAlignmentCenter;
		
		//get text from the slot, if it's been used
		if(!Sky::g_engine->slotUsed(j))
			[slotText[j] setPlaceholder:[g_AppDelegate ASCII:1248]];
		else
		{
			const char* cString = Sky::g_engine->giveSlotAscii(j);
		//	printf("slot %d = [%s]\n", j, cString);
			NSString *name = [[NSString alloc] initWithCString:cString encoding:NSMacOSRomanStringEncoding];
			[slotText[j] setText:name];
		}

		slotText[j].textColor = [UIColor colorWithRed:0.24 green:0.61 blue:1.0 alpha:1.0];
		slotText[j].backgroundColor = [UIColor clearColor];
		slotText[j].delegate=self;
		slotText[j].autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		slotText[j].returnKeyType = UIReturnKeyDone;
		slotText[j].clearButtonMode = UITextFieldViewModeWhileEditing;

		[self addSubview:slotText[j]];//add to the view
	}

	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;

	m_editing=false;

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
	
	//draw the slots
	for (int	j=0;j<MAX_saves;j++)
	{
		int	y=(SAVE_text_y+(j*SAVE_text_spacing));
		y+=7;//pull up from where the text is placed


		r.size.width=30;
		r.size.height=300;
		r.origin.x=y;
		r.origin.y=160;

		[slotImage drawInRect:r];
	}
}
//----------------------------------------------------------------------------------------------------------------------------------


//limit editing length
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (textField.text.length >= MAX_edit_save_text_length && range.length == 0)
		return NO;
	return YES;
}
//----------------------------------------------------------------------------------------------------------------------------------

//lock other edits out
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	printf("Should Begin?\n");
	
	if(!m_editing)
	{

		Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
		m_editing=true;
		return YES;
		


	}
	
	return NO;
}
//----------------------------------------------------------------------------------------------------------------------------------

//user pressed return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	int	slot;
	
	m_editing=false;
	
	//check for 0 length string
	if (textField.text.length==0)
	{
		[textField setText:[g_AppDelegate ASCII:1249]];
	}
	
	
	//which slot?
/*	for (j=0;j<MAX_saves;j++)
		if	(m_yids[j]==textField.frame.origin.x)
			slot=j;
*/

	slot=textField.tag;

	printf("Slot %d [%s]\n", slot,[textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]]);

	//save the game
	if (!Sky::g_engine->saveGameState(slot+1))
	{	printf("Save Failed\n");
		//alert=[[UIAlertView alloc] initWithTitle:[g_AppDelegate ASCII:1252] message:[g_AppDelegate ASCII:1253] delegate:self cancelButtonTitle:nil otherButtonTitles:[g_AppDelegate ASCII:1256], nil];

	}
	else
	{
		//save the slot info
		const char* cString = [textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]];
		//printf("[%s]\n", cString);
		
		Sky::g_engine->setSlotAscii(slot, cString);

		[g_AppDelegate savedOK];
	}

	//popup
	//[alert show];

//	printf("end [%s]\n", [textField.text cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	//goodbye, goodbye, it's time to say... goodbye
	[textField resignFirstResponder];
	//yep, yep, goodbye
	return YES;
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	printf("Begin editing %d\n", textField.tag);
	
	backButton.frame.origin.x=YY(150);
	[backButton removeFromSuperview];
	
	if	(textField.tag>3)
	{


		[UIView beginAnimations:Nil context:NULL];
		[UIView setAnimationDuration:0.3];

		int	slot=(textField.tag-4);

		printf("shift by %d\n", slot);
		
		//scroll into view
		CGRect frame = self.frame;
		frame.origin.x+=(4*SAVE_text_spacing);
		self.frame = frame;

		[UIView commitAnimations];

	}
	else
	{
		backButton.frame=CGRectMake(YY(125),20, 25, 120);//y,x,h,w
	}

//	[self addSubview:backButton];

	//check for no current text, only placeholder, which we'll remove now as it's confusing at edit time
	if (textField.text.length==0)
	{
		[textField setPlaceholder:@""];
	}
	
	//remember
	curTextField=textField;
}
//----------------------------------------------------------------------------------------------------------------------------------

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	printf("End editing\n");
	
	//scroll back?
/*	[UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDuration:0.6];
	CGRect frame = self.frame;
	frame.origin.y+=scrolln;
	//frame.size.height -= scrolln;
	self.frame = frame;
	[UIView commitAnimations];*/
	
	//change text colour
	//textField.textColor = [UIColor greenColor];	
	
	//remove cancel button
//	[cancelButton removeFromSuperview];
//	[cancelButton dealloc];

	[g_AppDelegate uberEndSavePanel];

}
//----------------------------------------------------------------------------------------------------------------------------------


- (void)cancelButtonPressed	//tony28may09
{

	printf("cancel [%d]\n", curTextField.text.length);

//	[g_AppDelegate endSavePanel];
		
	[curTextField resignFirstResponder];

}
//----------------------------------------------------------------------------------------------------------------------------------


- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate endSavePanel];
}
//----------------------------------------------------------------------------------------------------------------------------------

/*
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//	[ alert release];
//	[g_AppDelegate uberEndSavePanel];
}
*/
//----------------------------------------------------------------------------------------------------------------------------------

- (void)dealloc
{
    [super dealloc];
}

@end


