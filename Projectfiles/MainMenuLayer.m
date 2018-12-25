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
#import "AboutLayer.h"


@implementation MainMenuLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        [[CCDirector sharedDirector] setDisplayStats:NO];
        winSize = [CCDirector sharedDirector].winSize;

        
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true || [[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeMusic"] boolValue] == false)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Undaunted.mp3"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Undaunted.mp3" loop:YES];
            }
        }
        
        [MGWU setReminderMessage:@"The devils are invading! We need your help!"];
        
        int width = winSize.width;
        
        if(width == 568)
        {
            CCSprite *background = [CCSprite spriteWithFile:@"main-menu-ip5.png"];
            background.position = CGPointMake(winSize.width/2,winSize.height/2);
            [self addChild:background z:-1];
        }
        
        
        if(width == 480)
        {
            CCSprite *background = [CCSprite spriteWithFile:@"main-menu-hd.png"];
            background.position = CGPointMake(winSize.width/2,winSize.height/2);
            [self addChild:background z:-1];
        }

        
        CCSprite *titleImage = [CCSprite spriteWithFile: @"game-logo.png"];
        titleImage.position = ccp(winSize.width *.25,winSize.height * .35);
        titleImage.scale=.25;
        [self addChild:titleImage z:4];
        
        
        CCMenuItemImage *startButton = [CCMenuItemImage itemWithNormalImage:@"start-button-n.png"
                                                              selectedImage: @"start-button-d.png"
                                                                     target:self
                                                                   selector:@selector(startGame:)];
        startButton.scale=0.8;
        startButton.position = CGPointMake(-winSize.width/4.2,winSize.height/8);
        
        
        
        
    
        
        
//        CCMenuItem *startButton = [CCMenuItemImage itemWithNormalImage:@"button.png" selectedImage:@"button.png"
//                                                                target:self
//                                                              selector:@selector(startGame:)];
//        startButton.position = CGPointMake(0, -65);

        
        
        
        
        
        
        
        
        
        
        CCMenuItemImage *StoreButton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                                selectedImage: @"shop-button-d.png"
                                                                 target:self
                                                                   selector:@selector(enterStore:)];
        StoreButton.scale=0.55;
        StoreButton.position = CGPointMake(-winSize.width/30, winSize.height/8);
        
       

        
        
        
//        CCMenuItemImage *moreGamesButton = [CCMenuItemImage itemWithNormalImage:@"star.png" selectedImage:@"star.png" target:self selector:@selector(moreGames:)];
//        moreGamesButton.scale = 0.4;
//        moreGamesButton.position = CGPointMake(125, -75);
//        
//         CCMenuItemImage *aboutButton = [CCMenuItemImage itemWithNormalImage:@"superhero.png" selectedImage:@"superhero.png" target:self selector:@selector(about:)];
//        aboutButton.scale = 0.4;
//        aboutButton.position = CGPointMake(-125, -75);
        

        
        myMenu = [CCMenu menuWithItems:StoreButton, startButton, nil];
        myMenu.position = ccp(winSize.width/2,0);
        [self addChild:myMenu z:2];
        
        CCMenuItemImage *DevButton = [CCMenuItemImage itemWithNormalImage:@"devButton.png"
                                                              selectedImage: @"devButton.png"
                                                                     target:self
                                                                   selector:@selector(aboutLayer:)];
        DevButton.scale=.8;
        DevButton.position = CGPointMake(winSize.width - 50, 30);
        
        myMenu1 = [CCMenu menuWithItems:DevButton, nil];
        myMenu1.position = ccp(0,0);
        [self addChild:myMenu1 z:2];
        
        
        
        
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
-(void) aboutLayer: (CCMenuItemImage *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[AboutLayer alloc] init]];
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



