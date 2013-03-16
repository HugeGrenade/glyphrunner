//
//  MainMenuScene.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

@synthesize layer = _layer;

- (id)init 
{	
	if ((self = [super init])) {
		self.layer = [MainMenu node];
		[self addChild:_layer];
	}
	return self;
}	

@end

@implementation MainMenu

@synthesize levels;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]) ) 
	{
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		self.isTouchEnabled = YES;
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> background image
		CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
		background.position = ccp(win_size.width/2, win_size.height/2);
		
		[self addChild:background z:0];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> title screen image
		titleScreen = [CCSprite spriteWithFile:@"title_screen.png"];
		titleScreen.position = ccp(384/2, win_size.height/2);

		[self addChild:titleScreen z:10];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> main menu setup
		newGameButton = [CCMenuItemImage itemWithNormalImage:@"new_game_but.png" 
											   selectedImage:@"new_game_but.png"
													  target:self
													selector:@selector(mainToLevelSelect:)];
		
		aboutButton = [CCMenuItemImage itemWithNormalImage:@"about_but.png" 
											 selectedImage:@"about_but.png"
													target:self
												  selector:@selector(mainToAbout:)];
		
		main_menu = [CCMenu menuWithItems:aboutButton, newGameButton, nil];
		main_menu.position = ccp(win_size.width-newGameButton.contentSize.width/2, newGameButton.contentSize.height);
		[main_menu alignItemsVerticallyWithPadding:0];
		
		[self addChild:main_menu z:11];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> level select setup
		[self showIcons];
		[self refreshLocks];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about screen setup
		aboutScreen = [CCSprite spriteWithFile:@"about_screen.png"];
		aboutScreen.position = ccp(384/2, win_size.height/2+win_size.height);
		
		abtBackButton = [CCMenuItemImage itemWithNormalImage:@"back_but.png" selectedImage:@"back_but.png"
																	target:self selector:@selector(aboutToMain:)];
		
		aboutMenu = [CCMenu menuWithItems:abtBackButton, nil];
		aboutMenu.position = ccp(win_size.width-abtBackButton.contentSize.width/2, 
								 abtBackButton.contentSize.height/2+win_size.height);
		
		[self addChild:aboutScreen z:10];
		[self addChild:aboutMenu z:11];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> armoury setup
		armouryScreen = [CCSprite spriteWithFile:@"armoury_screen.png"];
		
		armouryScreen.position = ccp(384/2, win_size.height/2+win_size.height);
		
		armBackButton = [CCMenuItemImage itemWithNormalImage:@"back_but.png" selectedImage:@"back_but.png"
													  target:self selector:@selector(armToLevelSelect:)];
		
		armStartButton = [CCMenuItemImage itemWithNormalImage:@"start_but.png" selectedImage:@"start_but.png"
													   target:self selector:@selector(goToGameScene:)];
		
		armMenu = [CCMenu menuWithItems:armStartButton, armBackButton, nil];
		armMenu.position = ccp(win_size.width-armStartButton.contentSize.width/2, 
							   armStartButton.contentSize.height+win_size.height);
		[armMenu alignItemsVerticallyWithPadding:0];
		
		[self addChild:armouryScreen z:10];
		[self addChild:armMenu z:11];
		
		// item slots
		item1Slot = [CCMenuItemImage itemWithNormalImage:@"item1.png" 
										   selectedImage:@"item1.png"
												  target:self
												selector:@selector(changeSelectPos1:)];
		
		item2Slot = [CCMenuItemImage itemWithNormalImage:@"item2.png" 
										   selectedImage:@"item2.png"
												  target:self
												selector:@selector(changeSelectPos2:)];
		
		itemSlots = [CCMenu menuWithItems:item1Slot, item2Slot, nil];
		itemSlots.position = CGPointZero;
		[itemSlots alignItemsVerticallyWithPadding:0];
		itemSlots.position = ccp(win_size.width-item1Slot.contentSize.width/2, 
								 win_size.height-item1Slot.contentSize.height+win_size.height);
		
		[self addChild:itemSlots z:10];
		
		itemSelector = [CCSprite spriteWithFile:@"itemSelector.png"];
		
		// Position of the two item slots
		//item1SlotPos = ccp(win_size.width*3/4-win_size.width/200-itemSelector.contentSize.width/2, win_size.height*3/4);
		//item2SlotPos = ccp(win_size.width*3/4+win_size.width/200+itemSelector.contentSize.width/2, win_size.height*3/4);
		item1SlotPos = ccp(win_size.width-item1Slot.contentSize.width/2, win_size.height-item1Slot.contentSize.height/2);
		item2SlotPos = ccp(item1SlotPos.x, item1SlotPos.y-item1Slot.contentSize.height);
		
		itemSelector.position = item1SlotPos;
		itemSelector.opacity = 0;
		
		[self addChild:itemSelector z:12];
		
		// init all items
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
		
		[self addChild:multiClearIcon z:11];
		[self addChild:iceAgeIcon z:11];
		[self addChild:lawnMowerIcon z:11];
		[self addChild:hugeGrenadeIcon z:11];
		[self addChild:matrixIcon z:11];
		
		// item selection screen
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
		
		curItem = 0;
		totalItems = 5;
		items = [[NSMutableArray alloc] init];
		[items addObject:multiClear];
		[items addObject:iceAge];
		[items addObject:lawnMower];
		[items addObject:matrix];
		[items addObject:hugeGrenade];
		
		itemMenu = [CCMenu menuWithItems:multiClear, iceAge, lawnMower, matrix, hugeGrenade, nil];
		
		
		[itemMenu alignItemsVerticallyWithPadding:0];
		
		itemMenu.position = CGPointZero;
		//itemMenu.position = ccp(itemMenu.position.x + win_size.width/2 * totalItems, win_size.height*2.5/10);
		
		itemMenu.position = ccp(win_size.width/2-newGameButton.contentSize.width/2,
								win_size.height*2.5/10-multiClear.contentSize.height/2*(totalItems-1)+win_size.height);
		
		[self addChild:itemMenu z:9];
		
		// left, right buttons
		upButt = [CCMenuItemImage itemWithNormalImage:@"up_dir.png" 
										  selectedImage:@"up_dir.png" 
												 target:self 
											   selector:@selector(clickedUp:)];
		
		downButt = [CCMenuItemImage itemWithNormalImage:@"down_dir.png" 
										   selectedImage:@"down_dir.png" 
												  target:self 
												selector:@selector(clickedDown:)];
		direct = [CCMenu menuWithItems:upButt, downButt, nil];

		[direct alignItemsVerticallyWithPadding:multiClear.contentSize.height];
		direct.position = ccp(win_size.width/2-newGameButton.contentSize.width/2,
							  win_size.height*2.5/10+win_size.height);
		/*direct.position = CGPointZero;
		upButt.position = ccp(win_size.width/2-newGameButton.contentSize.width/2, 
								win_size.height*4/10);
		downButt.position = ccp(win_size.width/2-newGameButton.contentSize.width/2, 
								 win_size.height*1/10);*/
		[self addChild:direct z:11];
		
		[self enterArmoury];
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sound pane setup
		CCMenuItemImage *soundOn = [CCMenuItemImage itemWithNormalImage:@"soundOn.png" selectedImage:@"soundOn.png"];
		CCMenuItemImage *soundOff = [CCMenuItemImage itemWithNormalImage:@"soundOff.png" selectedImage:@"soundOff.png"];
		CCMenuItemImage *musicOn = [CCMenuItemImage itemWithNormalImage:@"musicOn.png" selectedImage:@"musicOn.png"];
		CCMenuItemImage *musicOff = [CCMenuItemImage itemWithNormalImage:@"musicOff.png" selectedImage:@"musicOff.png"];
		
		CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(toggleSoundEffect:) 
																   items:soundOn, soundOff, nil];
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(toggleBackgroundMusic:) 
																   items:musicOn, musicOff, nil];
		
		soundPane = [CCMenu menuWithItems:soundToggle, musicToggle, nil];
		soundPane.position = CGPointZero;
		
		soundToggle.position = ccp((win_size.width-soundToggle.contentSize.width/2)-win_size.width/100,
								   win_size.height-soundToggle.contentSize.height/2-win_size.width/100);
		musicToggle.position = ccp((soundToggle.position.x-musicToggle.contentSize.width)-win_size.width/100,
								   soundToggle.position.y);
		
		[self addChild:soundPane z:15];
	}
	return self;
}	

