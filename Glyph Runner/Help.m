//
//  Help.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Help.h"

@implementation Help

+(CCAnimation*) loadAnim:(NSString*)nameFormat numFrames:(int)numFrames delay:(CGFloat)delay
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",nameFormat]];
	//CCSpriteSheet *spriteSheet = [CCSpriteSheet spriteSheetWithFile:[NSString stringWithFormat:@"%@.png",nameFormat]];
	//[self addChild:spriteSheet];
	
	// Load up the frames of our animation
	NSMutableArray *animFrames = [NSMutableArray array];
	for(int i = 1; i <= numFrames; ++i) {
		[animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
							   spriteFrameByName:[NSString stringWithFormat:@"%@%04d.png",nameFormat, i]]];
	}
	//CCAnimation* animation = [[CCAnimation animationWithName:nameFormat delay:delay frames:animFrames] retain];
	//CCAnimation *animation = [[CCAnimation animationWithFrames:animFrames delay:delay] retain];
    CCAnimation *animation = [[CCAnimation animationWithAnimationFrames:animFrames delayPerUnit:delay loops:1] retain];
	return animation;
}

@end
