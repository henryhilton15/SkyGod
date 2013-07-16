//
//  Main Menu Layer.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/3/13.
//
//

#import "Main Menu Layer.h"
#import "HelloWorldLayer.h"

@implementation Main_Menu_Layer
-(id) init
{
	if ((self = [super init]))
	{

CCMenuItemImage *startButton = [CCMenuItemImage itemWithNormalImage:@"play-button.png"
                                                      selectedImage: @"play-button.png"
                                                             target:self
                                                           selector:@selector(startGame:)];
startButton.position = CGPointMake(0, -65);

CCMenu *myMenu = [CCMenu menuWithItems:startButton, nil];
[self addChild:myMenu];

        CCSprite *background = [CCSprite spriteWithFile:@"background_grass-top.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
    }
    return self;
        
}

-(void) startGame: (CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[HelloWorldLayer alloc] init]];
    
}

        

        

    
@end
