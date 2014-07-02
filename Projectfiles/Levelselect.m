//
//  Levelselect.m
//  Gorilla Game
//
//  Created by Ajay Shah on 11/3/13.
//
//

#import "Levelselect.h"
#import "GameLayer.h"

@implementation Levelselect
-(id)init
{
    
    if ((self = [super init]))
    {
        
        
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
                                                              selector:@selector(doSomethingTwo:)];
        menuItem2.scale=1.25;
        menuItem2.position = CGPointMake(-140, 300);

    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"level3Label.png"
                                                         selectedImage: @"level3Label.png"
                                                                target:self
                                                              selector:@selector(doSomethingThree:)]; 
        menuItem3.scale=1.25;
        menuItem3.position = CGPointMake(-100, 300);

        
    CCMenuItemImage * menuItem4 = [CCMenuItemImage itemWithNormalImage:@"level4Label.png"
                                                             selectedImage: @"level4Label.png"
                                                                    target:self
                                                                  selector:@selector(doSomethingFour:)];
        menuItem4.scale=1.25;
        menuItem4.position = CGPointMake(-60, 300);

    
    CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"level5Label.png"
                                                             selectedImage: @"level5Label.png"
                                                                    target:self
                                                                  selector:@selector(doSomethingFive:)];
        menuItem5.scale=1.25;
        menuItem5.position = CGPointMake(-20, 300);

        
        
        
    CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3,menuItem4, menuItem5, nil];
    
//	[myMenu alignItemsHorizontallyWithPadding:5.0];

	[self addChild:myMenu];

}
    return self;
}
    
    -(void) level1: (CCMenuItem *)menuItem
    {
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
        
    }

@end
