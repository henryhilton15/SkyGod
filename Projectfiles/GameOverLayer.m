//
//  GameOverLayer.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/3/13.
//
//
#import "GameOverLayer.h"
#import "MainMenuLayer.h"
#import "GameLayer.h"

@implementation GameOverLayer

-(id) init
{
    if ((self = [super init]))
	{
        CCMenuItemImage *restartButton = [CCMenuItemImage itemWithNormalImage:@"restart.png"
                                                                selectedImage: @"restart.png"
                                                                       target:self
                                                                     selector:@selector(restartGame:)];
        restartButton.position = CGPointMake(100,0);
        
        //startButton.tag = 1;
        
        CCMenuItemImage *endbutton = [CCMenuItemImage itemWithNormalImage:@"button_backbutton.png"
                                                            selectedImage: @"button_backbutton.png"
                                                                   target:self
                                                                 selector:@selector(endGame:)];
        endbutton.position = CGPointMake(-100, 0);
        
        CCMenu *myMenu = [CCMenu menuWithItems:restartButton, endbutton, nil];
        [self addChild:myMenu];
        
        
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"city-front.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
        GameOverLabel = [CCLabelTTF labelWithString:@"You Suck!" fontName:@"Marker Felt" fontSize:36];
        GameOverLabel.position = ccp(240, 300);
        [self addChild:GameOverLabel z:4];
    }
    return self;
}
-(void)restartGame: (CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    
}
-(void)endGame:(CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[MainMenuLayer alloc] init]];
}
@end
