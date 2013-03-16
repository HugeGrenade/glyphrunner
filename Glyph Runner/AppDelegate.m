//
//  AppDelegate.mm
//  Glyph Runner
//
//  Created by jasonvan on 2013-03-08.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "IntroLayer.h"

#import "GameConfig.h"
#import "HelloWorldScene.h"
#import "RootViewController.h"

@implementation AppController

//@synthesize window;
@synthesize curLevelIndex = _curLevelIndex;
@synthesize mainScene = _mainScene;
@synthesize gameScene = _gameScene;
@synthesize gameOverScene = _gameOverScene;
//@synthesize newLevelScene = _newLevelScene;
@synthesize levelScene = _levelScene;
@synthesize armouryScene = _armouryScene;
@synthesize levels = _levels;
@synthesize highestLevel = highestLevel;
//@synthesize soundLay = soundLay;
@synthesize chosenItem = chosenItem;
@synthesize pauseLay = pauseLay;
@synthesize gameOverLay = gameOverLay;



@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	// Multiple Touches enabled
	[glView setMultipleTouchEnabled:YES];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:YES];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
	// for rotation and other messages
	[director_ setDelegate:self];
	
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	//[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [IntroLayer scene]]; 
	
	
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Loading game
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSMutableData *gameData;
	NSKeyedUnarchiver *decoder;
	
	NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:@"saveFile.dat"];
	gameData = [NSData dataWithContentsOfFile:documentPath];
	
	if (gameData) {
		decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:gameData];
		
		// Set the local instance of my object to the object held in saveFile with the key of my object
		self.highestLevel = [decoder decodeIntForKey:@"highestLevel"];
		
		[decoder release];
	} else {
		self.highestLevel = 1;
	}
    self.highestLevel = 4;
	
	[[CCTextureCache sharedTextureCache] addImage:@"1one.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1two.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1three.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1four.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1oneBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1twoBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1threeBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1fourBroken.tif"];
	
	[[CCTextureCache sharedTextureCache] addImage:@"1oneBig.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1twoBig.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1threeBig.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1fourBig.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1oneBigBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1twoBigBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1threeBigBroken.tif"];
	[[CCTextureCache sharedTextureCache] addImage:@"1fourBigBroken.tif"];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Chosen Item
	chosenItem = [[NSMutableArray alloc] init];
	[chosenItem addObject:[NSNull null]];
	[chosenItem addObject:[NSNull null]];
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Preload music and sound effects
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"crunch.mp3"];
	[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg.mp3"];
	//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Lighters.mp3" loop:YES];
	NSLog(@"FINISHED PRELOADING SOUND");
	
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Load levels
    self.levels = [[[NSMutableArray alloc] init] autorelease];
    PrepLevel *level1 = [[[PrepLevel alloc] initWithLevelNum:1 dropRate:2.0 num_of_cols:1 init_rows:3 dif:1 imagePack:@"1"] autorelease];
    PrepLevel *level2 = [[[PrepLevel alloc] initWithLevelNum:2 dropRate:10.0 num_of_cols:4 init_rows:3 dif:2 imagePack:@"1"] autorelease];
	PrepLevel *level3 = [[[PrepLevel alloc] initWithLevelNum:3 dropRate:10.0 num_of_cols:5 init_rows:1 dif:3 imagePack:@"1"] autorelease];
	PrepLevel *level4 = [[[PrepLevel alloc] initWithLevelNum:4 dropRate:10.0 num_of_cols:6 init_rows:1 dif:4 imagePack:@"1"] autorelease];
    PrepLevel *level5 = [[[PrepLevel alloc] initWithLevelNum:5 dropRate:10.0 num_of_cols:7 init_rows:1 dif:2 imagePack:@"1"] autorelease];
	
    [_levels addObject:level1];
    [_levels addObject:level2];
	[_levels addObject:level3];
	[_levels addObject:level4];
    [_levels addObject:level5];
	
    //self.curLevelIndex = 0;
    cpInitChipmunk();
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Load scenes and layers
    self.mainScene = [MainMenuScene node];
	self.levelScene = [LevelScene node];
	self.armouryScene = [ArmouryScene node];
	self.gameScene = [GameScene scene];
	
    //self.newLevelScene = [NewLevelScene node];
	//self.gameOverScene = [GameOverLayer node];
	
	//self.soundLay = [SoundLayer node];
	self.pauseLay = [PauseLayer node];
	self.gameOverLay = [GameOverLayer node];
	
	//self.highestLevel = 1;
    
    [_gameScene.layer resetGame];
	[[CCDirector sharedDirector] setDepthTest: NO];
	[[CCDirector sharedDirector] setProjection:kCCDirectorProjection2D];
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene:self.mainScene];
    [_mainScene.layer refreshLocks];
	//[self enterMainScene];
	
	//[GameState loadState];

	
	return YES;
}

