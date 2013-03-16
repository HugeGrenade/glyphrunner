//
//  ArmouryScene.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArmouryScene.h"


@implementation ArmouryScene

@synthesize layer = _layer;

- (id)init 
{	
	if ((self = [super init])) {
		self.layer = [Armoury node];
		[self addChild:_layer];
	}
	return self;
}	
- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}
@end

@implementation Armoury

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]) ) 
	{
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Setup player area
		//Player *player = [Player player];
		//player.position = ccp(player.contentSize.width/2+win_size.width/100, win_size.height*3/4);
		//player.opacity = 0;
		Player *player = [[Player alloc] initPlayer];
		CGPoint pos = ccp(player.contentSize.width/2+win_size.width/100, win_size.height*3/4);
		[player runAction:pos];
		player.opacity = 0;
		[self addChild:player];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Setup menu buttons
		CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalImage:@"back.png" 
															 selectedImage:@"backClicked.png"
																	target:self
																  selector:@selector(goToMainMenu:)];
		
		CCMenuItemImage *startButton = [CCMenuItemImage itemWithNormalImage:@"start.png" 
															  selectedImage:@"startClicked.png"
																	 target:self
																   selector:@selector(goToGameScene:)];
		
		CCMenu *menu = [CCMenu menuWithItems:backButton, startButton, nil];
		menu.position = CGPointZero;
		
		startButton.position = ccp((win_size.width-startButton.contentSize.width/2)-win_size.width/100, 
								   (startButton.contentSize.height/2)+(win_size.width/100));
		backButton.position = ccp((startButton.position.x-backButton.contentSize.width)-win_size.width/100, 
								  startButton.position.y);
		
		[self addChild:menu];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Chosen item screen
		item1Slot = [CCMenuItemImage itemWithNormalImage:@"item1.png" 
										   selectedImage:@"item1.png"
												  target:self
												selector:@selector(changeSelectPos1:)];
		
		item2Slot = [CCMenuItemImage itemWithNormalImage:@"item2.png" 
										   selectedImage:@"item2.png"
												  target:self
												selector:@selector(changeSelectPos2:)];
		
		CCMenu *itemSlots = [CCMenu menuWithItems:item1Slot, item2Slot, nil];
		itemSlots.position = CGPointZero;
		[itemSlots alignItemsHorizontallyWithPadding:win_size.width/100];
		itemSlots.position = ccp(win_size.width*3/4, win_size.height*3/4);
		
		[self addChild:itemSlots];
		
		itemSelector = [CCSprite spriteWithFile:@"itemSelector.png"];
		
		// Position of the two item slots
		item1SlotPos = ccp(win_size.width*3/4-win_size.width/200-itemSelector.contentSize.width/2, win_size.height*3/4);
		item2SlotPos = ccp(win_size.width*3/4+win_size.width/200+itemSelector.contentSize.width/2, win_size.height*3/4);
		
		itemSelector.position = item1SlotPos;
		
		[self addChild:itemSelector z:10];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Init all items
		iceAgeIcon = [CCSprite spriteWithFile:@"iceAgeIcon.png"];
		multiClearIcon = [CCSprite spriteWithFile:@"multiClearIcon.png"];
		lawnMowerIcon = [CCSprite spriteWithFile:@"lawnMowerIcon.png"];
		hugeGrenadeIcon = [CCSprite spriteWithFile:@"hugeGrenadeIcon.png"];
		matrixIcon = [CCSprite spriteWithFile:@"matrixIcon.png"];
		
		disappear = ccp(0-iceAgeIcon.contentSize.width,0-iceAgeIcon.contentSize.height);
		iceAgeIcon.position = disappear;
		multiClearIcon.position = disappear;
		lawnMowerIcon.position = disappear;
		hugeGrenadeIcon.position = disappear;
		matrixIcon.position = disappear;
		
		itemIcons = [[NSMutableArray alloc] init];
		[itemIcons addObject:iceAgeIcon];
		[itemIcons addObject:multiClearIcon];
		[itemIcons addObject:lawnMowerIcon];
		[itemIcons addObject:hugeGrenadeIcon];
		[itemIcons addObject:matrixIcon];
		
		[self addChild:multiClearIcon z:9];
		[self addChild:iceAgeIcon z:9];
		[self addChild:lawnMowerIcon z:9];
		[self addChild:hugeGrenadeIcon z:9];
		[self addChild:matrixIcon z:9];

		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Item selection screen
		CCMenuItemImage *multiClear = [CCMenuItemImage itemWithNormalImage:@"multiClearItem.png" 
															 selectedImage:@"multiClearItem.png"
																	target:self
																  selector:@selector(selectMultiClear:)];
		
		CCMenuItemImage *iceAge = [CCMenuItemImage itemWithNormalImage:@"freezeItem.png" 
														 selectedImage:@"freezeItem.png"
																target:self
															  selector:@selector(selectIceAge:)];
		
		CCMenuItemImage *lawnMower = [CCMenuItemImage itemWithNormalImage:@"lawnMowerItem.png" 
														 selectedImage:@"lawnMowerItem.png"
																target:self
															  selector:@selector(selectLawnMower:)];
		
		CCMenuItemImage *hugeGrenade = [CCMenuItemImage itemWithNormalImage:@"hugeGrenadeItem.png" 
															  selectedImage:@"hugeGrenadeItem.png" 
																	 target:self 
																   selector:@selector(selectHugeGrenade:)];
		
		CCMenuItemImage *matrix = [CCMenuItemImage itemWithNormalImage:@"matrixItem.png" 
															  selectedImage:@"matrixItem.png" 
																	 target:self 
																   selector:@selector(selectMatrix:)];
		
		/*items = [NSMutableArray arrayWithCapacity:10];
		[items addObject:multiClear];
		[items addObject:iceAge];
		[items addObject:lawnMower];*/
		totalItems = 5;
		itemMenu = [CCMenu menuWithItems:multiClear, iceAge, lawnMower, matrix, hugeGrenade, nil];
		itemMenu.position = CGPointZero;
		
		[itemMenu alignItemsHorizontallyWithPadding:100];
		
		itemMenu.position = ccp(itemMenu.position.x + win_size.width/2 * totalItems, win_size.height*2/6);
		
		[self addChild:itemMenu z:10];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Left Right Butt
		leftButt = [CCMenuItemImage itemWithNormalImage:@"leftButt.png" 
										  selectedImage:@"leftButt.png" 
												 target:self 
											   selector:@selector(clickedLeft:)];
		
		rightButt = [CCMenuItemImage itemWithNormalImage:@"rightButt.png" 
										   selectedImage:@"rightButt.png" 
												  target:self 
												selector:@selector(clickedRight:)];
		CCMenu *direct = [CCMenu menuWithItems:leftButt, rightButt, nil];
		direct.position = CGPointZero;
		leftButt.position = ccp(leftButt.contentSize.width/2+win_size.width/100, 
								win_size.height*2/6);
		rightButt.position = ccp(win_size.width-rightButt.contentSize.width/2-win_size.width/100, 
								 win_size.height*2/6);
		[self addChild:direct z:11];
	}
	return self;
}

