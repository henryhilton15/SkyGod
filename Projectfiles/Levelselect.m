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

@implementation Levelselect
-(id)init
{
    
    if ((self = [super init]))
    {
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
        
        CCSprite *levelTitleImage = [CCSprite spriteWithFile: @"cooltext1265591974.png"];
        levelTitleImage.position = ccp(240,280);
        levelTitleImage.scale =.6;
        [self addChild:levelTitleImage z:4];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"background_grass-top.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
        
        
    
	// Create some menu items
	CCMenuItemImage * menuItem1 = [CCMenuItemImage itemWithNormalImage:@"level1Label.png"
                                                         selectedImage: @"level1Label.png"
                                                                target:self
                                                              selector:@selector(level1:)];
        menuItem1.scale =1.25;
        menuItem1.position = CGPointMake(-180, 300);
    
	CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"level2Label.png"
                                                         selectedImage: @"level2Label.png"
                                                         target:self
                                                              selector:@selector(level2:)];
        menuItem2.scale=1.25;
        menuItem2.position = CGPointMake(-120, 300);

    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                         selectedImage: @"level3Label.png"
                                                                target:self
                                                              selector:@selector(level3:)];
        menuItem3.scale=1.25;
        menuItem3.position = CGPointMake(-60, 300);

        
    CCMenuItemImage * menuItem4 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                             selectedImage: @"level4Label.png"
                                                                    target:self
                                                                  selector:@selector(level4:)];
        menuItem4.scale=1.25;
        menuItem4.position = CGPointMake(0, 300);

    
    CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                  selector:@selector(level5:)];
        menuItem5.scale=1.25;
        menuItem5.position = CGPointMake(60, 300);

        
        
        
    CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3,menuItem4, menuItem5, nil];
    
//	[myMenu alignItemsHorizontallyWithPadding:5.0];

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
@end
