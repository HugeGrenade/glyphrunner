//
//  ArmouryScene.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface Armoury : CCLayer  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	UIWindow *window;
	UIImage *newImage;
	int itemPos;
	NSMutableArray *items;
	CCMenu *itemMenu;
	int totalItems;
	CCMenuItemImage *leftButt;
	CCMenuItemImage *rightButt;
	
	CCMenuItemImage *item1Slot;
	CCMenuItemImage *item2Slot;
	CCSprite *itemSelector;
	CGPoint item1SlotPos;
	CGPoint item2SlotPos;
	
	CCSprite *multiClearIcon;
	CCSprite *iceAgeIcon;
	CCSprite *lawnMowerIcon;
	CCSprite *hugeGrenadeIcon;
	CCSprite *matrixIcon;
	CGPoint disappear;
	
	NSMutableArray *itemIcons;
}

@end

@interface ArmouryScene : CCScene
{
	Armoury *_layer;
}

@property (nonatomic, retain) Armoury *layer;

@end
