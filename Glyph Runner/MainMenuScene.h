//
//  MainMenuScene.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface MainMenu : CCLayer
{
	//CCMenu *soundPane;
	NSMutableArray *levels;
	CCMenu *main_menu;
	CCMenu *select_menu_1;
	CCMenu *aboutMenu;
	CCMenu *soundPane;
	CCMenu *armMenu;
	
	CCSprite *titleScreen;
	CCSprite *aboutScreen;
	CCSprite *armouryScreen;
	
	// armoury
	CCMenuItemImage *armBackButton;
	CCMenuItemImage *armStartButton;
	
	int curItem;
	NSMutableArray *items;
	CCMenu *itemMenu;
	int totalItems;
	CCMenu *itemSlots;
	CCMenu *direct;

	CCMenuItemImage *upButt;
	CCMenuItemImage *downButt;
	
	CCMenuItemImage *item1Slot;
	CCMenuItemImage *item2Slot;
	CCSprite *itemSelector;
	CGPoint item1SlotPos;
	CGPoint item2SlotPos;
	
	// items
	CCSprite *multiClearIcon;
	CCSprite *iceAgeIcon;
	CCSprite *lawnMowerIcon;
	CCSprite *hugeGrenadeIcon;
	CCSprite *matrixIcon;
	
	CGPoint disappear;
	
	NSMutableArray *itemIcons;
	
	// level select
	CCMenuItemImage *easyMode;
	CCMenuItemImage *normalMode;
	CCMenuItemImage *hardMode;
	CCMenuItemImage *lvlBackButton;
	
	// about
	CCMenuItemImage *abtBackButton;
	
	// main menu
	CCMenuItemImage *newGameButton;
	CCMenuItemImage *aboutButton;
}

@property (nonatomic, retain) NSMutableArray *levels;

-(void) showIcons;
-(void) refreshLocks;
-(void) exitArmoury;
-(void) enterArmoury;

@end

@interface MainMenuScene : CCScene
{
	MainMenu *_layer;
}

@property (nonatomic, retain) MainMenu *layer;

@end
