/* ScummVM - Graphic Adventure Engine
 *
 * ScummVM is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to:
 * http://www.scummvm.org/credits/
 *
 * Portions Copyright (C) 2009 Revolution Software Ltd.
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
 *
 */

#ifndef SKY_LOGIC_H
#define SKY_LOGIC_H

#include "common/system.h"
#include "system/random.h"

namespace Sky {

struct Compact;

enum scriptVariableOffsets {
	RESULT = 0,
	SCREEN = 1,
	LOGIC_LIST_NO = 2,
	SAFE_LOGIC_LIST = 3,
	MOUSE_LIST_NO = 6,
	DRAW_LIST_NO = 8,
	CUR_ID = 12,
	MOUSE_STATUS = 13,
	MOUSE_STOP = 14,
	BUTTON = 15,
	SPECIAL_ITEM = 17,
	GET_OFF = 18,
	CURSOR_ID = 22,
	SAFEX = 25,
	SAFEY = 26,
	PLAYER_X = 27,
	PLAYER_Y = 28,
	PLAYER_MOOD = 29,
	PLAYER_SCREEN = 30,
	HIT_ID = 37,
	LAYER_0_ID = 41,
	LAYER_1_ID = 42,
	LAYER_2_ID = 43,
	LAYER_3_ID = 44,
	GRID_1_ID = 45,
	GRID_2_ID = 46,
	GRID_3_ID = 47,
	THE_CHOSEN_ONE = 51,
	TEXT1 = 53,
	FIRST_ICON = 99,
	MENU_LENGTH = 100,
	SCROLL_OFFSET = 101,
	MENU = 102,
	OBJECT_HELD = 103,
	ICON_LIT = 104,
	LAMB_GREET = 109,
	RND = 115,
	CUR_SECTION = 143,
	JOEY_SECTION = 145,
	LAMB_SECTION = 146,
	KNOWS_PORT = 190,
	GOT_SPONSOR = 240,
	GOT_JAMMER = 258,
	CONSOLE_TYPE = 345,
	S15_FLOOR = 450,
	FOREMAN_FRIEND = 451,
	REICH_DOOR_FLAG = 470,
	CARD_STATUS = 479,
	CARD_FIX = 480,
	GUARDIAN_THERE = 640,
	FS_COMMAND = 643,
	ENTER_DIGITS = 644,
	LINC_DIGIT_0 = 646,
	LINC_DIGIT_1 = 647,
	LINC_DIGIT_2 = 648,
	LINC_DIGIT_3 = 649,
	LINC_DIGIT_4 = 650,
	LINC_DIGIT_5 = 651,
	LINC_DIGIT_6 = 651,
	LINC_DIGIT_7 = 653,
	LINC_DIGIT_8 = 654,
	LINC_DIGIT_9 = 655,
	DOOR_67_68_FLAG = 678,
	SC70_IRIS_FLAG = 693,
	DOOR_73_75_FLAG = 704,
	SC76_CABINET1_FLAG = 709,
	SC76_CABINET2_FLAG = 710,
	SC76_CABINET3_FLAG = 711,
	DOOR_77_78_FLAG = 719,
	SC80_EXIT_FLAG = 720,
	SC31_LIFT_FLAG = 793,
	SC32_LIFT_FLAG = 797,
	SC33_SHED_DOOR_FLAG = 798,
	BAND_PLAYING = 804,
	COLSTON_AT_TABLE = 805,
	SC36_NEXT_DEALER = 806,
	SC36_DOOR_FLAG = 807,
	SC37_DOOR_FLAG = 808,
	SC40_LOCKER_1_FLAG = 817,
	SC40_LOCKER_2_FLAG = 818,
	SC40_LOCKER_3_FLAG = 819,
	SC40_LOCKER_4_FLAG = 820,
	SC40_LOCKER_5_FLAG = 821
};

#define NUM_SKY_SCRIPTVARS 838

class AutoRoute;
class Control;
class Disk;
class Grid;
class Mouse;
class Music;
class Screen;
class Sound;
class Text;
class SkyCompact;

class Logic;

typedef void (Logic::*LogicTable) ();
typedef bool (Logic::*McodeTable) (uint32, uint32, uint32);

class Logic {
public:
	Logic(
		SkyCompact *skyCompact,
		Screen *skyScreen,
		Disk *skyDisk,
		Text *skyText,
		Music *skyMusic,
		Mouse *skyMouse,
		Sound *skySound);
	~Logic(void);
	void engine();
	void useControlInstance(Control *control) { _skyControl = control; }

