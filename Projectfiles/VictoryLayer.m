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
        
        CCSprite *background = [CCSprite spriteWithFile:@"victory-screen.png"];
        [self addChild:background z:-1];
        background.position = CGPointMake(winSize.width/2, winSize.height/2);
        
        CCMenuItemImage *continueButton = [CCMenuItemImage itemWithNormalImage:@"continue-button-n.png"
                                                         selectedImage: @"continue-button-d.png"
                                                                target:self
                                                              selector:@selector(nextLevel:)];
        continueButton.position = CGPointMake((winSize.width * .25), (winSize.height * .6));
        continueButton.scale = 0.5f;
        
        
        CCMenuItemImage *shopButton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                          selectedImage: @"shop-button-d.png"
                                                                 target:self
                                                               selector:@selector(shop:)];
        shopButton.position = CGPointMake(0, (winSize.height * .6));
        shopButton.scale = 0.5f;
        
        
        CCMenuItemImage *levelSelectButton = [CCMenuItemImage itemWithNormalImage:@"select-button-n.png"
                                                                 selectedImage: @"select-button-d.png"
                                                                        target:self
                                                                      selector:@selector(levelSelct:)];
        levelSelectButton.position = CGPointMake((-winSize.width * .25), (winSize.height * .6));
        levelSelectButton.scale = 0.5f;
        
        CCMenu *victoryMenu = [CCMenu menuWithItems:continueButton, shopButton, levelSelectButton, nil];
        [self addChild: victoryMenu z:1];
        
    }
    return self;
}

-(void) nextLevel: (CCMenuItem *)continueButton
{
    [GameData sharedData].currentLevelSelected++;
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    NSLog(@"hit continue button");
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
