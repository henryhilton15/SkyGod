//
//  MainMenuLayer.m
//  Gorilla
//
//  Created by maria hilton on 7/5/13.
//
//


#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "Store.h"
#import "Levelselect.h"
#import "SimpleAudioEngine.h"
#import "GameData.h"


@implementation MainMenuLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true || [[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeMusic"] boolValue] == false)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Undaunted.wav"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Undaunted.wav" loop:YES];
            }
        }
        
        CCSprite *background = [CCSprite spriteWithFile:@"main-menu.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
        
        CCSprite *titleImage = [CCSprite spriteWithFile: @"game-logo.png"];
        titleImage.position = ccp(110,110);
        titleImage.scale=.25;
        [self addChild:titleImage z:4];
        
        CCMenuItemImage *startButton = [CCMenuItemImage itemWithNormalImage:@"start-button-n.png"
                                                              selectedImage: @"start-button-d.png"
                                                                     target:self
                                                                   selector:@selector(startGame:)];
        startButton.scale=0.8;
        startButton.position = CGPointMake(-122.5, 150);
        
        
        
        
    
        
        
//        CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"button.png" selectedImage:@"button.png"
//                                                                target:self
//                                                              selector:@selector(startGame:)];
//        startButton.position = CGPointMake(0, -65);

        
        
        
        
        
        
        
        
        
        
        CCMenuItemImage *StoreButton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                                selectedImage: @"shop-button-d.png"
                                                                 target:self
                                                                   selector:@selector(enterStore:)];
        StoreButton.scale=0.55;
        StoreButton.position = CGPointMake(0, 150);
        
       
        CCMenuItemImage *LevelButton = [CCMenuItemImage itemWithNormalImage:@"select-button-n.png"
                                                              selectedImage: @"select-button-d.png"
                                                                     target:self
                                                                   selector:@selector(selectLevel:)];
        LevelButton.scale=0.3;
        LevelButton.position = CGPointMake(-1000,-1000);
        
        
        
//        CCMenuItemImage *moreGamesButton = [CCMenuItemImage itemWithNormalImage:@"star.png" selectedImage:@"star.png" target:self selector:@selector(moreGames:)];
//        moreGamesButton.scale = 0.4;
//        moreGamesButton.position = CGPointMake(125, -75);
//        
//         CCMenuItemImage *aboutButton = [CCMenuItemImage itemWithNormalImage:@"superhero.png" selectedImage:@"superhero.png" target:self selector:@selector(about:)];
//        aboutButton.scale = 0.4;
//        aboutButton.position = CGPointMake(-125, -75);
        

        
        myMenu = [CCMenu menuWithItems:StoreButton, startButton, LevelButton, nil];
        [self addChild:myMenu z:2];
        
        [self scheduleUpdate];

    }
    return self;
}

//-(void) update:(ccTime)delta
//{
//    if([GameData sharedData].musicPlaying == NO)
//    {
//        [[SimpleAudioEngine sharedEngine] playEffect:@"Undaunted.wav"];
//        [GameData sharedData].musicPlaying = YES;
//    }
//}

-(void) startGame: (CCMenuItem *)menuItem
{
    
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Levelselect alloc] init]];
}

-(void) enterStore: (CCMenuItemImage *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Store alloc] init]];
}
-(void) selectLevel: (CCMenuItemImage *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Levelselect alloc] init]];
}

-(void) moreGames: (CCMenuItem *)menuItem
{
    [MGWU displayCrossPromo];
}

-(void) about: (CCMenuItem *)menuItem
{
    [MGWU displayAboutPage];
}
@end



