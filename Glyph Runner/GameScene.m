//
//  GameScene.m
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
//#import "drawSpace.h"

@implementation GameScene

@synthesize layer = _layer;

+(id) scene
{
	// 'scene' is an autorelease object.
	GameScene *scene = [GameScene node];
	
	// 'layer' is an autorelease object.
	Game *layer = [Game node];
    scene.layer = layer;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)dealloc {
    self.layer = nil;
	[self.layer release];
    [super dealloc];
}

@end

@implementation Game

@synthesize block_row = _block_row;
@synthesize glyphs = _glyphs;
@synthesize glyph_con = _glyph_con;

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Physics stuff
- (void)createSpace {
    space = cpSpaceNew();
    space->gravity = ccp(0, -750);
    //cpSpaceResizeStaticHash(space, 400, 200);
    //cpSpaceResizeActiveHash(space, 200, 200);
	space->sleepTimeThreshold = 1.0;
}

- (void)createGround {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint lowerLeft = ccp(0, 0);
    CGPoint lowerRight = ccp(winSize.width, 0);
    
    groundBody = cpBodyNewStatic();
    
    float radius = 10.0;
    groundShape = cpSegmentShapeNew(groundBody, lowerLeft, lowerRight, radius);
    groundShape->e = 0.0; // elasticity
    groundShape->u = 1.0; // friction
	groundShape->collision_type = 0x1;
    cpSpaceAddShape(space, groundShape);
}
/*
- (void)createBoxAtLocation:(CGPoint)location {
    
    float boxSize = 32.0;
    float mass = 1.0;
    cpBody *body = cpBodyNew(mass, cpMomentForBox(mass, boxSize, boxSize));
    body->p = location;
    cpSpaceAddBody(space, body);
    
    cpShape *shape = cpBoxShapeNew(body, boxSize, boxSize);
    shape->e = 0.5; 
    shape->u = 0.5;
    cpSpaceAddShape(space, shape);
}*/
/*
- (void)draw {
    drawSpaceOptions options = {
        0, // drawHash
        0, // drawBBs,
        1, // drawShapes
        4.0, // collisionPointSize
        4.0, // bodyPointSize,
        2.0 // lineThickness
    };
	
    drawSpace(space, &options);
	
}
*/
- (void)updateSpace:(ccTime)dt {
    cpSpaceStep(space, dt);
	
	for (CPSprite *sprite in physicsSprite) {
		[sprite update];
	}
}
/*
- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    cpMouseGrab(mouse, touchLocation, false);
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    cpMouseMove(mouse, touchLocation);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    cpMouseRelease(mouse);
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    cpMouseRelease(mouse);    
}
*/
// ******************************************************* //
// Setting up all the glyphs for the game. (big and small) //
// Naming, position, and animation of the glyphs.		   //
// ******************************************************* //
-(void)setupGlyphs
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 4 big glyphs
	/*NSString *bigGlyph1Name = [NSString stringWithFormat:@"%@oneBig", imgPack];
	NSString *bigGlyph2Name = [NSString stringWithFormat:@"%@twoBig", imgPack];
	NSString *bigGlyph3Name = [NSString stringWithFormat:@"%@threeBig", imgPack];
	NSString *bigGlyph4Name = [NSString stringWithFormat:@"%@fourBig", imgPack];

	bigGlyph1 = [Block spriteWithFile:[NSString stringWithFormat:@"%@.tif", bigGlyph1Name]];
	bigGlyph2 = [Block spriteWithFile:[NSString stringWithFormat:@"%@.tif", bigGlyph2Name]];
	bigGlyph3 = [Block spriteWithFile:[NSString stringWithFormat:@"%@.tif", bigGlyph3Name]];
	bigGlyph4 = [Block spriteWithFile:[NSString stringWithFormat:@"%@.tif", bigGlyph4Name]];
	
	[Block setName:bigGlyph1 name:bigGlyph1Name];
	[Block setName:bigGlyph2 name:bigGlyph2Name];
	[Block setName:bigGlyph3 name:bigGlyph3Name];
	[Block setName:bigGlyph4 name:bigGlyph4Name];
	*/
	
	bigGlyph1 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@oneBig", imgPack]];
	bigGlyph2 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@twoBig", imgPack]];
	bigGlyph3 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@threeBig", imgPack]];
	bigGlyph4 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@fourBig", imgPack]];
	 
	/*
	bigGlyph1 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@oneBig", imgPack] clicked:oneBr not_clicked:oneB];
	bigGlyph2 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@twoBig", imgPack] clicked:twoBr not_clicked:twoB];
	bigGlyph3 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@threeBig", imgPack] clicked:threeBr not_clicked:threeB];
	bigGlyph4 = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@fourBig", imgPack] clicked:fourBr not_clicked:fourB];
	*/
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 4 positions
	CGPoint bottom_right = ccp(win_size.width-bigGlyph1.contentSize.width/2, 
							   bigGlyph1.contentSize.height/2+win_size.height);
	CGPoint bottom_left = ccp(bigGlyph1.contentSize.width/2, 
							  bigGlyph1.contentSize.height/2+win_size.height);
	CGPoint top_right = ccp(win_size.width-bigGlyph1.contentSize.width/2, 
							bigGlyph1.contentSize.height+bigGlyph1.contentSize.height/2+win_size.height);
	CGPoint top_left = ccp(bigGlyph1.contentSize.width/2, 
						   bigGlyph1.contentSize.height+bigGlyph1.contentSize.height/2+win_size.height);
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Mix glyphs
	NSMutableArray *locMixer = [NSMutableArray arrayWithCapacity:4];
	[locMixer addObject:[NSValue valueWithCGPoint:bottom_right]];
	[locMixer addObject:[NSValue valueWithCGPoint:bottom_left]];
	[locMixer addObject:[NSValue valueWithCGPoint:top_right]];
	[locMixer addObject:[NSValue valueWithCGPoint:top_left]];
	
	[locMixer exchangeObjectAtIndex:arc4random()%2 withObjectAtIndex:arc4random()%4];
	[locMixer exchangeObjectAtIndex:arc4random()%4 withObjectAtIndex:arc4random()%4];
	
	bigGlyph1.position = [[locMixer objectAtIndex:0] CGPointValue];
	bigGlyph2.position = [[locMixer objectAtIndex:1] CGPointValue];
	bigGlyph3.position = [[locMixer objectAtIndex:2] CGPointValue];
	bigGlyph4.position = [[locMixer objectAtIndex:3] CGPointValue];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Add item glyphs
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
		NSLog(@"adding item menu");
	if (![[delegate.chosenItem objectAtIndex:0] isEqual:[NSNull null]]) {
		leftItem = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@Icon.png", 
														 [delegate.chosenItem objectAtIndex:0]]
										  selectedImage:[NSString stringWithFormat:@"%@Icon.png",
														 [delegate.chosenItem objectAtIndex:0]]
												 target:self
											   selector:@selector(useLeftItem:)];
		[leftItem setIsEnabled:YES];
	} else {
		leftItem = [CCMenuItemImage itemWithNormalImage:@"item1.png" selectedImage:@"item1.png" disabledImage:@"item1.png" 
												 target:self selector:@selector(useLeftItem:)];
		[leftItem setIsEnabled:NO];
		//leftItem.opacity = 0;
	}
	
	if (![[delegate.chosenItem objectAtIndex:1] isEqual:[NSNull null]]) {
		rightItem = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@Icon.png",
														  [delegate.chosenItem objectAtIndex:1]]
										   selectedImage:[NSString stringWithFormat:@"%@Icon.png",
														  [delegate.chosenItem objectAtIndex:1]]
												  target:self
												selector:@selector(useRightItem:)];
		[rightItem setIsEnabled:YES];
	} else {
		rightItem = [CCMenuItemImage itemWithNormalImage:@"item2.png" selectedImage:@"item2.png" disabledImage:@"item2.png"
												  target:self selector:@selector(useRightItem:)];
		[rightItem setIsEnabled:NO];
		//rightItem.opacity = 0;
	}

	items = [CCMenu menuWithItems:leftItem, rightItem, nil];
	items.position = CGPointZero;

	BOOL aniLeft = FALSE;
	BOOL aniRight = FALSE;
	
	//if (![[delegate.chosenItem objectAtIndex:0] isEqual:[NSNull null]]) {
		leftItem.position = ccp(leftItem.contentSize.width/2, leftItem.contentSize.height*2.5+win_size.height);
		
		aniLeft = TRUE;
	//}
	
	//if (![[delegate.chosenItem objectAtIndex:1] isEqual:[NSNull null]]) {
		rightItem.position = ccp(win_size.width-rightItem.contentSize.width/2, rightItem.contentSize.height*2.5+win_size.height);
		
		aniRight = TRUE;
	//}

	[self addChild:items];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Animate glpyhs
	[bigGlyph1 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph1.position.x, bigGlyph1.position.y-win_size.height)]];
	[bigGlyph2 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph2.position.x, bigGlyph2.position.y-win_size.height)]];
	[bigGlyph3 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph3.position.x, bigGlyph3.position.y-win_size.height)]];
	[bigGlyph4 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph4.position.x, bigGlyph4.position.y-win_size.height)]];
	
	/*
	[bigGlyph1 runAction:[CCMoveTo actionWithDuration:1 position:ccp(win_size.width-bigGlyph1.contentSize.width/2, 
																bigGlyph1.contentSize.height/2)]];
	[bigGlyph2 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph1.contentSize.width/2, 
																	   bigGlyph1.contentSize.height/2)]];
	[bigGlyph3 runAction:[CCMoveTo actionWithDuration:1 position:ccp(win_size.width-bigGlyph1.contentSize.width/2, 
																bigGlyph1.contentSize.height+bigGlyph1.contentSize.height/2)]];
	[bigGlyph4 runAction:[CCMoveTo actionWithDuration:1 position:ccp(bigGlyph1.contentSize.width/2, 
																bigGlyph1.contentSize.height+bigGlyph1.contentSize.height/2)]];
	*/
	
	[self addChild:bigGlyph1 z:200];
	[self addChild:bigGlyph2 z:200];
	[self addChild:bigGlyph3 z:200];
	[self addChild:bigGlyph4 z:200];
	
	if (aniLeft) [leftItem runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.25],
									  [CCMoveTo actionWithDuration:1 
														  position:ccp(leftItem.position.x, leftItem.position.y-win_size.height)],nil]];
	if (aniRight) [rightItem runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.25],
										[CCMoveTo actionWithDuration:1 
															position:ccp(rightItem.position.x, rightItem.position.y-win_size.height)],nil]];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Array for big glpyhs	
	self.glyph_con = [NSMutableArray arrayWithCapacity:4];
	[self.glyph_con addObject:bigGlyph1];
	[self.glyph_con addObject:bigGlyph2];
	[self.glyph_con addObject:bigGlyph3];
	[self.glyph_con addObject:bigGlyph4];
	
	/*
	 // initialize sprites
	 self.glyphs = [NSMutableArray arrayWithCapacity:4];
	 [self.glyphs addObject:[NSString stringWithFormat:@"glyph_circle"]];
	 [self.glyphs addObject:[NSString stringWithFormat:@"glyph_square"]];
	 [self.glyphs addObject:[NSString stringWithFormat:@"glyph_triangle"]];
	 [self.glyphs addObject:[NSString stringWithFormat:@"glyph_x"]];
	 */
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Array for small glpyhs
	
	self.glyphs = [NSMutableArray arrayWithCapacity:4];
	[self.glyphs addObject:[NSString stringWithFormat:@"%@one", imgPack]];
	[self.glyphs addObject:[NSString stringWithFormat:@"%@two", imgPack]];
	[self.glyphs addObject:[NSString stringWithFormat:@"%@three", imgPack]];
	[self.glyphs addObject:[NSString stringWithFormat:@"%@four", imgPack]];
	 
	/*
	self.glyphs = [NSMutableArray arrayWithCapacity:4];
	[self.glyphs addObject:[NSString stringWithFormat:@"one"]];
	[self.glyphs addObject:[NSString stringWithFormat:@"two"]];
	[self.glyphs addObject:[NSString stringWithFormat:@"three"]];
	[self.glyphs addObject:[NSString stringWithFormat:@"four"]];
	 */
}

