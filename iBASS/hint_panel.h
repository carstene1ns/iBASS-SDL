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
#import "help_panel.h"



@interface HintPanelView : UIView
{
	Hint* m_hint;
	UILabel		*m_label;
	UIButton	*m_babel;
	UIButton	*backButton;
	
	UILabel		*a_label[MAX_hint_answers];
	UIButton	*a_button[MAX_hint_answers];

	UIImage *boxImage;
	UIImage *bgImage;
}
- (void)setup: (Hint*) hint;
- (void)backButtonPressed;	//tony28may09
- (void)clickHint:(id)sender;	//tony18june09
- (void)drawRect:(CGRect)rect;
@end
