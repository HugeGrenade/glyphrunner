//
//  NewLevelScene.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"


@interface NewLevelLayer : CCLayer {
}

-(void)reset;

@end

@interface NewLevelScene : CCScene {
	NewLevelLayer *_layer;
}

@property (nonatomic, retain) NewLevelLayer *layer;

@end
