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

#import <UIKit/UIKit.h>


#define MAX_saves	8
#define SAVE_text_y 10//120
#define SAVE_text_spacing 39	//35

#define MAX_edit_save_text_length 23//user filename size




@interface SavePanelView : UIView <UITextFieldDelegate>	//UIScrollView
{
	UITextField * slotText[MAX_saves];
	int		scrolln;
	bool	m_editing;
	int		m_yids[MAX_saves];//lookup which we clicked
	UIButton *backButton;

	UIImage *bgImage;
	UIImage *slotImage;
	UIButton *fakeHeaderButton;
	UITextField * curTextField;//write a ref to current, so we can tell it to cancel
}



- (void)setup;
- (void)backButtonPressed;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)drawRect:(CGRect)rect;

@end
