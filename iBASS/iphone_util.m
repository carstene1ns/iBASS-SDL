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
 * $URL: https://scummvm.svn.sourceforge.net/svnroot/scummvm/scummvm/trunk/backends/platform/iphone/iphone_video.m $
 * $Id: iphone_video.m 40872 2009-05-24 21:53:29Z lordhoto $
 *
 */

#include "iphone_util.h"
#include "iphone_common.h"

#import <AVFoundation/AVFoundation.h>
#include <dlfcn.h>

AVAudioPlayer *_musicPlayer = nil;

float _musicVolume = 1.0f;
volatile bool g_musicIsLoading = false;

@interface MusicPlayer : NSObject {
	int section;
	int song;
}
- (void)setMusic:(int)song setSection:(int)section;
- (void)playMusic;
@end

@implementation MusicPlayer

- (void)setMusic:(int)song_num setSection:(int)section_num {
	song = song_num;
	section = section_num;
}

- (void)playMusic
{
	NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
	
	g_musicIsLoading = true;
	
	if (_musicPlayer != nil) {
		if (_musicPlayer.playing == YES ) {
			int fade_duration = 50; 
			const float fade_step = _musicPlayer.volume / (float)fade_duration;
			
			while (fade_duration-- && _musicPlayer.volume > 0.00f) {
				_musicPlayer.volume -= fade_step;
				usleep(5000);
			}
			
			//now fully kill it
			iPhone_stopMusic();
		}
	}

	//handle dupes
	if ((section == 2 && song == 1) || (section == 5 && song == 1)) {
		section = 1;
		song = 1;
	} else if ((section == 2 && song == 4) || (section == 5 && song == 4)) {
		section = 1;
		song = 4;
	} else if (section == 5 && song == 6) {
		section = 4;
		song = 4;
	}

	
	char musicFile[64];
	sprintf(musicFile, "music_%03d", (section * 100) + song);
	
	// check existence
	char musicFileCheck[64];
	sprintf(musicFileCheck, "%s.mp3", musicFile);
	FILE *fp = fopen(musicFileCheck, "rb");
	if (!fp) {
		g_musicIsLoading = false;
		return;
	}
	fclose(fp);
	
	NSString *soundFile = [NSString stringWithUTF8String:musicFile];
	
	bool result;
	_musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundFile ofType:@"mp3"]] error:nil];
	_musicPlayer.numberOfLoops = -1; //set to looping...
	
	//...unless
	if (	(section == 1 && song == 1)
		|| (section == 1 && song == 4)
		|| (section == 2 && song == 1)
		|| (section == 2 && song == 4)
		|| (section == 4 && song == 2)
		|| (section == 4 && song == 3)
		|| (section == 4 && song == 5)
		|| (section == 4 && song == 6)
		|| (section == 4 && song == 6)
		|| (section == 4 && song == 11)
		|| (section == 5 && song == 1)
		|| (section == 5 && song == 3)
		|| (section == 5 && song == 4)
		) {
		_musicPlayer.numberOfLoops = 0;	//these are non-looping
	}
	
	_musicPlayer.volume = 0; //_musicVolume;
	
	result = [_musicPlayer play];
	
	/* fade up from 0 */
	int fade_duration = 50;
	const float fade_step = _musicVolume / (float)fade_duration;
	
	while (fade_duration-- && _musicPlayer.volume < _musicVolume) {
		_musicPlayer.volume += fade_step;
		usleep(5000);
	}
	
	g_musicIsLoading = false;
	
	[autoreleasepool release];
}
@end


volatile int g_xCoord = 0;
volatile int g_yCoord = 0;
volatile bool g_mouseDown = false;


static MusicPlayer *_mp = nil;
static iPhoneView *sharedInstance = nil;
static int _width = 0;
static int _height = 0;
static CGRect _screenRect;
static char* _textureBuffer = 0;
static int _textureWidth = 0;
static int _textureHeight = 0;
static int _needsScreenUpdate = 0;

static bool _isOS3 = false;

// static long lastTick = 0;
// static int frames = 0;

