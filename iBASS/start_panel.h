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
#import <MediaPlayer/MediaPlayer.h>


@interface StartPanelView : UIView
{

	UIButton *newGameButton;
	UIButton *loadButton;
	UIButton *continueButton;
	UIButton *langButton;
	UILabel	*subLabel;
	bool	label_on;
	bool	_izFirstResponder;
	
	MPMoviePlayerController *mMoviePlayer;
//	MPMoviePlayerController *mOutroPlayer;

    NSURL *mMovieURL;
	UILabel	*m_WaterMarkLabel;
	UIImage		*bgImage;
}
- (void)setup:(int)init;
- (void)newButtonPressed;
- (void)continueButtonPressed;
-(void)drawRect:(CGRect)rect;
-(void)setSubtitle:(NSString*)text;
-(void)removeSubtitle;
-(void)movieSubtitles: (int)blah;
-(void)restartMovie;

@end