- (PrepLevel *)curLevel {
    return [_levels objectAtIndex:_curLevelIndex];
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)loadNewLevelScene {
    [_newLevelScene.layer reset];
    [[CCDirector sharedDirector] replaceScene:_newLevelScene];
}

- (void)nextLevel {
	// [_gameScene.layer resetGame];
	//_curLevelIndex++;
    //[[CCDirector sharedDirector] replaceScene:_gameScene];
    [[CCDirector sharedDirector] pushScene:_gameScene];
	//[[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

- (void)restartGame {
    //_curLevelIndex = 0;
	//[self nextLevel];
	//[_gameScene.layer.gameOver removeAllChildrenWithCleanup:YES];
	[_gameScene removeChild:self.gameOverLay cleanup:NO];
	[_gameScene removeChild:self.pauseLay cleanup:NO];
	[_gameScene.layer resetGame];
	NSLog(@"Removed Pause");
	NSLog(@"Removed GameOver");
}

- (void)levelComplete {
    
    _curLevelIndex++;
    if (_curLevelIndex >= [_levels count]) {
        _curLevelIndex = 0;
        //[self loadWinScene];
    } else {
        [self loadNewLevelScene];
    }
}

- (void)loadGameOverLayer
{
	[_gameScene addChild:self.gameOverLay];
	NSLog(@"Added GameOver");
}

- (void)pausing
{
	[[CCDirector sharedDirector] pause];
    
    [_gameScene addChild:self.pauseLay];
	NSLog(@"Added Pause");
	//[_gameScene.layer pauseGame];
	//[_gameScene.layer addChild:self.soundLay z:100000];
}

- (void)resuming
{
    [[CCDirector sharedDirector] resume];
    
	[_gameScene removeChild:self.pauseLay cleanup:YES];
    [_gameScene.layer resumeGame];
	//[_gameScene removeChild:self.soundLay cleanup:YES];
    [[CCDirector sharedDirector] replaceScene:self.armouryScene];
	NSLog(@"Removed Pause");
	//NSLog(@"Removed Sound");
}

- (void)restarting
{
	//[_gameScene removeChild:self.soundLay cleanup:YES];
	[_gameScene removeChild:self.pauseLay cleanup:NO];
	[_gameScene removeChild:self.gameOverLay cleanup:NO];
	[_gameScene.layer restartGame];
	NSLog(@"Removed Pause");
	//NSLog(@"Removed Sound");
	NSLog(@"Removed GameOver");
}

- (void)enterMainScene
{
	//[_gameScene removeChild:self.soundLay cleanup:YES];
	//[_mainScene addChild:self.soundLay z:100000];
	[_mainScene.layer refreshLocks];
    [[CCDirector sharedDirector] popScene];//:self.mainScene];//replaceScene:self.mainScene];
}

- (void)enterMainSceneFromGameOver
{
    [_mainScene.layer refreshLocks];
    [_gameScene removeChild:self.gameOverLay cleanup:NO];
    [[CCDirector sharedDirector] popScene];
}

- (void)exitMainScene
{
	//[_mainScene removeChild:self.soundLay cleanup:YES];
}

- (void) updateChosenItem:(int)leftRight item:(NSObject *)item
{
	NSLog(@"UPDATING CHOSEN ITEM");
	[chosenItem replaceObjectAtIndex:leftRight withObject:item];
	NSLog(@"UPDATED CHOSEN ITEM");
}

-(void) toggleSoundEffect:(id)sender
{
	if ([SimpleAudioEngine sharedEngine].effectsVolume)
		[SimpleAudioEngine sharedEngine].effectsVolume = 0;
	else
		[SimpleAudioEngine sharedEngine].effectsVolume = 1;
}

-(void) toggleBackgroundMusic:(id)sender
{
	if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
		[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	else
		[[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

- (void)dealloc {
	self.gameScene = nil;
    
    [window_ release];
	[navController_ release];
    
    //self.gameOverScene = nil;
	[[CCDirector sharedDirector] end];
	[[CCDirector sharedDirector] release];
	[SimpleAudioEngine end];
	
	[_mainScene release];
	[_gameScene release];
	[_levelScene release];
	[_armouryScene release];
	[chosenItem release];
	[pauseLay release];
	[gameOverLay release];
	
	[super dealloc];
}

@end