void iPhone_swapBuffers() {
	if (!_needsScreenUpdate) {
		_needsScreenUpdate = 1;
		[sharedInstance performSelectorOnMainThread:@selector(swapBuffers) withObject:nil waitUntilDone: NO];
	}
}

void iPhone_initSurface(int width, int height) {
	_width = width;
	_height = height;
	[sharedInstance performSelectorOnMainThread:@selector(initSurface) withObject:nil waitUntilDone: YES];
}

bool iPhone_fetchEvent(int *outEvent, float *outX, float *outY) {
	id event = [sharedInstance getEvent];
	if (event == nil) {
		return false;
	}

	id type = [event objectForKey:@"type"];

	if (type == nil) {
		printf("fetchEvent says: No type!\n");
		return false;
	}

	*outEvent = [type intValue];
	*outX = [[event objectForKey:@"x"] floatValue];
	*outY = [[event objectForKey:@"y"] floatValue];
	return true;
}

const char* iPhone_getDocumentsDir() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory UTF8String];
}

bool iPhone_isOS3(void) {
	return _isOS3;
}

bool iPhone_isMusicPlaying(void) {
	bool playing = false;
	
	if (_musicPlayer != nil) {
		playing = _musicPlayer.playing == YES;
		//printf("isMusicPlaying() %f / %f\n", _musicPlayer.currentTime, _musicPlayer.duration);
	}
	
	return playing;	
}

void iPhone_playMusic(int section, int song) {	
	//printf("iPhone_playMusic(%d, %d)\n", section, song);
	
	if (_isOS3) {	//use fading on OS3

		//If we're already loading music then wait until it's finished to prevent catastrophe.
		while (g_musicIsLoading) {
			usleep(10);
		}
		
		printf("Loaded\n");
	
		[_mp setMusic:song setSection:section];
	
		[NSThread detachNewThreadSelector:@selector(playMusic) toTarget:_mp withObject:nil];
	} else {
		iPhone_stopMusic();
	
		//handle dupes
		if ((section == 2 && song == 1) || (section == 5 && song == 1)) {
			section = 1;
			song = 1;
		} else if ((section == 2 && song == 4) || (section == 5 && song == 4)) {
			section = 1;
			song = 4;
		} else if (section == 5 && song == 6) {
			section = 4;
			song = 4;
		}

	
		char musicFile[64];
		sprintf(musicFile, "music_%03d", (section * 100) + song);
	
		// check existence
		char musicFileCheck[64];
		sprintf(musicFileCheck, "%s.mp3", musicFile);
		FILE *fp = fopen(musicFileCheck, "rb");
		if (!fp) {
			return;
		}
		fclose(fp);
	
		NSString *soundFile = [NSString stringWithUTF8String:musicFile];
	
		bool result;
		_musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundFile ofType:@"mp3"]] error:nil];
		_musicPlayer.numberOfLoops = -1; //set to looping...
	
		//...unless
		if (	(section == 1 && song == 1)
			|| (section == 1 && song == 4)
			|| (section == 2 && song == 1)
			|| (section == 2 && song == 4)
			|| (section == 4 && song == 2)
			|| (section == 4 && song == 3)
			|| (section == 4 && song == 5)
			|| (section == 4 && song == 6)
			|| (section == 4 && song == 6)
			|| (section == 4 && song == 11)
			|| (section == 5 && song == 1)
			|| (section == 5 && song == 3)
			|| (section == 5 && song == 4)
			) {
			_musicPlayer.numberOfLoops = 0;	//these are non-looping
		}
	
		_musicPlayer.volume = _musicVolume;
	
		result = [_musicPlayer play];
	}
}

void iPhone_stopMusic(void) {
	if (_musicPlayer != nil) {
		if (iPhone_isMusicPlaying()) {
			[_musicPlayer stop];
		}
		
		[_musicPlayer dealloc];
		_musicPlayer = nil;
	}
}

float iPhone_getMusicVolume(void) {
	return _musicVolume;
}
	
void iPhone_setMusicVolume(float vol) {
	_musicVolume = vol;
	if (_musicPlayer != nil) {
		_musicPlayer.volume = _musicVolume;
	}
}



