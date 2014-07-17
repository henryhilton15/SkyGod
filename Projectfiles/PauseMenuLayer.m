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
#import "GameData.h"
#import "SimpleAudioEngine.h"

@implementation PauseMenuLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"resume-button-d.png"
            selectedImage: @"resume-button-d.png"
            target:self
            selector:@selector(resumeGame:)];
       resume.position = CGPointMake(160, 110);
        resume.scale = 0.8f;
    

        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"restart-button-d.png"
            selectedImage: @"restart-button-d.png"
            target:self
            selector:@selector(restartGame:)];
        restart.position = CGPointMake(0, 270);
        restart.scale = 0.5f;
        
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-d.png"
             selectedImage: @"main menu-button-d.png"
             target:self
             selector:@selector(mainMenu:)];
        mainMenuButton.position = CGPointMake(0, 235);
        mainMenuButton.scale = 0.5f;
        
        
        CCMenuItemImage *sfxButton = [CCMenuItemImage itemWithNormalImage:@"sound_btn.png"
                                                          selectedImage: @"sound_btn.png"
                                                                 target:self
                                                                 selector:@selector(sfxToggle:)];
        sfxButton.position = CGPointMake(-20, 200);
        sfxButton.scale = 1.0f;
        
        CCMenuItemImage *musicButton = [CCMenuItemImage itemWithNormalImage:@"music_btn.png"
                                                          selectedImage: @"music_btn.png"
                                                                 target:self
                                                                   selector:@selector(musicToggle:)];
        musicButton.position = CGPointMake(20, 200);
        musicButton.scale = 0.5f;
        
        
        
        CCMenu *pauseMenu = [CCMenu menuWithItems:resume, restart, mainMenuButton, sfxButton, musicButton, nil];
        [self addChild: pauseMenu z:1];
        
        CCSprite *pause_background = [CCSprite spriteWithFile:@"pause-screen-hd.png"];
        pause_background.position = CGPointMake(240,160);
        [self addChild:pause_background z:0];
        

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
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[GameLayer alloc]  init]];
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

- (void) sfxToggle: (CCMenuItemImage *) sfxButton
{
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeSound"] boolValue] == true)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:false] forKey:@"firstTimeSound"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
    {
        sfx = false;
        NSLog(@"sfx off");
    }
    
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == false)
    {
        sfx = true;
        NSLog(@"sfx on");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sfx] forKey:@"sfx"];
}

- (void) musicToggle: (CCMenuItemImage *) musicButton
{
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeMusic"] boolValue] == true)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:false] forKey:@"firstTimeMusic"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
    {
        music = false;
        NSLog(@"music off");
    }
    
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == false)
    {
        music = true;
        NSLog(@"music on");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:music] forKey:@"music"];
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
    {
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:(@"The Descent.wav")];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:(@"The Descent.wav") loop:YES];

    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == false)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }

}

@end
