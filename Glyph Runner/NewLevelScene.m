//
//  NewLevelScene.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewLevelScene.h"

@implementation NewLevelScene
@synthesize layer = _layer;

- (id)init {
    
	if ((self = [super init])) {
		self.layer = [NewLevelLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation NewLevelLayer

- (void)reset {
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:3],
                     [CCCallFunc actionWithTarget:self selector:@selector(newLevelDone)],
                     nil]];
}

-(id) init
{
	if( (self=[super init] )) {
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Get Ready!!" fontName:@"Helvetica" fontSize:32];
		//label.color = ccc3(0,0,0);
		label.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:label];
		
	}	
	return self;
}

- (void)newLevelDone {
    
    //Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate nextLevel];
	
}

- (void)dealloc {
	[super dealloc];
}

@end