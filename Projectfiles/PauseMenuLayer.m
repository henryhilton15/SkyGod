//
//  PauseMenuLayer.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/11/13.
//
//

#import "MainMenuLayer.h"
#import "PauseMenuLayer.h"
#import "GameLayer.h"

@implementation PauseMenuLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"button_playbutton.png"
                                                         selectedImage: @"button_playbutton.png"
                                                                target:self
                                                              selector:@selector(resumeGame:)];
        resume.position = CGPointMake(-100, 0);
        resume.scale = 0.5f;
        
        
        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"restart.png"
                                                          selectedImage: @"restart.png"
                                                                 target:self
                                                               selector:@selector(restartGame:)];
        restart.position = CGPointMake(0, 0);
        restart.scale = 0.5f;
        
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"button_backbutton.png"
                                                                 selectedImage: @"button_backbutton.png"
                                                                        target:self
                                                                      selector:@selector(mainMenu:)];
        mainMenuButton.position = CGPointMake(100, 0);
        mainMenuButton.scale = 0.5f;
        
        
        CCMenu *pauseMenu = [CCMenu menuWithItems:resume, restart, mainMenuButton, nil];
        [self addChild: pauseMenu z:1];
   
        PauseLabel = [CCLabelTTF labelWithString:@"Get Your Ass back to the Game!" fontName:@"Marker Felt" fontSize:28];
        PauseLabel.position = ccp(240, 300);
        [self addChild:PauseLabel z:4];
    }
    return self;
}

- (void) resumeGame: (CCMenuItemImage *) resume
{
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