bool getLocalMouseCoords(CGPoint *point) {
	if (point->x < _screenRect.origin.x || point->x >= _screenRect.origin.x + _screenRect.size.width ||
		point->y < _screenRect.origin.y || point->y >= _screenRect.origin.y + _screenRect.size.height) {
			return false;
	}

	point->x = (point->x - _screenRect.origin.x) / _screenRect.size.width;
	point->y = (point->y - _screenRect.origin.y) / _screenRect.size.height;

	return true;
}

uint getSizeNextPOT(uint size) {
    if ((size & (size - 1)) || !size) {
        int log = 0;

        while (size >>= 1)
            ++log;

        size = (2 << log);
    }

    return size;
}

@implementation iPhoneView

+ (Class) layerClass
{
	return [CAEAGLLayer class];
}

- (id)initWithFrame:(struct CGRect)frame {
	[super initWithFrame: frame];

	_fullWidth = frame.size.width;
	_fullHeight = frame.size.height;
	_screenLayer = nil;

	sharedInstance = self;

	_context = nil;
	
	_mp = [MusicPlayer alloc];
	
	//check for 3.0 capable
	//Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	//_isOS3 = (mailClass != nil && [mailClass canSendMail]);
	_isOS3 = dlsym(RTLD_DEFAULT, "MFMailComposeErrorDomain") != NULL; 
	printf("OS3: %s\n", _isOS3 ? "yes" : "no");
	
	return self;
}

-(void) dealloc {
	[super dealloc];
}

- (void *)getSurface {
	return _screenSurface;
}

- (void)drawRect:(CGRect)frame {
	// if (lastTick == 0) {
	//	lastTick = time(0);
	// }
	//
	// frames++;
	// if (time(0) > lastTick) {
	//	lastTick = time(0);
	//	printf("FPS: %i\n", frames);
	//	frames = 0;
	// }
}

- (void)swapBuffers {
	if (!_needsScreenUpdate) {
		return;
	}
	_needsScreenUpdate = 0;
	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, _viewRenderbuffer);
	[_context presentRenderbuffer:GL_RENDERBUFFER_OES];

}

- (void)initSurface {
	_textureWidth = getSizeNextPOT(_width);
	_textureHeight = getSizeNextPOT(_height);

	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

	//printf("Window: (%d, %d), Surface: (%d, %d), Texture(%d, %d)\n", _fullWidth, _fullHeight, _width, _height, _textureWidth, _textureHeight);

	if (_context == nil) {
		orientation = UIDeviceOrientationLandscapeRight;
		CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;

		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
										[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, nil];

		_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		if (!_context || [EAGLContext setCurrentContext:_context]) {
			glGenFramebuffersOES(1, &_viewFramebuffer);
			glGenRenderbuffersOES(1, &_viewRenderbuffer);

			glBindFramebufferOES(GL_FRAMEBUFFER_OES, _viewFramebuffer);
			glBindRenderbufferOES(GL_RENDERBUFFER_OES, _viewRenderbuffer);
			[_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
			glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, _viewRenderbuffer);

			glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &_backingWidth);
			glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &_backingHeight);

			if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
				NSLog(@"Failed to make complete framebuffer object %x.", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
				return;
			}

			glViewport(0, 0, _backingWidth, _backingHeight);
			glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

			glEnable(GL_TEXTURE_2D);
			glEnableClientState(GL_TEXTURE_COORD_ARRAY);
			glEnableClientState(GL_VERTEX_ARRAY);
		}
	}

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

//	if (orientation ==  UIDeviceOrientationLandscapeRight) {
//		glRotatef(-90, 0, 0, 1);
//	} else if (orientation == UIDeviceOrientationLandscapeLeft) {
//		glRotatef(90, 0, 0, 1);
//	} else {
//		glRotatef(180, 0, 0, 1);
//	}
	
	glOrthof(0, _backingWidth, 0, _backingHeight, 0, 1);

	glBindRenderbufferOES(GL_RENDERBUFFER_OES, _viewRenderbuffer);

	// The color buffer is triple-buffered, so we clear it multiple times right away to avid doing any glClears later.
	int clearCount = 3;
	while (clearCount-- > 0) {
		glClear(GL_COLOR_BUFFER_BIT);
		[_context presentRenderbuffer:GL_RENDERBUFFER_OES];
	}

	//we want full-screen!
	_visibleWidth = _backingWidth;
	_visibleHeight = _backingHeight;
	_widthOffset = 0.0f;
	_heightOffset = 0.0f;
	_screenRect = CGRectMake(_widthOffset, _heightOffset, _fullWidth, _fullHeight);
}

