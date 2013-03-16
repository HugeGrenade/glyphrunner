//
//  GameState.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface GameState : NSObject <NSCoding>
{
	int highestLevel;
}

@property int highestLevel;

-(void) clear;
//-(void) setHighestLevel:(int)to;

+(GameState*) get;
+(void) purge;
+(void) loadState;
+(void) saveState;
+(NSString*) makeSavePath;

@end
