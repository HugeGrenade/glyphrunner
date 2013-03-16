//
//  Row.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Row.h"

@implementation BlockArea

@synthesize array, array_cap, next_idx, select;

-(id) initWith:(int)_array_cap
{
	if ((self = [super init])) {
		self.array = [[[NSMutableArray alloc] init] autorelease];
		self.select = FALSE;
		self.next_idx = 0;
	}
	return self;
}

-(void) cleanUp
{
	[array release];
}

-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	NSLog(@"dealloc block area");
	[array release];
	//[self.name release];
	//[self.not_clicked release];
	//[self.clicked release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

/*
+(id) init
{
	BlockArea *rows=nil;
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (rows = [[[BlockArea alloc] init] autorelease]) )
	{
	}
	return rows;
}

+(void) setup:(BlockArea *)_rows array_cap:(int)_array_cap
{
	_rows.array = [NSMutableArray arrayWithCapacity:_array_cap];
	_rows.select = FALSE;
	_rows.next_idx = 0;
}
*/
@end


@implementation Row

@synthesize array, select, array_cap, next_idx, count, default_action, ignore, level;

-(id) initWith:(int)_array_cap level:(int)_level
{
    if ((self = [super init])) {
		self.array = [[[NSMutableArray alloc] init] autorelease];
		self.array_cap = _array_cap;
		self.next_idx = 0;
		self.select = FALSE;
		self.count = 0;
		self.default_action = TRUE;
		self.ignore = FALSE;
		self.level = _level;
    }
    return self;
}

-(void) cleanUp
{
	[array release];
}

-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	NSLog(@"dealloc row");
	[array release];
	//[self.name release];
	//[self.not_clicked release];
	//[self.clicked release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


/*
+(id) init
{
	Row *row=nil;
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (row = [[[Row alloc] init] autorelease]) )
	{
	}
	return row;
}

+(void) setup:(Row *)_row array_cap:(int)_array_cap level:(int)_level
{
	_row.array = [[NSMutableArray alloc] init];
	_row.array_cap = _array_cap;
	_row.next_idx = 0;
	_row.select = FALSE;
	_row.count = 0;
	_row.default_action = TRUE;
	_row.ignore = FALSE;
	_row.level = _level;
}
*/

@end
