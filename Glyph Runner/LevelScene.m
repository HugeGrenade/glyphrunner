//
//  LevelScene.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene

@synthesize layer = _layer;

- (id)init 
{	
	if ((self = [super init])) {
		self.layer = [Level node];
		[self addChild:_layer];
	}
	return self;
}	
- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}
/*
+(id) scene
{
	// 'scene' is an autorelease object.
	LevelScene *scene = [LevelScene node];
	
	// 'layer' is an autorelease object.
	Level *layer = [Level node];
    scene.layer = layer;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}
*/
@end

@implementation Level

@synthesize levels;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]) ) 
	{
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *label = [CCSprite spriteWithFile:@"levelLabel.png"];
		label.position = ccp(win_size.width/2, (win_size.height-label.contentSize.height/2)-win_size.width/100);
		
		[self addChild:label z:1];
		
		[self showIcons];
	}
	return self;
}

-(void) refreshLocks
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	int highestLevel = delegate.highestLevel;
	int i,j;
	
	for (i = 0; i<=(highestLevel-1); i++) {
		//CCMenuItemImage *tLevel = [self.levels objectAtIndex:i];
		//[tLevel setIsEnabled:YES];
		[[levels objectAtIndex:i] setIsEnabled:YES];
	}
	for (j = i; j<3; j++) {
		//CCMenuItemImage *tLevel = [self.levels objectAtIndex:j];
		//NSLog(@"stoped2");
		//[tLevel setIsEnabled:YES];
		[[levels objectAtIndex:j] setIsEnabled:NO];
	}
}

-(void) showIcons
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	CCMenuItemImage *easyMode = [CCMenuItemImage itemWithNormalImage:@"easy_but.png" 
													  selectedImage:@"easy_but.png" 
													  disabledImage:@"easy_but.png"
															 target:self 
														   selector:@selector(goToLevelSelect1:)];
	CCMenuItemImage *normalMode = [CCMenuItemImage itemWithNormalImage:@"normal_but.png" 
													  selectedImage:@"normal_but.png"
													  disabledImage:@"normal_but.png"
															 target:self 
														   selector:@selector(goToLevelSelect2:)];
	CCMenuItemImage *hardMode = [CCMenuItemImage itemWithNormalImage:@"hard_but.png" 
													  selectedImage:@"hard_but.png" 
													  disabledImage:@"hard_but.png"
															 target:self 
														   selector:@selector(goToLevelSelect3:)];
	
	CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalImage:@"back_but.png" 
														 selectedImage:@"back_but.png"
																target:self
															  selector:@selector(goToMainMenu:)];
	
	
	self.levels = [NSMutableArray arrayWithCapacity:4];
	[self.levels addObject:easyMode];
	[self.levels addObject:normalMode];
	[self.levels addObject:hardMode];
	[self.levels addObject:backButton];
	// create menu from menu items
	CCMenu *select_menu_1 = [CCMenu menuWithItems:easyMode, normalMode, hardMode, backButton, nil];

	select_menu_1.position = ccp(win_size.width-win_size.width/100-easyMode.contentSize.width/2, 
								 win_size.height/100*2+easyMode.contentSize.height*2);
	[select_menu_1 alignItemsVerticallyWithPadding:win_size.width/200];
	
	[self addChild:select_menu_1 z:3];
}

-(void) goToGameScene:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate nextLevel];
}

-(void) goToMainMenu:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate enterMainScene];
	[[CCDirector sharedDirector] replaceScene:delegate.mainScene];
}

-(void) goToLevelSelect1:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 0;
	[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
	//[delegate nextLevel];
}

-(void) goToLevelSelect2:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 1;
	[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
	//[delegate loadNewLevelScene];
	//[[CCDirector sharedDirector] replaceScene:[GameScene scene]];
	//[[CCDirector sharedDirector] replaceScene:delegate.mainScene];
	//[delegate restartGame];
	//[delegate nextLevel];
}

-(void) goToLevelSelect3:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 2;
	[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
	//[delegate restartGame];
	//[delegate nextLevel];
}

// on "dealloc" you need to release all your retained objects
-(void) dealloc
{
	[levels release];
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
