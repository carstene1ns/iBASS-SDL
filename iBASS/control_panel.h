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
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ControlPanelView : UIViewController <MFMailComposeViewControllerDelegate> //UIImageView
{
	UIImageView *IView;
	UIButton *backButton;
	MPMoviePlayerController *mCreditsPlayer;
    NSURL *mMovieURL;
}


- (void)setup;
- (void)backButtonPressed;
- (void)audioButtonPressed;
- (void)saveButtonPressed;
- (void)loadButtonPressed;
- (void)friendButtonPressed;	//tony27may09
- (void)creditsButtonPressed;	//tony27may09
- (void)langButtonPressed;	//tony28july09
- (void) moviePlayBackDidFinish:(NSNotification*)notification;
- (void)launchMailAppOnDevice;

@end