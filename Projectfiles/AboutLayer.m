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
        photo.position = ccp(winSize.width * .19, winSize.height * .45);
        photo.scale = 0.5;
        [self addChild:photo];
        
        CCSprite *ajayPhoto = [CCSprite spriteWithFile:@"SkyGodAjayBioPhoto.jpg"];
        ajayPhoto.position = ccp(winSize.width * .88, winSize.height * .16);
        ajayPhoto.scale = 1;
        [self addChild:ajayPhoto];
        
        CCLabelTTF *aboutLabel = [CCLabelTTF labelWithString:@"ABOUT THE DEVELOPERS" fontName:@"Algerian" fontSize:30];
        aboutLabel.position = ccp(winSize.width/2, winSize.height * .90);
        aboutLabel.color = ccBLACK;
        [self addChild:aboutLabel];
        
        int textX = winSize.width * .69;
        int ajayTextX = winSize.width * .6;
        
        CCLabelTTF* dannyBio1 = [CCLabelTTF labelWithString:@"Danny Laporte (right) and Henry Hilton     " fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* dannyBio2 = [CCLabelTTF labelWithString:@"are seniors at Menlo-Atherton HS in Menlo  " fontName:@"BenguiatItcTEE-Book" fontSize:14];
        CCLabelTTF* dannyBio3 = [CCLabelTTF labelWithString:@"Park, CA. In addition to coding, Danny     " fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* dannyBio4 = [CCLabelTTF labelWithString:@"drains 3's on the basketball court.        " fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio1 = [CCLabelTTF labelWithString:@"He plays hard and works even harder.       " fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio2 = [CCLabelTTF labelWithString:@"Henry is an Eagle Scout and rows crew.     " fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio3 = [CCLabelTTF labelWithString:@"He stands 8'8'' with purple skin and" fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio4 = [CCLabelTTF labelWithString:@"bowling-ball biceps. In their spare time,  "  fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio5 = [CCLabelTTF labelWithString:@"Henry and Danny strike smoldering poses and"  fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* henryBio6 = [CCLabelTTF labelWithString:@"write about themselves in the third person."  fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* ajayBio = [CCLabelTTF labelWithString:@"Ajay Shah is a senior and plays" fontName:@"BenguiatItcTEE-Book" fontSize:13];
        CCLabelTTF* ajayBio2 = [CCLabelTTF labelWithString:@"tennis for Menlo-Atherton HS." fontName:@"BenguiatItcTEE-Book" fontSize:13];
    
        ajayBio.position =  ccp(ajayTextX, winSize.height * .26);
        ajayBio.color = ccBLACK;
        [self addChild:ajayBio];
        
        ajayBio2.position =  ccp(ajayTextX, winSize.height * .21);
        ajayBio2.color = ccBLACK;
        [self addChild:ajayBio2];
        
        
        henryBio1.position = ccp(textX, winSize.height * .58);
        henryBio2.position = ccp(textX, winSize.height * .53);
        henryBio3.position = ccp(textX, winSize.height * .48);
        henryBio4.position = ccp(textX, winSize.height * .43);
        henryBio5.position = ccp(textX, winSize.height * .38);
        henryBio6.position = ccp(textX, winSize.height * .33);
        henryBio1.color = ccBLACK;
        henryBio2.color = ccBLACK;
        henryBio3.color = ccBLACK;
        henryBio4.color = ccBLACK;
        henryBio5.color = ccBLACK;
        henryBio6.color = ccBLACK;
        [self addChild:henryBio1];
        [self addChild:henryBio2];
        [self addChild:henryBio3];
        [self addChild:henryBio4];
        [self addChild:henryBio5];
        [self addChild:henryBio6];
        
        dannyBio1.position = ccp(textX, winSize.height * .78);
        dannyBio2.position = ccp(textX, winSize.height * .73);
        dannyBio3.position = ccp(textX, winSize.height * .68);
        dannyBio4.position = ccp(textX, winSize.height * .63);
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
        mainMenuButton.position = ccp(winSize.width * .6, winSize.height * .1);
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
