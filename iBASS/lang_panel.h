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

class	SkyEngine;


#define	MAX_langs	8


@interface LangPanelView : UIView
{
	UIImage *bgImage;
	
	UIButton	*textSwitch;
	UIButton	*speechSwitch;
	
	UILabel		*m_TextSwitchLabel;
	UILabel		*m_SpeechSwitchLabel;
	UILabel		*m_TextLanguageLabel;

	UIButton *backButton;
	
	UIButton *flagButton[MAX_langs];
	
    int flags;
	
	//the flag index list
	int	_flagList[MAX_langs];
	
	bool	_fromControlPanel;
}
- (void)setup:(bool)fromControlPanel;
- (void)backButtonPressed;
-(void)drawRect:(CGRect)rect;
- (void)initFlagButtons;//tony29july09
- (void)setSwitchButtons;


@end