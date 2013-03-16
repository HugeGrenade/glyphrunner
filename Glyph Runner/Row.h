//
//  Row.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"

@interface BlockArea : NSObject
{
	NSMutableArray *array;
	BOOL select;
	int next_idx;
	int array_cap;
}

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) int next_idx;
@property (nonatomic, assign) int array_cap;

-(id) initWith:(int)_array_cap;
-(void) cleanUp;
/*
+(id) init;
+(void) setup:(BlockArea *)_rows array_cap:(int)_array_cap;
*/
@end


@interface Row : NSObject 
{
	NSMutableArray *array;
	BOOL select;
	int array_cap;
	int next_idx;
	int count;
	BOOL default_action;
	BOOL ignore;
}

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) int next_idx;
@property (nonatomic, assign) int array_cap;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL default_action;
@property (nonatomic, assign) BOOL ignore;
@property (nonatomic, assign) int level;

-(id) initWith:(int)_array_cap level:(int)_level;
-(void) cleanUp;
/*
+(id) init;
+(void) setup:(Row *)_row array_cap:(int)_array_cap level:(int)_level;
*/
@end
