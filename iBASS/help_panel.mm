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

#import "help_panel.h"
#include "iphone_common.h"
#include "iBASSAppDelegate.h"
#include "sky.h"

extern	iBASSAppDelegate *g_AppDelegate;

/*
int	helpQ[]=
{
	//RECYCLING PLANT 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"The Firedoor is locked – how do I open it?",				//0
	@"I do wish that Joey was with me – what should I do?",		//1
	@"How do I get that elevator working?",						//2
	@"How do I get down the elevator shaft?",					//3
	@"How do I get out of the furnace room?",					//4
	//INDUSTRIAL 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I need to de-activate the welder robot...",	//5
	@"So how do I get the welder shell for Joey?",	//6
	@"How can I get into the storeroom?",	//7
	@"Everything that I get from the storeroom is removed from me when I leave – what should I do?",	//8
	@"How can I get rid of the man in the power room?",	//9
	@"How can I restore power?",	//10
	@"How can I use that elevator?",	//11
	//BELLEVUE 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"How do I get a ticket from the travel agent?",	//12
	@"What should I do with this ticket?",	//13
	//INDUSTRIAL 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"Lamb has my ticket – what now?",	//14
	//BELLEVUE 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"How do I get into the surgery?",	//15
	@"What must I do to get a Schriebmann port?",	//16
	@"The anchor looks important – how can I get it?",	//17
	@"I’ve got the anchor – what now?",	//18
	//INDUSTRIAL 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"What do I do with this grappling hook?",	//19
	//SECURITY CENTRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I’m in the security HQ. What should I do?",	//20
	//LINC 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I’m stuck in the LINC world – what should I do?",	//21
	@"I’m in a cyber maze – how do I get through it?",	//22
	@"I’m through the cyber maze – what now?",	//23
	//SECURITY CENTRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I think I’ve done everything in LINC space – how do I get out?",	//24
	//HYDE PARK ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I’ve got to ground level. What should I do now?",	//25
	@"How do I get those dog biscuits?",	//26
	@"How do I get into the entrance that the security man is guarding?",	//27
	@"I’m in the cathedral – what now?",	//28
	@"Anita’s been murdered. What should I do?",	//29
	//LINC 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I’ve got Anita’s card – maybe she left some clues?",	//30
	//HYDE PARK 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I’ve read Anita’s message – how do I make contact with Eduardo?",	//31
	@"I’ve made contact with Eduardo. What now?",	//32
	@"I’ve got Colston’s glass but why?",	//33
	//HYDE PARK 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"So, how do I get through to the subway?",	//34
	@"I’ve made a hole in the grill – what do I need to extend the hole?",	//35
	@"I’ve made a hole in the grill – how do I extend the hole and proceed?",	//36
	//UNDERWORLD ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"There’s a creature that grabs me – how can I avoid it?",	//37
	@"How do I get through the big metal door?",	//38
	@"There’s a strange pit – what do I do with it?",	//39
	@"What do I do in this strange underworld?",	//40
	@"How can we get past the Android in the lab?",	//41
	@"I killed the android. What next?",	//42
	@"Anita mentioned a virus – how do I get it?",	//43
	//LINC 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I'm back in LINC – how do I get the virus?",	//44
	//UNDERWORLD ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"Poor old Joey – how do I get resurrect him. Again?",	//45
	@"I’ve turned Joey into an android. What I do with him?",	//46
	@"I’ve got the virus from LINC space – how get it into the real world?",	//47
	@"I’ve got some infected tissue – what now?",	//48
	@"I’ve met my own father – how do I save humanity?",	//49

	//E X T R A
	//E X T R A
	//E X T R A
	//RECYCLING PLANT 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I've out-foxed the guard - what now?",	//50
	//INDUSTRIAL 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"I'm in an industrial area. What should I do?",	//51
	@"I've found some putty-like substance - but what now?",	//52
	@"I've given myself special security status on LINC - now what?",	//53 (after first linc visit)

	//EXTRA ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	@"User Interface and game controls – help!", //54
	@"Inventory Instructions – using the objects that Foster is carrying", //55
	@"First screen walk-through", //56
	
};

NSString	*helpA[]=
{
	//RECYCLING PLANT 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//0
	@"Get the rung from the top of the stairs on the left of the gantry.",		//0
	@"Open your inventory and use the rung on the fire door to lever it open.",	//1
	//1
	@"Examine the junk in the foreground to reveal the robot shell.",	//2
	@"Use the circuit board on the robot shell.",	//3
	//2
	@"Examine the transporter robot.",	//4
	@"Talk to Hobbins until you get option to ask him about the transporter – and he tells you what’s wrong with the transporter.",	//5
	@"Ask Joey to start the transporter (you may need to talk nicely to him about a range of subjects).",	//6
	//3
	@"When the lift descends, quickly climb down the lift shaft. ",	//7
	//4
	@"Examine the lock on the door.",	//8
	@"When Joey arrives, ask him to open the door.",	//9
	//INDUSTRIAL 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//5
	@"You need to ‘throw a wrench in the works’",	//10
	@"Did you find the wrench in Hobbins’s workshop? If not, then return to Hobbins’s workshop, open the cupboard and take the wrench.",	//11
	@"Return to the production line – in the room beyond the welder robot you will see some gears. ",	//12
	@"If you haven’t done so, talk to Anita and then Lamb until he leaves. Then throw the wrench onto the gears.",	//13
	@" ",	//14
	//6
	@"Retrieve the wrench from the cogs.",	//15
	@"Use the wrench on the welder robot.",	//16
	@"Offer Joey a new shell.",	//17
	//7
	@"Attempt to enter the storeroom.",	//18
	@"Tell Joey to check out the storeroom. When he reports that he has found the fusebox, tell him to disable the fuse box.",	//19
	//8
	@"Lift the gangway on the floor.",	//20
	@"Pick up the putty (plastic explosive) which was under the gangway. This is the only object that you can keep after leaving.",	//21
	//9
	@"Use the spanner on each of the two buttons beneath the pipes on the right.",	//22
	@"Tell Joey to press the right hand button, then press the other as he does so.",	//23
	//10
	@"Turn off the switch on the control panel on the left.",	//24
	@"Remove the light bulb.",	//25
	@"Put the putty in the light fitting.",	//26
	@"Turn the switch back on.",	//27
	@"Pull the right hand power switch down to restore power to the lift.",	//28
	//11
	@"Examine Reich’s corpse in the furnace room to get his ID.",	//29
	@"Use his ID card on the lift slot.",	//30
	//BELLEVUE 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//12
	@"Go to Reich’s apartment and lift the pillow to reveal the motorbiking magazine.",	//31
	@"Go to the travel agent and ask him about the tours.",	//32
	@"Ask for the economy tour.",	//33
	@"Give him the motorbiking magazine in return for a tour ticket.",	//34
	//13
	@"Give the ticket to Lamb to be invited on a tour of the pipe factory. ",	//35
	//INDUSTRIAL 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//14
	@"Ask Lamb about the tour – he will leave when he sees that the conveyor has stopped.",	//36
	@"Talk to Anita.",	//37
	@"She will eventually offer you a “jammer” – give her Reich’s ID.",	//38
	@"Talk further to learn about the Schriebmann port.",	//39
	//BELLEVUE 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//15
	@"Talk to the surgery receptionist by clicking on the projector.",	//40
	@"Ask for a Schriebmann port.",	//41
	@"Ask Joey to talk to the receptionist to gain admittance to the surgery.",	//42
	//16
	@"Talk to Burke until you get offer to fit a Schriebmann port.",	//43
	//17
	@"After operation, keep talking to Burke to learn about Anchor’s “special policy”.",	//44
	@"Visit Anchor in the insurance office and mention Burke’s name to get him out of the room.",	//45
	@"Ask Joey to get the anchor from the statue.",	//46
	@"Pick up the anchor after Joey has melted the statue’s arm.",	//47
	//18
	@"If you don’t have it, now would be a good time to get the cable hanging from the Industrial level.",	//48
	@"Ask Joey to cut the loose cable - get out of his way.",	//49
	@"Retrieve the cable which has fallen onto the Belle Vue level.",	//50
	@"Use the anchor on the cable to create a grappling hook.",	//51
	//INDUSTRIAL 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//19
	@"Go to the fire door in the recycling plant and out on the ledge.",	//52
	@"Use the grappling hook on the Security sign on the opposite wall.",	//53
	//SECURITY CENTRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//20
	@"In the Security HQ, use the ID card on the slot and sit down.",	//54
	//LINC 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//21
	@"Pick up the ball (compressed data) in area 1.",	//55
	@"Go right to area 2 and use open (in inventory) on the carpet bag.",	//56
	@"Get the birthday surprise (decompress). Use decompress on compressed data (in inventory).",	//57
	@"Get magnifying glass (decrypt) and use it on report.doc and briefing.doc (in inventory).",	//58
	@"",	//59
	//22
	@"Use green password on lower row / left tile. Use red password on lower row / centre tile.",	//60
	@"Pick up the green password and use on middle row / left tile.",	//61
	@"Pick up the red password and use on central tile.",	//62
	@"Pick up the green password and use on lower row / right tile.",	//63
	@"",	//64 Walk to upper row / right tile and exit.
	//23
	@"Get book (phoenix.doc).",	//65
	@"Use decrypt on phoenix.doc.",	//66
	@"Get bust (phoenix program).",	//67
	@"Disconnect from LINC.",	//68
	//SECURITY CENTRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//24
	@"Use ID card on LINC terminal.",	//69
	@"Select “Security services”. Select “view documents”",	//70
	@"Read each document. Note that they need to have been decrypted in LINC space. ",	//71
	@"Select “special operations”. Select “special status request”.",	//72
	@"Select “file adjustment” to D-LINC Lamb.",	//73
	//HYDE PARK ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//25
	@"Talk to Henri, the bouncer, to find out about sponsorship for the club.",	//74
	@"Talk to Danielle to be invited back to her apartment.",	//75
	@"Go back to Danielle’s Apartment. ",	//76
	//26
	@"You will need the cat video from Lamb’s apartment.",	//77
	@"D-LINC Lamb from “file adjustment” on the LINC terminal, and then talk to him.",	//78
	@"While Danielle is on the phone, play the video.",	//79
	@"While the dog is distracted, get the dog biscuits.",	//80
	//27
	@"Go to the see-saw by the lake and use the dog biscuits on the plank.",	//81
	@"When the dog is nearby, pull the rope.",	//82
	@"When the dog gets onto the plank, release the rope. ",	//83
	//28
	@"Explore the lockers in the lower level - until you discover the terrible truth.",	//84
	//29
	@"Return to the reactor in the factory and put on the radiation suit.",	//85
	@"Go to the terminal and open the reactor. Inside, pick up Anita’s ID card.",	//86
	@"Go back through the Security building.",	//87
	@"Enter LINC using Anita’s card.",	//88
	//LINC 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//30
	@"Use “blind” on the eyeball in area 2.",	//89
	@"Use “playback” on the holographic projector (“well”) to view Anita’s message.",	//90
	@"Disconnect from LINC.",	//91
	//HYDE PARK 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//31
	@"Return to HYDE PARK.",	//92
	@"Talk to Vincent to find out about the gardener.",	//93
	@"Talk to the gardener until he tells you about the virus.",	//94
	//32
	@"Walk into the courtroom to witness Hobbins’s trial.",	//95
	@"Go to the club.",	//96
	@"Select “You search, but find nothing” on jukebox.",	//97
	@"Get Colston’s glass while he is away from the table.",	//98
	//33
	@"Give the glass to Burke to get fingerprints.",	//99
	//HYDE PARK 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//34
	@"Touch the plate to open the door to the wine cellar.",	//100
	@"Use the crowbar on the large box on the left.",	//101
	@"Get the lid and use it on the smaller box.",	//102
	@"Climb on top of the box.",	//103
	@"Use the crowbar on the grill.",	//104
	//35
	@"If you haven’t found the secateurs then go to the shed in the park. ",	//105
	@"Look at the door.",	//106
	@"Use the ID card on the lock.",	//107
	@"Enter the shed and get the secateurs.",	//108
	//36
	@"Use the secateurs on the grill.",	//109
	@"Climb through the grill.",	//110
	//UNDERWORLD ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//37
	@"Use the light bulb on the light socket to the left of the creature’s hole.",	//111
	//38
	@"Use the crowbar on the crumbling plaster, then again on the brickwork to obtain a brick.",	//112
	@"Use the crowbar on the clot in the vein.",	//113
	@"Use the brick on the crowbar to puncture the clot.",	//114
	@"Wait until the medical robot comes to repair the puncture, then exit through the door to the right.",	//115
	//39
	@"Close the cover over the pit using the terminal beside the pit.",	//116
	@"Climb on top of the pit cover.",	//117
	@"Pull the retaining bar on the grill above your head to loosen the grill.",	//118
	@"Return to the room above.",	//119
	//40
	@"Look through the grills to warn of any impending danger. ",	//120
	@"Look through the first grill that you encounter. ",	//121
	@"Walk right to the room where the medical robot is recharging.",	//122
	@"Use the circuit board on the medical robot.",	//123
	//41
	@"Talk to Joey and send him into the tank room.",	//124
	@"Ask Joey what he saw in the tank room.",	//125
	@"Ask Joey about the tank.",	//126
	@"Tell Joey to open the tap.",	//127
	@"Enter the tank room and watch the android plunge to his death. ",	//128
	//42
	@"Walk to the right of the tanks, into the computer room.",	//129
	@"Use Reich’s ID card on the terminal (to the left of the bank of computers)",	//130
	@"Open the access door.",	//131
	@"Leave the computer room and watch Joey get destroyed again.",	//132
	@"Take Gallagher’s card from his remains.",	//133
	//43
	@"Return to the computer room.",	//134
	@"Enter LINC using Gallagher’s card.",	//135
	//44
	@"You need to enter LINC using Gallagher’s card. Drop out, then return again.",	//136
	@"Use blind on the eyeball in area 1. Quickly go to area 2 and blind the eyeball.",	//137
	@"Get the oscillator (tuning fork).",	//138
	@"Go to the Crusader’s room. Use “divine wrath” to remove the Crusader.",	//139
	@"Enter the crystal room. Use the oscillator on the crystal.",	//140
	@"Get the virus. Disconnect from LINC.",	//141
	//45
	@"Go to the special android room. Open the cabinet on the middle console.",	//142
	@"Insert the circuit board in the cabinet.",	//143
	@"Use the monitor to download the data from the board.",	//144
	@"Run the android start-up program.",	//145
	//46
	@"Go right to the room with the large tanks.",	//146
	@"Ask Joey/Ken to put his hand on the door panel.",	//147
	@"Put your own hand on the other panel.",	//148
	//47
	@"Go to the tank of tissue samples and get the tongs from the wall (just to right of tank).",	//149
	@"Use Gallagher’s card (or whichever card contains the virus) on the console to infect the tissue with the virus.",	//150
	@"Remove a sample of infected tissue with the tongs.",	//151
	@"Put the sample of tissue into the nitrogen tank to freeze it.",	//152
	//48
	@"Go to the end of the pipes. Attach the cable to the pipe support.",	//153
	@"Use the rungs to descend to the feeding orifice.",	//154
	@"Drop the infected tissue into the orifice.",	//155
	@"Use the hanging rope to swing into the final room.",	//156
	//49
	@"When Joey/Ken enters tell him to sit in the chair.",	//157
	//E X T R A
	//E X T R A
	//E X T R A
	//RECYCLING PLANT 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//50
	@"Explore the factory. Perhaps you'll be able to get Joey working again.",	//158
	//INDUSTRIAL 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//51
	@"Take a look around - there must be someone around who can help.",	//159
	//52
	@"Explore some more - there's sure to be more to find.",	//160
	@"Go down the elevator on this level, and then the next one on Bellevue.",	//161
	@"",	//162
	@"",	//163
};
*/

