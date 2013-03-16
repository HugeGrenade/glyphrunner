//
//  CPSprite.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPSprite.h"

@implementation CPSprite
@synthesize body;

- (void)update {    
    self.position = body->p;
    self.rotation = CC_RADIANS_TO_DEGREES(-1 * body->a);
}

- (void)createBodyAtLocation:(CGPoint)location {
	
    float mass = 1.0;
    body = cpBodyNew(mass, cpMomentForBox(mass, self.contentSize.width, self.contentSize.height));
    body->p = location;
    body->data = self;
    cpSpaceAddBody(space, body);
	
    shape = cpBoxShapeNew(body, self.contentSize.width, self.contentSize.height);
    shape->e = 0.3; 
    shape->u = 1.0;
    shape->data = self;
    cpSpaceAddShape(space, shape);
	
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location sprite:(NSString *)sprite {
	
    if ((self = [super initWithFile:sprite])) {
		
        space = theSpace;
        [self createBodyAtLocation:location];
        canBeDestroyed = YES;
		
    }
    return self;
	
}

- (void)destroy {
	
    if (!canBeDestroyed) return;
	
    cpSpaceRemoveBody(space, body);
    cpSpaceRemoveShape(space, shape);
	cpShapeDestroy(shape);
	cpShapeFree(shape);
	cpBodyDestroy(body);
	cpBodyFree(body);

    [self removeFromParentAndCleanup:YES];
}

@end