-(void) refreshLocks
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	int highestLevel = delegate.highestLevel;
	int i,j;
	
	for (i = 0; i<=(highestLevel-1); i++)
		[[levels objectAtIndex:i] setIsEnabled:YES];
	for (j = i; j<3; j++)
		[[levels objectAtIndex:j] setIsEnabled:NO];
    CCLOG(@"refreshing locks");
}

-(void) showIcons
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	easyMode = [CCMenuItemImage itemWithNormalImage:@"easy_but.png" 
									  selectedImage:@"easy_but.png" 
									  disabledImage:@"easy_but.png"
											 target:self 
										   selector:@selector(goToLevelSelect1:)];
	
	normalMode = [CCMenuItemImage itemWithNormalImage:@"normal_but.png" 
										selectedImage:@"normal_but.png"
										disabledImage:@"normal_but.png"
											   target:self 
											 selector:@selector(goToLevelSelect2:)];
	
	hardMode = [CCMenuItemImage itemWithNormalImage:@"hard_but.png" 
									  selectedImage:@"hard_but.png" 
									  disabledImage:@"hard_but.png"
											 target:self 
										   selector:@selector(goToLevelSelect3:)];
	
	lvlBackButton = [CCMenuItemImage itemWithNormalImage:@"back_but.png" 
										selectedImage:@"back_but.png"
											   target:self
											 selector:@selector(levelSelectToMain:)];
	
	self.levels = [NSMutableArray arrayWithCapacity:4];
	[self.levels addObject:easyMode];
	[self.levels addObject:normalMode];
	[self.levels addObject:hardMode];
	[self.levels addObject:lvlBackButton];
	
	select_menu_1 = [CCMenu menuWithItems:easyMode, normalMode, hardMode, lvlBackButton, nil];
	
	select_menu_1.position = ccp(win_size.width-easyMode.contentSize.width/2,
								 easyMode.contentSize.height*2+win_size.height);

	[select_menu_1 alignItemsVerticallyWithPadding:0];
	
	[self addChild:select_menu_1 z:11];
}