// ************************************************************ //
// Seting up the game.										    //
// Gathering level data, setting up artwork, setting up player. //
// ************************************************************ //
-(void)setup
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Gather/set level data
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    speed = delegate.curLevel.dropRate;
	num_of_col = delegate.curLevel.num_of_cols;
	init_rows = delegate.curLevel.init_rows;
	imgPack = delegate.curLevel.imagePack;
	dif = delegate.curLevel.dif;
	levelNum = delegate.curLevel.levelNum;
	
	// items
	multiRowClear = FALSE;
	freezeRows = FALSE;
	
	added_rows = 0;
	block_size = 32;
	num_of_rows = 0;
	deleted_rows = 0;
	NSLog(@"GATHERED LEVEL INFO!");
	
	self.block_row = [[[BlockArea alloc] initWith:20] autorelease];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Setting up level artwork
	front_spikes1 = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_front_spikes.png", imgPack]];
	front_spikes1.position = ccp(front_spikes1.contentSize.width/2, win_size.height-front_spikes1.contentSize.height/2);
	front_spikes2 = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_front_spikes.png", imgPack]];
	front_spikes2.position = ccp(front_spikes1.position.x, front_spikes1.position.y+win_size.width);
	
	moveSpike1 = FALSE;
	moveSpike2 = TRUE;
	[front_spikes1 runAction:[CCMoveTo actionWithDuration:speed 
												 position:ccp(0-front_spikes1.contentSize.width/2-2, win_size.height/2)]];
	[self addChild:front_spikes1 z:-1];
	[self addChild:front_spikes2 z:-1];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Physics
	[self createSpace];
	[self createGround];
	//mouse = cpMouseNew(space);
	physicsSprite = [[NSMutableArray alloc] init];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Setting up player
	/*player = [Player player];
	player.position = ccp(win_size.width/2, player.contentSize.height/2);
	player.opacity = 0;
	
	cur_score = 0;*/
	[[CCDirector sharedDirector] resume];
	
	//[self addChild:player];
	NSLog(@"FINISHED SETTING UP PLAYER!");
	[self setupGlyphs];
	NSLog(@"FINISHED SETTING UP GLYPHS!");
}

