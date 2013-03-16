//
//  BlockSprite.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-06-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPSprite.h"

@interface BlockSprite : CPSprite {
}

- (id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location sprite:(NSString *)sprite;

@end