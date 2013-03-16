//
//  AppDelegate.h
//  Glyph Runner
//
//  Created by jasonvan on 2013-03-08.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

/*
#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
*/

#import <UIKit/UIKit.h>
#import "import.h"

@class RootViewController;
@class GameScene;
@class NewLevelScene;
@class PrepLevel;
@class GameOverLayer;
@class LevelScene;
@class ArmouryScene;
@class MainMenuScene;
@class SoundLayer;
@class PauseLayer;

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
    UIWindow *window_;
    UINavigationController *navController_;
    CCDirectorIOS	*director_;							// weak ref

    //UIWindow			*window;
	//RootViewController	*viewController;
	NSMutableArray *_levels;
    //GameOverScene *_gameOverScene;
	
	GameScene *_gameScene;
	GameOverLayer *_gameOverScene;
    NewLevelScene *_newLevelScene;
	LevelScene *_levelScene;
	ArmouryScene *_armouryScene;
	MainMenuScene *_mainScene;
	
	int highestLevel;
	//SoundLayer *soundLay;
	NSMutableArray *chosenItem;
	
	PauseLayer *pauseLay;
	GameOverLayer *gameOverLay;
	
	//int _curLevelIndex;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

//@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, assign) int curLevelIndex;
@property (nonatomic, retain) NSMutableArray *levels;
@property (nonatomic, retain) MainMenuScene *mainScene;
@property (nonatomic, retain) GameScene *gameScene;
//@property (nonatomic, retain) GameOverScene *gameOverScene;
@property (nonatomic, retain) GameOverLayer *gameOverScene;
//@property (nonatomic, retain) NewLevelScene *newLevelScene;
@property (nonatomic, retain) LevelScene *levelScene;
@property (nonatomic, retain) ArmouryScene *armouryScene;
@property (nonatomic, assign) int highestLevel;
//@property (nonatomic, retain) SoundLayer *soundLay;
@property (nonatomic, retain) NSMutableArray *chosenItem;
@property (nonatomic, retain) PauseLayer *pauseLay;
@property (nonatomic, retain) GameOverLayer *gameOverLay;
- (PrepLevel *)curLevel;
- (void)nextLevel;
- (void)levelComplete;
- (void)restartGame;
- (void)loadNewLevelScene;
//- (void)loadGameOverScene;
//- (void)loadWinScene;
- (void)pausing;
- (void)resuming;
- (void)restarting;

- (void)enterMainScene;
- (void)exitMainScene;
- (void)loadGameOverLayer;
- (void)enterMainSceneFromGameOver;

- (void) updateChosenItem:(int)leftRight item:(NSObject *)item;

@end