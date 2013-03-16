//
//  soundLayer.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface SoundLayer : CCLayer
{	
	CCMenu *soundPane;
	CCMenuItemToggle *soundToggle;
	CCMenuItemToggle *musicToggle;
}

@property (nonatomic, retain) CCMenu *soundPane;

-(void) mainMenuSoundPane;

@end