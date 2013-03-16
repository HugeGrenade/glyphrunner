//
//  soundLayer.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "soundLayer.h"

@implementation SoundLayer

@synthesize soundPane = soundPane;

-(id)init
{
	if ( (self=[super init]) ) {
		CCMenuItemImage *soundOn = [CCMenuItemImage itemWithNormalImage:@"soundOn.png" selectedImage:@"soundOn.png"];
		CCMenuItemImage *soundOff = [CCMenuItemImage itemWithNormalImage:@"soundOff.png" selectedImage:@"soundOff.png"];
		CCMenuItemImage *musicOn = [CCMenuItemImage itemWithNormalImage:@"musicOn.png" selectedImage:@"musicOn.png"];
		CCMenuItemImage *musicOff = [CCMenuItemImage itemWithNormalImage:@"musicOff.png" selectedImage:@"musicOff.png"];
		
		soundToggle = [CCMenuItemToggle itemWithTarget:self 
											  selector:@selector(toggleSoundEffect:) 
												 items:soundOn, soundOff, nil];
		musicToggle = [CCMenuItemToggle itemWithTarget:self 
											  selector:@selector(toggleBackgroundMusic:) 
												 items:musicOn, musicOff, nil];
		
		self.soundPane = [CCMenu menuWithItems:soundToggle, musicToggle, nil];
		self.soundPane.position = CGPointZero;
		/*self.soundPane.position = CGPointZero;
		
		soundToggle.position = ccp((win_size.width-soundToggle.contentSize.width/2)-win_size.width/100,
								   soundToggle.contentSize.height/2+win_size.width/100);
		musicToggle.position = ccp((soundToggle.position.x-musicToggle.contentSize.width)-win_size.width/100,
								   soundToggle.position.y);
		*/
		[self mainMenuSoundPane];
		[self addChild:soundPane];
	}
	return self;
}

-(void) mainMenuSoundPane
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	soundToggle.position = ccp((win_size.width-soundToggle.contentSize.width/2)-win_size.width/100,
							   soundToggle.contentSize.height/2+win_size.width/100);
	musicToggle.position = ccp((soundToggle.position.x-musicToggle.contentSize.width)-win_size.width/100,
							   soundToggle.position.y);
}

-(void) toggleSoundEffect:(id)sender
{
	if ([SimpleAudioEngine sharedEngine].effectsVolume) 
		[SimpleAudioEngine sharedEngine].effectsVolume = 0;
	else 
		[SimpleAudioEngine sharedEngine].effectsVolume = 1;
}

-(void) toggleBackgroundMusic:(id)sender
{
	if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
		[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	else
		[[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];		
}
@end