-(void) selectMultiClear:(id)sender
{
	NSLog(@"SELECTING MULTI CLEAR");
	for (CCSprite *item in itemIcons)
		if (CGPointEqualToPoint(item.position, itemSelector.position))
			item.position = disappear;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	multiClearIcon.position = itemSelector.position;
	if (CGPointEqualToPoint(multiClearIcon.position, item1SlotPos)) {
		[delegate updateChosenItem:0 item:[NSString stringWithFormat:@"multiClear"]];
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:[NSString stringWithFormat:@"multiClear"]]) {
			[delegate.chosenItem replaceObjectAtIndex:1 withObject:[NSNull null]];
		}
	} else {
		[delegate updateChosenItem:1 item:[NSString stringWithFormat:@"multiClear"]];
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:[NSString stringWithFormat:@"multiClear"]]) {
			[delegate.chosenItem replaceObjectAtIndex:0 withObject:[NSNull null]];
		}
	}
	NSLog(@"SELECTED MULTI CLEAR");	
}

-(void) selectIceAge:(id)sender
{
	NSLog(@"SELECTING FREEZE");
	for (CCSprite *item in itemIcons)
		if (CGPointEqualToPoint(item.position, itemSelector.position))
			item.position = disappear;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	iceAgeIcon.position = itemSelector.position;
	if (CGPointEqualToPoint(iceAgeIcon.position, item1SlotPos)) {
		[delegate updateChosenItem:0 item:[NSString stringWithFormat:@"iceAge"]];
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:[NSString stringWithFormat:@"iceAge"]]) {
			[delegate.chosenItem replaceObjectAtIndex:1 withObject:[NSNull null]];
		}
	} else {
		[delegate updateChosenItem:1 item:[NSString stringWithFormat:@"iceAge"]];
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:[NSString stringWithFormat:@"iceAge"]]) {
			[delegate.chosenItem replaceObjectAtIndex:0 withObject:[NSNull null]];
		}
	}
	NSLog(@"SELECTED FREEZE");	
}