// **************************************************** //
// Reseting the game.								    //
// Removing all objects currently in the game.		    //
// Calling the function setup to setup back everything. //
// **************************************************** //
-(void)resetGame
{	
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	[self unschedule:@selector(update:)];
	[self unschedule:@selector(updateBackground:)];
	[self unschedule:@selector(updateBlocks:)];
	[self unschedule:@selector(updateSpace:)];
	[front_spikes1 stopAllActions];
	[front_spikes2 stopAllActions];
	
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove all the rows of blocks
    for (Row *row in _block_row.array) {
		for (Block *block in row.array) {
			//[block cleanUp];
			[self removeChild:block cleanup:YES];
		}
		//[row cleanUp];
		[row.array removeAllObjects];
	}
	//[_block_row cleanUp];
	[_block_row.array removeAllObjects];
	
	for (CPSprite *sprite in physicsSprite) {
		[sprite destroy];
		[self removeChild:sprite cleanup:YES];
	}
	[physicsSprite removeAllObjects];
	[physicsSprite release];
	/*
	[bigGlyph1 release];
	[bigGlyph2 release];
	[bigGlyph3 release];
	[bigGlyph4 release];
	*/

	//[self.block_row release];
	//cpMouseFree(mouse);
    //cpSpaceFree(space);
	
	for (Block *block in self.glyph_con) {
		[block release];
	}
	[self.glyph_con removeAllObjects];
	[self.glyphs removeAllObjects];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove the 4 big glyphs
	[self removeChild:bigGlyph1 cleanup:YES];
	[self removeChild:bigGlyph2 cleanup:YES];
	[self removeChild:bigGlyph3 cleanup:YES];
	[self removeChild:bigGlyph4 cleanup:YES];
	
	//[self removeChild:leftItem cleanup:YES];
	//[self removeChild:rightItem cleanup:YES];
	NSLog(@"1");
	[self removeChild:items cleanup:YES];	
	//[items removeChild:rightItem cleanup:YES];
	//[items removeChild:leftItem cleanup:YES];
	NSLog(@"1");
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove everything else
	[self removeChild:player cleanup:YES];
	//[self removeChild:pause cleanup:YES];
	//[self removeChild:gameOver cleanup:YES];
	[self removeChild:front_spikes1 cleanup:YES];
	[self removeChild:front_spikes2 cleanup:YES];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Starting the game back up
	[self setup];
	
	three.position = ccp(win_size.width/2, win_size.height+three.contentSize.height/2);
	
	id spin = [CCRotateTo actionWithDuration:0.33f angle:180];
	id goToMid = [CCMoveTo actionWithDuration:0.33f position:ccp(win_size.width/2, win_size.height/2)];
	id goToBottom = [CCMoveTo actionWithDuration:0.33f position:ccp(win_size.width/2, -three.contentSize.height/2)];
	id grow = [CCScaleTo actionWithDuration:0.165f scale:2.0f];
	id shrink = [CCScaleTo actionWithDuration:0.165f scale:1.0f];
	
	[self schedule:@selector(updateBackground:)];
	
	[three runAction:[CCSequence actions:goToMid,grow,shrink,goToBottom,nil]];
	[three runAction:[CCSequence actions:spin,[CCDelayTime actionWithDuration:0.33f],spin,nil]];
	[two runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],goToMid,grow,shrink,goToBottom,nil]];
	[two runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0f],spin,[CCDelayTime actionWithDuration:0.33f],spin,nil]];
	[one runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0f],goToMid,grow,shrink,goToBottom,nil]];
	[one runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0f],spin,[CCDelayTime actionWithDuration:0.33f],spin,
					[CCCallFunc actionWithTarget:self selector:@selector(begin:)], nil]];
	
}

-(void) begin:(id)sender
{
	self.isTouchEnabled = YES;
    [self schedule:@selector(update:)];
	[self schedule:@selector(updateBlocks:)];
	[self schedule:@selector(updateSpace:)];
}

