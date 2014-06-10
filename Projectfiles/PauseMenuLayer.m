//
//  PauseMenuLayer.m
//  Gorilla
//
//  Created by maria hilton on 7/4/13.
//
//

#import "PauseMenuLayer.h"
#import "GameLayer.h"
#import "MainMenuLayer.h"

@implementation PauseMenuLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"resume-button-d.png"
            selectedImage: @"resume-button-d.png"
            target:self
            selector:@selector(resumeGame:)];
       resume.position = CGPointMake(0, 0);
        resume.scale = 0.5f;
    

        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"restart-button-d.png"
            selectedImage: @"restart-button-d.png"
            target:self
            selector:@selector(restartGame:)];
        restart.position = CGPointMake(0, -65);
        restart.scale = 0.5f;
        
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-d.png"
             selectedImage: @"main menu-button-d.png"
             target:self
             selector:@selector(mainMenu:)];
        mainMenuButton.position = CGPointMake(0, -130);
        mainMenuButton.scale = 0.5f;
        
        
        CCMenu *pauseMenu = [CCMenu menuWithItems:resume, restart, mainMenuButton, nil];
        [self addChild: pauseMenu z:1];
        
        CCSprite *pause_background = [CCSprite spriteWithFile:@"pause screen.png"];
        pause_background.position = CGPointMake(240,160);
        [self addChild:pause_background z:-1];
    }
    return self;
}

- (void) resumeGame: (CCMenuItemImage *) resume
{
   // [[CCDirector sharedDirector] popScene: (CCScene *)[[GameLayer alloc]  init]];
    [[CCDirector sharedDirector] popScene];
}

- (void) restartGame: (CCMenuItemImage *) restart
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[GameLayer alloc]  init]];
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

@end
