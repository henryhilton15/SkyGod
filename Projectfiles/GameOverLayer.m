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
        
        selectButton.position = CGPointMake(winSize.width * .25, winSize.height * .7);
        selectButton.scale = .5;

        CCMenuItemImage *restartButton = [CCMenuItemImage itemWithNormalImage:@"restart-button-n.png"
                                                                selectedImage: @"restart-button-d.png"
                                                                       target:self
                                                                     selector:@selector(restartLevel:)];
        
        restartButton.position = CGPointMake(0, winSize.height * .7);
        restartButton.scale = .5;
        
        CCMenuItemImage *endbutton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                            selectedImage: @"shop-button-d.png"
                                                                   target:self
                                                                 selector:@selector(endGame:)];
       
        endbutton.position = CGPointMake(-winSize.width * .25, winSize.height * .7);
        endbutton.scale=.5;
        
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
        GameOverLabel = [CCLabelTTF labelWithString:@"You suck!" fontName:@"Algerian" fontSize:36];
        GameOverLabel.position = ccp(240,300);
        [self addChild:GameOverLabel z:4];
        
        GameData *data = [GameData sharedData];
        int score = data.score;
        NSString *scoreString = [NSString stringWithFormat:@"score: %d", score];
        
        scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"BenguiatItcTEE-Book" fontSize:40];
        scoreLabel.position = ccp(240,50);
        //scoreLabel.color = ccBLUE;
        [self addChild:scoreLabel z:4];
        
        NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
        
        if(score > [currentHighScore intValue])
        {
            NSNumber* newHighScore = [NSNumber numberWithInt:score];
            [[NSUserDefaults standardUserDefaults] setObject:newHighScore forKey: @"highScore"];
            newHighScoreLabel = [CCLabelTTF labelWithString:@"New High Score!" fontName:@"BenguiatItcTEE-Book" fontSize:36];
            newHighScoreLabel.position = ccp(100,160);
            [self addChild:newHighScoreLabel z:4];
            NSLog(@"new high score!");
        }
        else
        {
            
        }
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


