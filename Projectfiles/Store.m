//
//  Store.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/17/13.
//
//

#import "Store.h"
#import "MainMenuLayer.h"
#import "Character.h"

@implementation Store
 -(id)init
{
    
if ((self = [super init]))
        {
            CCMenuItemImage *BuyButton1 = [CCMenuItemImage itemWithNormalImage:@"upgrades-button.png" selectedImage:@"upgrades-button.png"];
            BuyButton1.position= CGPointMake (100, 300);
            BuyButton1.scale = 0.1f;
            [self addChild:BuyButton1 z:50];
            BuyButton1.color = ccBLUE;
            
            
            
            //CCMenu *myMenu = [CCMenu menuWithItems:BuyButton, nil];
            //[self addChild:myMenu];
            
            CCSprite *background = [CCSprite spriteWithFile:@"background_grass-top.png"];
            background.position = CGPointMake(240,160);
            [self addChild:background z:-1];
            
            StoreLabel = [CCLabelTTF labelWithString:@"Store" fontName:@"Marker Felt" fontSize:40];
            StoreLabel.position = ccp(240,240);
            StoreLabel.color = ccBLUE;
            [self addChild:StoreLabel z:4];

            CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"button_backbutton.png"
                                                                     selectedImage: @"button_backbutton.png"
                                                                            target:self
                                                                          selector:@selector(mainMenu:)];
            mainMenuButton.position = CGPointMake(100, 0);
            mainMenuButton.scale = 0.5f;
          
            CCMenuItemImage *goodGuyButton = [CCMenuItemImage itemWithNormalImage:@"cat4.png" selectedImage:@"cat4.png" target:self selector:@selector(upgradeGoodGuy:)];
            
            CCMenu* storeMenu = [CCMenu menuWithItems:mainMenuButton, goodGuyButton, nil ];
            [self addChild:storeMenu];
            
        }
            
        
    return self;
            
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

- (void) upgradeGoodGuy: (CCMenuItemImage *) goodGuyButton
{
    NSNumber *currentGoodGuyRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGoodGuyRank"];
    
    {
        int rank = [currentGoodGuyRank intValue];
        rank++;
        NSNumber *newGoodGuyRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newGoodGuyRank forKey: @"currentGoodGuyRank"];
        if ([newGoodGuyRank intValue] == 1)
        {
            goodGuyButton.color = ccBLUE;
        }
        if ([newGoodGuyRank intValue] == 2)
        {
            goodGuyButton.color = ccRED;
        }
    }
}

@end