/*
-(void)resetGame
{	
	[self unschedule:@selector(update:)];
	[self unschedule:@selector(updateBlocks:)];
	[self unschedule:@selector(updateSpace:)];
	[front_spikes1 stopAllActions];
	[front_spikes2 stopAllActions];
	
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove all the rows of blocks
    for (Row *row in _block_row.array) {
		for (Block *block in row.array) {
			[block cleanUp];
			[self removeChild:block cleanup:YES];
			[row.array removeObject:block];
		}
		[row cleanUp];
		[row.array removeAllObjects];
	}
	[_block_row.array removeAllObjects];
	[self.block_row cleanUp];
	
	for (CPSprite *sprite in physicsSprite) {
		[self removeChild:sprite cleanup:YES];
		//[sprite destroy];
	}
	[physicsSprite removeAllObjects];
	
	[bigGlyph1 release];
	[bigGlyph2 release];
	[bigGlyph3 release];
	[bigGlyph4 release];
	 
	//[physicsSprite release];
	//[self.block_row release];
	//cpMouseFree(mouse);
    //cpSpaceFree(space);
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove the 4 big glyphs
	[self removeChild:bigGlyph1 cleanup:YES];
	[self removeChild:bigGlyph2 cleanup:YES];
	[self removeChild:bigGlyph3 cleanup:YES];
	[self removeChild:bigGlyph4 cleanup:YES];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Remove everything else
	[self removeChild:player cleanup:YES];
	//[self removeChild:pause cleanup:YES];
	//[self removeChild:gameOver cleanup:YES];
	[self removeChild:front_spikes1 cleanup:YES];
	[self removeChild:front_spikes2 cleanup:YES];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Starting the game back up
	[self setup];
	
	self.isTouchEnabled = YES;
    [self schedule:@selector(update:)];
	[self schedule:@selector(updateBlocks:)];
	[self schedule:@selector(updateSpace:)];
}
*/
-(void)switchToPhysics:(id)sender
{
	for (Row *row in self.block_row.array) {
		for (Block *block in row.array) {
			BlockSprite *pBlock = [[[BlockSprite alloc] initWithSpace:space 
															 location:block.position 
															   sprite:[NSString stringWithFormat:@"%@.tif",block.name]]autorelease];
			//[self createBoxAtLocation:block.position];
			[physicsSprite addObject:pBlock];
			[self addChild:pBlock];
			[self removeChild:block cleanup:YES];
			//[block release];
		}
		[row.array removeAllObjects];
	}
}

// *********************************************** //
// Animation of the blocks going on top of player. //
// *********************************************** //
-(void)gameOverClip
{	
	self.isTouchEnabled = NO;
	[self unschedule:@selector(update:)];
	[self unschedule:@selector(updateBackground:)];
	//[self unschedule:@selector(updateBlocks:)];
	[front_spikes1 stopAllActions];
	[front_spikes2 stopAllActions];
	
	Row *first_row = [self.block_row.array objectAtIndex:0];
	
	for (Block *block in first_row.array) {
		[block stopAllActions];
		
		id moveRowUp = [CCMoveTo actionWithDuration:0.01f
										   position:ccp(block.position.x, block.position.y+block.contentSize.height/10)];
		id moveRowDown = [CCMoveTo actionWithDuration:0.01
											 position:ccp(block.position.x, block.position.y+block.contentSize.height/20)];
		id delay = [CCDelayTime actionWithDuration:0.1];
		
		[block runAction:[CCRepeat actionWithAction:[CCSequence actions: delay, moveRowUp, moveRowDown, nil] times:10]];
	}
	
	id switchBlocks = [CCCallFunc actionWithTarget:self selector:@selector(switchToPhysics:)];
	id moveDone = [CCCallFunc actionWithTarget:self selector:@selector(showGameOver:)];
	id delay1 = [CCDelayTime actionWithDuration:1];
	
	[self runAction:[CCSequence actions:delay1, switchBlocks, [CCDelayTime actionWithDuration:2], moveDone,nil]];
}

// ********************************************************** //
// Unschedule the whole game and place game over layer ontop. //
// ********************************************************** //
-(void)showGameOver:(id)sender
{
	//[self unschedule:@selector(updateBlocks:)];
	//[self unschedule:@selector(updateSpace:)];
	[self stopAllActions];
	/*
	self.isTouchEnabled = NO;
	[self unschedule:@selector(update:)];
	[self unschedule:@selector(updateBlocks:)];
	[front_spikes1 stopAllActions];
	[front_spikes2 stopAllActions];
	 */
	//[self unschedule:@selector(updateSpace:)];

	//gameOver = [GameOverLayer node];
	//[gameOver.score setString:[NSString stringWithFormat:@"Score: %d",cur_score]];
	//[self addChild:gameOver z:1000];
	
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate.gameOverLay.score setString:[NSString stringWithFormat:@"Score: %d",cur_score]];
	[delegate loadGameOverLayer];
}

-(void)showLevelComplete
{
	self.isTouchEnabled = NO;
	[self unschedule:@selector(update:)];
	[self unschedule:@selector(updateBlocks:)];
	[front_spikes1 stopAllActions];
	[front_spikes2 stopAllActions];
	
	//gameOver = [GameOverLayer node];
	//[gameOver.score setString:[NSString stringWithFormat:@"Score: %d",cur_score]];
	//[self addChild:gameOver z:1000];
}

-(BOOL) inArray:(NSMutableArray *)nums match:(int)match
{
	for (NSNumber *num in nums)
		if ([num intValue] == match)
			return TRUE;
	return FALSE;
}

// *********************************************************** //
// Checks to see if player loses and add new rows when needed. //
// *********************************************************** //
-(void) update : (ccTime)dt
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Checking game over conditions
	if (num_of_rows > 0) {
		Row *row = [self.block_row.array objectAtIndex:0];
		Block *block = [row.array objectAtIndex:0];
		
		//if (block.position.y-block.contentSize.height/2 < player.contentSize.height && row.default_action) {
		if (block.position.y-block.contentSize.height/2 < 64 && row.default_action) {
			self.isTouchEnabled = NO;
			
			Row *first_row = [self.block_row.array objectAtIndex:0];
			first_row.default_action = FALSE;
			
			[self gameOverClip];
		}
	}
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Adding a new row
	if (num_of_rows == 0) {
		[self addRow];
		
	} else {
		Row *row = [self.block_row.array lastObject];
		Block *t_sprite = [row.array lastObject];
		
		if (t_sprite.position.y < win_size.height) {
			[self addRow];
		}
	}
}

