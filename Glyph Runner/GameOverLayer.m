//
//  GameOverLayer.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"

@implementation GameOverLayer
@synthesize score = _score;

- (void)reset {
	
    //[self runAction:[CCSequence actions:
    //                 [CCDelayTime actionWithDuration:3],
    //                 [CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],
    //                 nil]];
	/*
	 CGSize win_size = [[CCDirector sharedDirector] winSize];
	 
	 // create game name
	 CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Lose!" fontName:@"Helvetica" fontSize:64];
	 
	 // create menu items
	 [CCMenuItemFont setFontName:@"Helvetica"];
	 CCMenuItemFont *restart = [CCMenuItemFont itemFromString:@"Restart"
	 target:self
	 selector:@selector(restart:)];
	 
	 CCMenuItemFont *main_menu = [CCMenuItemFont itemFromString:@"Main Menu"
	 target:self
	 selector:@selector(goToMainMenu:)];
	 
	 // create menu from menu items
	 CCMenu *options = [CCMenu menuWithItems:restart, main_menu, nil];
	 
	 // positioning the items
	 [options alignItemsVertically];
	 options.position = ccp(win_size.width/2, win_size.height/2);
	 label.position = ccp(win_size.width/2, win_size.height-50);
	 [self addChild:options];
	 [self addChild:label];
	 */
}

-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled = NO;
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		
		self.score = [CCLabelTTF labelWithString:@"" fontName:@"Helvetica" fontSize:64];
		self.score.position = ccp(win_size.width/2, win_size.height-self.score.contentSize.height/2 - 50);
		[self addChild:self.score z:1000];
		
		// background image for the layer
		CCSprite *bimage = [CCSprite spriteWithFile:@"pause_bg.png"];
		CCSprite *blur = [CCSprite spriteWithFile:@"blur.png"];
		blur.opacity = 50;
		bimage.position = ccp(win_size.width/2, win_size.height/2);
		blur.position = ccp(win_size.width/2, win_size.height/2);
		[self addChild:bimage z:999];
		[self addChild:blur z:998];
		
		// menu items
		/*[CCMenuItemFont setFontName:@"Helvetica"];
		CCMenuItem *restart = [CCMenuItemFont itemFromString:@"Restart"
													  target:self
													selector:@selector(restart:)];
		
		CCMenuItem *main_menu = [CCMenuItemFont itemFromString:@"Main Menu"
														target:self
													  selector:@selector(goToMainMenu:)];*/
		
		CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"restart.png"
														selectedImage:@"restartClicked.png"
																 target:self
															   selector:@selector(restart:)];
		
		CCMenuItemImage *main_menu = [CCMenuItemImage itemWithNormalImage:@"mainMenu.png" 
															selectedImage:@"mainMenuClicked.png"
																   target:self
																 selector:@selector(goToMainMenu:)];
		
		CCMenu *options = [CCMenu menuWithItems:restart, main_menu, nil];
		[options alignItemsVertically];
		options.position = ccp(win_size.width/2, win_size.height/2);
		[self addChild:options z:1001];

	}	
	return self;
}

-(void)goToMainMenu:(id)sender {
	//AppController *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	//[[CCDirector sharedDirector] resume];
	[delegate.gameScene.layer unschedule:@selector(updateBlocks:)];
	[delegate.gameScene.layer unschedule:@selector(updateSpace:)];
    [delegate enterMainSceneFromGameOver];
    //[delegate.gameScene.layer unschedule:@selector(updateBlocks:)];
    //[delegate.gameScene.layer unschedule:@selector(updateSpace:)];
	//[[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
	//[[CCDirector sharedDirector] replaceScene:delegate.mainScene];
	//[[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

-(void)restart:(id)sender {
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	//[delegate restarting];
    [delegate restartGame];
}
/*
 - (void)gameOverDone {
 
 //[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
 Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
 [delegate restartGame];
 
 }
 */
- (void)dealloc {
	[_score release];
	_score = nil;
	[super dealloc];
}

@end