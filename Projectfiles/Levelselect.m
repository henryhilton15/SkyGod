//
//  Levelselect.m
//  Gorilla Game
//
//  Created on 11/3/13
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
        mainMenuButton.position = CGPointMake(winSize.width/2, winSize.height * .065);
        mainMenuButton.scale = 0.6f;
        
        int row1 = winSize.height * .8;
        int row2 = winSize.height * .65;
        int row3 = winSize.height * .5;
        int row4 = winSize.height * .35;
        int row5 = winSize.height * .2;
        
        int col1 = winSize.width * .142;
        int col2 = winSize.width * 2 * .142;
        int col3 = winSize.width * 3 * .142;
        int col4 = winSize.width * 4 * .142;
        int col5 = winSize.width * 5 * .142;
        int col6 = winSize.width * 6 * .142;
        
        
        
	CCMenuItemImage * menuItem1 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                         selectedImage: @"box_grey.png"
                                                                target:self
                                                              selector:@selector(level1:)];
        menuItem1.scale =.35;
        menuItem1.position = ccp(col1, row1);
    
	CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                         selectedImage: @"box_grey.png"
                                                         target:self
                                                              selector:@selector(level2:)];
        menuItem2.scale=.35;
        menuItem2.position = ccp(col2, row1);

    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                         selectedImage: @"box_grey.png"
                                                                target:self
                                                              selector:@selector(level3:)];
        menuItem3.scale=.35;
        menuItem3.position = ccp(col3, row1);

        
    CCMenuItemImage * menuItem4 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level4:)];
        menuItem4.scale=.35;
        menuItem4.position = ccp(col4, row1);

    
    CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level5:)];
        menuItem5.scale=.35;
        menuItem5.position = ccp(col5, row1);
        
        CCMenuItemImage * menuItem6 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level6:)];
        menuItem6.scale=.35;

        menuItem6.position = ccp(col6, row1);
        
        CCMenuItemImage * menuItem7 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level7:)];
        menuItem7.scale =.35;
        menuItem7.position = ccp(col1, row2);
        
        CCMenuItemImage * menuItem8 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level8:)];
        menuItem8.scale =.35;
        menuItem8.position = ccp(col2, row2);
        
        CCMenuItemImage * menuItem9 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level9:)];
        menuItem9.scale=.35;
        menuItem9.position = ccp(col3, row2);
        
        CCMenuItemImage * menuItem10 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level10:)];
        menuItem10.scale=.35;
        menuItem10.position = ccp(col4, row2);
        
        CCMenuItemImage * menuItem11 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level11:)];
        menuItem11.scale=.35;
        menuItem11.position = ccp(col5, row2);
        

        CCMenuItemImage * menuItem12 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                   selector:@selector(level12:)];
        menuItem12.scale=.35;
        menuItem12.position = ccp(col6, row2);
        
        CCMenuItemImage * menuItem13 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level13:)];
        menuItem13.scale =.35;
        menuItem13.position = ccp(col1, row3);

        CCMenuItemImage * menuItem14 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level14:)];
        menuItem14.scale =.35;
        menuItem14.position = ccp(col2, row3);

        CCMenuItemImage * menuItem15 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                             selectedImage: @"box_grey.png"
                                                                    target:self
                                                                  selector:@selector(level15:)];
        menuItem15.scale=.35;
        menuItem15.position = ccp(col3, row3);
        
        CCMenuItemImage * menuItem16 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level16:)];
        menuItem16.scale=.35;
        menuItem16.position = ccp(col4, row3);

        CCMenuItemImage * menuItem17 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level17:)];
        menuItem17.scale=.35;
        menuItem17.position = ccp(col5, row3);

        
        CCMenuItemImage * menuItem18 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level18:)];
        menuItem18.scale=.35;

        menuItem18.position = ccp(col6, row3);
        
        
        CCMenuItemImage * menuItem19 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level19:)];

        
        menuItem19.scale =.35;
        menuItem19.position = ccp(col1, row4);
        
        CCMenuItemImage * menuItem20 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level20:)];
        menuItem20.scale =.35;
        menuItem20.position = ccp(col2, row4);
        
        CCMenuItemImage * menuItem21 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level21:)];
        menuItem21.scale=.35;
        menuItem21.position = ccp(col3, row4);
        
        CCMenuItemImage * menuItem22 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level22:)];
        menuItem22.scale=.35;
        menuItem22.position = ccp(col4, row4);
        
        CCMenuItemImage * menuItem23 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level23:)];
        menuItem23.scale=.35;
        menuItem23.position = ccp(col5, row4);
        
        
        CCMenuItemImage * menuItem24 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level24:)];
        menuItem24.scale=.35;

        menuItem24.position = ccp(col6, row4);
        
        CCMenuItemImage * menuItem25 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level25:)];
        
        
        menuItem25.scale =.35;
        menuItem25.position = ccp(col1, row5);
        
        CCMenuItemImage * menuItem26 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level26:)];
        menuItem26.scale =.35;
        menuItem26.position = ccp(col2, row5);
        
        CCMenuItemImage * menuItem27 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level27:)];
        menuItem27.scale=.35;
        menuItem27.position = ccp(col3, row5);
        
        CCMenuItemImage * menuItem28 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level28:)];
        menuItem28.scale=.35;
        menuItem28.position = ccp(col4, row5);
        
        CCMenuItemImage * menuItem29 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level29:)];
        menuItem29.scale=.35;
        menuItem29.position = ccp(col5, row5);
        
        
        CCMenuItemImage * menuItem30 = [CCMenuItemImage itemWithNormalImage:@"Box_Yellow.png"
                                                              selectedImage: @"box_grey.png"
                                                                     target:self
                                                                   selector:@selector(level30:)];
        menuItem30.scale=.35;

        menuItem30.position = ccp(col6, row5);
        


        
    CCMenu *myMenu = [CCMenu menuWithItems:mainMenuButton, menuItem1, menuItem2, menuItem3,menuItem4, menuItem5, menuItem6, menuItem7, menuItem8, menuItem9,menuItem10, menuItem11, menuItem12, menuItem13, menuItem14, menuItem15,menuItem16, menuItem17, menuItem18, menuItem19, menuItem20, menuItem21,menuItem22, menuItem23, menuItem24, menuItem25, menuItem26, menuItem27,menuItem28, menuItem29, menuItem30, nil];
    
        myMenu.position = ccp(0,0);

	[self addChild:myMenu];
        
        CCLabelTTF *L1 = [CCLabelTTF labelWithString:@"1" fontName:@"Algerian" fontSize: 50];
        
        L1.scale=.35;
        L1.color = ccBLACK;
        L1.position = ccp(col1, row1);
        [self addChild:L1 z:6];
        
        CCLabelTTF *L2 = [CCLabelTTF labelWithString:@"2" fontName:@"Algerian" fontSize: 50];
        
        
        L2.scale=.35;
        L2.color = ccBLACK;
        L2.position = ccp(col2, row1);
        [self addChild:L2 z:6];
        
        
        CCLabelTTF *L3 = [CCLabelTTF labelWithString:@"3" fontName:@"Algerian" fontSize: 50];
        
        
        L3.scale=.35;
        L3.color = ccBLACK;
        L3.position = ccp(col3, row1);
        [self addChild:L3 z:6];
        
        
        CCLabelTTF *L4 = [CCLabelTTF labelWithString:@"4" fontName:@"Algerian" fontSize: 50];
        
        
        L4.scale=.35;
        L4.color = ccBLACK;
        L4.position = ccp(col4, row1);
        [self addChild:L4 z:6];
        
        CCLabelTTF *L5 = [CCLabelTTF labelWithString:@"5" fontName:@"Algerian" fontSize: 50];
        
        
        L5.scale=.35;
        L5.color = ccBLACK;
        L5.position = ccp(col5, row1);
        [self addChild:L5 z:6];
        
        CCLabelTTF *L6 = [CCLabelTTF labelWithString:@"6" fontName:@"Algerian" fontSize: 50];
        
        L6.scale=.35;
        L6.color = ccBLACK;
        L6.position = ccp(col6, row1);
        [self addChild:L6 z:6];
        
        CCLabelTTF *L7 = [CCLabelTTF labelWithString:@"7" fontName:@"Algerian" fontSize: 50];
        
        
        L7.scale=.35;
        L7.color = ccBLACK;
        L7.position = ccp(col1, row2);
        [self addChild:L7 z:6];
        
        CCLabelTTF *L8 = [CCLabelTTF labelWithString:@"8" fontName:@"Algerian" fontSize: 50];
        
        
        L8.scale=.35;
        L8.color = ccBLACK;
        L8.position = ccp(col2, row2);
        [self addChild:L8 z:6];
        
        CCLabelTTF *L9 = [CCLabelTTF labelWithString:@"9" fontName:@"Algerian" fontSize: 50];
        
        
        L9.scale=.35;
        L9.color = ccBLACK;
        L9.position = ccp(col3, row2);
        [self addChild:L9 z:6];
        
        CCLabelTTF *L10 = [CCLabelTTF labelWithString:@"10" fontName:@"Algerian" fontSize: 50];
        
        
        L10.scale=.35;
        L10.color = ccBLACK;
        L10.position = ccp(col4, row2);
        [self addChild:L10 z:6];
        
        CCLabelTTF *L11 = [CCLabelTTF labelWithString:@"11" fontName:@"Algerian" fontSize: 50];
        
        
        L11.scale=.35;
        L11.color = ccBLACK;
        L11.position = ccp(col5, row2);
        [self addChild:L11 z:6];
        
        
        CCLabelTTF *L12 = [CCLabelTTF labelWithString:@"12" fontName:@"Algerian" fontSize: 50];
        
        
        L12.scale=.35;
        L12.color = ccBLACK;
        L12.position = ccp(col6, row2);
        [self addChild:L12 z:6];
        
        CCLabelTTF *L13 = [CCLabelTTF labelWithString:@"13" fontName:@"Algerian" fontSize: 50];
        
        
        L13.scale=.35;
        L13.color = ccBLACK;
        L13.position = ccp(col1, row3);
        [self addChild:L13 z:6];
        
        CCLabelTTF *L14 = [CCLabelTTF labelWithString:@"14" fontName:@"Algerian" fontSize: 50];
        
        
        L14.scale=.35;
        L14.color = ccBLACK;
        L14.position = ccp(col2, row3);
        [self addChild:L14 z:6];
        
        CCLabelTTF *L15 = [CCLabelTTF labelWithString:@"15" fontName:@"Algerian" fontSize: 50];
        
        
        L15.scale=.35;
        L15.color = ccBLACK;
        L15.position = ccp(col3, row3);
        [self addChild:L15 z:6];
        
        CCLabelTTF *L16 = [CCLabelTTF labelWithString:@"16" fontName:@"Algerian" fontSize: 50];
        
        
        L16.scale=.35;
        L16.color = ccBLACK;
        L16.position = ccp(col4, row3);
        [self addChild:L16 z:6];
        
        CCLabelTTF *L17 = [CCLabelTTF labelWithString:@"17" fontName:@"Algerian" fontSize: 50];
        
        
        L17.scale=.35;
        L17.color = ccBLACK;
        L17.position = ccp(col5, row3);
        [self addChild:L17 z:6];
        
        
        CCLabelTTF *L18 = [CCLabelTTF labelWithString:@"18" fontName:@"Algerian" fontSize: 50];
        
        
        L18.scale=.35;
        L18.color = ccBLACK;
        L18.position = ccp(col6, row3);
        [self addChild:L18 z:6];
        
        
        CCLabelTTF *L19 = [CCLabelTTF labelWithString:@"19" fontName:@"Algerian" fontSize: 50];
        
        
        L19.scale=.35;
        L19.color = ccBLACK;
        L19.position = ccp(col1, row4);
        [self addChild:L19 z:6];
        
        CCLabelTTF *L20 = [CCLabelTTF labelWithString:@"20" fontName:@"Algerian" fontSize: 50];
        
        
        L20.scale=.35;
        L20.color = ccBLACK;
        L20.position = ccp(col2, row4);
        [self addChild:L20 z:6];
        
        CCLabelTTF *L21 = [CCLabelTTF labelWithString:@"21" fontName:@"Algerian" fontSize: 50];
        
        
        L21.scale=.35;
        L21.color = ccBLACK;
        L21.position = ccp(col3, row4);
        [self addChild:L21 z:6];
        
        CCLabelTTF *L22 = [CCLabelTTF labelWithString:@"22" fontName:@"Algerian" fontSize: 50];
        
        
        L22.scale=.35;
        L22.color = ccBLACK;
        L22.position = ccp(col4, row4);
        [self addChild:L22 z:6];
        
        CCLabelTTF *L23 = [CCLabelTTF labelWithString:@"23" fontName:@"Algerian" fontSize: 50];
        
        
        L23.scale=.35;
        L23.color = ccBLACK;
        L23.position = ccp(col5, row4);
        [self addChild:L23 z:6];
        
        
        CCLabelTTF *L24 = [CCLabelTTF labelWithString:@"24" fontName:@"Algerian" fontSize: 50];
        
        
        L24.scale=.35;
        L24.color = ccBLACK;
        L24.position = ccp(col6, row4);
        [self addChild:L24 z:6];
        
        CCLabelTTF *L25 = [CCLabelTTF labelWithString:@"25" fontName:@"Algerian" fontSize: 50];
        
        
        
        
        L25.scale=.35;
        L25.color = ccBLACK;
        L25.position = ccp(col1, row5);
        [self addChild:L25 z:6];
        
        CCLabelTTF *L26 = [CCLabelTTF labelWithString:@"26" fontName:@"Algerian" fontSize: 50];
        
        
        L26.scale=.35;
        L26.color = ccBLACK;
        L26.position = ccp(col2, row5);
        [self addChild:L26 z:6];
        
        CCLabelTTF *L27 = [CCLabelTTF labelWithString:@"27" fontName:@"Algerian" fontSize: 50];
        
        
        L27.scale=.35;
        L27.color = ccBLACK;
        L27.position = ccp(col3, row5);
        [self addChild:L27 z:6];
        
        CCLabelTTF *L28 = [CCLabelTTF labelWithString:@"28" fontName:@"Algerian" fontSize: 50];
        
        
        L28.scale=.35;
        L28.color = ccBLACK;
        L28.position = ccp(col4, row5);
        [self addChild:L28 z:6];
        
        CCLabelTTF *L29 = [CCLabelTTF labelWithString:@"29" fontName:@"Algerian" fontSize: 50];
        
        
        L29.scale=.35;
        L29.color = ccBLACK;
        L29.position = ccp(col5, row5);
        [self addChild:L29 z:6];
        
        
        CCLabelTTF *L30 = [CCLabelTTF labelWithString:@"30" fontName:@"Algerian" fontSize: 50];
        
        
        L30.scale=.35;
        L30.color = ccBLACK;
        L30.position = ccp(col6, row5);
        [self addChild:L30 z:6];
        


    
        for (int i=0; i<=30; i++)
        {
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"highestLevelUnlocked"] intValue] < i)
            {
                CCSprite *lock = [CCSprite spriteWithFile:@"lock.png"];
                lock.scale = .15;
                [self addChild:lock z:5];
                int y = 1 + ((i-1)/6);
                int x = i - (6*(y-1));
                
                int posY;
                int posX;
                
                if(y == 1)
                {
                    posY = row1;
                }
                if(y == 2)
                {
                    posY = row2;
                }
                if(y == 3)
                {
                    posY = row3;
                }
                if(y == 4)
                {
                    posY = row4;
                }
                if(y == 5)
                {
                    posY = row5;
                }
                
                if(x == 1)
                {
                    posX = col1;
                }
                if(x == 2)
                {
                    posX = col2;
                }
                if(x == 3)
                {
                    posX = col3;
                }
                if(x == 4)
                {
                    posX = col4;
                }
                if(x == 5)
                {
                    posX = col5;
                }
                
                if(x == 6)
                {
                    posX = col6;
                }

                lock.position = ccp(posX,posY);

            }

        }

    }
    return self;
}




-(void) level1: (CCMenuItem *)menuItem
{
    if(1 <= highestLevelUnlocked)
    {
        
        NSNumber* NSCoins = [[NSUserDefaults standardUserDefaults] objectForKey:@"coins"];
        int coins = [NSCoins intValue];
        coins += 50000;
        NSNumber* newCoins = [NSNumber numberWithInt:coins];
        [MGWU setObject:newCoins forKey:@"coins"];
        NSLog(@"coins = %@", newCoins);
        
//
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