-(void) updateBackground:(ccTime)dt
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];

	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Moving Spikes
	if (front_spikes1.position.x<=-front_spikes1.contentSize.width/2 || front_spikes2.position.x<=-front_spikes1.contentSize.width/2) {
		moveSpike1 = FALSE;
		moveSpike2 = FALSE;
		[front_spikes1 stopAllActions];
		[front_spikes2 stopAllActions];
		if (front_spikes1.position.x<=0-win_size.width/2) {
			front_spikes1.position = ccp(front_spikes2.position.x+front_spikes1.contentSize.width/2, win_size.height/2);
			[front_spikes2 runAction:[CCMoveTo actionWithDuration:speed 
														 position:ccp(0-front_spikes1.contentSize.width/2-2, win_size.height/2)]];
			moveSpike1 = TRUE;
		} else if (front_spikes2.position.x<=0-win_size.width/2) {
			front_spikes2.position = ccp(front_spikes1.position.x+front_spikes2.contentSize.width/2, win_size.height/2);
			[front_spikes1 runAction:[CCMoveTo actionWithDuration:speed 
														 position:ccp(0-front_spikes1.contentSize.width/2-2, win_size.height/2)]];
			moveSpike2 = TRUE;
		}
	}
	if (moveSpike1) {
		front_spikes1.position = ccp(front_spikes2.position.x+front_spikes2.contentSize.width, front_spikes2.position.y);
	}
	if (moveSpike2) {
		front_spikes2.position = ccp(front_spikes1.position.x+front_spikes1.contentSize.width, front_spikes1.position.y);
	}
}

// ************************************* //
// Manually move blocks down the screen. //
// Ignoring blocks that use action move. //
// ************************************* //
-(void) updateBlocks:(ccTime)dt
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	
	BOOL skiped_first = FALSE;
	Block *prev_sprite;
	int idx = 0;
	int row_pos = win_size.width/2 - (num_of_col-1)*(block_size/2);
	
	if (freezeRows) {
		
		if (num_of_rows > 0) {
			Row *row = [self.block_row.array objectAtIndex:0];
			row.ignore = FALSE;
			
			for (Block *block in row.array)
				[block stopAllActions];
		}
		
	} else {
		
		if (num_of_rows > 0) {
			Row *row = [self.block_row.array objectAtIndex:0];
			
			if (!row.ignore) {
				row.ignore = TRUE;
				
				for (Block *block in row.array) {
					float time_lapse = speed*(block.position.y/win_size.height);
					[block stopAllActions];
					[block runAction: [CCMoveTo actionWithDuration:time_lapse position:ccp(row_pos, block.contentSize.height/2)]];
					row_pos = row_pos+block_size;
				}
				
				BOOL SkipFirst = FALSE;
				
				for (Row *row in self.block_row.array) {
					
					if (row.ignore && SkipFirst) {
						
						for (Block *block in row.array) {
							Row *gotoRow = [self.block_row.array objectAtIndex:[self.block_row.array indexOfObject:row]-1];
							Block *gotoBlock = [gotoRow.array lastObject];
							
							id moveRow = [CCMoveTo actionWithDuration:0.5f
															 position:ccp(block.position.x, gotoBlock.position.y+block.contentSize.height)];
							id moveDone = [CCCallFuncND actionWithTarget:self selector:@selector(animateRowFinished:data:) data:(Row *)row];
							
							[block runAction:[CCSequence actions: moveRow, moveDone, nil]];
						}
					}
					SkipFirst = TRUE;
				}
			}
		}
		for (Row *row in self.block_row.array) {	// for (NSMutableArray *row in self.block_row) {
			
			if (num_of_rows > 0 && skiped_first && !row.ignore) {

				for (Block *sprite in row.array)
					sprite.position = ccp(sprite.position.x, prev_sprite.position.y+sprite.contentSize.height);
			}
			prev_sprite = [row.array lastObject];
			skiped_first = TRUE;
			idx++;
		}
	}
	
	if (lawnMower) {
		NSMutableArray *rows_to_delete = [NSMutableArray arrayWithCapacity:num_of_rows*2];
		for (int i = 0; (i<num_of_rows && i<3); i++) {
			[rows_to_delete addObject:[NSNumber numberWithInt:i]];
		}
		[self removeRow:rows_to_delete];
		lawnMower = FALSE;
	}
	
	if (hugeGrenade) {
		NSMutableArray *rows_to_delete = [NSMutableArray arrayWithCapacity:num_of_rows*2];
		for (int i = 0; i<num_of_rows; i++) {
			[rows_to_delete addObject:[NSNumber numberWithInt:i]];
		}
		[self removeRow:rows_to_delete];
		hugeGrenade = FALSE;
	}
}