-(void) activateButs:(id)sender
{
	[easyMode setIsEnabled:YES];
	[normalMode setIsEnabled:YES];
	[hardMode setIsEnabled:YES];
	[lvlBackButton setIsEnabled:YES];
	
	[upButt setIsEnabled:YES];
	[downButt setIsEnabled:YES];
	[item1Slot setIsEnabled:YES];
	[item2Slot setIsEnabled:YES];
	[armBackButton setIsEnabled:YES];
	[armStartButton setIsEnabled:YES];
	
	[aboutButton setIsEnabled:YES];
	[newGameButton setIsEnabled:YES];
	
	[abtBackButton setIsEnabled:YES];
}

-(void) showItemSelector:(id)sender {itemSelector.opacity=255;}
-(void) hideItemSelector:(id)sender {itemSelector.opacity=0;}

-(void) levelSelectToArm:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[self enterArmoury];
	
	[select_menu_1 runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	 position:ccp(select_menu_1.position.x,
																				  select_menu_1.position.y-win_size.height)],
							  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
															  blockHeight*2+win_size.height)],
							  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[armMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(armMenu.position.x,
																			  armMenu.position.y-win_size.height)],
						[CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
															   position:ccp(itemMenu.position.x,
																			itemMenu.position.y-win_size.height)],
						 [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	for (CCSprite *item in itemIcons) {
		if (item.position.x == item1SlotPos.x && item.position.y == (item1SlotPos.y+win_size.height)) {
			[item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	position:item1SlotPos],
							 [CCPlace actionWithPosition:item1SlotPos],nil]];
		}
		if (item.position.x == item2SlotPos.x && item.position.y == (item2SlotPos.y+win_size.height)) {
			[item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	position:item2SlotPos],
							 [CCPlace actionWithPosition:item2SlotPos],nil]];
		}
	}
	
	[itemSlots runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(itemSlots.position.x,
																			 itemSlots.position.y-win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],
						  [CCCallFunc actionWithTarget:self selector:@selector(showItemSelector:)], nil]];
	 
	[direct runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
															  position:ccp(direct.position.x,
																		   direct.position.y-win_size.height)],
					   [CCPlace actionWithPosition:ccp(direct.position.x,win_size.height*2.5/10)],nil]];
	
	[titleScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
																   position:ccp(titleScreen.position.x,
																				titleScreen.position.y-win_size.height)],
							[CCPlace actionWithPosition:ccp(win_size.width/2-blockWidth/2,
															win_size.height/2+win_size.height)],nil]];
	
	[armouryScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																   position:ccp(armouryScreen.position.x,
																				armouryScreen.position.y-win_size.height)],nil]];
	
	[easyMode setIsEnabled:NO];
	[normalMode setIsEnabled:NO];
	[hardMode setIsEnabled:NO];
	[lvlBackButton setIsEnabled:NO];
	
	[upButt setIsEnabled:NO];
	[downButt setIsEnabled:NO];
	[item1Slot setIsEnabled:NO];
	[item2Slot setIsEnabled:NO];
	[armBackButton setIsEnabled:NO];
	[armStartButton setIsEnabled:NO];
}

