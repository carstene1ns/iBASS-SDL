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


#define	MAX_hint_answers	5
#define	MAX_hint_questions	10	//at any one time - eg for cur section

#define	HINT_base_y	50
#define	HINT_spacing	60

@interface Hint : NSObject
{
	int	m_question;
	int m_num_answers;
	int	m_answers[MAX_hint_answers];

	UIButton	*m_button;	//we build a button
	UILabel		*m_label;

}
-(int)giveQ;
-(int)giveNumAnswers;
-(int)giveAnswer:(int)answer;
-(id)initWithQuestion:(int)question xcoord:(int) x ycoord:(int) y;
-(void)addAnswer: (int) answer;
-(UIButton*)giveButton;
-(void)clickQuestion:(id)sender;//tony17june09
-(bool)answerSeen:(int)answer;//tony6july09
-(void)setAnswerSeen:(int)answer;//tony6july09

@end

@interface HelpPanelView : UIView
{
	int	m_num_questions;	//how many live questions
	Hint *m_hints[MAX_hint_questions];
	UIButton	*backButton;
	UIImage *bgImage;
	UIImage *buttonImage;
}
- (void)setup;
- (void)backButtonPressed;
- (void)newQ:(int) question;//tony16june09
- (void)addAnswer:(int) answer;//tony16june09
-(void)drawRect:(CGRect)rect;

@end