// 
// Touch detected.
// 
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Choose one of the touches to work with
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
	//CGSize winSize = [[CCDirector sharedDirector] winSize];
	BOOL reset = TRUE;
	BOOL need_to_delete = FALSE;
	BOOL selectedOne = FALSE;
	NSMutableArray *rows_to_delete = [NSMutableArray arrayWithCapacity:num_of_rows*2];
	//Row *row_to_delete = [[Row alloc] init];
	/*
	CGRect pause_rect = CGRectMake(pause_but.position.x - (pause_but.contentSize.width/2), 
								   pause_but.position.y - (pause_but.contentSize.height/2), 
								   pause_but.contentSize.width,
								   pause_but.contentSize.height);
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Touched pause
	if (CGRectContainsPoint(pause_rect, location)) {
		[self pauseOpt];
	}
	*/
	for (Block *glyph in self.glyph_con) {
		CGRect glyph_rect = CGRectMake(glyph.position.x - (glyph.contentSize.width/2), 
									   glyph.position.y - (glyph.contentSize.height/2), 
									   glyph.contentSize.width,
									   glyph.contentSize.height);
		
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Touch one of the 4 glyphs
		if (CGRectContainsPoint(glyph_rect, location)) {
			
			for (Row *row in self.block_row.array) {		// for each row in the puzzle
				
				if (self.block_row.select) {				// if there is already a matching process going on
					
					if (row.select)	{						// if the row is being matched
						//Block *block = [row.array objectAtIndex:row.next_idx];//self.block_row.next_idx];
						Block *block = [row.array objectAtIndex:self.block_row.next_idx];
						
						//if ([glyph.name isEqualToString:[NSString stringWithFormat:@"big_%@",block.name]]) {
						if ([glyph.name isEqualToString:[NSString stringWithFormat:@"%@Big",block.name]]) {
							//[Block changeToSelectName:block];
							[block changeToSelectName];
							[[SimpleAudioEngine sharedEngine] playEffect:@"crunch.mp3"];
							//self.block_row.next_idx++;
							row.next_idx++;
							reset = FALSE;
							
							//if (row.next_idx == num_of_col) {
							//if (row.next_idx == row.array_cap) {	
							if (self.block_row.next_idx+1 == row.array_cap) {
								reset = TRUE;
								row.next_idx = 0;
								//self.block_row.next_idx = 0;
								need_to_delete = TRUE;
								//row_to_delete = row;
								//[rows_to_delete addObject:row];
								[rows_to_delete addObject:[NSNumber numberWithInt:[self.block_row.array indexOfObject:row]]];
								//[self removeRow:row];
								cur_score = cur_score + ([self.block_row.array indexOfObject:row]+1);
							}
							
						} else {
							
							for (int i = row.next_idx; i != -1; i--) {
								block = [row.array objectAtIndex:i];
								//[Block changeToNotSelectName:block];
								[block changeToNotSelectName];
							}
							row.select = FALSE;
							row.next_idx = 0;
						}
					}
					
				} else if (!selectedOne || multiRowClear) {		// If it didn't select one row
					
					Block *block = [row.array objectAtIndex:0];
					
					//if ([glyph.name isEqualToString:[NSString stringWithFormat:@"big_%@",block.name]]) {
					if ([glyph.name isEqualToString:[NSString stringWithFormat:@"%@Big",block.name]]) {
						selectedOne = TRUE;
						//[Block changeToSelectName:block];
						[block changeToSelectName];
						[[SimpleAudioEngine sharedEngine] playEffect:@"crunch.mp3"];
						//self.block_row.select = TRUE;
						//self.block_row.next_idx++;
						row.select = TRUE;
						row.next_idx++;
						reset = FALSE;
						
						//if (row.next_idx == num_of_col) {
						//if (row.next_idx == row.array_cap) {
						if (self.block_row.next_idx+1 == row.array_cap) {
							reset = TRUE;
							row.next_idx = 0;
							//self.block_row.next_idx = 0;
							need_to_delete = TRUE;
							//row_to_delete = row;
							//[rows_to_delete addObject:row];
							[rows_to_delete addObject:[NSNumber numberWithInt:[self.block_row.array indexOfObject:row]]];
							//[self removeRow:row];
							cur_score = cur_score + ([self.block_row.array indexOfObject:row]+1);
						}
					}
				}
			}
			if (reset) {
				self.block_row.select = FALSE;
				self.block_row.next_idx = 0;
			} else {
				self.block_row.select = TRUE;
				self.block_row.next_idx++;
			}
			if (need_to_delete) [self removeRow:rows_to_delete];
		}
	}
}


-(void) animateBlockFinished:(id)sender data:(Row *)row
{
	//if (row.count+1 == num_of_col) {
	if (row.default_action) {
		
		if (row.count+1 == row.array_cap) {
			[self animateBlock:row];
			row.count = 0;

		} else {
			row.count++;
		}
	}
}

-(void) animateBlock:(Row *)row
{
	NSInteger index = [self.block_row.array indexOfObject:row];
	CGSize win_size = [[CCDirector sharedDirector] winSize];

	if (index > 0) {
		Row *next_row = [self.block_row.array objectAtIndex:index-1];
		Block *next_sprite = [next_row.array objectAtIndex:0];
		Block *this_sprite = [row.array objectAtIndex:0];
		
		if ((this_sprite.position.y - next_sprite.position.y) > block_size) {		//blocks need to catch up
			
			for (Block *block in row.array) {
				id moveRow = [CCMoveTo actionWithDuration:0.05f
												 position:ccp(block.position.x, next_sprite.position.y+block.contentSize.height)];
				//id moveRow = [CCPlace actionWithPosition:ccp(block.position.x, next_sprite.position.y+block.contentSize.height)];
				id moveDone = [CCCallFuncND actionWithTarget:self selector:@selector(animateBlockFinished:data:) data:(Row *)row];
				[block runAction:[CCSequence actions: moveRow, moveDone, nil]];
			}
			
		} else {																	// just following
			
			for (Block *block in row.array) {
				//float time_lapse = speed*(block.position.y/win_size.height);
				id moveRow = [CCMoveTo actionWithDuration:0.0001f
												 position:ccp(block.position.x, next_sprite.position.y+block.contentSize.height)];
				//id moveRow = [CCPlace actionWithPosition:ccp(block.position.x, next_sprite.position.y+block.contentSize.height)];
				//id moveRow = [CCMoveTo actionWithDuration:time_lapse
				//								 position:ccp(block.position.x, block.contentSize.height/2)];
				id moveDone = [CCCallFuncND actionWithTarget:self selector:@selector(animateBlockFinished:data:) data:(Row *)row];
				[block runAction:[CCSequence actions: moveRow, moveDone, nil]];
			}
		}
		
	} else {																		// block closest to the bottom
	
		for (Block *block in row.array) {
			float time_lapse = speed*(block.position.y/win_size.height);
			id moveRow = [CCMoveTo actionWithDuration:time_lapse
											 position:ccp(block.position.x, block.contentSize.height/2)];
			//id moveRow = [CCMoveTo actionWithDuration:time_lapse*(32/win_size.height)
			//								 position:ccp(block.position.x, block.position.y-block.contentSize.height/2)];
			id moveDone = [CCCallFuncND actionWithTarget:self selector:@selector(animateBlockFinished:data:) data:(Row *)row];
			[block runAction:[CCSequence actions: moveRow, moveDone, nil]];
		}
	}
}

