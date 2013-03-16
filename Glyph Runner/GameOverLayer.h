//
//  GameOverLayer.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface GameOverLayer : CCLayer {
	CCLabelTTF *_score;
}

-(void)reset;

@property (nonatomic, retain) CCLabelTTF *score;

@end