	uint16 mouseScript(uint32 scrNum, Compact *scriptComp);

	static uint32 _scriptVariables[NUM_SKY_SCRIPTVARS];
	Grid *_skyGrid;

	uint16 script(uint16 scriptNo, uint16 offset);
	void initScreen0(void);
	void parseSaveData(uint32 *data);

	void	Start_inventory(uint32	highlightedId=0);//tony23april2009
	uint32	*Give_inv_list(){return &_objectList[0];}//tony23april2009
	void	KillInventory();//tony26april09
	void	BlankMouse(){fnBlankMouse(0, 0, 0);}//tony1may2009 (Mac-Mini number 2!)

private:
	void setupLogicTable();
	void setupMcodeTable();
	const LogicTable *_logicTable;
	const McodeTable *_mcodeTable;
	bool _liveInv;

protected:
	void push(uint32);
	uint32 pop();
	void checkModuleLoaded(uint16 moduleNo);
	bool collide(Compact *cpt);
	void initScriptVariables();
	void mainAnim();
	void runGetOff();
	void stopAndWait();
	bool checkProtection(void);

	void nop();
	void logicScript();
	void autoRoute();
	void arAnim();
	void arTurn();
	void alt();
	void anim();
	void turn();
	void cursor();
	void talk();
	void listen();
	void stopped();
	void choose();
	void frames();
	void pause();
	void waitSync();
	void simpleAnim();

