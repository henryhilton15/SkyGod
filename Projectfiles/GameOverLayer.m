//
//  GameOverLayer.m
//  Gorilla
//
//  Created by maria hilton on 7/5/13.
//
//

#import "GameOverLayer.h"

#import "Levelselect.h"
#import "Store.h"
#import "SimpleAudioEngine.h"
#import "GameData.h"
#import "GameLayer.h"

@implementation GameOverLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        winSize = [CCDirector sharedDirector].winSize;

        
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }

        CCMenuItemImage *selectButton = [CCMenuItemImage itemWithNormalImage:@"select-button-n.png"
                                                                selectedImage: @"select-button-d.png"
                                                                       target:self
                                                                     selector:@selector(levelSelect:)];
        
        selectButton.position = CGPointMake(winSize.width * -.3, winSize.height * .2);
        selectButton.scale = .5;

        CCMenuItemImage *restartButton = [CCMenuItemImage itemWithNormalImage:@"restart-button-n.png"
                                                                selectedImage: @"restart-button-d.png"
                                                                       target:self
                                                                     selector:@selector(restartLevel:)];
        
        restartButton.position = CGPointMake(winSize.width * -.3, winSize.height * .1);
        restartButton.scale = .5;
        
        CCMenuItemImage *endbutton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                            selectedImage: @"shop-button-d.png"
                                                                   target:self
                                                                 selector:@selector(endGame:)];
       
        endbutton.position = CGPointMake(winSize.width * -.3, winSize.height * .38);
        endbutton.scale= 1;
        
        CCMenu *myMenu = [CCMenu menuWithItems:endbutton, selectButton, restartButton, nil];
        myMenu.position = ccp(winSize.width/2, 0);
        [self addChild:myMenu z:10];
        
        CCSprite *background = [CCSprite spriteWithFile:@"game-over-ip5.png"];
        background.position = CGPointMake(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        /*
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"gameOverLaugh.wav"];
    
        [[SimpleAudioEngine sharedEngine] playEffect:@"gameOverLaugh.wav"];
        */
        GameOverLabel = [CCLabelTTF labelWithString:@"You Lose!" fontName:@"Algerian" fontSize:95];
        GameOverLabel.position = ccp(winSize.width * .5, winSize.height *.8);
        [self addChild:GameOverLabel z:4];
        
    }
    return self;
}

-(void)levelSelect: (CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Levelselect alloc] init]];
}

-(void)endGame:(CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Store alloc] init]];
}

-(void) restartLevel:(CCMenuItemImage *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
}


@end


