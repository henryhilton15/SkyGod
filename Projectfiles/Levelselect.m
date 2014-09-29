//
//  Levelselect.m
//  Gorilla Game
//
//  Created by Ajay Shah on 11/3/13.
//
//

#import "Levelselect.h"
#import "GameLayer.h"
#import "SimpleAudioEngine.h"
#import "GameData.h"
#import "MainMenuLayer.h"

@implementation Levelselect
-(id)init
{
    
    if ((self = [super init]))
    {
        winSize = [CCDirector sharedDirector].winSize;
        
        NSHighestLevelUnlocked = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestLevelUnlocked"];
        highestLevelUnlocked = [NSHighestLevelUnlocked intValue];
        
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Undaunted.wav"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Undaunted.wav" loop:YES];
            }
        }

        

        if(highestLevelUnlocked < 1)
        {
            highestLevelUnlocked = 1;
            NSNumber *newHighestLevel = [NSNumber numberWithInt:highestLevelUnlocked];
            [[NSUserDefaults standardUserDefaults] setObject:newHighestLevel forKey:@"highestLevelUnlocked"];
        }
        NSLog(@"highestLevelUnlocked = %d", highestLevelUnlocked);
        

        
        CCLabelTTF *selectLabel = [CCLabelTTF labelWithString:@"Select Level" fontName:@"Algerian" fontSize: 30];
        selectLabel.position = ccp(winSize.width * .5, winSize.height * .925);
        selectLabel.color = ccBLACK;
        [self addChild:selectLabel z:4];

        
        
        CCSprite *background = [CCSprite spriteWithFile:@"sky-ip5.png"];
        background.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild:background z:-1];
        
        
    
	// Create some menu items
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-n.png"
                                                                 selectedImage: @"main menu-button-d.png"
                                                                        target:self
                                                                      selector:@selector(mainMenu:)];
        mainMenuButton.position = CGPointMake(winSize.width/2, winSize.height * .075);
        mainMenuButton.scale = 0.8f;
        
        int row1 = winSize.height * .8;
        int row2 = winSize.height * .65;
        int row3 = winSize.height * .5;
        int row4 = winSize.height * .35;
        int row5 = winSize.height * .2;
        
        int col1 = winSize.width * .14;
        int col2 = winSize.width * 2 * .14;
        int col3 = winSize.width * 3 * .14;
        int col4 = winSize.width * 4 * .14;
        int col5 = winSize.width * 5 * .14;
        int col6 = winSize.width * 6 * .14;
        
	CCMenuItemImage * menuItem1 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                         selectedImage: @"level1Label.png"
                                                                target:self
                                                              selector:@selector(level1:)];
        menuItem1.scale =1.25;
        menuItem1.position = ccp(col1, row1);
    
	CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                         selectedImage: @"level2Label.png"
                                                         target:self
                                                              selector:@selector(level2:)];
        menuItem2.scale=1.25;
        menuItem2.position = ccp(col2, row1);

    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                         selectedImage: @"level3Label.png"
                                                                target:self
                                                              selector:@selector(level3:)];
        menuItem3.scale=1.25;
        menuItem3.position = ccp(col3, row1);

        
    CCMenuItemImage * menuItem4 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                             selectedImage: @"level4Label.png"
                                                                    target:self
                                                                  selector:@selector(level4:)];
        menuItem4.scale=1.25;
        menuItem4.position = ccp(col4, row1);

    
    CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                  selector:@selector(level5:)];
        menuItem5.scale=1.25;
        menuItem5.position = ccp(col5, row1);
        
        CCMenuItemImage * menuItem6 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                  selector:@selector(level6:)];
        menuItem6.scale=1.25;
        menuItem6.position = ccp(col6, row1);
        
        CCMenuItemImage * menuItem7 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                             selectedImage: @"level1Label.png"
                                                                    target:self
                                                                  selector:@selector(level7:)];
        menuItem7.scale =1.25;
        menuItem7.position = ccp(col1, row2);
        
        CCMenuItemImage * menuItem8 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                             selectedImage: @"level2Label.png"
                                                                    target:self
                                                                  selector:@selector(level8:)];
        menuItem8.scale =1.25;
        menuItem8.position = ccp(col2, row2);
        
        CCMenuItemImage * menuItem9 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                             selectedImage: @"level3Label.png"
                                                                    target:self
                                                                  selector:@selector(level9:)];
        menuItem9.scale=1.25;
        menuItem9.position = ccp(col3, row2);
        
        CCMenuItemImage * menuItem10 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                             selectedImage: @"level4Label.png"
                                                                    target:self
                                                                  selector:@selector(level10:)];
        menuItem10.scale=1.25;
        menuItem10.position = ccp(col4, row2);
        
        CCMenuItemImage * menuItem11 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                  selector:@selector(level11:)];
        menuItem11.scale=1.25;
        menuItem11.position = ccp(col5, row2);
        

        CCMenuItemImage * menuItem12 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                   selector:@selector(level12:)];
        menuItem12.scale=1.25;
        menuItem12.position = ccp(col6, row2);
        
        CCMenuItemImage * menuItem13 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                             selectedImage: @"level1Label.png"
                                                                    target:self
                                                                  selector:@selector(level13:)];
        menuItem13.scale =1.25;
        menuItem13.position = ccp(col1, row3);

        CCMenuItemImage * menuItem14 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                             selectedImage: @"level2Label.png"
                                                                    target:self
                                                                  selector:@selector(level14:)];
        menuItem14.scale =1.25;
        menuItem14.position = ccp(col2, row3);

        CCMenuItemImage * menuItem15 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                             selectedImage: @"level3Label.png"
                                                                    target:self
                                                                  selector:@selector(level15:)];
        menuItem15.scale=1.25;
        menuItem15.position = ccp(col3, row3);
        
        CCMenuItemImage * menuItem16 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                              selectedImage: @"level4Label.png"
                                                                     target:self
                                                                   selector:@selector(level16:)];
        menuItem16.scale=1.25;
        menuItem16.position = ccp(col4, row3);

        CCMenuItemImage * menuItem17 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level17:)];
        menuItem17.scale=1.25;
        menuItem17.position = ccp(col5, row3);

        
        CCMenuItemImage * menuItem18 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level18:)];
        menuItem18.scale=1.25;
        menuItem18.position = ccp(col6, row3);
        
        
        CCMenuItemImage * menuItem19 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                              selectedImage: @"level1Label.png"
                                                                     target:self
                                                                   selector:@selector(level19:)];

        
        menuItem19.scale =1.25;
        menuItem19.position = ccp(col1, row4);
        
        CCMenuItemImage * menuItem20 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                              selectedImage: @"level2Label.png"
                                                                     target:self
                                                                   selector:@selector(level20:)];
        menuItem20.scale =1.25;
        menuItem20.position = ccp(col2, row4);
        
        CCMenuItemImage * menuItem21 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                              selectedImage: @"level3Label.png"
                                                                     target:self
                                                                   selector:@selector(level21:)];
        menuItem21.scale=1.25;
        menuItem21.position = ccp(col3, row4);
        
        CCMenuItemImage * menuItem22 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                              selectedImage: @"level4Label.png"
                                                                     target:self
                                                                   selector:@selector(level22:)];
        menuItem22.scale=1.25;
        menuItem22.position = ccp(col4, row4);
        
        CCMenuItemImage * menuItem23 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level23:)];
        menuItem23.scale=1.25;
        menuItem23.position = ccp(col5, row4);
        
        
        CCMenuItemImage * menuItem24 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level24:)];
        menuItem24.scale=1.25;
        menuItem24.position = ccp(col6, row4);
        
        CCMenuItemImage * menuItem25 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                              selectedImage: @"level1Label.png"
                                                                     target:self
                                                                   selector:@selector(level25:)];
        
        
        menuItem25.scale =1.25;
        menuItem25.position = ccp(col1, row5);
        
        CCMenuItemImage * menuItem26 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                              selectedImage: @"level2Label.png"
                                                                     target:self
                                                                   selector:@selector(level26:)];
        menuItem26.scale =1.25;
        menuItem26.position = ccp(col2, row5);
        
        CCMenuItemImage * menuItem27 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                              selectedImage: @"level3Label.png"
                                                                     target:self
                                                                   selector:@selector(level27:)];
        menuItem27.scale=1.25;
        menuItem27.position = ccp(col3, row5);
        
        CCMenuItemImage * menuItem28 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                              selectedImage: @"level4Label.png"
                                                                     target:self
                                                                   selector:@selector(level28:)];
        menuItem28.scale=1.25;
        menuItem28.position = ccp(col4, row5);
        
        CCMenuItemImage * menuItem29 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level29:)];
        menuItem29.scale=1.25;
        menuItem29.position = ccp(col5, row5);
        
        
        CCMenuItemImage * menuItem30 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                              selectedImage: @"level5Label.png"
                                                                     target:self
                                                                   selector:@selector(level30:)];
        menuItem30.scale=1.25;
        menuItem30.position = ccp(col6, row5);
        


        
    CCMenu *myMenu = [CCMenu menuWithItems:mainMenuButton, menuItem1, menuItem2, menuItem3,menuItem4, menuItem5, menuItem6, menuItem7, menuItem8, menuItem9,menuItem10, menuItem11, menuItem12, menuItem13, menuItem14, menuItem15,menuItem16, menuItem17, menuItem18, menuItem19, menuItem20, menuItem21,menuItem22, menuItem23, menuItem24, menuItem25, menuItem26, menuItem27,menuItem28, menuItem29, menuItem30, nil];
    
        myMenu.position = ccp(0,0);

	[self addChild:myMenu];

    }
    return self;
}
-(void) level1: (CCMenuItem *)menuItem
{
    if(1 <= highestLevelUnlocked)
    {
//        NSNumber* NSCoins = [[NSUserDefaults standardUserDefaults] objectForKey:@"coins"];
//        int coins = [NSCoins intValue];
//        coins += 120;
//        NSNumber* newCoins = [NSNumber numberWithInt:coins];
//        [[NSUserDefaults standardUserDefaults] setObject:newCoins forKey:@"coins"];
//        NSLog(@"coins = %@", newCoins);
        [GameData sharedData].currentLevelSelected = 1;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}

-(void) level2: (CCMenuItem *)menuItem
{
    if(2 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 2;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}

-(void) level3: (CCMenuItem *)menuItem
{
    if(3 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 3;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}


-(void) level4: (CCMenuItem *)menuItem
{
    if(4 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 4;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}

-(void) level5: (CCMenuItem *)menuItem
{
    if(5 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 5;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}

-(void) level6: (CCMenuItem *)menuItem
{
    if(6 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 6;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level7: (CCMenuItem *)menuItem
{
    if(7 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 7;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level8: (CCMenuItem *)menuItem
{
    if(8 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 8;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level9: (CCMenuItem *)menuItem
{
    if(9 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 9;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level10: (CCMenuItem *)menuItem
{
    if(10 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 10;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level11: (CCMenuItem *)menuItem
{
    if(11 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 11;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level12: (CCMenuItem *)menuItem
{
    if(12 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 12
        ;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level13: (CCMenuItem *)menuItem
{
    if(13 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 13;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level14: (CCMenuItem *)menuItem
{
    if(14 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 14;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level15: (CCMenuItem *)menuItem
{
    if(15 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 15;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level16: (CCMenuItem *)menuItem
{
    if(16 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 16;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level17: (CCMenuItem *)menuItem
{
    if(17 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 17;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level18: (CCMenuItem *)menuItem
{
    if(18 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 18;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level19: (CCMenuItem *)menuItem
{
    if(19 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 19;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level20: (CCMenuItem *)menuItem
{
    if(20 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 20;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level21: (CCMenuItem *)menuItem
{
    if(21 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 21;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level22: (CCMenuItem *)menuItem
{
    if(22 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 22;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level23: (CCMenuItem *)menuItem
{
    if(23 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 23;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level24: (CCMenuItem *)menuItem
{
    if(24 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 24;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level25: (CCMenuItem *)menuItem
{
    if(25 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 25;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level26: (CCMenuItem *)menuItem
{
    if(26 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 26;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level27: (CCMenuItem *)menuItem
{
    if(27 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 27;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level28: (CCMenuItem *)menuItem
{
    if(28 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 28;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level29: (CCMenuItem *)menuItem
{
    if(29 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 29;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}
-(void) level30: (CCMenuItem *)menuItem
{
    if(30 <= highestLevelUnlocked)
    {
        [GameData sharedData].currentLevelSelected = 30;
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
    }
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}
@end