	bool fnCacheChip(uint32 a, uint32 b, uint32 c);
	bool fnCacheFast(uint32 a, uint32 b, uint32 c);
	bool fnDrawScreen(uint32 a, uint32 b, uint32 c);
	bool fnAr(uint32 a, uint32 b, uint32 c);
	bool fnArAnimate(uint32 a, uint32 b, uint32 c);
	bool fnIdle(uint32 a, uint32 b, uint32 c);
	bool fnInteract(uint32 a, uint32 b, uint32 c);
	bool fnStartSub(uint32 a, uint32 b, uint32 c);
	bool fnTheyStartSub(uint32 a, uint32 b, uint32 c);
	bool fnAssignBase(uint32 a, uint32 b, uint32 c);
	bool fnDiskMouse(uint32 a, uint32 b, uint32 c);
	bool fnNormalMouse(uint32 a, uint32 b, uint32 c);
	bool fnBlankMouse(uint32 a, uint32 b, uint32 c);
	bool fnCrossMouse(uint32 a, uint32 b, uint32 c);
	bool fnCursorRight(uint32 a, uint32 b, uint32 c);
	bool fnCursorLeft(uint32 a, uint32 b, uint32 c);
	bool fnCursorDown(uint32 a, uint32 b, uint32 c);
	bool fnOpenHand(uint32 a, uint32 b, uint32 c);
	bool fnCloseHand(uint32 a, uint32 b, uint32 c);
	bool fnGetTo(uint32 a, uint32 b, uint32 c);
	bool fnSetToStand(uint32 a, uint32 b, uint32 c);
	bool fnTurnTo(uint32 a, uint32 b, uint32 c);
	bool fnArrived(uint32 a, uint32 b, uint32 c);
	bool fnLeaving(uint32 a, uint32 b, uint32 c);
	bool fnSetAlternate(uint32 a, uint32 b, uint32 c);
	bool fnAltSetAlternate(uint32 a, uint32 b, uint32 c);
	bool fnKillId(uint32 a, uint32 b, uint32 c);
	bool fnNoHuman(uint32 a, uint32 b, uint32 c);
	bool fnAddHuman(uint32 a, uint32 b, uint32 c);
	bool fnAddButtons(uint32 a, uint32 b, uint32 c);
	bool fnNoButtons(uint32 a, uint32 b, uint32 c);
	bool fnSetStop(uint32 a, uint32 b, uint32 c);
	bool fnClearStop(uint32 a, uint32 b, uint32 c);
	bool fnPointerText(uint32 a, uint32 b, uint32 c);
	bool fnQuit(uint32 a, uint32 b, uint32 c);
	bool fnSpeakMe(uint32 targetId, uint32 mesgNum, uint32 animNum);
	bool fnSpeakMeDir(uint32 targetId, uint32 mesgNum, uint32 animNum);
	bool fnSpeakWait(uint32 a, uint32 b, uint32 c);
	bool fnSpeakWaitDir(uint32 a, uint32 b, uint32 c);
	bool fnChooser(uint32 a, uint32 b, uint32 c);
	bool fnHighlight(uint32 a, uint32 b, uint32 c);
	bool fnTextKill(uint32 a, uint32 b, uint32 c);
	bool fnStopMode(uint32 a, uint32 b, uint32 c);
	bool fnWeWait(uint32 a, uint32 b, uint32 c);
	bool fnSendSync(uint32 a, uint32 b, uint32 c);
	bool fnSendFastSync(uint32 a, uint32 b, uint32 c);
	bool fnSendRequest(uint32 a, uint32 b, uint32 c);
	bool fnClearRequest(uint32 a, uint32 b, uint32 c);
	bool fnCheckRequest(uint32 a, uint32 b, uint32 c);
	bool fnStartMenu(uint32 a, uint32 b, uint32 c);
	bool fnUnhighlight(uint32 a, uint32 b, uint32 c);
	bool fnFaceId(uint32 a, uint32 b, uint32 c);
	bool fnForeground(uint32 a, uint32 b, uint32 c);
	bool fnBackground(uint32 a, uint32 b, uint32 c);
	bool fnNewBackground(uint32 a, uint32 b, uint32 c);
	bool fnSort(uint32 a, uint32 b, uint32 c);
	bool fnNoSpriteEngine(uint32 a, uint32 b, uint32 c);
	bool fnNoSpritesA6(uint32 a, uint32 b, uint32 c);
	bool fnResetId(uint32 a, uint32 b, uint32 c);
	bool fnToggleGrid(uint32 a, uint32 b, uint32 c);
	bool fnPause(uint32 a, uint32 b, uint32 c);
	bool fnRunAnimMod(uint32 a, uint32 b, uint32 c);
	bool fnSimpleMod(uint32 a, uint32 b, uint32 c);
	bool fnRunFrames(uint32 a, uint32 b, uint32 c);
	bool fnAwaitSync(uint32 a, uint32 b, uint32 c);
	bool fnIncMegaSet(uint32 a, uint32 b, uint32 c);
	bool fnDecMegaSet(uint32 a, uint32 b, uint32 c);
	bool fnSetMegaSet(uint32 a, uint32 b, uint32 c);
	bool fnMoveItems(uint32 a, uint32 b, uint32 c);
	bool fnNewList(uint32 a, uint32 b, uint32 c);
	bool fnAskThis(uint32 a, uint32 b, uint32 c);
	bool fnRandom(uint32 a, uint32 b, uint32 c);
	bool fnPersonHere(uint32 a, uint32 b, uint32 c);
	bool fnToggleMouse(uint32 a, uint32 b, uint32 c);
	bool fnMouseOn(uint32 a, uint32 b, uint32 c);
	bool fnMouseOff(uint32 a, uint32 b, uint32 c);
	bool fnFetchX(uint32 a, uint32 b, uint32 c);
	bool fnFetchY(uint32 a, uint32 b, uint32 c);
	bool fnTestList(uint32 a, uint32 b, uint32 c);
	bool fnFetchPlace(uint32 a, uint32 b, uint32 c);
	bool fnCustomJoey(uint32 a, uint32 b, uint32 c);
	bool fnSetPalette(uint32 a, uint32 b, uint32 c);
	bool fnTextModule(uint32 a, uint32 b, uint32 c);
	bool fnChangeName(uint32 a, uint32 b, uint32 c);
	bool fnMiniLoad(uint32 a, uint32 b, uint32 c);
	bool fnFlushBuffers(uint32 a, uint32 b, uint32 c);
	bool fnFlushChip(uint32 a, uint32 b, uint32 c);
	bool fnSaveCoods(uint32 a, uint32 b, uint32 c);
	bool fnPlotGrid(uint32 a, uint32 b, uint32 c);
	bool fnRemoveGrid(uint32 a, uint32 b, uint32 c);
	bool fnEyeball(uint32 a, uint32 b, uint32 c);
	bool fnCursorUp(uint32 a, uint32 b, uint32 c);
	bool fnLeaveSection(uint32 a, uint32 b, uint32 c);
	bool fnEnterSection(uint32 sectionNo, uint32 b, uint32 c);
	bool fnRestoreGame(uint32 a, uint32 b, uint32 c);
	bool fnRestartGame(uint32 a, uint32 b, uint32 c);
	bool fnNewSwingSeq(uint32 a, uint32 b, uint32 c);
	bool fnWaitSwingEnd(uint32 a, uint32 b, uint32 c);
	bool fnSkipIntroCode(uint32 a, uint32 b, uint32 c);
	bool fnBlankScreen(uint32 a, uint32 b, uint32 c);
	bool fnPrintCredit(uint32 a, uint32 b, uint32 c);
	bool fnLookAt(uint32 a, uint32 b, uint32 c);
	bool fnLincTextModule(uint32 a, uint32 b, uint32 c);
	bool fnTextKill2(uint32 a, uint32 b, uint32 c);
	bool fnSetFont(uint32 a, uint32 b, uint32 c);
	bool fnStartFx(uint32 a, uint32 b, uint32 c);
	bool fnStopFx(uint32 a, uint32 b, uint32 c);
	bool fnStartMusic(uint32 a, uint32 b, uint32 c);
	bool fnStopMusic(uint32 a, uint32 b, uint32 c);
	bool fnFadeDown(uint32 a, uint32 b, uint32 c);
	bool fnFadeUp(uint32 a, uint32 b, uint32 c);
	bool fnQuitToDos(uint32 a, uint32 b, uint32 c);
	bool fnPauseFx(uint32 a, uint32 b, uint32 c);
	bool fnUnPauseFx(uint32 a, uint32 b, uint32 c);
	bool fnPrintf(uint32 a, uint32 b, uint32 c);

