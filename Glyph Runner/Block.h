//
//  Block.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"


@interface Block : CCSprite 
{
	NSString *name;
	CCTexture2D *clicked;
	CCTexture2D *not_clicked;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) CCTexture2D *clicked;
@property (nonatomic, retain) CCTexture2D *not_clicked;

//+(void) setName:(Block *)_block name:(NSString *)_name;
//-(id) initWithBlock:(NSString *)block clicked:(CCTexture2D *)_clicked not_clicked:(CCTexture2D *)_not_clicked;
-(id) initWithBlock:(NSString *)block;
-(void) changeToSelectName;
-(void) changeToNotSelectName;
-(void) cleanUp;
@end
