//
//  Block.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-05-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Block.h"


@implementation Block

@synthesize name, clicked, not_clicked;
/*
- (id)initWithBlock:(NSString *)block clicked:(CCTexture2D *)_clicked not_clicked:(CCTexture2D *)_not_clicked {
	
    if ((self = [super initWithFile:[NSString stringWithFormat:@"%@.tif", block]])) {
		
		self.name = block;
		self.not_clicked = _not_clicked;
		self.clicked = _clicked;
    }
    return self;
}
*/

- (id)initWithBlock:(NSString *)block {
	
    if ((self = [super initWithFile:[NSString stringWithFormat:@"%@.tif", block]])) {
		
		self.name = block;
		
		//NSString *select_name = [NSString stringWithFormat:@"%@.png", _block.name];
		NSString *select_name = [NSString stringWithFormat:@"%@.tif", block];
		//self.not_clicked = [[CCTextureCache sharedTextureCache] addImage:select_name];
		self.not_clicked = [[CCTextureCache sharedTextureCache] textureForKey:select_name];
		//select_name = [NSString stringWithFormat:@"%@_s.png", _block.name];
		select_name = [NSString stringWithFormat:@"%@Broken.tif", block];
		//self.clicked = [[CCTextureCache sharedTextureCache] addImage:select_name];
		self.clicked = [[CCTextureCache sharedTextureCache] textureForKey:select_name];
		
		//[self.not_clicked setAliasTexParameters];
		//[self.clicked setAliasTexParameters];
    }
    return self;
}

-(void) changeToSelectName
{
	//NSString *select_name = [NSString stringWithFormat:@"%@_s.png", _block.name];
	//not_clicked = [[CCTextureCache sharedTextureCache] addImage:select_name]
	[self setTexture:self.clicked];
}

-(void) changeToNotSelectName
{
	//NSString *select_name = [NSString stringWithFormat:@"%@", _block.name];
	//[_block setTexture:[[CCTextureCache sharedTextureCache]  :select_name]];
	[self setTexture:self.not_clicked];
}

-(void) cleanUp
{
	[name release];
	[not_clicked release];
	[clicked release];
	//[[CCTextureCache sharedTextureCache] removeTexture:[NSString stringWithFormat:@"%@.tif",self.name]];
	//[[CCTextureCache sharedTextureCache] removeTexture:[NSString stringWithFormat:@"%@Broken.tif",self.name]];
}

-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	NSLog(@"dealloc block");
	[name release];
	[not_clicked release];
	[clicked release];
	//[self.name release];
	//[self.not_clicked release];
	//[self.clicked release];
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

/*
+(id) init
{
	Block *block = nil;

    if (( block = [[[Block alloc] init] autorelease] ))
	{
	}
	return block;
}

+(void) setName:(Block *)_block name:(NSString *)_name
{
	_block.name = _name;
	
	//NSString *select_name = [NSString stringWithFormat:@"%@.png", _block.name];
	NSString *select_name = [NSString stringWithFormat:@"%@.tif", _block.name];
	_block.not_clicked = [[CCTextureCache sharedTextureCache] addImage:select_name];
	
	//select_name = [NSString stringWithFormat:@"%@_s.png", _block.name];
	select_name = [NSString stringWithFormat:@"%@Broken.tif", _block.name];
	_block.clicked = [[CCTextureCache sharedTextureCache] addImage:select_name];
	
	[_block.not_clicked setAliasTexParameters];
	[_block.clicked setAliasTexParameters];
}
*/


@end