@implementation Hint

-(UIButton*)giveButton//tony17june09
{
	return	m_button;
}

-(id)initWithQuestion:(int)question xcoord:(int) x ycoord:(int) y;//tony16june09
{
	//indent da text on da button
/*	UIEdgeInsets	e;
	e.left=14;
	e.right=14;
	e.top=-2;
	e.bottom=0;*/
	
	printf("Create question %d y=%d\n", question,y);
	
	m_question=(question+1000);
	m_num_answers=0;

	UIFont *font;
	font = [UIFont boldSystemFontOfSize:14];
		
		
	NSString *name = [g_AppDelegate ASCII:m_question];//[[NSString alloc] initWithString:helpQ[question] ];
//	name = [NSString stringWithFormat:@"• %@", name];
	
	CGSize textSize = [ name sizeWithFont: font constrainedToSize: CGSizeMake(220, 1000.0f) lineBreakMode: UILineBreakModeWordWrap ];
	int	h=(int)(textSize.height);

	printf("height=%d y=%d\n", h,y);

	//set up button
	m_button = [[UIButton alloc]init];//WithFrame:CGRectMake(10,y, 300, 45)];
	m_button.transform = TRANS(m_button);
	
	m_button.frame=CGRectMake(YY((y+h)),x, h, 220);//y,x,h,w

	if	(iPhone_isOS3())
		m_label = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 220, h)];
	else
		m_label = [[UILabel alloc]initWithFrame:CGRectMake(0,0-h, 220, h)];

	m_label.font=font;
	m_label.textColor = [UIColor colorWithRed:0.24 green:0.61 blue:1.0 alpha:1.0];//ibass-blue
	m_label.backgroundColor = [UIColor clearColor];
	m_label.textAlignment = UITextAlignmentLeft;
	m_label.lineBreakMode = UILineBreakModeWordWrap;
	m_label.numberOfLines=2;
	[m_label setText:name];
	[m_button addSubview:m_label];
	
	
	//has a handler
	[m_button addTarget:self action:@selector(clickQuestion:) forControlEvents:UIControlEventTouchUpInside];
	//set button id that will be passed with the event - ahh, so this is the proper way to do it :)
	m_button.tag=question;

	m_button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
	
	return self;
}
-(void)addAnswer: (int) answer//tony16june09
{
	if (m_num_answers==MAX_hint_answers)
	{
		printf("Too many answers\n");
		exit(1);
	}
	
	printf("Add answer %d (%d)", m_num_answers, answer);
	
	m_answers[m_num_answers++]=answer;
}

