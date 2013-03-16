//
//  PauseLayer.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

@synthesize bimage = _bimage;
@synthesize pauseMenu = _pauseMenu;
@synthesize blur = _blur;

-(id)init
{
	if ( (self=[super init]) ) {
		self.isTouchEnabled = NO;
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		
		self.bimage = [CCSprite spriteWithFile:@"pause_bg.png"];
		self.blur = [CCSprite spriteWithFile:@"blur.png"];
		
		self.blur.opacity = 50;
		
		self.bimage.position = ccp(win_size.width/2, win_size.height/2);
		self.blur.position = ccp(win_size.width/2, win_size.height/2);
		
		// menu items
		/*[CCMenuItemFont setFontName:@"Helvetica"];
		CCMenuItem *pauseMenuItem1 = [CCMenuItemFont itemFromString:@"Resume"
															 target:self
														   selector:@selector(resumeGame:)];
		
		CCMenuItem *pauseMenuItem2 = [CCMenuItemFont itemFromString:@"Main Menu"
															 target:self
														   selector:@selector(goToMainMenu:)];*/
		
		CCMenuItemImage *pauseMenuItem1 = [CCMenuItemImage itemWithNormalImage:@"resume.png" 
																 selectedImage:@"resumeClicked.png"
																		target:self
																	  selector:@selector(resumeGame:)];
		
		CCMenuItemImage *pauseMenuItem2 = [CCMenuItemImage itemWithNormalImage:@"mainMenu.png" 
																 selectedImage:@"mainMenuClicked.png"
																		target:self
																	  selector:@selector(goToMainMenu:)];
		
		CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"restart.png" 
														  selectedImage:@"restartClicked.png"
																 target:self
															   selector:@selector(restart:)];
		/*
		CCMenuItemImage *reEqupit = [CCMenuItemImage itemWithNormalImage:@"newGame.png" 
														  selectedImage:@"newGame.png"
																 target:self
															   selector:@selector(goToArmoury:)];
		*/
		
		self.pauseMenu = [CCMenu menuWithItems:pauseMenuItem1, restart, pauseMenuItem2, nil];
		[self.pauseMenu alignItemsVertically];
		self.pauseMenu.position = ccp(win_size.width/2, win_size.height/2);
		
		[self addChild:self.pauseMenu z:1001];
		[self addChild:self.bimage z:999];
		[self addChild:self.blur z:998];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sound pane
		/*CCMenuItemImage *soundOn = [CCMenuItemImage itemWithNormalImage:@"soundOn.png" selectedImage:@"soundOn.png"];
		CCMenuItemImage *soundOff = [CCMenuItemImage itemWithNormalImage:@"soundOff.png" selectedImage:@"soundOff.png"];
		CCMenuItemImage *musicOn = [CCMenuItemImage itemWithNormalImage:@"musicOn.png" selectedImage:@"musicOn.png"];
		CCMenuItemImage *musicOff = [CCMenuItemImage itemWithNormalImage:@"musicOff.png" selectedImage:@"musicOff.png"];
		
		CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(toggleSoundEffect:) 
																   items:soundOn, soundOff, nil];
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(toggleBackgroundMusic:) 
																   items:musicOn, musicOff, nil];
		
		CCMenu *soundPane = [CCMenu menuWithItems:soundToggle, musicToggle, nil];
		soundPane.position = CGPointZero;
		
		soundToggle.position = ccp((win_size.width-soundToggle.contentSize.width/2)-win_size.width/100,
								   soundToggle.contentSize.height/2+win_size.width/100);
		musicToggle.position = ccp((soundToggle.position.x-musicToggle.contentSize.width)-win_size.width/100,
								   soundToggle.position.y);
		
		[self addChild:soundPane];
		*/
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sound pane
		/*Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		CCMenu *soundPane = delegate.soundPane;
		
		CCSprite *sizeCheck = [CCSprite spriteWithFile:@"soundOn.png"];
		
		soundPane.position = ccp((win_size.width-(sizeCheck.contentSize.width+win_size.width/200))-win_size.width/100,
								 sizeCheck.contentSize.height/2+win_size.width/100);

		[soundPane alignItemsHorizontallyWithPadding:win_size.width/100];
		
		[self addChild:soundPane];*/
	}
	return self;
}

-(void)resumeGame:(id)sender
{
	//[self removeChild:_pauseMenu cleanup:YES];
	//[self removeChild:_bimage cleanup:YES];
	//[self removeChild:_blur cleanup:YES];
	
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate resuming];
	[[CCDirector sharedDirector] resume];
	//[[CCDirector sharedDirector] resume];
}

-(void)restart:(id)sender {
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	//[delegate resuming];
	[delegate restarting];
    //[delegate restartGame];
	//[[CCDirector sharedDirector] resume];
}
/*
-(void)goToArmoury:(id)sender
{
	Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[[CCDirector sharedDirector] resume];
	//[delegate resuming];
	[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
}
*/
-(void)goToMainMenu:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate resuming];
	//[[CCDirector sharedDirector] resume];
	[delegate enterMainScene];
    [delegate.gameScene.layer goToMainMenu];
	//[delegate enterMainScene];
	//[[CCDirector sharedDirector] replaceScene:delegate.mainScene];
}
/*
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
*/
@end

