//
//  LevelScene.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface Level : CCLayer
{
	NSMutableArray *levels;
}

@property (nonatomic, retain) NSMutableArray *levels;

-(void) showIcons;
-(void) refreshLocks;

@end

@interface LevelScene : CCScene
{
	Level *_layer;
}

@property (nonatomic, retain) Level *layer;

@end