-(void)clickQuestion:(id)sender//tony17june09
{
	printf("Q %d\n", m_question);
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	
	//hacky intercept the special cases
	if (m_question==1054)
	{	[g_AppDelegate startInstructPanel: 0];
		return;
	}
	if (m_question==1055)
	{	[g_AppDelegate startInstructPanel: 1];
		return;
	}
	if (m_question==1056)
	{	[g_AppDelegate startInstructPanel: 2];
		return;
	}
	
	
	//now switch to hint screen, passing a reference to this hint
	[g_AppDelegate startHintPanel: self];
}
-(int)giveQ//tony18june09
{
	return m_question;
}
-(int)giveNumAnswers//tony18june09
{
	return m_num_answers;
}
-(int)giveAnswer:(int)answer//tony18june09
{
	return	m_answers[answer];
}

-(bool)answerSeen:(int)answer//tony6july09
{
	return Sky::g_engine->isHintAnswerSeen(answer-1057);
}
-(void)setAnswerSeen:(int)answer//tony6july09
{
	Sky::g_engine->setHintAnswerSeen(answer-1057);
}

@end




@implementation HelpPanelView




- (void)setup
{
	//title
	UIButton *titleButton= [[UIButton alloc] init];
//	titleButton.frame = CGRectMake(160-(269>>1),18, 269, 40);
	titleButton.transform = TRANS(titleButton);
	titleButton.frame=CGRectMake(YY(20),20, 30, 200);//y,x,h,w
	
	[titleButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"titlebar_puzzlehints.png"]] forState:UIControlStateDisabled];
	titleButton.backgroundColor = [UIColor clearColor];
	[self addSubview:titleButton];//add to the view
	titleButton.enabled = NO;

	

	
	//back button
	backButton= [[UIButton alloc] init];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_on.png"]] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"btn_sml_back_press.png"]] forState:UIControlStateHighlighted];
