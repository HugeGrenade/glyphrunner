//
//  BlockSprite.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockSprite.h"

@implementation BlockSprite


- (void)createBodyAtLocation:(CGPoint)location {
    
    int num = 4;
	CGPoint verts[] = {
		cpv(-16.0f, 16.0f),
		cpv(16.0f, 16.0f),
		cpv(16.0f, -16.0f),
		cpv(-16.0f, -16.0f)
	};
	
    float mass = 1.0;
    float moment = cpMomentForPoly(mass, num, verts, CGPointZero);
    body = cpBodyNew(mass, moment);
    body->p = location;
    cpSpaceAddBody(space, body);
    
    shape = cpPolyShapeNew(body, num, verts, CGPointZero);
    shape->e = 0.3; 
    shape->u = 0.5;
    //shape->collision_type = 0x1;
    cpSpaceAddShape(space, shape);
    
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location sprite:(NSString *)sprite {
    if ((self = [super initWithSpace:theSpace location:location sprite:sprite])) {
        canBeDestroyed = NO;        
    }
    return self;
}

@end