//
//  VictoryLayer.m
//  Gorilla Game
//
//  Created by Danny Laporte on 7/11/14.
//
//

#import "VictoryLayer.h"
#import "GameLayer.h"
#import "GameData.h"
#import "Store.h"
#import "Levelselect.h"

@implementation VictoryLayer

-(id) init
{
	if ((self = [super init]))
    {
        winSize = [CCDirector sharedDirector].winSize;
        
        int currentLevel = [GameData sharedData].currentLevelSelected;
        
        CCSprite *background = [CCSprite spriteWithFile:@"victory-screen-ip5.png"];
        background.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild:background z:-1];
        
        CCMenuItemImage *continueButton = [CCMenuItemImage itemWithNormalImage:@"continue-button-n.png"
                                                         selectedImage: @"continue-button-d.png"
                                                                target:self
                                                              selector:@selector(nextLevel:)];
        continueButton.position = CGPointMake(0, (winSize.height * .3));
        continueButton.scale = 0.5f;
        
        CCMenuItemImage *levelSelectButton = [CCMenuItemImage itemWithNormalImage:@"select-button-n.png"
                                                                 selectedImage: @"select-button-d.png"
                                                                        target:self
                                                                      selector:@selector(levelSelct:)];
        levelSelectButton.position = CGPointMake((-winSize.width * .15), (winSize.height * .3));
        levelSelectButton.scale = 0.5f;
        
        CCMenu *victoryMenu = [CCMenu menuWithItems:continueButton, /*shopButton, levelSelectButton,*/ nil];
        victoryMenu.position = ccp(winSize.width/2, 0);
        [self addChild: victoryMenu z:1];
        
        NSNumber* NSHighestLevelUnlocked = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestLevelUnlocked"];
        int highestLevelUnlocked = [NSHighestLevelUnlocked intValue];
        
        highestLevelUnlocked = 15;

        
        if(highestLevelUnlocked == 15)
        {
            CCLabelTTF* NiggaWe = [CCLabelTTF labelWithString:@"Congrats! You beat the game you fiend." fontName:@"BenguiatItcTEE-Book" fontSize:20];
            NiggaWe.position = CGPointMake(winSize.width * .5, winSize.height * .85);
            NiggaWe.color = ccBLACK;
            [self addChild:NiggaWe];
            
            CCLabelTTF* MadeIt = [CCLabelTTF labelWithString:@"Watch out for the next 15 levels dropping soon!" fontName:@"BenguiatItcTEE-Book" fontSize:20];
            MadeIt.position = CGPointMake(winSize.width * .5, winSize.height * .75);
            MadeIt.color = ccBLACK;
            [self addChild:MadeIt];
        }
        
        else
        {
            CCLabelTTF* coinsWonLabel = [CCLabelTTF labelWithString:@" " fontName:@"BenguiatItcTEE-Book" fontSize:35];
            [coinsWonLabel setString:[NSString stringWithFormat:@"coins won: %d", [GameData sharedData].coinsGained]];
            coinsWonLabel.position = CGPointMake(winSize.width * .5, winSize.height * .75);
            coinsWonLabel.color = ccBLACK;
            [self addChild:coinsWonLabel];
        }
        
    }
    return self;
}

-(void) nextLevel: (CCMenuItem *)continueButton
{
    [GameData sharedData].currentLevelSelected++;
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Store alloc] init]];
}

-(void) shop: (CCMenuItem *)shopButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Store alloc] init]];
}

-(void) levelSelct: (CCMenuItem *)levelSelectButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Levelselect alloc] init]];
}

@end