//	backButton.frame = CGRectMake((160-(176>>1)),420, 176, 29);
	backButton.transform = TRANS(backButton);
	backButton.frame=CGRectMake(YY(274),20, 25, 120);//y,x,h,w

	backButton.backgroundColor = [UIColor clearColor];
	[backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:backButton];//add to the view
	
	
	//have to switch this on in UIImageView class to get clicks - "who knew?" < reader's voice
	self.userInteractionEnabled=YES;
	
	
	//load images
	bgImage=	[[UIImage imageNamed:@"bg_plain.png"] retain];
	buttonImage=[[UIImage imageNamed:@"hintsbar.png"] retain];
	
	//hints! This was meant to be 2 weeks work on BSDC - it tooks months. So, 1 week to do all this on iBASS ;)
	//1 work out which section we're in
	//2 work out which questions are live
	//3 print em
	//4 click question - trans to new screen with answers greyed out until clicked
	

	//reset
	m_num_questions=0;
	
	//1
	switch(Sky::g_engine->giveCurrentScreen())
	{
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	0:
		case	1:
		case	2:
		case	4://hobbins workshop
			//2

			//if never been outside
			if	(!Sky::g_engine->hasSeenScreen(5))
			{
				printf("Section RECYCLING PLANT 1\n");
				
				printf("flag==%d\n", Sky::g_engine->giveScriptVar(106));
				
				//fire exit unopened - fire_exit_flag==106
				if(2==Sky::g_engine->giveScriptVar(106))
				{
					[self newQ: 0];
						[self addAnswer:1057];
						[self addAnswer:1058];
					break;
				}
				
				
				//if joey not alive and on transporter screen - joey_born==125
				if (!Sky::g_engine->giveScriptVar(125))
				{
					//if on trans screen - text is specific
					if	(Sky::g_engine->giveCurrentScreen()==2)
					{
						[self newQ: 1];
							[self addAnswer:1059];
							[self addAnswer:1060];
					}
					else//pre Joey, not on Joey screen
					{
						[self newQ: 50];//I've out-foxed the guard - what now?",	//50
							[self addAnswer:1213];
					}
					break;
				}

				[self newQ: 2];
					[self addAnswer:1061];
					[self addAnswer:1062];
					[self addAnswer:1063];
				[self newQ: 3];
					[self addAnswer:1064];
					
				break;
			}
			
			//got hook & not been to linc
			if(Sky::g_engine->giveScriptVar(90) && !Sky::g_engine->hasSeenScreen(90))//90 == hook inv slot
			{
				[self newQ: 19];//What do I do with this grappling hook?",	//19
					[self addAnswer:1108];
					[self addAnswer:1109];
			
				break;
			}			
			
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	3://furnace

			//if never been outside
			if	(!Sky::g_engine->hasSeenScreen(6))
			{
				[self newQ: 4];
					[self addAnswer:1065];
					[self addAnswer:1066];
			}
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	10:	//security centre
		case	11:

			//seen_holo but not knows_virus
			if(Sky::g_engine->giveScriptVar(337) && !Sky::g_engine->giveScriptVar(788))		
			{
				[self newQ: 31];//I’ve read Anita’s message – how do I make contact with Eduardo?",	//31
					[self addAnswer:1146];
					[self addAnswer:1147];
					[self addAnswer:1148];
					
				break;
			}
			
			
			//if seen anita corpse, not seen message seen_holo==337
			if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
			{
				[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
					[self addAnswer:1139];
					[self addAnswer:1140];
					[self addAnswer:1141];
					[self addAnswer:1142];
					
				break;
			}
			
			
			[self newQ: 20];//I’m in the security HQ. What should I do?",	//20
				[self addAnswer:1110];
				
			//seen the last linc room
			if	(Sky::g_engine->hasSeenScreen(93))
			{
				[self newQ: 24];//I think I’ve done everything in LINC space – how do I get out?",	//24
					[self addAnswer:1123];
					[self addAnswer:1124];
					[self addAnswer:1125];
					[self addAnswer:1126];
					[self addAnswer:1127];
			}
			
			break;
		
		
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	5: //INDUSTRIAL
		case	6:
		case	7:
		case	8:
		case	9:
		case	12://first inner fact
		case	13:
		case	14:
		case	15:
		case	18:
		

			//got new_prints==787
			if(Sky::g_engine->giveScriptVar(787))		
			{
				//quit
				break;
			}
			
			//stolen glass glass_stolen==830 but not got new_prints==787
			if(Sky::g_engine->giveScriptVar(830) && !Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 33];//I’ve got Colston’s glass but why?",	//33
					[self addAnswer:1153];
					
				break;
			}

			//seen_holo but not knows_virus
			if(Sky::g_engine->giveScriptVar(337) && !Sky::g_engine->giveScriptVar(788))		
			{
				[self newQ: 31];//I’ve read Anita’s message – how do I make contact with Eduardo?",	//31
					[self addAnswer:1146];
					[self addAnswer:1147];
					[self addAnswer:1148];
					
				break;
			}
		
			//if seen anita corpse, not seen message seen_holo==337
			if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
			{
				[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
					[self addAnswer:1139];
					[self addAnswer:1140];
					[self addAnswer:1141];
					[self addAnswer:1142];
					
					break;
			}
				

			//if getting the port knows_port==190 **
			if(Sky::g_engine->giveScriptVar(190) && 0==Sky::g_engine->giveScriptVar(256))//knows_port, but got_port==0
			{
				[self newQ: 15];//How do I get into the surgery?",	//15
					[self addAnswer:1096];
					[self addAnswer:1097];
					[self addAnswer:1098];
				break;
			}
				
			//if been in linc world - then no more hints
			if	(Sky::g_engine->hasSeenScreen(90))
			{
				//unless not been to hyde park!
				if	(!Sky::g_engine->hasSeenScreen(31))
				{
					[self newQ: 53];//"I've given myself special security status on LINC - now what?";	//53 (after first linc visit)
						[self addAnswer:1216];
				}
				break;	// ** ** ** ** ** ** t h e  e n d ** ** ** ** ** **
			}
			
			
			
			
			
		
			//got hook
			if(Sky::g_engine->giveScriptVar(90))//90 == hook inv slot
			{
				[self newQ: 19];//What do I do with this grappling hook?",	//19
					[self addAnswer:1108];
					[self addAnswer:1109];
			
				break;
			}	
								
									
													
			//if waiting for the tour, or done the tour, and not seen security complex
			if(Sky::g_engine->giveScriptVar(282) && !Sky::g_engine->hasSeenScreen(10))//tour_flag
			{
				[self newQ: 14];//Lamb has my ticket – what now?",	//14
					[self addAnswer:1092];
					[self addAnswer:1093];
					[self addAnswer:1094];
					[self addAnswer:1095];
			
				break;
			}
			
			

			
							
			//else
			printf("Section INDUSTRIAL LEVEL 1\n");

			//if has been in the first pipe room
			if	(Sky::g_engine->hasSeenScreen(12) && Sky::g_engine->giveScriptVar(428)==0)	//machine_stops=204, factory_flag==428
			{
				[self newQ: 5];//@"I need to de-activate the welder robot...",	//5
					[self addAnswer:1067];
					[self addAnswer:1068];
					[self addAnswer:1069];
					[self addAnswer:1070];
		//			[self addAnswer:14];
					
				break;//no more
			}
			
			
			//seen_welder==448,whats_joey==446
			//if seen welder and joey not got new shell, then -
			if	(Sky::g_engine->hasSeenScreen(12) && Sky::g_engine->giveScriptVar(446)==0)
			{
				[self newQ: 6];//"So how do I get the welder shell for Joey?",	//6
					[self addAnswer:1071];
					[self addAnswer:1072];
					[self addAnswer:1073];
				break;
			}

			
			//if has been in the 2nd pipe room
			if	(Sky::g_engine->hasSeenScreen(13))
			{
				//if not got putty and power room man still here - eg dont come back once used putty in power room - o6==75
				if	(Sky::g_engine->giveScriptVar(224)!=42 && Sky::g_engine->giveScriptVar(75)==0)
				{
					[self newQ: 7];//@"How can I get into the storeroom?",	//7
						[self addAnswer:1074];
						[self addAnswer:1075];

					//if been searched search_flag==270
					if	(Sky::g_engine->giveScriptVar(270))
					{
						[self newQ: 8];//@"Everything that I get from the storeroom is removed from me when I leave – what should I do?",	//8
							[self addAnswer:1076];
							[self addAnswer:1077];
					}
				}
			}
			
			//has been in power room
			//if has been in the power room
			if	(Sky::g_engine->hasSeenScreen(18))
			{

				//if man still here blown_top!=42
				if	(Sky::g_engine->giveScriptVar(224)!=42)
				{
					[self newQ: 9];//@"How can I get rid of the man in the power room?",	//9
						[self addAnswer:1078];
						[self addAnswer:1079];
				}
				
				//power to lift is off lift_power==445 && got_putty
				if (Sky::g_engine->giveScriptVar(445)==0 && Sky::g_engine->giveScriptVar(75))
				{
					[self newQ: 10];//@"How can I restore power?",	//10
						[self addAnswer:1080];
						[self addAnswer:1081];
						[self addAnswer:1082];
						[self addAnswer:1083];
						[self addAnswer:1084];
				}
			}

			//if not been to bellevue, and power on lift_power==445
			if	(!Sky::g_engine->hasSeenScreen(29) && Sky::g_engine->giveScriptVar(445))
			{
				[self newQ: 11];//@"How can I use that elevator?",	//11
					[self addAnswer:1085];
					[self addAnswer:1086];
					
				break;
			}
			
			
			//default at start, before seen welding robot
			if	(!Sky::g_engine->hasSeenScreen(12))
			{
				[self newQ: 51];//@"I'm in an industrial area. What should I do?",	//51
					[self addAnswer:1214];
			}
			//got putty and powerman still sat and not seen power room
			if	(!Sky::g_engine->hasSeenScreen(18))
				if	(Sky::g_engine->giveScriptVar(75) && Sky::g_engine->giveScriptVar(224)!=42)
				{
					[self newQ: 52];//@"I've found some putty-like substance - but what now?",	//52
						[self addAnswer:1215];
				}
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	16://reactor
		case	17:
			printf("Section INDUSTRIAL LEVEL 4\n");
			
			//if seen anita corpse, not seen message seen_holo==337
			if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
			{
				[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
					[self addAnswer:1139];
					[self addAnswer:1140];
					[self addAnswer:1141];
					[self addAnswer:1142];
			}
			
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	19:	//BELLEVUE
		case	20:
		case	21:
		case	22:
		case	23:
		case	24:
		case	25:
		case	26:
//		case	27://surgery
		case	28:
		case	29:


			//if waiting for the tour, or done the tour, and doesn't know about schreib port
			if(Sky::g_engine->giveScriptVar(282) && !Sky::g_engine->giveScriptVar(190))//tour_flag, knows_port
			{
				[self newQ: 14];//Lamb has my ticket – what now?",	//14
					[self addAnswer:1092];
					[self addAnswer:1093];
					[self addAnswer:1094];
					[self addAnswer:1095];
			
				break;
			}
			
			
			//got new_prints==787
			if(Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 34];//So, how do I get through to the subway?",	//34
					[self addAnswer:1154];
					[self addAnswer:1155];
					[self addAnswer:1156];
					[self addAnswer:1157];
					[self addAnswer:1158];
				break;
			}
			
			

			//stolen glass glass_stolen==830 but not got new_prints==787
			if(Sky::g_engine->giveScriptVar(830) && !Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 33];//I’ve got Colston’s glass but why?",	//33
					[self addAnswer:1153];
					
				break;
			}


			//seen_holo but not knows_virus
			if(Sky::g_engine->giveScriptVar(337) && !Sky::g_engine->giveScriptVar(788))		
			{
				[self newQ: 31];//I’ve read Anita’s message – how do I make contact with Eduardo?",	//31
					[self addAnswer:1146];
					[self addAnswer:1147];
					[self addAnswer:1148];
					
				break;
			}


			//if seen anita corpse, not seen message seen_holo==337
			if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
			{
				[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
					[self addAnswer:1139];
					[self addAnswer:1140];
					[self addAnswer:1141];
					[self addAnswer:1142];
					
				break;
			}
			
			
			//if been in apartment, but not got buscuits got_dog_biscuits==814
			if (Sky::g_engine->hasSeenScreen(38) && !Sky::g_engine->giveScriptVar(814))
			{
				[self newQ: 26];//How do I get those dog biscuits?",	//26
					[self addAnswer:1131];
					[self addAnswer:1132];
					[self addAnswer:1133];
					[self addAnswer:1134];
				
				break;
			}
			
			


			//at this point... if been in linc world...
			if	(Sky::g_engine->hasSeenScreen(90))
			{
				//unless not been to hyde park!
				if	(!Sky::g_engine->hasSeenScreen(31))
				{
					[self newQ: 53];//"I've given myself special security status on LINC - now what?";	//53 (after first linc visit)
						[self addAnswer:1216];
				}
				break;
			}


				
				
			//got hook
			if(Sky::g_engine->giveScriptVar(90))//90 == hook inv slot
			{
				[self newQ: 19];//What do I do with this grappling hook?",	//19
					[self addAnswer:1108];
					[self addAnswer:1109];
			
				break;
			}				
		
			//if getting the port knows_port==190
			if(Sky::g_engine->giveScriptVar(190) && 0==Sky::g_engine->giveScriptVar(256))//knows_port, but got_port==0
			{
				printf("Section BELLEVUE 2\n");
						
				[self newQ: 15];//How do I get into the surgery?",	//15
					[self addAnswer:1096];
					[self addAnswer:1097];
					[self addAnswer:1098];
					
				break;
			}
		
		
			//if not done tour - tour_flag goes to 42 when it's pending
			if(0==Sky::g_engine->giveScriptVar(282))//tour_flag
			{
				printf("Section BELLEVUE 1\n");

				//not got ticket
				if(0==Sky::g_engine->giveScriptVar(88))//019
				{
					[self newQ: 12];//"How do I get a ticket from the travel agent?",	//12
						[self addAnswer:1087];
						[self addAnswer:1088];
						[self addAnswer:1089];
						[self addAnswer:1090];
				}
				//have got ticket
				if(Sky::g_engine->giveScriptVar(88))//019
				{
					[self newQ: 13];//""What should I do with this ticket?",	//13
						[self addAnswer:1091];
				}
				break;
			}
			


			//perhaps if not been into security place? (or we can fake a room visit when combine in the inv menu)
			
			//if not got anchor, and got anchor+cable
			if(0==Sky::g_engine->giveScriptVar(83) && 0==Sky::g_engine->giveScriptVar(90))//o14==83
			{
				[self newQ: 17];//"The anchor looks important – how can I get it?",	//17
					[self addAnswer:1100];
					[self addAnswer:1101];
					[self addAnswer:1102];
					[self addAnswer:1103];
				break;
			}

			//if just got anchor
			if(Sky::g_engine->giveScriptVar(83))//o14==83
			{
				[self newQ: 18];//I’ve got the anchor – what now?",	//18
					[self addAnswer:1104];
					[self addAnswer:1105];
					[self addAnswer:1106];
					[self addAnswer:1107];
				break;
			}

			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	27://surgery
			//if got glass
			//stolen glass glass_stolen==830 but not got new_prints==787
			if(Sky::g_engine->giveScriptVar(830) && !Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 33];//I’ve got Colston’s glass but why?",	//33
					[self addAnswer:1153];
					
				break;
			}

			
			//if not got port got_port==256
			if(0==Sky::g_engine->giveScriptVar(256))
			{
				[self newQ: 16];//What must I do to get a Schriebmann port?",	//16
					[self addAnswer:1099];

				break;
			}
			
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	90://LINC WORLD
		case	91:
		case	92:
		case	93:
		case	94:
		case	95:
		

			//UNDERWORLD
			//if got gallaghers card - knows_virus==788 - card_used==497
			if(Sky::g_engine->giveScriptVar(703)==1)
			{
				[self newQ: 44];//I'm back in LINC – how do I get the virus?",	//44
				//using right card?
				if	(Sky::g_engine->giveScriptVar(497)!=6)
				{
					[self addAnswer:1191];
				}
				else
				{
					[self addAnswer:1192];
					[self addAnswer:1193];
					[self addAnswer:1194];
					[self addAnswer:1195];
					[self addAnswer:1196];
				}
				
				break;
			}	





			//if got anita's card - o13 = 71, seen_holo=337
			if(Sky::g_engine->giveScriptVar(82))
			{
				if(!Sky::g_engine->giveScriptVar(337))//not if already seen holo message - help me obe-wan
				{
					[self newQ: 30];//I’ve got Anita’s card – maybe she left some clues?",	//30
						[self addAnswer:1143];
						[self addAnswer:1144];
						[self addAnswer:1145];
				}
				
				break;
			}

			
			//else
			
			//if first 2 screens
			if (Sky::g_engine->giveCurrentScreen()==90 || Sky::g_engine->giveCurrentScreen()==91)
			{
				[self newQ: 21];//I’m stuck in the LINC world – what should I do?",	//21
					[self addAnswer:1111];
					[self addAnswer:1112];
					[self addAnswer:1113];
					[self addAnswer:1114];
				//	[self addAnswer:59];
				break;
			}
			
			//maze
			if (Sky::g_engine->giveCurrentScreen()==92)
			{
				[self newQ: 22];//I’m in a cyber maze – how do I get through it?",	//22
					[self addAnswer:1115];
					[self addAnswer:1116];
					[self addAnswer:1117];
					[self addAnswer:1118];
				//	[self addAnswer:64];
				break;
			}

			[self newQ: 23];//I’m through the cyber maze – what now?",	//23
				[self addAnswer:1119];
				[self addAnswer:1120];
				[self addAnswer:1121];
				[self addAnswer:1122];

			break;
			
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	30://HYDE PARK
		case	31:
		case	32:
		case	33:
		case	34:
		case	35:
		case	36:
		case	38:



			//got new_prints==787
			if(Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 34];//So, how do I get through to the subway?",	//34
					[self addAnswer:1154];
					[self addAnswer:1155];
					[self addAnswer:1156];
					[self addAnswer:1157];
					[self addAnswer:1158];
				break;
			}
			
			
			

			//stolen glass glass_stolen==830 but not got new_prints==787
			if(Sky::g_engine->giveScriptVar(830) && !Sky::g_engine->giveScriptVar(787))		
			{
				[self newQ: 33];//I’ve got Colston’s glass but why?",	//33
					[self addAnswer:1153];
					
				break;
			}


			
			//knows_virus or been_to_court
			if(Sky::g_engine->giveScriptVar(788) || Sky::g_engine->giveScriptVar(789))		
			{
				[self newQ: 32];//I’ve made contact with Eduardo. What now?",	//32
					[self addAnswer:1149];
					[self addAnswer:1150];
					[self addAnswer:1151];
					[self addAnswer:1152];
					
				break;
			}
			
			
			
			//seen_holo but not knows_virus
			if(Sky::g_engine->giveScriptVar(337) && !Sky::g_engine->giveScriptVar(788))		
			{
				[self newQ: 31];//I’ve read Anita’s message – how do I make contact with Eduardo?",	//31
					[self addAnswer:1146];
					[self addAnswer:1147];
					[self addAnswer:1148];
					
				break;
			}

			
			//got fingerprints
			
			//else first visit
			
			//if seen anita corpse, not seen message seen_holo==337
			if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
			{
				[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
					[self addAnswer:1139];
					[self addAnswer:1140];
					[self addAnswer:1141];
					[self addAnswer:1142];
					
				break;
			}
			
			//if been in apartment, but not got buscuits got_dog_biscuits==814
			if (Sky::g_engine->hasSeenScreen(38) && !Sky::g_engine->giveScriptVar(814))
			{
				[self newQ: 26];//How do I get those dog biscuits?",	//26
					[self addAnswer:1131];
					[self addAnswer:1132];
					[self addAnswer:1133];
					[self addAnswer:1134];
				
				break;
			}
			
			
			//if not been in apartment
			if	(!Sky::g_engine->hasSeenScreen(38))
			{
				[self newQ: 25];//I’ve got to ground level. What should I do now?",	//25
					[self addAnswer:1128];
					[self addAnswer:1129];
					[self addAnswer:1130];
			}
				
			//if has been in apartment AND
			//if NOT in apartment
			if (Sky::g_engine->giveCurrentScreen()!=38 && Sky::g_engine->hasSeenScreen(38))
			{
				[self newQ: 27];//"How do I get into the entrance that the security man is guarding?",	//27
					[self addAnswer:1135];
					[self addAnswer:1136];
					[self addAnswer:1137];
			}
			break;

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	39://cathedral
		case	40:
		case	41:
				[self newQ: 28];//I’m in the cathedral – what now?",	//28
					[self addAnswer:1138];
					
					
				//if seen anita corpse, not seen message seen_holo==337
				if(Sky::g_engine->giveScriptVar(822) && !Sky::g_engine->giveScriptVar(337))	
				{
					[self newQ: 29];//Anita’s been murdered. What should I do?",	//29
						[self addAnswer:1139];
						[self addAnswer:1140];
						[self addAnswer:1141];
						[self addAnswer:1142];
				}
					
				break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	37:	//hyde park grill room to subway
		
			[self newQ: 34];//So, how do I get through to the subway?",	//34
				[self addAnswer:1154];
				[self addAnswer:1155];
				[self addAnswer:1156];
				[self addAnswer:1157];
				[self addAnswer:1158];


			//if not got secateurs o10==79 but made first hole
			if(!Sky::g_engine->giveScriptVar(79) && Sky::g_engine->giveScriptVar(813)==1)
			{
				[self newQ: 35];//I’ve made a hole in the grill – what do I need to extend the hole?",	//35
					[self addAnswer:1159];
					[self addAnswer:1160];
					[self addAnswer:1161];
					[self addAnswer:1162];
					
				break;
			}
			
			//if not extended hole sc37_grill_state==813
			if(Sky::g_engine->giveScriptVar(813)==1)
			{
				[self newQ: 36];//I’ve made a hole in the grill – how do I extend the hole and proceed?",	//36
					[self addAnswer:1163];
					[self addAnswer:1164];
			}
			
						
												
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	48://UNDERWORLD lightbulb
			[self newQ: 37];//There’s a creature that grabs me – how can I avoid it?",	//37
				[self addAnswer:1165];
				
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	67://UNDERWORLD vein room
			[self newQ: 38];//How do I get through the big metal door?",	//38
				[self addAnswer:1166];
				[self addAnswer:1168];
				[self addAnswer:1169];
				[self addAnswer:1170];
				
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	68://UNDERWORLD
		case	69:
		case	70:
		case	71:
		case	72:
		case	73:
		case	74:
		case	75:
		case	76:
		case	77:
		case	78:
		case	79:
		case	80:
				
			//if not killed android - sc72_witness_killed==700
			if(Sky::g_engine->giveScriptVar(700)==0)
			{
				if	(Sky::g_engine->hasSeenScreen(70) && Sky::g_engine->giveScriptVar(696)==0)//seen pit room && not opened grill sc70_grill_flag==696
				{
					[self newQ: 39];//There’s a strange pit – what do I do with it?",	//39
						[self addAnswer:1171];
						[self addAnswer:1172];
						[self addAnswer:1173];
						[self addAnswer:1174];
				}
				
				//still got joey board
				if(Sky::g_engine->giveScriptVar(72)>0)
				{
					[self newQ: 40];//What do I do in this strange underworld?",	//40
						[self addAnswer:1175];
						[self addAnswer:1176];
						[self addAnswer:1177];
						[self addAnswer:1178];
				}
				//if joey alive again o3==72 (not got joey board)
				if(Sky::g_engine->giveScriptVar(72)==0)
				{
					[self newQ: 41];//How can we get past the Android in the lab?",	//41
						[self addAnswer:1179];
						[self addAnswer:1180];
						[self addAnswer:1181];
						[self addAnswer:1182];
						[self addAnswer:1183];
				}
				break;
			}
			
			//if not got gallagher's card - sc73_searched_corpse==703, o23==92
			if(Sky::g_engine->giveScriptVar(703)==0)
			{
				[self newQ: 42];//I killed the android. What next?",	//42
					[self addAnswer:1184];
					[self addAnswer:1185];
					[self addAnswer:1186];
					[self addAnswer:1187];
					[self addAnswer:1188];
				break;
			}


			//if not got virus from linc - virus_taken==642
			if(Sky::g_engine->giveScriptVar(642)==0)
			{
				[self newQ: 43];//Anita mentioned a virus – how do I get it?",	//43
					[self addAnswer:1189];
					[self addAnswer:1190];
				break;
			}


			//get ken going! - sc76_ken_prog_flag==713
			if(Sky::g_engine->giveScriptVar(713)==0)
			{
				[self newQ: 45];//Poor old Joey – how do I get resurrect him. Again?",	//45
					[self addAnswer:1197];
					[self addAnswer:1198];
					[self addAnswer:1199];
					[self addAnswer:1200];
				break;
			}
			
			//hand door opened - door_77_78_flag==719
			if(Sky::g_engine->giveScriptVar(719)!=2)
			{
				[self newQ: 46];//I’ve turned Joey into an android. What I do with him?",	//46
					[self addAnswer:1201];
					[self addAnswer:1202];
					[self addAnswer:1203];
				break;
			}
			
			//if not got frozen virus - sc75_tongs_flag==708
			if	(Sky::g_engine->giveScriptVar(708)!=3)
			{
				[self newQ: 47];//I’ve got the virus from LINC space – how get it into the read world?",	//47
					[self addAnswer:1204];
					[self addAnswer:1205];
					[self addAnswer:1206];
					[self addAnswer:1207];
				break;
			}
			else
			{
				[self newQ: 48];//I’ve got some infected tissue – what now?",	//48
					[self addAnswer:1208];
					[self addAnswer:1209];
					[self addAnswer:1210];
					[self addAnswer:1211];
				break;
			}
			

			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		case	81://final room
			[self newQ: 49];//I’ve met my own father – how do I save humanity?",	//49
				[self addAnswer:1212];
				
			break;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	}

	//special UI
	int	y=HINT_base_y;//(HINT_base_y+(m_num_questions*HINT_spacing)+10);
		
	//title
	UIButton *titleButton2= [[UIButton alloc] init];
