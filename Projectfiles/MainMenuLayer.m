//
//  MainMenuLayer.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/3/13.
//
//

#import "MainMenuLayer.h"
# import "GameLayer.h"
@implementation MainMenuLayer


-(id) init
{
	if ((self = [super init]))
	{
        
        CCMenuItemImage *startButton = [CCMenuItemImage itemWithNormalImage:@"play-button.png"
                                                              selectedImage: @"play-button.png"
                                                                     target:self
                                                                   selector:@selector(startGame:)];
        startButton.scale=0.5;
        startButton.position = CGPointMake(0, 10);
        
        
        
        CCMenu *myMenu = [CCMenu menuWithItems:startButton, nil];
        [self addChild:myMenu];
        
        CCSprite *background = [CCSprite spriteWithFile:@"background_grass-top.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
        TitleLabel = [CCLabelTTF labelWithString:@"Banana Bonanza" fontName:@"Marker Felt" fontSize:40];
        TitleLabel.position = ccp(240, 240);
        TitleLabel.color=ccBLUE;
    
        [self addChild:TitleLabel z:4];
    }
    return self;
    
}

-(void) startGame: (CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    
}

@end