-(void) armToLevelSelect:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[self exitArmoury];
	
	[armMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
															   position:ccp(armMenu.position.x,
																			armMenu.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
														  blockHeight+win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
															   position:ccp(itemMenu.position.x,
																			itemMenu.position.y-win_size.height)],
						[CCPlace actionWithPosition:ccp(itemMenu.position.x, 
														win_size.height*2.5/10-68/2*(totalItems-1)
														+win_size.height)],
						[CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	for (CCSprite *item in itemIcons) {
		if (CGPointEqualToPoint(item.position, item1SlotPos)) {
			[item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	position:ccp(item.position.x,
																				 item.position.y-win_size.height)],
							 [CCPlace actionWithPosition:ccp(item1SlotPos.x,item1SlotPos.y+win_size.height)],nil]];
		}
		if (CGPointEqualToPoint(item.position, item2SlotPos)) {
			[item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	position:ccp(item.position.x,
																				 item.position.y-win_size.height)],
							 [CCPlace actionWithPosition:ccp(item2SlotPos.x,item2SlotPos.y+win_size.height)],nil]];
		}
	}
	
	[itemSlots runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(hideItemSelector:)],
						  [CCMoveTo actionWithDuration:0.5 position:ccp(itemSlots.position.x,
																		itemSlots.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(itemSlots.position.x, 
														 win_size.height-item1Slot.contentSize.height+win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[direct runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
															  position:ccp(direct.position.x,
																		   direct.position.y-win_size.height)],
					   [CCPlace actionWithPosition:ccp(direct.position.x,win_size.height*2.5/10+win_size.height)],nil]];
	
	[select_menu_1 runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	 position:ccp(select_menu_1.position.x,
																				  select_menu_1.position.y-win_size.height)],
							  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[armouryScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
																   position:ccp(armouryScreen.position.x,
																				armouryScreen.position.y-win_size.height)],
							[CCPlace actionWithPosition:ccp(win_size.width/2-blockWidth/2,
															win_size.height/2+win_size.height)],nil]];
	
	[titleScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																   position:ccp(titleScreen.position.x,
																				titleScreen.position.y-win_size.height)],nil]];
	
	[easyMode setIsEnabled:NO];
	[normalMode setIsEnabled:NO];
	[hardMode setIsEnabled:NO];
	[lvlBackButton setIsEnabled:NO];
	
	[upButt setIsEnabled:NO];
	[downButt setIsEnabled:NO];
	[item1Slot setIsEnabled:NO];
	[item2Slot setIsEnabled:NO];
	[armBackButton setIsEnabled:NO];
	[armStartButton setIsEnabled:NO];
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
	[upButt setIsEnabled:YES];
	[downButt setIsEnabled:YES];
}

-(void) clickedUp:(id)sender
{
	NSLog(@"clicked up,%i", curItem);
	if (curItem!=0) {
		int blockHeight = 68;
		[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 
																	position:ccp(itemMenu.position.x,
																				itemMenu.position.y-blockHeight)],
							[CCCallFunc actionWithTarget:self selector:@selector(activateDirect:)],nil]];
		[[items objectAtIndex:curItem] setIsEnabled:NO];
		NSLog(@"item disabled,%i", curItem);
		curItem--;
		NSLog(@"item enabled,%i", curItem);
		[[items objectAtIndex:curItem] setIsEnabled:YES];
		
		[upButt setIsEnabled:NO];
		[downButt setIsEnabled:NO];
	}
}

-(void) clickedDown:(id)sender
{
	NSLog(@"clicked down,%i",curItem);
	if (curItem!=(totalItems-1)) {
		int blockHeight = 68;
		[itemMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 
																	position:ccp(itemMenu.position.x,
																				 itemMenu.position.y+blockHeight)],
							[CCCallFunc actionWithTarget:self selector:@selector(activateDirect:)],nil]];
		[[items objectAtIndex:curItem] setIsEnabled:NO];
		NSLog(@"item disabled,%i", curItem);
		curItem++;
		NSLog(@"item enabled,%i", curItem);
		[[items objectAtIndex:curItem] setIsEnabled:YES];
		
		[upButt setIsEnabled:NO];
		[downButt setIsEnabled:NO];
	}
}

-(void) goToGameScene:(id)sender
{
	/*[upButt setIsEnabled:NO];
	[downButt setIsEnabled:NO];
	[item1Slot setIsEnabled:NO];
	[item2Slot setIsEnabled:NO];
	[armBackButton setIsEnabled:NO];
	[armStartButton setIsEnabled:NO];
	*/
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate restartGame];
	[delegate nextLevel];
}