	void stdSpeak(Compact *target, uint32 textNum, uint32 animNum, uint32 base);
	void fnExec(uint16 num, uint32 a, uint32 b, uint32 c);

	uint16 *_moduleList[16];
	uint32 _stack[20];
	byte _stackPtr;

	Compact *_compact;

	uint32 _objectList[30];

	uint32 _currentSection;

	RandomThing _rnd;

	SkyCompact	*_skyCompact;
	Screen		*_skyScreen;
	Disk		*_skyDisk;
	Text		*_skyText;
	Music		*_skyMusic;
	Sound		*_skySound;
	AutoRoute	*_skyAutoRoute;
	Mouse		*_skyMouse;
	Control		*_skyControl;
};

} // End of namespace Sky

#endif

/* all

 0: result
 1: screen
 2: logic_list_no
 3: safe_logic_list
 4: low_list_no
 5: high_list_no
 6: mouse_list_no
 7: safe_mouse_list
 8: draw_list_no
 9: second_draw_list
 10: do_not_use
 11: music_module
 12: cur_id
 13: mouse_status
 14: mouse_stop
 15: button
 16: but_repeat
 17: special_item
 18: get_off
 19: safe_click
 20: click_id
 21: player_id
 22: cursor_id
 23: pointer_pen
 24: last_pal
 25: safex
 26: safey
 27: player_x
 28: player_y
 29: player_mood
 30: player_screen
 31: old_x
 32: old_y
 33: joey_x
 34: joey_y
 35: joey_list
 36: flag
 37: hit_id
 38: player_target
 39: joey_target
 40: mega_target
 41: layer_0_id
 42: layer_1_id
 43: layer_2_id
 44: layer_3_id
 45: grid_1_id
 46: grid_2_id
 47: grid_3_id
 48: stop_grid
 49: text_rate
 50: text_speed
 51: the_chosen_one
 52: chosen_anim
 53: text1
 54: anim1
 55: text2
 56: anim2
 57: text3
 58: anim3
 59: text4
 60: anim4
 61: text5
 62: anim5
 63: text6
 64: anim6
 65: text7
 66: anim7
 67: text8
 68: anim8
 69: o0
 70: o1
 71: o2
 72: o3
 73: o4
 74: o5
 75: o6
 76: o7
 77: o8
 78: o9
 79: o10
 80: o11
 81: o12
 82: o13
 83: o14
 84: o15
 85: o16
 86: o17
 87: o18
 88: o19
 89: o20
 90: o21
 91: o22
 92: o23
 93: o24
 94: o25
 95: o26
 96: o27
 97: o28
 98: o29
 99: first_icon
 100: menu_length
 101: scroll_offset
 102: menu
 103: object_held
 104: icon_lit
 105: at_sign
 106: fire_exit_flag
 107: small_door_flag
 108: jobs_greet
 109: lamb_greet
 110: knob_flag
 111: lazer_flag
 112: cupb_flag
 113: jobs_loop
 114: done_something
 115: rnd
 116: jobs_text
 117: jobs_loc1
 118: jobs_loc2
 119: jobs_loc3
 120: id_talking
 121: alarm
 122: alarm_count
 123: clearing_alarm
 124: jobs_friend
 125: joey_born
 126: joey_text
 127: joey_peeved
 128: knows_linc
 129: linc_overmann
 130: reich_entry
 131: seen_lock
 132: wshop_text
 133: knows_firedoor
 134: knows_furnace
 135: jobs_got_spanner
 136: jobs_got_sandwich
 137: jobs_firedoor
 138: knows_transporter
 139: joey_loc1
 140: joey_loc2
 141: joey_loc3
 142: joey_screen
 143: cur_section
 144: old_section
 145: joey_section
 146: lamb_section
 147: knows_overmann
 148: jobs_overmann
 149: jobs_seen_joey
 150: anita_text
 151: anit_loc1
 152: anit_loc2
 153: anit_loc3
 154: lamb_friend
 155: lamb_sick
 156: lamb_crawly
 157: lamb_loc1
 158: lamb_loc2
 159: lamb_loc3
 160: lamb_got_spanner
 161: lamb_text
 162: knows_auditor
 163: lamb_security
 164: lamb_auditor
 165: fore_text
 166: transporter_alive
 167: anita_friend
 168: anita_stop
 169: anita_count
 170: knows_security
 171: fore_loc1
 172: fore_loc2
 173: fore_loc3
 174: fore_friend
 175: knows_dlinc
 176: seen_lift
 177: player_sound
 178: guard_linc
 179: guard_text
 180: guar_loc1
 181: guar_loc2
 182: guar_loc3
 183: guard_talk
 184: lamb_out
 185: guard_warning
 186: wshp_loc1
 187: wshp_loc2
 188: wshp_loc3
 189: jobs_linc
 190: knows_port
 191: jobs_port
 192: joey_overmann
 193: joey_count
 194: knows_pipes
 195: knows_hobart
 196: fore_hobart
 197: fore_overmann
 198: anit_text
 199: seen_eye
 200: anita_dlinc
 201: seen_dis_lift
 202: lamb_move_anita
 203: lamb_stat
 204: machine_stops
 205: guard_stat
 206: guard_hobart
 207: gordon_text
 208: gord_loc1
 209: gord_loc2
 210: gord_loc3
 211: lamb_hobart
 212: anita_loc1
 213: anita_loc2
 214: anita_loc3
 215: knows_elders
 216: anita_elders
 217: anita_overmann
 218: stay_here
 219: joey_pause
 220: knows_break_in
 221: joey_break_in
 222: joey_lift
 223: stair_talk
 224: blown_top
 225: tamper_flag
 226: knows_reich
 227: gordon_reich
 228: open_panel
 229: panel_count
 230: wreck_text
 231: press_button
 232: touch_count
 233: gordon_overmann
 234: lamb_reich
 235: exit_stores
 236: henri_text
 237: henr_loc1
 238: henr_loc2
 239: henr_loc3
 240: got_sponsor
 241: used_deodorant
 242: lob_dad_text
 243: lob_son_text
 244: scan_talk
 245: dady_loc1
 246: dady_loc2
 247: dady_loc3
 248: samm_loc1
 249: samm_loc2
 250: samm_loc3
 251: dirty_card
 252: wrek_loc1
 253: wrek_loc2
 254: wrek_loc3
 255: crushed_nuts
 256: got_port
 257: anita_port
 258: got_jammer
 259: knows_anita
 260: anita_hobart
 261: local_count
 262: lamb_joey
 263: stop_store
 264: knows_suit
 265: joey_box
 266: asked_box
 267: shell_count
 268: got_cable
 269: local_flag
 270: search_flag
 271: rad_count
 272: rad_text
 273: radm_loc1
 274: radm_loc2
 275: radm_loc3
 276: gordon_off
 277: knows_jobsworth
 278: rad_back_flag
 279: lamb_lift
 280: knows_cat
 281: lamb_screwed
 282: tour_flag
 283: foreman_reactor
 284: foreman_anita
 285: burke_text
 286: burk_loc1
 287: burk_loc2
 288: burk_loc3
 289: burke_anchor
 290: jason_text
 291: jaso_loc1
 292: jaso_loc2
 293: helg_loc2
 294: say_to_helga
 295: interest_count
 296: anchor_text
 297: anchor_overmann
 298: anch_loc1
 299: anch_loc2
 300: anch_loc3
 301: anchor_count
 302: lamb_anchor
 303: anchor_port
 304: knows_stephen
 305: knows_ghoul
 306: anchor_talk
 307: joey_hook
 308: joey_done_dir
 309: bios_loc1
 310: bios_loc2
 311: bios_loc3
 312: got_hook
 313: anchor_anita
 314: trev_loc1
 315: trev_loc2
 316: trev_loc3
 317: trevor_text
 318: trev_text
 319: trev_overmann
 320: lamb_smell
 321: art_flag
 322: trev_computer
 323: helga_text
 324: helg_loc1
 325: helg_loc3
 326: bios_loc4
 327: gallagher_text
 328: gall_loc1
 329: gall_loc2
 330: gall_loc3
 331: warn_lamb
 332: open_apts
 333: store_count
 334: foreman_auditor
 335: frozen_assets
 336: read_report
 337: seen_holo
 338: knows_subway
 339: exit_flag
 340: father_text
 341: lamb_fix
 342: read_briefing
 343: seen_shaft
 344: knows_mother
 345: console_type
 346: hatch_selected
 347: seen_walters
 348: joey_fallen
 349: jbel_loc1
 350: lbel_loc1
 351: lbel_loc2
 352: jobsworth_speech
 353: jobs_alert
 354: jobs_alarmed_ref
 355: safe_joey_recycle
 356: safe_joey_sss
 357: safe_joey_mission
 358: safe_trans_mission
 359: safe_slot_mission
 360: safe_corner_mission
 361: safe_joey_logic
 362: safe_gordon_speech
 363: safe_button_mission
 364: safe_dad_speech
 365: safe_son_speech
 366: safe_skorl_speech
 367: safe_uchar_speech
 368: safe_wreck_speech
 369: safe_anita_speech
 370: safe_lamb_speech
 371: safe_foreman_speech
 372: joey_42_mission
 373: joey_junction_mission
 374: safe_welder_mission
 375: safe_joey_weld
 376: safe_radman_speech
 377: safe_link_7_29
 378: safe_link_29_7
 379: safe_lamb_to_3
 380: safe_lamb_to_2
 381: safe_burke_speech
 382: safe_burke_1
 383: safe_burke_2
 384: safe_dr_1
 385: safe_body_speech
 386: joey_bell
 387: safe_anchor_speech
 388: safe_anchor
 389: safe_pc_mission
 390: safe_hook_mission
 391: safe_trevor_speech
 392: joey_fact
 393: safe_helga_speech
 394: helga_mission
 395: gal_bel_speech
 396: safe_glass_mission
 397: safe_lamb_fact_return
 398: lamb_part_2
 399: safe_lamb_bell_return
 400: safe_lamb_bell
 401: safe_cable_mission
 402: safe_foster_tour
 403: safe_lamb_tour
 404: safe_foreman_logic
 405: safe_lamb_leave
 406: safe_lamb_3
 407: safe_lamb_2
 408: into_linc
 409: out_10
 410: out_74
 411: safe_link_28_31
 412: safe_link_31_28
 413: safe_exit_linc
 414: safe_end_game
 415: which_linc
 416: lift_moving
 417: lift_on_screen
 418: barrel_on_screen
 419: convey_on_screen
 420: shades_searched
 421: joey_wiz
 422: slot_slotted
 423: motor_flag
 424: panel_flag
 425: switch_flag
 426: steam_flag
 427: steam_fx_no
 428: factory_flag
 429: power_door_open
 430: left_skull_flag
 431: right_skull_flag
 432: monitor_watching
 433: left_lever_flag
 434: right_lever_flag
 435: lobby_door_flag
 436: weld_stop
 437: cog_flag
 438: sensor_flag
 439: look_through
 440: welder_nut_flag
 441: s7_lift_flag
 442: s29_lift_flag
 443: whos_at_lift_7
 444: whos_at_lift_29
 445: lift_power
 446: whats_joey
 447: seen_box
 448: seen_welder
 449: flap_flag
 450: s15_floor
 451: foreman_friend
 452: locker1_flag
 453: locker2_flag
 454: locker3_flag
 455: whats_in_locker
 456: knows_radsuit
 457: radman_anita
 458: at_anita
 459: coat_flag
 460: dressed_as
 461: s14_take
 462: reactor_door_flag
 463: joey_in_lift
 464: chair_27_flag
 465: at_body_flag
 466: at_gas_flag
 467: anchor_seated
 468: door_23_jam
 469: door_20_jam
 470: reich_door_flag
 471: reich_door_jam
 472: lamb_door_flag
 473: lamb_door_jam
 474: pillow_flag
 475: cat_food_flag
 476: helga_up
 477: got_magazine
 478: trevs_doing
 479: card_status
 480: card_fix
 481: lamb_gallager
 482: locker_11_flag
 483: ever_opened
 484: linc_10_flag
 485: chair_10_flag
 486: skorl_flag
 487: lift_pause
 488: lift_in_use
 489: gordon_back
 490: furnace_door_flag
 491: whos_with_gall
 492: read_news
 493: whos_at_lift_28
 494: s28_lift_flag
 495: mission_state
 496: anita_flag
 497: card_used
 498: gordon_catch
 499: car_flag
 500: first_jobs
 501: jobs_removed
 502: menu_id
 503: tonys_tour_flag
 504: joey_foster_phase
 505: start_info_window
 506: ref_slab_on
 507: ref_up_mouse
 508: ref_down_mouse
 509: ref_left_mouse
 510: ref_right_mouse
 511: ref_disconnect_foster
 512: k0
 513: k1
 514: k2
 515: k3
 516: k4
 517: k5
 518: k6
 519: k7
 520: k8
 521: k9
 522: k10
 523: k11
 524: k12
 525: k13
 526: k14
 527: k15
 528: k16
 529: k17
 530: k18
 531: k19
 532: k20
 533: k21
 534: k22
 535: k23
 536: k24
 537: k25
 538: k26
 539: k27
 540: k28
 541: k29
 542: a0
 543: a1
 544: a2
 545: a3
 546: a4
 547: a5
 548: a6
 549: a7
 550: a8
 551: a9
 552: a10
 553: a11
 554: a12
 555: a13
 556: a14
 557: a15
 558: a16
 559: a17
 560: a18
 561: a19
 562: a20
 563: a21
 564: a22
 565: a23
 566: a24
 567: a25
 568: a26
 569: a27
 570: a28
 571: a29
 572: g0
 573: g1
 574: g2
 575: g3
 576: g4
 577: g5
 578: g6
 579: g7
 580: g8
 581: g9
 582: g10
 583: g11
 584: g12
 585: g13
 586: g14
 587: g15
 588: g16
 589: g17
 590: g18
 591: g19
 592: g20
 593: g21
 594: g22
 595: g23
 596: g24
 597: g25
 598: g26
 599: g27
 600: g28
 601: g29
 602: window_subject
 603: file_text
 604: size_text
 605: auth_text
 606: note_text
 607: id_head_compact
 608: id_file_compact
 609: id_size_compact
 610: id_auth_compact
 611: id_note_compact
 612: pal_no
 613: strikes
 614: char_set_number
 615: eye90_blinded
 616: zap90
 617: eye90_frame
 618: eye91_blinded
 619: zap91
 620: eye91_frame
 621: bag_open
 622: bridge_a_on
 623: bridge_b_on
 624: bridge_c_on
 625: bridge_d_on
 626: bridge_e_on
 627: bridge_f_on
 628: bridge_g_on
 629: bridge_h_on
 630: green_slab
 631: red_slab
 632: foster_slab
 633: circle_slab
 634: slab1_mouse
 635: slab2_mouse
 636: slab3_mouse
 637: slab4_mouse
 638: slab5_mouse
 639: at_guardian
 640: guardian_there
 641: crystal_shattered
 642: virus_taken
 643: fs_command
 644: enter_digits
 645: next_page
 646: linc_digit_0
 647: linc_digit_1
 648: linc_digit_2
 649: linc_digit_3
 650: linc_digit_4
 651: linc_digit_5
 652: linc_digit_6
 653: linc_digit_7
 654: linc_digit_8
 655: linc_digit_9
 656: ref_std_on
 657: ref_std_exit_left_on
 658: ref_std_exit_right_on
 659: ref_advisor_188
 660: ref_shout_action
 661: ref_mega_click
 662: ref_mega_action
 663: ref_walter_speech
 664: ref_joey_medic
 665: ref_joey_med_logic
 666: ref_joey_med_mission72
 667: ref_ken_logic
 668: ref_ken_speech
 669: ref_ken_mission_hand
 670: ref_sc70_iris_opened
 671: ref_sc70_iris_closed
 672: ref_foster_enter_boardroom
 673: ref_father_speech
 674: ref_foster_enter_new_boardroom
 675: ref_hobbins_speech
 676: ref_sc82_jobs_sss
 677: brickwork
 678: door_67_68_flag
 679: crowbar_in_clot
 680: clot_ruptured
 681: clot_repaired
 682: walt_text
 683: walt_loc1
 684: walt_loc2
 685: walt_loc3
 686: walt_count
 687: medic_text
 688: seen_room_72
 689: seen_tap
 690: joey_med_seen72
 691: seen_secure_door
 692: ask_secure_door
 693: sc70_iris_flag
 694: sc70_iris_frame
 695: foster_on_sc70_iris
 696: sc70_grill_flag
 697: sc71_charging_flag
 698: sc72_slime_flag
 699: sc72_witness_sees_foster
 700: sc72_witness_killed
 701: sc73_gallagher_killed
 702: sc73_removed_board
 703: sc73_searched_corpse
 704: door_73_75_flag
 705: sc74_sitting_flag
 706: sc75_crashed_flag
 707: sc75_tissue_infected
 708: sc75_tongs_flag
 709: sc76_cabinet1_flag
 710: sc76_cabinet2_flag
 711: sc76_cabinet3_flag
 712: sc76_board_flag
 713: sc76_ken_prog_flag
 714: sc76_and2_up_flag
 715: ken_text
 716: ken_door_flag
 717: sc77_foster_hand_flag
 718: sc77_ken_hand_flag
 719: door_77_78_flag
 720: sc80_exit_flag
 721: ref_danielle_speech
 722: ref_danielle_go_home
 723: ref_spunky_go_home
 724: ref_henri_speech
 725: ref_buzzer_speech
 726: ref_foster_visit_dani
 727: ref_danielle_logic
 728: ref_jukebox_speech
 729: ref_vincent_speech
 730: ref_eddie_speech
 731: ref_blunt_speech
 732: ref_dani_answer_phone
 733: ref_spunky_see_video
 734: ref_spunky_bark_at_foster
 735: ref_spunky_smells_food
 736: ref_barry_speech
 737: ref_colston_speech
 738: ref_gallagher_speech
 739: ref_babs_speech
 740: ref_chutney_speech
 741: ref_foster_enter_court
 742: dani_text
 743: dani_loc1
 744: dani_loc2
 745: dani_loc3
 746: dani_buff
 747: dani_huff
 748: mother_hobart
 749: foster_id_flag
 750: knows_spunky
 751: dog_fleas
 752: op_flag
 753: chat_up
 754: buzz_loc1
 755: buzz_loc2
 756: blunt_text
 757: blun_loc1
 758: blun_loc2
 759: blun_loc3
 760: blunt_dan_info
 761: vincent_text
 762: vinc_loc1
 763: vinc_loc2
 764: vinc_loc3
 765: eddie_text
 766: eddi_loc1
 767: eddi_loc2
 768: eddi_loc3
 769: knows_dandelions
 770: barry_text
 771: bazz_loc1
 772: bazz_loc2
 773: bazz_loc3
 774: seen_cellar_door
 775: babs_text
 776: babs_loc1
 777: babs_loc2
 778: babs_loc3
 779: colston_text
 780: cols_loc1
 781: cols_loc2
 782: cols_loc3
 783: jukebox
 784: knows_soaking
 785: knows_complaint
 786: dog_bite
 787: new_prints
 788: knows_virus
 789: been_to_court
 790: danielle_target
 791: spunky_target
 792: henri_forward
 793: sc31_lift_flag
 794: sc31_food_on_plank
 795: sc31_spunky_at_plank
 796: dog_in_lake
 797: sc32_lift_flag
 798: sc33_shed_door_flag
 799: gardener_up
 800: babs_x
 801: babs_y
 802: foster_caching
 803: colston_caching
 804: band_playing
 805: colston_at_table
 806: sc36_next_dealer
 807: sc36_door_flag
 808: sc37_door_flag
 809: sc37_lid_loosened
 810: sc37_lid_used
 811: sc37_standing_on_box
 812: sc37_box_broken
 813: sc37_grill_state
 814: got_dog_biscuits
 815: sc38_video_playing
 816: dani_on_phone
 817: sc40_locker_1_flag
 818: sc40_locker_2_flag
 819: sc40_locker_3_flag
 820: sc40_locker_4_flag
 821: sc40_locker_5_flag
 822: seen_anita_corpse
 823: spunky_at_lift
 824: court_text
 825: blunt_knew_jobs
 826: credit_1_text
 827: credit_2_text
 828: id_credit_1
 829: id_credit_2
 830: glass_stolen
 831: foster_at_plank
 832: foster_at_guard
 833: man_talk
 834: man_loc1
 835: man_loc2
 836: man_loc3

 */
