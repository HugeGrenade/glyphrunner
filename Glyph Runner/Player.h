//
//  Player.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"


@interface Player : CCSprite {
	CCSprite *_runner;
	
}

@property (nonatomic, retain) CCSprite *runner;

-(id)initPlayer;
-(void)runAction:(CGPoint)pos;

/*
+(id)player;
-(void)runAction:(Player *)player;
*/
@end