-(void) selectLawnMower:(id)sender
{
	NSLog(@"SELECTING LAWNMOWER");
	for (CCSprite *item in itemIcons)
		if (CGPointEqualToPoint(item.position, itemSelector.position))
			item.position = disappear;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	lawnMowerIcon.position = itemSelector.position;
	if (CGPointEqualToPoint(lawnMowerIcon.position, item1SlotPos)) {
		[delegate updateChosenItem:0 item:[NSString stringWithFormat:@"lawnMower"]];
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:[NSString stringWithFormat:@"lawnMower"]]) {
			[delegate.chosenItem replaceObjectAtIndex:1 withObject:[NSNull null]];
		}
	} else {
		[delegate updateChosenItem:1 item:[NSString stringWithFormat:@"lawnMower"]];
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:[NSString stringWithFormat:@"lawnMower"]]) {
			[delegate.chosenItem replaceObjectAtIndex:0 withObject:[NSNull null]];
		}
	}
	NSLog(@"SELECTED LAWNMOWER");	
}

-(void) selectHugeGrenade:(id)sender
{
	NSLog(@"SELECTING HUGEGRENADE");
	for (CCSprite *item in itemIcons)
		if (CGPointEqualToPoint(item.position, itemSelector.position))
			item.position = disappear;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	hugeGrenadeIcon.position = itemSelector.position;
	if (CGPointEqualToPoint(hugeGrenadeIcon.position, item1SlotPos)) {
		[delegate updateChosenItem:0 item:[NSString stringWithFormat:@"hugeGrenade"]];
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:[NSString stringWithFormat:@"hugeGrenade"]]) {
			[delegate.chosenItem replaceObjectAtIndex:1 withObject:[NSNull null]];
		}
	} else {
		[delegate updateChosenItem:1 item:[NSString stringWithFormat:@"hugeGrenade"]];
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:[NSString stringWithFormat:@"hugeGrenade"]]) {
			[delegate.chosenItem replaceObjectAtIndex:0 withObject:[NSNull null]];
		}
	}
	NSLog(@"SELECTED HUGEGRENADE");	
}

-(void) selectMatrix:(id)sender
{
	NSLog(@"SELECTING MATRIX");
	for (CCSprite *item in itemIcons)
		if (CGPointEqualToPoint(item.position, itemSelector.position))
			item.position = disappear;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	matrixIcon.position = itemSelector.position;
	if (CGPointEqualToPoint(matrixIcon.position, item1SlotPos)) {
		[delegate updateChosenItem:0 item:[NSString stringWithFormat:@"matrix"]];
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:[NSString stringWithFormat:@"matrix"]]) {
			[delegate.chosenItem replaceObjectAtIndex:1 withObject:[NSNull null]];
		}
	} else {
		[delegate updateChosenItem:1 item:[NSString stringWithFormat:@"matrix"]];
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:[NSString stringWithFormat:@"matrix"]]) {
			[delegate.chosenItem replaceObjectAtIndex:0 withObject:[NSNull null]];
		}
	}
	NSLog(@"SELECTED MATRIX");	
}

-(void) changeSelectPos1:(id)sender
{
	if (CGPointEqualToPoint(itemSelector.position, item1SlotPos)) {
		//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
		[delegate updateChosenItem:0 item:[NSNull null]];
		for (CCSprite *item in itemIcons)
			if (CGPointEqualToPoint(item.position, item1SlotPos))
				item.position = disappear;
	} else
		itemSelector.position = item1SlotPos;
}

-(void) changeSelectPos2:(id)sender
{
	if (CGPointEqualToPoint(itemSelector.position, item2SlotPos)) {
		//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
		[delegate updateChosenItem:1 item:[NSNull null]];
		for (CCSprite *item in itemIcons)
			if (CGPointEqualToPoint(item.position, item2SlotPos))
				item.position = disappear;
	} else
		itemSelector.position = item2SlotPos;
}

-(void) activateDirect:(id)sender
{
	[leftButt setIsEnabled:YES];
	[rightButt setIsEnabled:YES];
}

-(void) clickedLeft:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																position:ccp(itemMenu.position.x+win_size.width,
																			 itemMenu.position.y)],
						 [CCCallFunc actionWithTarget:self selector:@selector(activateDirect:)],nil]];
	[leftButt setIsEnabled:NO];
	[rightButt setIsEnabled:NO];
}

-(void) clickedRight:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																position:ccp(itemMenu.position.x-win_size.width,
																			 itemMenu.position.y)],
						 [CCCallFunc actionWithTarget:self selector:@selector(activateDirect:)],nil]];
	[leftButt setIsEnabled:NO];
	[rightButt setIsEnabled:NO];
}

-(void) goToGameScene:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate restartGame];
	[delegate nextLevel];
}
/*
-(void) goToLevelScene:(id)sender
{
	Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[[CCDirector sharedDirector] replaceScene:delegate.levelScene];
}
*/
-(void) goToMainMenu:(id)sender
{
    CCLOG(@"back pressed");
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate enterMainScene];
	[[CCDirector sharedDirector] replaceScene:delegate.mainScene];
}
@end
