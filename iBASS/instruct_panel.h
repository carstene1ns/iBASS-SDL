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

#define	MAX_texts	6

@interface InstructPanelView : UIImageView
{
	UIButton	*backButton;
	
	UIButton	*_but[MAX_texts];
	UILabel		*_text[MAX_texts];
	int			_y;

	int	_numTexts;
}
- (void)setup: (int) which;
- (void)backButtonPressed;	//tony28may09
-(void)addLine:(int)line title:(bool)b;//tony4aug09

@end