-(void) enterArmoury
{
	curItem = 0;
	
	BOOL skipFirst = TRUE;	
	for (CCMenuItemImage *item in items){
		if (skipFirst) {
			NSLog(@"enabled");
			[item setIsEnabled:YES];
			skipFirst = FALSE;
		} else [item setIsEnabled:NO];	
	}
}

-(void) exitArmoury
{
	for (CCMenuItemImage *item in items){
		[item setIsEnabled:NO];
	}
}

-(void) mainToLevelSelect:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[main_menu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																position:ccp(main_menu.position.x,
																			 main_menu.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
														  blockHeight+win_size.height)],
						 [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[select_menu_1 runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(select_menu_1.position.x,
																			  select_menu_1.position.y-win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[aboutButton setIsEnabled:NO];
	[newGameButton setIsEnabled:NO];
	
	[easyMode setIsEnabled:NO];
	[normalMode setIsEnabled:NO];
	[hardMode setIsEnabled:NO];
	[lvlBackButton setIsEnabled:NO];
}

-(void) mainToAbout:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[main_menu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(main_menu.position.x,
																			  main_menu.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
														  blockHeight+win_size.height)],nil]];
	
	[aboutMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(aboutMenu.position.x,
																			  aboutMenu.position.y-win_size.height)],
							  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[titleScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
																   position:ccp(titleScreen.position.x,
																				titleScreen.position.y-win_size.height)],
							[CCPlace actionWithPosition:ccp(win_size.width/2-blockWidth/2,
															win_size.height/2+win_size.height)],nil]];
	
	[aboutScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																   position:ccp(aboutScreen.position.x,
																				aboutScreen.position.y-win_size.height)],nil]];

	[aboutButton setIsEnabled:NO];
	[newGameButton setIsEnabled:NO];
	
	[abtBackButton setIsEnabled:NO];
}

-(void) aboutToMain:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[aboutMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(aboutMenu.position.x,
																			  aboutMenu.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
														  blockHeight/2+win_size.height)],nil]];
	
	[main_menu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(main_menu.position.x,
																			  main_menu.position.y-win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[aboutScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5
																   position:ccp(aboutScreen.position.x,
																				aboutScreen.position.y-win_size.height)],
							[CCPlace actionWithPosition:ccp(win_size.width/2-blockWidth/2,
															win_size.height/2+win_size.height)],nil]];
	
	[titleScreen runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																   position:ccp(titleScreen.position.x,
																				titleScreen.position.y-win_size.height)],nil]];
	
	[abtBackButton setIsEnabled:NO];

	[aboutButton setIsEnabled:NO];
	[newGameButton setIsEnabled:NO];
}

/*
-(void) goToLevelSelect:(id)sender
{
	//[[CCDirector sharedDirector] replaceScene:[Level scene]];
	Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.levelScene.layer refreshLocks];
	[delegate exitMainScene];
	[[CCDirector sharedDirector] replaceScene:delegate.levelScene];
}
*/
-(void) levelSelectToMain:(id)sender
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	int blockWidth = 96;
	int blockHeight = 48;
	
	[select_menu_1 runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																 position:ccp(select_menu_1.position.x,
																			  select_menu_1.position.y-win_size.height)],
						  [CCPlace actionWithPosition:ccp(win_size.width-blockWidth/2, 
														  blockHeight*2+win_size.height)],
						  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[main_menu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.5 
																	 position:ccp(main_menu.position.x,
																				  main_menu.position.y-win_size.height)],
							  [CCCallFunc actionWithTarget:self selector:@selector(activateButs:)],nil]];
	
	[easyMode setIsEnabled:NO];
	[normalMode setIsEnabled:NO];
	[hardMode setIsEnabled:NO];
	[lvlBackButton setIsEnabled:NO];
	
	[aboutButton setIsEnabled:NO];
	[newGameButton setIsEnabled:NO];	
}

-(void) goToLevelSelect1:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 0;
	[self levelSelectToArm:NULL];
	//[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
}

-(void) goToLevelSelect2:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 1;
    [self levelSelectToArm:NULL];
	//[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
}

-(void) goToLevelSelect3:(id) sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	delegate.curLevelIndex = 2;
    [self levelSelectToArm:NULL];
	//[[CCDirector sharedDirector] replaceScene:delegate.armouryScene];
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

// on "dealloc" you need to release all your retained objects
-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	[levels release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
