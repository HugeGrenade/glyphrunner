//
//  PhysicsSprite.h
//  Glyph Runner
//
//  Created by jasonvan on 2013-03-08.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface PhysicsSprite : CCSprite
{
	cpBody *body_;	// strong ref
}

-(void) setPhysicsBody:(cpBody*)body;

@end