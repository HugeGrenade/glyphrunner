//
//  Player.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize runner = _runner;

/*
+(id) player
{
	Player *player = nil;
	if ((player = [[[super alloc] initWithFile:@"Runner0001.png"] autorelease]))
	{	
		[player runAction:player];
	}
	return player;
}
*/

-(id) initPlayer
{
	if ((self = [[super initWithFile:@"Runner0001.png"] autorelease])) {
	}
	return self;
}

-(void)runAction:(CGPoint)pos
{/*
	CCAnimation *runAnim = [Help loadAnim:@"Runner" numFrames:30 delay:0.04f];
	self.runner = [CCSprite spriteWithSpriteFrameName:@"Runner0001.png"];     
	_runner.position = pos;
	[_runner runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnim]]];
	[self addChild:_runner];
	[runAnim release];
*/
}

/*
-(void)runAction:(Player *) player
{
	CCAnimation *runAnim = [Help loadAnim:@"Runner" numFrames:30 delay:0.04f];
	self.runner = [CCSprite spriteWithSpriteFrameName:@"Runner0001.png"];     
	_runner.position = ccp(player.position.x+player.contentSize.width/2, player.position.y+player.contentSize.height/2);	
	[_runner runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnim restoreOriginalFrame:NO]]];
	[self addChild:_runner];
	[runAnim release];
}
*/
- (void) cleanupSprite : (id)sender 
{	
	CCSprite *sprite = (CCSprite *)sender;
	[sprite.parent removeChild:sprite cleanup:YES];
	[self removeChild:sprite.parent cleanup:YES];
	[self removeChild:sprite cleanup:YES];
	[sprite release];
}

- (void) dealloc
{
	[super dealloc];
}


@end
