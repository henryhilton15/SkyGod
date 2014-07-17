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

@implementation GameOverLayer

-(id) init
{
	if ((self = [super init]))
	{
        winSize = [CCDirector sharedDirector].winSize;
         
        CCMenuItemImage *restartButton = [CCMenuItemImage itemWithNormalImage:@"select-button-d.png"
                                                                selectedImage: @"select-button-d.png"
                                                                       target:self
                                                                     selector:@selector(restartGame:)];
        restartButton.position = CGPointMake(50,250);
        restartButton.scale=.5;

        
        //startButton.tag = 1;
        
        CCMenuItemImage *endbutton = [CCMenuItemImage itemWithNormalImage:@"shop-button-d.png"
                                                            selectedImage: @"shop-button-d.png"
                                                                   target:self
                                                                 selector:@selector(endGame:)];
        endbutton.position = CGPointMake(-50, 250);
        endbutton.scale=.5;
        
        CCMenu *myMenu = [CCMenu menuWithItems: endbutton,restartButton,  nil];
        [self addChild:myMenu z:10];
        
        CCSprite *background = [CCSprite spriteWithFile:@"game-over.png"];
        background.position = CGPointMake(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        /*
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"gameOverLaugh.wav"];
    
        [[SimpleAudioEngine sharedEngine] playEffect:@"gameOverLaugh.wav"];
        */
        GameOverLabel = [CCLabelTTF labelWithString:@"You suck!" fontName:@"Marker Felt" fontSize:36];
        GameOverLabel.position = ccp(240,300);
        [self addChild:GameOverLabel z:4];
        
        GameData *data = [GameData sharedData];
        int score = data.score;
        NSString *scoreString = [NSString stringWithFormat:@"score: %d", score];
        
        scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"Marker Felt" fontSize:40];
        scoreLabel.position = ccp(240,50);
        //scoreLabel.color = ccBLUE;
        [self addChild:scoreLabel z:4];
        
        NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
        
        if(score > [currentHighScore intValue])
        {
            NSNumber* newHighScore = [NSNumber numberWithInt:score];
            [[NSUserDefaults standardUserDefaults] setObject:newHighScore forKey: @"highScore"];
            newHighScoreLabel = [CCLabelTTF labelWithString:@"New High Score!" fontName:@"Marker Felt" fontSize:36];
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
-(void)restartGame: (CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Levelselect alloc] init]];
    
}
-(void)endGame:(CCMenuItem *)menuItem
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[Store alloc] init]];
}

@end


