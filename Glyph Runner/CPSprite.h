//
//  CPSprite.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface CPSprite : CCSprite {
    cpBody *body;
    cpShape *shape;
    cpSpace *space;
    BOOL canBeDestroyed;
}

@property (assign) cpBody *body;

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location sprite:(NSString *)sprite;
- (void)update;
- (void)createBodyAtLocation:(CGPoint)location;
- (void)destroy;

@end