-(void) animateRowFinished:(id)sender data:(Row *)row
{
	if (row.count+1 == row.array_cap) {
		row.ignore = FALSE;
		row.count = 0;		
	} else {
		row.count++;
	}
}

-(void) removeRow:(NSMutableArray *)rows
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	BOOL moveFirst = FALSE;
	
	// Remove all the rows
	for (NSNumber *num in rows) {
		Row *row = [self.block_row.array objectAtIndex:[num intValue]];
		if ([num intValue] == 0 && num_of_rows > 0) {
			moveFirst = TRUE;
		} else if ([num intValue]+1 < num_of_rows && ![self inArray:rows match:[num intValue]+1]) {
			Row *prevRow = [self.block_row.array objectAtIndex:[num intValue]+1];
			prevRow.ignore = TRUE;
		}
		for (Block *block in row.array) {
			//------[block cleanUp];
			[self removeChild:block cleanup:YES];
		}
		[row.array removeAllObjects];
	}
	
	int count = 0;
	
	for (NSNumber *num in rows) {
		Row *row = [self.block_row.array objectAtIndex:[num intValue]-count];
		//-------[row cleanUp];
		//[self.block_row.array removeObjectAtIndex:[num intValue]-count];
		[self.block_row.array removeObject:row];
		count++;
		num_of_rows--;
		deleted_rows++;
		
		//NSLog(@"%i",deleted_rows);
		if (deleted_rows%5==0) {
			speed = speed*0.99;
			//NSLog(@"speed = %f",speed);
		}
	}
	
	// Move the blocks
	// Move the first row
	if (moveFirst && num_of_rows!=0) {
		Row *row = [self.block_row.array objectAtIndex:0];
		row.ignore = TRUE;
		for (Block *block in row.array) {
			float time_lapse = speed*(block.position.y/win_size.height);
			id moveRow = [CCMoveTo actionWithDuration:time_lapse
											 position:ccp(block.position.x, block.contentSize.height/2)];
			[block stopAllActions];
			[block runAction:moveRow];
		}
	}
	
	// Move the rest of the rows
	BOOL SkipFirst = FALSE;
	if (!freezeRows) {
		for (Row *row in self.block_row.array) {
			if (row.ignore && SkipFirst) {
				for (Block *block in row.array) {
					Row *gotoRow = [self.block_row.array objectAtIndex:[self.block_row.array indexOfObject:row]-1];
					Block *gotoBlock = [gotoRow.array lastObject];
					id moveRow = [CCMoveTo actionWithDuration:0.5f
													 position:ccp(block.position.x, gotoBlock.position.y+block.contentSize.height)];
					id moveDone = [CCCallFuncND actionWithTarget:self selector:@selector(animateRowFinished:data:) data:(Row *)row];
					[block runAction:[CCSequence actions: moveRow, moveDone, nil]];
				}
			}
			SkipFirst = TRUE;
		}
	}
	
	// Checking if user unlocked new level
	if (deleted_rows >= init_rows) {
		//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
		NSLog(@"%i, %i",delegate.highestLevel,delegate.curLevelIndex+1);
		if (delegate.highestLevel == delegate.curLevelIndex+1) {
			delegate.highestLevel++;
			NSLog(@"added some shit");
		}
	}
	
	[score_label setString:[NSString stringWithFormat:@"%03d",cur_score]];	
}

-(void) addRow
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	//Row *row_blocks = [[Row alloc] init];
	//[Row setup:row_blocks array_cap:num_of_col level:levelNum];
	//Row *row_blocks = [[[Row alloc] initWith:num_of_col level:levelNum] autorelease];
	Row *row_blocks = [[Row alloc] initWith:num_of_col level:levelNum];
	
	int row_pos = win_size.width/2 - (num_of_col-1)*(block_size/2);
		
	for (int i = 0; i < num_of_col; i++) {
		NSString *name = [self.glyphs objectAtIndex:arc4random()%dif];
		//Block *sprite = [Block spriteWithFile:[NSString stringWithFormat:@"%@.png",name]];
		//Block *sprite = [Block spriteWithFile:[NSString stringWithFormat:@"%@.tif",name]];
		//[Block setName:sprite name:name];
		//Block *sprite = [[[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@",name]] autorelease];
		Block *sprite = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"%@",name]];
		//Block *sprite = [[Block alloc] initWithBlock:[NSString stringWithFormat:@"1%@",name] 
		//									 clicked:[listOfTex objectForKey:[NSString stringWithFormat:@"%@Br",name]] 
		//								 not_clicked:[listOfTex objectForKey:name]];
		sprite.position = ccp(row_pos, win_size.height+sprite.contentSize.height/2);
		
		if (num_of_rows == 0) {
			float time_lapse = speed*(win_size.height+sprite.contentSize.height/2/win_size.height);
			[sprite runAction: [CCMoveTo actionWithDuration:time_lapse position:ccp(row_pos, sprite.contentSize.height/2)]];
		}
		
		row_pos = row_pos+block_size;
		[row_blocks.array addObject:sprite];
		[self addChild:sprite z:100];
		[sprite release];
	}
	[self.block_row.array addObject:row_blocks];
	num_of_rows++;
	added_rows++;
	/*
	if (added_rows == init_rows) {
		Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		delegate.curLevelIndex++;
		speed = delegate.curLevel.dropRate;
		num_of_col = delegate.curLevel.num_of_cols;
		init_rows = delegate.curLevel.init_rows + init_rows;
		dif = delegate.curLevel.dif;
		levelNum = delegate.curLevel.levelNum;
		if (delegate.highestLevel = delegate.curLevelIndex) {
			delegate.highestLevel++;
		}
	}
	 */
	[row_blocks release];
}

