//
//  GameScene.h
//  Glyph_Runner
//
//  Created by jasonvan on 11-04-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "import.h"
//#import "cpMouse.h"

@class BlockArea;
@class Block;
@class Row;
@class Player;
@class PauseLayer;
@class GameOverLayer;

@interface Game : CCLayer 
{
	BlockArea *_block_row;
	NSMutableArray *_glyphs;
	NSMutableArray *_glyph_con;
	CCLabelTTF *label;
	CCLabelTTF *label2;

	int max_num_of_rows;
	int num_of_col;
	float speed;
	int init_rows;
	int added_rows;
	int levelNum;

	int block_size;
	int num_of_rows;
	
	int deleted_rows;
	
	Player *player;
	PauseLayer *pause;
	CCSprite *pause_but;
	CCLabelTTF *score_label;
	int cur_score;
//	GameOverLayer *gameOver;
	
	NSString *imgPack;
	int dif;
	
	Block *bigGlyph1;
	Block *bigGlyph2;
	Block *bigGlyph3;
	Block *bigGlyph4;
	
	NSString *curImagePack;
	BOOL multiRowClear;
	BOOL freezeRows;
	BOOL lawnMower;
	BOOL hugeGrenade;
	BOOL matrix;
	
	int leftCount;
	int rightCount;
	
	cpSpace *space;
	//cpMouse *mouse;
	cpBody *groundBody;
	cpShape *groundShape;
	
	NSMutableArray *physicsSprite;
	
	CCSprite *front_spikes1;
	CCSprite *front_spikes2;
	BOOL moveSpike1;
	BOOL moveSpike2;
	
	CCMenuItemImage *leftItem, *rightItem;
	CCMenu *items;
	
	CCLabelTTF *three;
	CCLabelTTF *two;
	CCLabelTTF *one;
	
}

@property (nonatomic, retain) BlockArea *block_row;
@property (nonatomic, retain) NSMutableArray *glyphs;
@property (nonatomic, retain) NSMutableArray *glyph_con;
//@property (nonatomic, retain) GameOverLayer *gameOver;
//@property (nonatomic, assign) int cur_score;


//+(id) scene;
-(void) addRow;
-(void) removeRow:(NSMutableArray *)rows;
-(void) animateBlock:(Row *)row;
-(void) animateBlockFinished:(id)sender data:(Row *)row;
-(void) resetGame;
-(void) pauseGame;
-(void) resumeGame;
-(void) restartGame;
-(void) pauseOpt;
-(void) showGameOver:(id)sender;
-(void)goToMainMenu;
//-(void) begin:(id)sender;

@end

@interface GameScene : CCScene {
	Game *_layer;
}

@property (nonatomic, retain) Game *layer;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end

