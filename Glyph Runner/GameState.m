//
//  GameState.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"

static GameState *singleton = nil;

@implementation GameState

@synthesize highestLevel;


-(id) init
{
	self = [super init];
	if( self != nil )
	{
		[self clear];
		NSLog(@"gameState init %@", self);
	}
	return self;
}

-(id) initWithCoder:(NSCoder*)coder
{
	self = [super init];
	if( self != nil )
	{
		// decode data
		highestLevel = [coder decodeIntForKey:@"highestLevel"];
	}
	return self;
}

-(void) encodeWithCoder:(NSCoder*)coder
{
	// encode data
	[coder encodeInt:highestLevel forKey:@"highestLevel"];
}

-(void) dealloc
{
	[super dealloc];
}

-(void) clear
{
	// erase levels
	//[currentLevel release];
	//[previousLevel release];
	//highestLevel = 0;
	highestLevel = 1;
	
	//currentLevel = nil;
	//previousLevel = nil;
	
	// set player defaults
	//[Player setDefaultState:self];
	
	// clear in-game flags
	//flashedClose = NO;
}
/*
-(void) setHighestLevel:(int)to
{
	if (to > highestLevel) {
		highestLevel=to;
	}
}*/


// 

+(GameState*) get
{
	@synchronized(self)
	{
		// create our single instance
		if(singleton == nil) {
			singleton = [[self alloc] init];
		}
	}
	return singleton;
}

+(id) alloc
{
	@synchronized(self)
	{
		// assert that we are the only instance
		NSAssert(singleton == nil, @"There can only be one GameState");
		return [super alloc];
	}
	return nil;
}

+(void) purge
{
	@synchronized(self)
	{
		[singleton release];
	}
}

+(void) loadState
{
	@synchronized(self)
	{
		// release any existing instance
		[singleton release];
		
		// load our data
		NSString* fname = [self makeSavePath];
		singleton = [[NSKeyedUnarchiver unarchiveObjectWithFile:fname] retain];
		[fname release];
		
		// couldn't load?
		if(singleton == nil)
		{
			NSLog(@"Couldn't load game state, so initialized with defaults");
			[self get];
		}
		
		NSLog(@"Loaded game state %@", singleton);
	}
}

+(void) saveState
{
	// archive our singleton to the save path
	NSString* fname = [self makeSavePath];
	[NSKeyedArchiver archiveRootObject:[GameState get] toFile:fname];
	[fname release];
	NSLog(@"saved game state %@", [GameState get]);
}

+(NSString*) makeSavePath
{
	// get our app's document directory
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// append save file name and retain
	return [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"savefile.sav"] retain];
}

@end