- (id)getEvent {
	if (_events == nil || [_events count] == 0) {
		return nil;
	}


	id event = [_events objectAtIndex: 0];

	[_events removeObjectAtIndex: 0];

	return event;
}

- (void)addEvent:(NSDictionary*)event {

	if(_events == nil)
		_events = [[NSMutableArray alloc] init];

	[_events addObject: event];
}

// Handles the start of a touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch*	touch = [[event touchesForView:self] anyObject];
	firstTouch = YES;
	//Convert touch point from UIView referential to OpenGL one (upside-down flip)
	location = [touch locationInView:self];
	
	
	//printf("touchesBegan(%f, %f)\n", location.x, location.y);
	const float xScale = 320.0f / 480.0f;
	const float yScale = 200.0 / 320.0f;
	g_xCoord = location.y * xScale;
	g_yCoord = 199 - (location.x * yScale);
	g_mouseDown = true;
}

// Handles the continuation of a touch.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch*			touch = [[event touchesForView:self] anyObject];
	
	
	//Convert touch point from UIView referential to OpenGL one (upside-down flip)
	if (firstTouch) {
		firstTouch = NO;
		previousLocation = [touch previousLocationInView:self];
	} else {
		location = [touch locationInView:self];
		previousLocation = [touch previousLocationInView:self];
	}
	
	//printf("touchesMoved(%f, %f)\n", location.x, location.y);
	const float xScale = 320.0f / 480.0f;
	const float yScale = 200.0 / 320.0f;
	g_xCoord = location.y * xScale;
	g_yCoord = 199 - (location.x * yScale);
	g_mouseDown = true;
}

// Handles the end of a touch event when the touch is a tap.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch*	touch = [[event touchesForView:self] anyObject];
	if (firstTouch) {
		firstTouch = NO;
		previousLocation = [touch previousLocationInView:self];
	}
	//printf("touchesEnd(%f, %f)\n", location.x, location.y);
	const float xScale = 320.0f / 480.0f;
	const float yScale = 200.0 / 320.0f;
	g_xCoord = location.y * xScale;
	g_yCoord = 199 - (location.x * yScale);
	g_mouseDown = false;
}

// Handles the end of a touch event.
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	// If appropriate, add code necessary to save the state of the application.
	// This application is not saving state.
}

- (void)handleKeyPress:(unichar)c {
	[self addEvent:
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSNumber numberWithInt:kInputKeyPressed], @"type",
		 [NSNumber numberWithFloat:(float)c], @"x",
		 [NSNumber numberWithFloat:0], @"y",
		 nil
		]
	];
}

- (BOOL)canHandleSwipes {
	return TRUE;
}

- (int)swipe:(int)num withEvent:(struct __GSEvent *)event {
	//printf("swipe: %i\n", num);

	[self addEvent:
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSNumber numberWithInt:kInputSwipe], @"type",
		 [NSNumber numberWithFloat:(float)num], @"x",
		 [NSNumber numberWithFloat:0], @"y",
		 nil
		]
	];
}

- (void)applicationSuspend {
	[self addEvent:
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSNumber numberWithInt:kInputApplicationSuspended], @"type",
		 [NSNumber numberWithFloat:0], @"x",
		 [NSNumber numberWithFloat:0], @"y",
		 nil
		]
	];
}

- (void)applicationResume {
	[self addEvent:
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSNumber numberWithInt:kInputApplicationResumed], @"type",
		 [NSNumber numberWithFloat:0], @"x",
		 [NSNumber numberWithFloat:0], @"y",
		 nil
		]
	];
}

@end