//	titleButton2.frame = CGRectMake(160-(269>>1),y, 269, 40);
	titleButton2.transform = TRANS(titleButton2);
	titleButton2.frame=CGRectMake(YY(20),260, 30, 200);//y,x,h,w
	
	[titleButton2 setBackgroundImage:[UIImage imageNamed:[g_AppDelegate BUTTON:@"titlebar_controlhelp.png"]] forState:UIControlStateDisabled];
	titleButton2.backgroundColor = [UIColor clearColor];
	[self addSubview:titleButton2];//add to the view
	titleButton2.enabled = NO;
	
	//make it
//	y+=HINT_spacing;
	m_hints[m_num_questions++]= [[Hint alloc] initWithQuestion:54 xcoord:250 ycoord:y];
	//add to view
	[self addSubview: [m_hints[m_num_questions-1] giveButton] ];//add to the view

	//make it
	y+=HINT_spacing;
	m_hints[m_num_questions++]= [[Hint alloc] initWithQuestion:55 xcoord:250 ycoord:y];
	//add to view
	[self addSubview: [m_hints[m_num_questions-1] giveButton] ];//add to the view
	
	//fire exit unopened - fire_exit_flag==106
	if(2==Sky::g_engine->giveScriptVar(106))
	{
		y+=HINT_spacing;
		//make it
		m_hints[m_num_questions++]= [[Hint alloc] initWithQuestion:56 xcoord:250 ycoord:y];
		//add to view
		[self addSubview: [m_hints[m_num_questions-1] giveButton] ];//add to the view
	}
	
}

