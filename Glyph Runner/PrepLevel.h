//
//  PrepLevel.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"


@interface PrepLevel : NSObject
{
    int _levelNum;
    float _dropRate;
	int _num_of_cols;
	int _init_rows;
	int _dif;
    NSString *_imagePack;
}

@property (nonatomic, assign) int levelNum;
@property (nonatomic, assign) float dropRate;
@property (nonatomic, assign) int num_of_cols;
@property (nonatomic, assign) int init_rows;
@property (nonatomic, assign) int dif;
@property (nonatomic, copy) NSString *imagePack;

- (id)initWithLevelNum:(int)levelNum dropRate:(float)dropRate num_of_cols:(int)num_of_cols init_rows:(int)init_rows dif:(int)dif imagePack:(NSString *)imagePack;

@end