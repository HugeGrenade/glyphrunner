//
//  PauseLayer.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"


@interface PauseLayer : CCLayer
{	
	CCMenu *_pauseMenu;
	CCSprite *_bimage;
	CCSprite *_blur;
}

@property (nonatomic, retain) CCMenu *pauseMenu;
@property (nonatomic, retain) CCSprite *bimage;
@property (nonatomic, retain) CCSprite *blur;

@end