-(void) changeSpeed 
{
	CGSize win_size = [[CCDirector sharedDirector] winSize];
	if (num_of_rows > 0) {
		Row *row = [self.block_row.array objectAtIndex:0];
		for (Block *block in row.array) {
			[block stopAllActions];
			[block runAction:[CCMoveTo actionWithDuration:speed*(block.position.y/win_size.height) 
												 position:ccp(block.position.x, block.contentSize.height/2)]];
		}
	}
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if ( (self=[super init]) ) 
	{
		CGSize win_size = [[CCDirector sharedDirector] winSize];
		
		//[self createSpace];
		//[self createGround];
		//[self schedule:@selector(updateA:)];
		//mouse = cpMouseNew(space);
		
		//num_of_col = 2;				// number of blocks a row
		//speed = 10;					// speed of the decending blocks
		//[self setup];
		//init_rows = 20;
		added_rows = 0;
		//max_num_of_rows = 6;		// number of rows in a game
		//block_size = 32;

		score_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%03d", cur_score]
										 fontName:@"Helvetica"
										 fontSize:32];
		score_label.position = ccp(score_label.contentSize.width/2, win_size.height-score_label.contentSize.height/2);
		[self addChild:score_label z:200];
		
		pause_but = [CCSprite spriteWithFile:@"pause_but.png"];
		pause_but.position = ccp(win_size.width-pause_but.contentSize.width, win_size.height-pause_but.contentSize.height);
        //[self addChild:pause_but z:1050];
		
		three = [CCLabelTTF labelWithString:@"3" fontName:@"Arial" fontSize:30];
		two = [CCLabelTTF labelWithString:@"2" fontName:@"Arial" fontSize:30];
		one = [CCLabelTTF labelWithString:@"1" fontName:@"Arial" fontSize:30];
		three.position = ccp(win_size.width/2, win_size.height+three.contentSize.height/2);
		two.position = three.position;
		one.position = three.position;
		
		[self addChild:three z:2000];
		[self addChild:two z:2000];
		[self addChild:one z:2000];
		
		//[self addChild:pauseMenu z:1000];
		//[self schedule:@selector(update:)];
		//[self schedule:@selector(updateBlocks:)];
		//[self schedule:@selector(updateSpace:)];
	}
	return self;
}

-(void) leftCountDown:(ccTime)dt
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	if (leftCount == 0) {
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"multiClear"])
			multiRowClear = FALSE;
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"iceAge"])
			freezeRows = FALSE;
		if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"matrix"]){
			speed = speed/2;//matrix = FALSE
			[self changeSpeed];
		}
		[self unschedule:@selector(leftCountDown:)];
	}
	leftCount--;
}

-(void) rightCountDown:(ccTime)dt
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	if (rightCount == 0) {
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"multiClear"])
			multiRowClear = FALSE;
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"iceAge"])
			freezeRows = FALSE;
		if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"matrix"]){
			speed = speed/2;//matrix = FALSE
			[self changeSpeed];
		}
		[self unschedule:@selector(rightCountDown:)];
	}
	rightCount--;
}

-(void)useLeftItem:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"multiClear"]) {
		multiRowClear = TRUE;
		[self schedule:@selector(leftCountDown:) interval:10];
	}
	if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"iceAge"]) {
		freezeRows = TRUE;
		[self schedule:@selector(leftCountDown:) interval:1];
	}
	if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"lawnMower"]) {
		lawnMower = TRUE;
	}
	if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"hugeGrenade"]) {
		hugeGrenade = TRUE;
	}
	if ([[delegate.chosenItem objectAtIndex:0] isEqual:@"matrix"]) {
		speed = speed*2;//matrix = TRUE;
		[self changeSpeed];
		[self schedule:@selector(leftCountDown:) interval:3];
	}
	leftCount = 1;
	
}

-(void)useRightItem:(id)sender
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"multiClear"]) {
		multiRowClear = TRUE;
		[self schedule:@selector(rightCountDown:) interval:1];
	}
	if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"iceAge"]) {
		freezeRows = TRUE;
		[self schedule:@selector(rightCountDown:) interval:1];
	}
	if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"lawnMower"]) {
		lawnMower = TRUE;
	}
	if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"hugeGrenade"]) {
		hugeGrenade = TRUE;
	}
	if ([[delegate.chosenItem objectAtIndex:1] isEqual:@"matrix"]) {
		speed = speed*2;
		[self changeSpeed];
		[self schedule:@selector(rightCountDown:) interval:3];
	}
	rightCount = 1;
}

-(void)pauseOpt//:(id)sender
{
	self.isTouchEnabled = NO;
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	[delegate pausing];
    

    //[[CCDirector sharedDirector] pause];
}

-(void)pauseGame
{
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
	//[delegate pausing];
    [[CCDirector sharedDirector] pause];
    
	/*
	 pause = [PauseLayer node];
	[self addChild:pause z:1000];
	[[CCDirector sharedDirector] pause];
	NSLog(@"--------added pause");
	 */
}

-(void)resumeGame
{
	//[self removeChild:pause cleanup:YES];
	self.isTouchEnabled = YES;
	//[[CCDirector sharedDirector] resume];
}

-(void)restartGame
{
	//[self resetGame];
	//[self removeChild:gameOver cleanup:YES];
	//[self removeChild:pause cleanup:YES];
	//Glyph_RunnerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate restartGame];
}

-(void)goToMainMenu
{
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [self stopAllActions];
    self.isTouchEnabled = YES;
    [[CCDirector sharedDirector] replaceScene:delegate.mainScene];
}

// on "dealloc" you need to release all your retained objects
-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	[_block_row release];
	[_glyphs release];
	[_glyph_con release];
	
	[bigGlyph1 release];
	[bigGlyph2 release];
	[bigGlyph3 release];
	[bigGlyph4 release];
	//[physicsSprite release];
	
	//[player release];
	
	//cpMouseDestroy(mouse);
	//cpMouseFree(mouse);

	cpShapeDestroy(groundShape);
	cpShapeFree(groundShape);
	cpBodyDestroy(groundBody);
	cpBodyFree(groundBody);
	//cpSpaceFreeChildren(space);
	cpSpaceDestroy(space);
    cpSpaceFree(space);
	 
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
