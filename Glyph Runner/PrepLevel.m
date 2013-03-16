//
//  PrepLevel.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PrepLevel.h"


@implementation PrepLevel

@synthesize dropRate = _dropRate;
@synthesize levelNum = _levelNum;
@synthesize num_of_cols = _num_of_cols;
@synthesize init_rows = _init_rows;
@synthesize dif = _dif;
@synthesize imagePack = _imagePack;

- (id)initWithLevelNum:(int)levelNum dropRate:(float)dropRate num_of_cols:(int)num_of_cols init_rows:(int)init_rows dif:(int)dif imagePack:(NSString *)imagePack
{
    if ((self = [super init])) {
        self.levelNum = levelNum;
        self.dropRate = dropRate;
		self.num_of_cols = num_of_cols;
		self.init_rows = init_rows;
        self.imagePack = imagePack;
		self.dif = dif;
    }
    return self;
}
@end