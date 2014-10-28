//
//  AboutLayer.m
//  SkyGod
//
//  Created by maria hilton on 10/27/14.
//
//

#import "AboutLayer.h"
#import "MainMenuLayer.h"

@implementation AboutLayer

-(id) init
{
	if ((self = [super init]))
	{
        winSize = [CCDirector sharedDirector].winSize;

        CCSprite *background = [CCSprite spriteWithFile:@"sky-ip5.png"];
        background.position = CGPointMake(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        CCSprite *photo = [CCSprite spriteWithFile:@"HenryDannyDevBioPhoto.jpg"];
        photo.position = ccp(winSize.width * .21, winSize.height * .45);
        photo.scale = 0.5;
        [self addChild:photo];
        
        CCLabelTTF *aboutLabel = [CCLabelTTF labelWithString:@"ABOUT THE DEVELOPERS" fontName:@"Algerian" fontSize:30];
        aboutLabel.position = ccp(winSize.width/2, winSize.height * .90);
        aboutLabel.color = ccBLACK;
        [self addChild:aboutLabel];
        
        int textX = winSize.width * .71;
        
        CCLabelTTF* dannyBio1 = [CCLabelTTF labelWithString:@"Danny Laporte (right) and Henry Hilton" fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* dannyBio2= [CCLabelTTF labelWithString:@"are seniors at M-A high school in" fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* dannyBio3 = [CCLabelTTF labelWithString:@"Menlo Park, CA. In addition to coding" fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* dannyBio4 = [CCLabelTTF labelWithString:@"Danny loves all kinds of sports." fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* henryBio1 = [CCLabelTTF labelWithString:@"Hank  " fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* henryBio2 = [CCLabelTTF labelWithString:@"Deezy " fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* henryBio3 = [CCLabelTTF labelWithString:@"Dirty " fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* henryBio4 = [CCLabelTTF labelWithString:@"Money " fontName:@"BenguiatItcTEE-Book" fontSize:14];
        
        
        
        henryBio1.position = ccp(textX, winSize.height * .51);
        henryBio2.position = ccp(textX, winSize.height * .45);
        henryBio3.position = ccp(textX, winSize.height * .39);
        henryBio4.position = ccp(textX, winSize.height * .33);
        henryBio1.color = ccBLACK;
        henryBio2.color = ccBLACK;
        henryBio3.color = ccBLACK;
        henryBio4.color = ccBLACK;
        [self addChild:henryBio1];
        [self addChild:henryBio2];
        [self addChild:henryBio3];
        [self addChild:henryBio4];
        
        dannyBio1.position = ccp(textX, winSize.height * .75);
        dannyBio2.position = ccp(textX, winSize.height * .69);
        dannyBio3.position = ccp(textX, winSize.height * .63);
        dannyBio4.position = ccp(textX, winSize.height * .57);
        dannyBio1.color = ccBLACK;
        dannyBio2.color = ccBLACK;
        dannyBio3.color = ccBLACK;
        dannyBio4.color = ccBLACK;
        [self addChild:dannyBio1];
        [self addChild:dannyBio2];
        [self addChild:dannyBio3];
        [self addChild:dannyBio4];
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-n.png"
                                                                               selectedImage: @"main menu-button-d.png"
                                                                                      target:self
                                                                                    selector:@selector(mainMenu:)];
        mainMenuButton.position = ccp(winSize.width * .82, winSize.height * .1);
        mainMenuButton.scale = .5;

        CCMenu *myMenu = [CCMenu menuWithItems:mainMenuButton, nil];
        myMenu.position = ccp(0,0);
        [self addChild:myMenu];
        

    }
    return self;
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}



@end