-(void)newQ:(int) question//tony16june09
{
	//add a new question
	
	//calc screen position
	int	y=(HINT_base_y+(m_num_questions*HINT_spacing));
	//make it
	m_hints[m_num_questions++]= [[Hint alloc] initWithQuestion:question xcoord:10 ycoord:y];
	//add to view
	[self addSubview: [m_hints[m_num_questions-1] giveButton] ];//add to the view
}


-(void)addAnswer:(int) answer//tony16june09
{
	//add a new question
	[ m_hints[m_num_questions-1] addAnswer:answer];
	printf("Add answer %d to q %d\n", answer, (m_num_questions-1));
}

- (void)backButtonPressed	//tony28may09
{
	Sky::g_engine->giveSystem()->playUISFX(UI_SOUND_MENU_INTO);
	//close view button pressed - transition back to game
	[g_AppDelegate endHelpPanel];
}


- (void)dealloc
{
//	printf("Help dealloc\n");
	
    [super dealloc];
	
	for	(int j=0;j<m_num_questions;j++)
		[m_hints[j] release];
}


-(void)drawRect:(CGRect)rect
{
	CGRect	r;

	//draw the background
	r.origin.x=0;
	r.origin.y=0;
	r.size=bgImage.size;
	[bgImage drawInRect:r];
	
	//draw up the button bg's if < 3.0 - grrrr
/*	if	(!iPhone_isOS3())
	{
		int	j,y=0, yy=0;

		r.origin.x=10;
		r.size.width=300;
		r.size.height=45;

		for	(j=0;j<m_num_questions;j++)
		{
			r.origin.y=(yy+HINT_base_y+(y*HINT_spacing));
			[buttonImage drawInRect:r];
			
			//next
			y++;
			//skip the gap before the 2 special hints
			if	(j==(m_num_questions-3))
			{	y++;
				yy=10;
			}
		}
	}
*/

}

@end


