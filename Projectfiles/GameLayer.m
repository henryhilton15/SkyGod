xcode//
//  GameLayer.m
//  Gorilla
//
//  Created by henry hilton, danny laporte, and scrub on 7/3/13.
//


#import "GameLayer.h"
#import "PauseMenuLayer.h"
#import "GameOverLayer.h"
#import "SimpleAudioEngine.h"
#import "Character.h"
#import "GameData.h"
#import "Player.h"
#import "VictoryLayer.h"
#import "InGameShop.h"
#import "TutorialLayer.h"


#define MOUNTAIN_HEIGHT 70.0f
#define BASE_HEIGHT 50

@implementation GameLayer

-(void) addFriendlyFastShooter
{
    angel3 = [[Character alloc] initWithFriendlyFastShooterImage];
    
    // Determine where to spawn the monster along the X axis
    int minX = 20;
    int maxX = winSize.width - 20;
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    while ((actualX < winSize.width * .57) && (actualX > winSize.width * .43))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    int minDuration = friendlyFallSpeed - 1;
    int maxDuration = friendlyFallSpeed + 1;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    angel3.scale = .5;
    
    angel3.position = ccp(actualX, winSize.height);
    [self addChild:angel3];
    [goodGuys addObject:angel3];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -angel3.contentSize.height/2)];
    [angel3 runAction:actionMove];
    
    NSMutableArray *angel3fallFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel3fall.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel3fall.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    angel3fallFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [angel3fallFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *angel3fallAnimation = [CCAnimation animationWithFrames: angel3fallFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel3fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel3fallAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [angel3 runAction:angel3fall];

}

-(void) addEnemyFastShooter
{
    // Determine where to spawn the monster along the X axis
    int minX = 12;
    int maxX = winSize.width - 8;
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    minDuration = 3.5;
    maxDuration = 5.0;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    enemy = [[Character alloc] initWithEnemyFastShooterImage];
    enemy.scale = .6;
    
    enemy.position = ccp(actualX, winSize.height);
    [self addChild:enemy];
    [badGuys addObject:enemy];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -enemy.contentSize.height/2)];
    [enemy runAction:actionMove];
}

-(void) addEnemyMelee:(BOOL)zigZag :(BOOL)zigZagScenario
{
    // Determine where to spawn the monster along the X axis
    int minX = 80;
    int maxX = winSize.width - 80;
    if(zigZag == YES)
    {
        minX = 100;
        maxX = winSize.width - 40;
    }
    if(zigZagScenario == YES && [zigZagScenarioEnemies count] == 0)
    {
        minX = winSize.width * .05;
        maxX = winSize.width * .2;
    }
    if(zigZagScenario == YES && [zigZagScenarioEnemies count] == 1)
    {
        minX = winSize.width * .3;
        maxX = winSize.width * .45;
    }
    if(zigZagScenario == YES && [zigZagScenarioEnemies count] == 2)
    {
        minX = winSize.width * .55;
        maxX = winSize.width * .6;
    }
    if(zigZagScenario == YES && [zigZagScenarioEnemies count] == 3)
    {
        minX = winSize.width * .8;
        maxX = winSize.width * .95;
    }
    
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    while ((actualX < winSize.width * .57) && (actualX > winSize.width * .43))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    devil1 = [[Character alloc] initWithEnemyMeleeImage];
    devil1.scale = .5;
    [self addChild:devil1];
    [badGuys addObject:devil1];
    if(zigZagScenario == YES)
    {
        [zigZagScenarioEnemies addObject:devil1];
    }
    devil1.position = ccp(actualX, winSize.height);
    
    minDuration = ((Character*)devil1).fallSpeed - 1.0;
    maxDuration = ((Character*)devil1).fallSpeed + 1.0;
    
    double rangeDuration = maxDuration - minDuration;
    double actualDuration = (((arc4random() % 100) * 1.0f) * .01 * rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -devil1.contentSize.height/2)];
    int x = devil1.position.x;
    int y = devil1.position.y;
    
    //  float timeInterval = 2.0f;
    
    
    //    id delay = [CCDelayTime actionWithDuration:timeInterval];
    
    id leftTop = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                     position:ccp(x - (winSize.width/6), y - (winSize.height/6))];
    
    id rightTop = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                      position:ccp(x + (winSize.width/6), y - (winSize.height/3))];
    
    id leftMid = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                     position:ccp(x - (winSize.width/6), y - (winSize.height/2))];
    
    id rightMid = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                      position:ccp(x + (winSize.width/6), y - (winSize.height/1.5))];
    
    id leftLow = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                     position:ccp(x - (winSize.width/6), y - (winSize.height/1.2))];
    
    id rightLow = [CCMoveTo actionWithDuration:actualDuration/(6.0)
                                      position:ccp(x + (winSize.width/6), y - winSize.height)];
    
    if(zigZag == YES)
    {
        [devil1 runAction:[CCSequence actions:leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];
    }
    else
    {
        [devil1 runAction:actionMove];
    }
    
    //animation
    
    NSMutableArray *devil1fallFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil1fall.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil1fall.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    devil1fallFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 2; ++i)
    {
        [devil1fallFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d1-fall-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *devil1fallAnimation = [CCAnimation animationWithFrames: devil1fallFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *devil1fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil1fallAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [devil1 runAction:devil1fall];

}

-(void) addFriendlyMelee
{
    angel1 = [[Character alloc] initWithFriendlyMeleeImage];
    
    // Determine where to spawn the monster along the X axis
    int minX = 20;
    int maxX = winSize.width - 20;
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    while ((actualX < winSize.width * .57) && (actualX > winSize.width * .43))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    int minDuration = friendlyFallSpeed - 1;
    int maxDuration = friendlyFallSpeed + 1;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;

//    NSLog(@"friendly melee fall duration = %d", actualDuration);
    
    angel1.position = ccp(actualX, winSize.height);
    angel1.scale = .5;
    [self addChild:angel1];
    [goodGuys addObject:angel1];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -angel1.contentSize.height/2)];
    [angel1 runAction:actionMove];
    
    //animation
    
    NSMutableArray *angel1fallFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel1fall.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel1fall.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    angel1fallFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [angel1fallFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a1-fall-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    

    CCAnimation *angel1fallAnimation = [CCAnimation animationWithFrames: angel1fallFrames delay:0.15f];

    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel1fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel1fallAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [angel1 runAction:angel1fall];
}

-(void) addKmonster
{
    if(bigGoodGuysCounter > 0)
    {
        NSLog(@"said to add Kamikaze");
        CCSprite *Kmonster = [[Character alloc] initWithKamikazeImage];
        CCSprite *friendlyTankDummy = [[Character alloc] initWithFriendlyTankImage];
        ((Character*)Kmonster).speed = ((Character*)friendlyTankDummy).fallSpeed;
        Kmonster.scale=.3;
        
        // Determine where to spawn the monster along the Y axis
        for(int i = 0; i < [goodGuys count]; i++)
        {
            if([goodGuys count] > 0)
            {
                if(((Character*)[goodGuys objectAtIndex:i]).type == BIG_GOOD_GUY)
                {
                    goodGuy = [goodGuys objectAtIndex:i];
                }
            }
        }
        
        // Determine speed of the monster
        int minDuration2 = ((Character*)Kmonster).speed - 2.5;
        int maxDuration2 = ((Character*)Kmonster).speed - 1.5;
        int rangeDuration2 = maxDuration2 - minDuration2;
        int actualDuration2 = (arc4random() % rangeDuration2) + minDuration2;
       
        int KmonsterMaxY = goodGuy.position.y - (actualDuration2 * 25) - 50;
        int KmonsterMinY = KmonsterMaxY - 10;
        int rangeY = KmonsterMaxY - KmonsterMinY;
        int actualY = arc4random() % rangeY + KmonsterMinY;
        if(actualY < 130)
        {
            return;
        }
        
        [self addChild:Kmonster];
        [Kmonsters addObject:Kmonster];
        [badGuys addObject:Kmonster];
    
        //NSLog(@"detects big guy");
        if(bigGoodGuyDirection == 1)
        {
            //NSLog(@"senses big guy is on left");
            
            // Create the monster slightly off-screen along the right edge,
            // and along a random position along the Y axis as calculated above
            Kmonster.position = ccp(winSize.width + 20, actualY);
            
                    
            // Create the actions
            CCMoveTo * actionMoveLeft = [CCMoveTo actionWithDuration:actualDuration2
                                                                    position:ccp(-40, actualY)];
            // CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            //[node removeFromParentAndCleanup:YES];
            //}];
                    
            [Kmonster runAction:actionMoveLeft];
            
        }
                
        if(bigGoodGuyDirection == 2)
        {
            //NSLog(@"senses big guy is on right");
            Kmonster.position = ccp(-20, actualY);
                    
            // Create the actions
            CCMoveTo * actionMoveRight = [CCMoveTo actionWithDuration:actualDuration2
                                                                     position:ccp(winSize.width + 40, actualY)];
            // CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            //[node removeFromParentAndCleanup:YES];
            //}];
                    
            [Kmonster runAction:actionMoveRight];
        }
        
        //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devilplanemove.plist"];
        
        //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devilplanemove.png"];
        
        [self addChild:spriteSheet];
        
        //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
        
        //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
        
        NSMutableArray *devilHeliFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 4; ++i)
        {
            [devilHeliFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d4-%d.png", i]]];
        }
        
        //Create an animation from the set of frames you created earlier
        
        CCAnimation *devilHeliAnimation = [CCAnimation animationWithFrames: devilHeliFrames delay:0.1f];
        
        //Create an action with the animation that can then be assigned to a sprite
        
        CCAction *devilHeliMove = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devilHeliAnimation restoreOriginalFrame:NO]];
        
        //tell the bear to run the taunting action
        [Kmonster runAction:devilHeliMove];

    }
}

//-(void) addGoodGuy
//{
//    // Determine where to spawn the monster along the X axis
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    int minX = 12;
//    int maxX = winSize.width - 8;
//    int rangeX = maxX - minX;
//    int actualX = minX + arc4random() % rangeX;
//    
//    // Determine speed of the monster
//    minDuration = 3.5;
//    maxDuration = 6.0;
//
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
//    
//    // Create the monster slightly off-screen along the right edge,
//    // and along a random position along the Y axis as calculated above
//
//    enemy = [[Character alloc] initWithGoodGuyImage];
//    enemy.scale=.3;
//
//    enemy.position = ccp(actualX, winSize.height); //+ enemy.contentSize.height/2);
//    enemy.color = ccc3(0, 255, 0);
//    [self addChild:enemy];
//    [goodGuys addObject:enemy];
//    
//    // Create the actions
//    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
//                                                position:ccp(actualX, -enemy.contentSize.height/2)];
//    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
//    //            [node removeFromParentAndCleanup:YES];
//    //        }];
//
//    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];    
//}

-(void) addFriendlyRegularShooter
{
    angel2 = [[Character alloc] initWithFriendlyRegularShooterImage];
    
    // Determine where to spawn the monster along the X axis
    int minX = 20;
    int maxX = winSize.width - 20;
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    while ((actualX < winSize.width * .55) && (actualX > winSize.width * .45))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    int minDuration = friendlyFallSpeed - 1;
    int maxDuration = friendlyFallSpeed + 1;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;

//    NSLog(@"friendly regular shooter fall speed = %d", actualDuration);
    
//    int friendlyRegularShooterHealth = ((Character*)angel2).health;
//    NSLog(@"friendly regualr shooter health = %d", friendlyRegularShooterHealth);
    angel2.scale = .5;
    angel2.position = ccp(actualX, winSize.height);
    [self addChild:angel2];
    [goodGuys addObject:angel2];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -angel2.contentSize.height/2)];
    [angel2 runAction:actionMove];
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel2fall.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel2fall.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *angel2fallFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [angel2fallFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a2-fall-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *angel2fallAnimation = [CCAnimation animationWithFrames: angel2fallFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel2fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel2fallAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [angel2 runAction:angel2fall];
}

-(void) addEnemyRegularShooter
{
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    devil2 = [[Character alloc] initWithEnemyRegularShooterImage];
   
    devil2.scale = .5;
    [self addChild:devil2];
    [badGuys addObject:devil2];
    
    // Determine where to spawn the monster along the X axis
    int minX = 20;
    int maxX = winSize.width - 20;
    int rangeX = maxX - minX;
    int actualX = minX + arc4random() % rangeX;
    
    while ((actualX < winSize.width * .57) && (actualX > winSize.width * .43))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    devil2.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    
    // Determine speed of the monster
    minDuration = ((Character*)devil1).fallSpeed - 1.0;
    maxDuration = ((Character*)devil1).fallSpeed + 1.0;
    
    double rangeDuration = maxDuration - minDuration;
    double actualDuration = (((arc4random() % 100) * 1.0f) * .01 * rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -devil2.contentSize.height/2)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [devil2 runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil2fall.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil2fall.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *devil2fallFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [devil2fallFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d2-fall-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier

    CCAnimation *devil2fallAnimation = [CCAnimation animationWithFrames: devil2fallFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *devil2fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil2fallAnimation restoreOriginalFrame:NO]];
    
   
    
    //tell the bear to run the taunting action
    [devil2 runAction:devil2fall];
}

-(void) addEnemyHelicopter
{
//    NSLog(@"inside enemy helicopter");
    
    devilHeli = [[Character alloc] initWithBadHelicopterImage];
    
    // Determine where to spawn the monster along the Y axis
    int minY = winSize.height * .85;
    int maxY = winSize.height * .93;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Determine speed of the monster
    minDuration = ((Character*)devilHeli).speed - 1;
    maxDuration = ((Character*)devilHeli).speed + 1;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    [self addChild:devilHeli z:1];
    devilHeli.scale = .6;
    devilHeli.position = ccp(winSize.width, actualY); //+ enemy.contentSize.height/2);
    [badGuys addObject: devilHeli];
    enemyHelicopterCount++;
    
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(-100, actualY)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [devilHeli runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devilplanemove.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devilplanemove.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *devilHeliFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [devilHeliFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d4-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *devilHeliAnimation = [CCAnimation animationWithFrames: devilHeliFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *devilHeliMove = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devilHeliAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [devilHeli runAction:devilHeliMove];
}

- (void) addZigZagBadGuy
{
    int minX = 80;
    int maxX = winSize.width - 40;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX + minX;


//    minDuration = 3.5;
//    maxDuration = 6.0;
//    
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    

    
    zenemy = [[Character alloc] initWithEnemyMeleeImage];
    zenemy.scale=.15;
    zenemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
     zenemy.color = ccc3(255, 0, 0);
    [self addChild:zenemy];
    [badGuys addObject:zenemy];

    
    int x = zenemy.position.x;
    int y = zenemy.position.y;
    
  //  float timeInterval = 2.0f;

    
//    id delay = [CCDelayTime actionWithDuration:timeInterval];
    
    id leftTop = [CCMoveTo actionWithDuration:1.0
            position:ccp(x - 80, y - 60)];

    
    id rightTop = [CCMoveTo actionWithDuration:1.0
            position:ccp(x + 80, y - 120)];
    
    id leftMid = [CCMoveTo actionWithDuration:1.0
            position:ccp(x - 80, y - 180)];
    
    id rightMid = [CCMoveTo actionWithDuration:1.0
            position:ccp(x + 80, y - 240)];
    
 
    
    id leftLow = [CCMoveTo actionWithDuration:1.0
            position:ccp(x - 80, y - 300)];
    
    
    id rightLow = [CCMoveTo actionWithDuration:1.0
            position:ccp(x + 80, y - 360)];
    
    [zenemy runAction:[CCSequence actions:leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];
}



//-(void) zigLeft
//{
//    int x = zenemy.position.x;
//    int y = zenemy.position.y;
//    distance = -50;
//    
//    CCMoveTo *zLeft = [CCMoveTo actionWithDuration:2.0
//    position:ccp(x + distance, y - 40)];
//    [zenemy runAction:zLeft];
//    NSLog(@"zLeft");
//
//}
//
//
//-(void) zagRight
//{
//    int x = zenemy.position.x;
//    int y = zenemy.position.y;
//    distance = 50;
//
//    
//    CCMoveTo *zRight = [CCMoveTo actionWithDuration:2
//    position:ccp(x + distance, y - 40)];
//    [zenemy runAction:zRight];
//    NSLog(@"zRight");
//}

-(void) addFriendlyTank
{
    CCSprite *angelTank = [[Character alloc] initWithFriendlyTankImage];
    if(arc4random() % 2 == 0)
    {
        bigGoodGuyMinX = 30;
        bigGoodGuyMaxX = 130;
        bigGoodGuyDirection = 1;
    }
    else
    {
        bigGoodGuyMinX = winSize.width - 130;
        bigGoodGuyMaxX = winSize.width - 30;
        bigGoodGuyDirection = 2;
    }
    int rangeX = bigGoodGuyMaxX - bigGoodGuyMinX;
    int actualX = arc4random() % rangeX + bigGoodGuyMinX;
    
    minDuration = ((Character*)angelTank).fallSpeed - .3;
    maxDuration = ((Character*)angelTank).fallSpeed + .3;
    double rangeDuration = maxDuration - minDuration;
    double actualDuration = (((arc4random() % 100) * 1.0f) * .01 * rangeDuration) + minDuration;
    
    angelTank.scale = .8;
    angelTank.position = CGPointMake(actualX, winSize.height + 30);
    [self addChild:angelTank];
    [goodGuys addObject:angelTank];
    bigGoodGuysCounter++;
    CCMoveTo *actionMove = [CCMoveTo actionWithDuration:actualDuration
                                               position:ccp(actualX, -angelTank.contentSize.height/2)];
    [angelTank runAction:actionMove];
    NSLog(@"added angel tank");
}


-(void) addEnemyTank
{
    CCSprite *devilTank = [[Character alloc] initWithEnemyTankImage];
    
    // Determine where to spawn the monster along the X axis
    int minX = 50;
    int maxX = winSize.width - 50;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX + minX;
    
    while ((actualX < winSize.width * .55) && (actualX > winSize.width * .45))
    {
        actualX = minX + arc4random() % rangeX;
    }
    
    // Determine speed of the monster2
    minDuration = ((Character*)devilTank).fallSpeed - 1;
    maxDuration = ((Character*)devilTank).fallSpeed + 1;
    double rangeDuration = maxDuration - minDuration;
    double actualDuration = (((arc4random() % 100) * 1.0f) * .01 * rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    devilTank.scale = .8;
    devilTank.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:devilTank];
    [badGuys addObject:devilTank];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -devilTank.contentSize.height/2)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [devilTank runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
}
-(void) addPlayer
{
    player = [CCSprite spriteWithFile:@"main-idle-15.png"];
    
    player.anchorPoint = CGPointZero;
    player.position = CGPointMake(winSize.width * .5, MOUNTAIN_HEIGHT + 20);
    player.scale = .2;
    //player.color = ccc3(249, 173, 22);
    //player.visible = true;
    
    [self addChild:player z:1000];
    
}

-(void) addCoin:(BOOL)sameSpot
{
    CCSprite *coin = [[Character alloc] initWithCoinImage];
    
    // Determine where to spawn the monster along the X axis
    int actualX;
    int actualDuration;
    int rangeDuration;
    if(sameSpot == NO)
    {
        int minX = winSize.width * .05;
        int maxX = winSize.width * .95;
        int rangeX = maxX - minX;
        actualX = (arc4random() % rangeX) + minX;
        previousCoinX = actualX;
    }
    else
    {
        actualX = previousCoinX;
    }
    
//    NSLog(@"coin fallSpeed = %d", ((Character*)coin).fallSpeed);
    
    // Determine speed of the monster2
    if(waveChanging == true)
    {
//        if(sameSpot == NO)
//        {3
            minDuration = ((Character*)coin).endgameFallSpeed - 1;
            maxDuration = ((Character*)coin).endgameFallSpeed + 1;
            rangeDuration = maxDuration - minDuration;
            actualDuration = (arc4random() % rangeDuration) + minDuration;
            previousCoinDuration = actualDuration;
//        }
//        else
//        {
//            actualDuration = previousCoinDuration;
//        }
    }
    else
    {
        minDuration = ((Character*)coin).fallSpeed - 1;
        maxDuration = ((Character*)coin).fallSpeed + 1;
        rangeDuration = maxDuration - minDuration;
        actualDuration = (arc4random() % rangeDuration) + minDuration;
    }
    
    
    coin.position = CGPointMake(actualX, winSize.height - 10);
    NSLog(@"coin x = %d", actualX);
    NSNumber *repeatingSpot = [NSNumber numberWithBool:sameSpot];
    NSLog(@"same spot? = %@", repeatingSpot);
    coin.scale = .3;
    [self addChild:coin];
    [coinsArray addObject:coin];
    
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -20)];
    [coin runAction:actionMove];
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"coinDrop.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"coinDrop.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *animationFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; i++)
    {
        [animationFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"Dollar-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *animation = [CCAnimation animationWithFrames: animationFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *fall = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [coin runAction:fall];
}

-(id) init
{
	if ((self = [super init]))
	{
        
//        self.isAccelerometerEnabled = YES;
//        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:
//         (1.0 / 60)];
       
        //[self changeLevel];
        //[self addPlayer];
        
        [self setIsTouchEnabled:YES];
        
        bananasToDelete = [[NSMutableArray alloc] init];
        enemiesToDelete= [[NSMutableArray alloc] init];
//  helicopters = [[NSMutableArray alloc] init];
        bananaArray = [[NSMutableArray alloc] init];
        goodGuys = [[NSMutableArray alloc] init];
        badGuys = [[NSMutableArray alloc] init];
        Kmonsters = [[NSMutableArray alloc] init];
        goodGuysBottom = [[NSMutableArray alloc] init];
        badGuysBottom = [[NSMutableArray alloc] init];
        goodBulletArray = [[NSMutableArray alloc] init];
        badBulletArray = [[NSMutableArray alloc] init];
        bombers = [[NSMutableArray alloc] init];
        badBars = [[NSMutableArray alloc] init];
        goodBombs = [[NSMutableArray alloc] init];
        badBombs = [[NSMutableArray alloc] init];
        zigZagScenarioEnemies = [[NSMutableArray alloc] init];
        coinsArray = [[NSMutableArray alloc] init];
        deadBases = [[NSMutableArray alloc] init];
//        badHelicopters = [[NSMutableArray alloc] init];

        previousCoinX = 200;
        framecount = 0;
        //monstercount = 0;
        //numberOfEnemies = 10;
        //helicopterDelayCounter = 0;
        //zigZagDelayCounter = 0;
        //zigZagScenarioCounter = 0;
        goodReinforcementCount = 0;
        bombCount = 0;
        enemiesKilled = 0;
        enemiesKilledCounter = 0;
        //bar = 240;
        helicoptersRemoved = 0;
        randNum = 0;
        KmonsterCounter = 0;
        bigGoodGuysCounter = 0;
        waveChangeCounter = 0;
        bigGoodGuyMaxX = 0;
        bigGoodGuyMinX = 0;
        immunityFramecount = 0;
        coinInterludeCounter = 0;
        coinDelayCounter = 0;
        friendlyTankFramecount = 0;
        startSpawnDelay = 650;


        //deathFramecount = 60 * 30;
        //timeRemaining = 30;
        bigGoodGuyDirection = 0;
        pointsFramecount = 0;
        score = 1;
        enemiesPassed = 0;
        friendliesPassed = 0;
        enemyHelicopterCount = 0;
        firstHeli = true;
        firstBigGoodGuy = true;
        firstZigZag = true;
        firstBigMonster = true;
        Scenario1 = false;
        Scenario2 = false;
        Scenario2interlude = false;
        Scenario3 = false;
        Scenario4 = false;
        isWalking = true;
        waveChanging = false;
        coinInterlude = false;
        wentToInGameShop = false;
        wave = 1;
        immunity = false;
        firstTimeCoin = true;
        orbsDeleted = 0;
        winSize = [CCDirector sharedDirector].winSize;
        explosionAnimationLength = .2;
        dyingAnimationLength = .2;
        immunityLength = 400;
        numReinforcments = 4;
        reinforcementFramecount = 50;
        reinforcementsSpawned = 0;
        reinforcements = false;
        badBaseExploded = false;
        goodBaseExploded = false;
        friendlyTankAvailable = NO;
        addedImmunityCounter = false;
        scenario2Prelude = false;
        scenario2PreludeCounter = 0;
        scenarioDelayCounter = 0;
        scenario2interludeCounter = 0;
        devilStartingWidth = winSize.width - 100;
        angelStartingWidth = 30;
        coinsInARow = 0;
        previousCoinDuration = 0;
        calledYouWin = 0;
        betweenCoinRowDelay = 0;
        friendlyRegularShooterModifier = (int)(arc4random() * baseCount);
        friendlyMeleeModifier = (int)(arc4random() * baseCount);
        friendlyFastShooterModifier = (int)(arc4random() * baseCount) + 100;
        enemyMeleeModifier = (int)(arc4random() * baseCount);
        enemyRegularShooterModifier = (int)(arc4random() * baseCount);
        enemyTankModifier = (int)(arc4random() * baseCount);
        coinModifier = (int)(arc4random() * baseCount);
        scenarioModifier = (int)(arc4random() * (gameplayCoinFramecount/100));
        
        
        [GameData sharedData].coinsGained = 0;
        currentLevelSelected = [GameData sharedData].currentLevelSelected;
        NSLog(@"level selected = %d", currentLevelSelected);
        
        
   //     [self addBaseBars];
        [self addBases];
    //    [self addBadRedBar];
        
        NSNumber *highScore = [NSNumber numberWithInteger:0];
        [[NSUserDefaults standardUserDefaults] setObject:highScore forKey:@"highScore"];
        firstTime = true;
        
//        Modifies frequency
//        friendlyRegularShooterFramecount = 200 - (wave * 10);
//        enemyRegularShooterFramecount = 200 - (wave * 10);
        helicopterBombFramecount = 50 - (wave * 5);
//        KmonsterFramecount = 30 - (wave * 3);
        helicopterFramecount = 200;
//        zigZagFramecount = 250;
//        enemyFrequency = 300 - (wave * 20);
//        friendlyFrequency = 500 - (wave * 17);
//        friendlyFastShooterFramecount = 240 - (wave * 6);
//        enemyFastShooterFramecount = 230 - (wave * 8);
//        friendlyMeleeFramecount = 215 - (wave * 5);
//        enemyMeleeFramecount = 210 - (wave * 8);
        
        [self loadLevelSettings];
        
        
        /*
        //Animating bear
        goodTeamCounter = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
        goodTeamCounter.anchorPoint = CGPointZero;
        goodTeamCounter.position = CGPointMake(bar - 40, goodTeamCounter.contentSize.height/2 - 35);
        goodTeamCounter.scale = .5;
        //Create an animation from the set of frames you created earlier
        
        CCAnimation *taunting = [CCAnimation animationWithFrames: tauntingFrames delay:0.2f];
        
        //Create an action with the animation that can then be assigned to a sprite
        
        taunt = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:taunting restoreOriginalFrame:NO]];
        
        //tell the bear to run the taunting action
        [goodTeamCounter runAction:taunt];
        [self addChild:goodTeamCounter z:1];
        
        
        //Animating knight
        badTeamCounter = [CCSprite spriteWithSpriteFrameName:@"animation_knight-1Flipped.png"];
        badTeamCounter.anchorPoint = CGPointZero;
        badTeamCounter.position = CGPointMake(bar + 35, badTeamCounter.contentSize.height/2 - 105);
        badTeamCounter.scale = .2;
        //Create an animation from the set of frames you created earlier
        
        CCAnimation *attacking = [CCAnimation animationWithFrames: knightAttackFrames delay:0.2f];
        
        //Create an action with the animation that can then be assigned to a sprite
        
        knightAttack = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:attacking restoreOriginalFrame:NO]];
        
        //tell the bear to run the taunting action
        [badTeamCounter runAction:knightAttack];
        [self addChild:badTeamCounter z:1];
   */
        
        //Background and placeholders -Henry
        
//            enemiesKilledLabel = [CCLabelTTF labelWithString:@"Enemies Killed:0" fontName:@"Marker Felt" fontSize:18];
//        enemiesKilledLabel.position = ccp(360, 300);
//        enemiesKilledLabel.color = ccBLUE;
//        [self addChild:enemiesKilledLabel z:4];

//        timeRemainingLabel = [CCLabelTTF labelWithString:@"Time left: 30" fontName:@"Marker Felt" fontSize:18];
//        timeRemainingLabel.position = ccp(360, 260);
//        timeRemainingLabel.color = ccBLUE;
//        [self addChild:timeRemainingLabel z:4];
        
//        LevelLabel = [CCLabelTTF labelWithString:@"Level:0" fontName:@"Marker Felt" fontSize:18];
//        LevelLabel.position = ccp(360, 280);
//        LevelLabel.color = ccBLUE;
//        [self addChild:LevelLabel z:4];
        
        
        bonusCoinsLabel = [CCLabelTTF labelWithString:@"Bonus Coins!" fontName:@"Algerian" fontSize:30];
        bonusCoinsLabel.position = ccp(-winSize.width * .5, winSize.height * .7);
        bonusCoinsLabel.color = ccBLACK;
        [self addChild:bonusCoinsLabel z:4];
        
        coinslabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [coinslabel setString:[NSString stringWithFormat:@"coins:%d", [[MGWU objectForKey:@"coins"] intValue]]];
        coinslabel.position = ccp(winSize.width * .67,winSize.height * .95);
        coinslabel.color = ccBLACK;
        [self addChild:coinslabel z:4];
        
        levelLabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [levelLabel setString:[NSString stringWithFormat:@"level:%d", currentLevelSelected]];
        levelLabel.position = ccp(winSize.width * .35,winSize.height * .95);
        levelLabel.color = ccBLACK;
        [self addChild:levelLabel z:4];
        
        goodBaseHealthLabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [goodBaseHealthLabel setString:[NSString stringWithFormat:@"%d",((Character*)goodBase).health]];
        goodBaseHealthLabel.position = ccp(44, BASE_HEIGHT * 2.1);
        goodBaseHealthLabel.color = ccBLACK;
        [self addChild:goodBaseHealthLabel z:4];
        
        badBaseHealthLabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [badBaseHealthLabel setString:[NSString stringWithFormat:@"%d",((Character*)badBase).health]];
        badBaseHealthLabel.position = ccp(winSize.width - 40, BASE_HEIGHT * 2.1);
        badBaseHealthLabel.color = ccBLACK;
        [self addChild:badBaseHealthLabel z:4];
        
        immunityCounterLabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        immunityCounterLabel.position = ccp(winSize.width/2, winSize.height * .7);
        immunityCounterLabel.color = ccBLUE;
        
        
        int width = winSize.width;
        
        if(width == 568)
        {
        CCSprite *background = [CCSprite spriteWithFile:@"sky-ip5.png"];
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        CCSprite *wall = [CCSprite spriteWithFile:@"foreground-ip5.png"];
        wall.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:wall z:1];
        
        CCSprite *mountains = [CCSprite spriteWithFile:@"mountain-ip5.png"];
            mountains.scale *=1;
            mountains.position = ccp(winSize.width/2,winSize.height/2);
            [self addChild:mountains z:0];
        }
        
        if(width == 480)
        {
            CCSprite *background = [CCSprite spriteWithFile:@"sky-hd.png"];
            background.position = ccp(winSize.width/2,winSize.height/2);
            [self addChild:background z:-1];
            
            CCSprite *wall = [CCSprite spriteWithFile:@"foreground-hd.png"];
            wall.position = ccp(winSize.width/2,winSize.height/2);
            [self addChild:wall z:1];
            
            CCSprite *mountains = [CCSprite spriteWithFile:@"mountain-hd.png"];
            mountains.scale *=1;
            mountains.position = ccp(winSize.width/2,winSize.height/2);
                  [self addChild:mountains z:0];
        }
        
        player = [CCSprite spriteWithFile:@"main-idle-1.png"];
        player.position = ccp(winSize.width * .5, winSize.height * .3);
        [self addChild:player z:1];
        [self mainCharacterIdleAnimation:player];
        
        buttonSpacing = winSize.width *.08;
        int farLeftX = winSize.width * .05;
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemWithNormalImage:@"pause_btn.png"
                                                              selectedImage: @"pause_btn.png"
                                                                     target:self
                                                                   selector:@selector(pauseMenu:)];
        pauseButton.position = CGPointMake(winSize.width * .96, winSize.height * .93);
        pauseButton.scale = .7;
        
        CCMenuItemImage *shopButton = [CCMenuItemImage itemWithNormalImage:@"shop-button-n.png"
                                                             selectedImage: @"shop-button-d.png"
                                                                    target:self
                                                                  selector:@selector(shop:)];
        shopButton.position = CGPointMake(winSize.width * .85, winSize.height * .94);
        shopButton.scale = .5;
        
    
        CCMenuItemImage *immunityPowerUp = [CCMenuItemImage itemWithNormalImage:@"immunity_btn.png" selectedImage:@"immunity_btn.png"
        target: self
        selector:@selector(immunityActivator:)];
        
        immunityPowerUp.position= CGPointMake ((farLeftX + (2 * buttonSpacing)), winSize.height * .93);
        immunityPowerUp.scale = 0.7f;

        
        CCMenuItemImage *reinforcementPowerUp = [CCMenuItemImage itemWithNormalImage:@"reinforcement_btn.png" selectedImage:@"reinforcement_btn.png"
                                                                                target: self
                                                                      selector:@selector(reinforcements:)];
        
        reinforcementPowerUp.position= CGPointMake ((farLeftX + buttonSpacing), winSize.height * .93);
        reinforcementPowerUp.scale = .7f;
        
        
        CCMenuItemImage *airstrikePowerUp = [CCMenuItemImage itemWithNormalImage:@"airstrike_btn.png" selectedImage:@"airstrike_btn.png"
                                                                        target: self
                                                                    selector:@selector(airstrike:)];
        airstrikePowerUp.position= CGPointMake (farLeftX, winSize.height * .93);
        airstrikePowerUp.scale = 0.7f;
        
        CCMenu *myMenu = [CCMenu menuWithItems:pauseButton, shopButton, airstrikePowerUp, reinforcementPowerUp, immunityPowerUp, nil];
        myMenu.position = ccp(0,0);
        [self addChild: myMenu z:100];

        
        NSNumber *NSNumAvailable1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"];
        int numAvailable1 = [NSNumAvailable1 intValue];
        
        counterSpacing = (winSize.width *.085);
        
        airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [airstrikeCount setString:[NSString stringWithFormat:@"%d", numAvailable1]];
        airstrikeCount.position = CGPointMake(winSize.width *.08 + winSize.width *.005, winSize.height - winSize.height/8);
        airstrikeCount.color = ccBLACK;
        [self addChild:airstrikeCount z:5000];
        
         NSNumber *NSNumAvailable2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"];
        int numAvailable2 = [NSNumAvailable2 intValue];
        
        reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", numAvailable2]];
        reinforcemtsCount.position = CGPointMake(winSize.width *.08 + counterSpacing, winSize.height - winSize.height/8);
        reinforcemtsCount.color = ccBLACK;
        [self addChild:reinforcemtsCount z:5000];
        
        NSNumber* NSNumAvailable3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"];
        int numAvailable3 = [NSNumAvailable3 intValue];
        
        immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [immunityCount setString:[NSString stringWithFormat:@"%d", numAvailable3]];
        immunityCount.position = CGPointMake(winSize.width *.08 + (counterSpacing * 2), winSize.height - winSize.height/8);
        immunityCount.color = ccBLACK;
        [self addChild:immunityCount z:5000];
        
        
   //     [self changeLevel];
        
        
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }

        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeSound"] boolValue] == false)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:true] forKey:@"sfx"];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:true] forKey:@"firstTimeSound"];
            
        }

        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstTimeMusic"] boolValue] == false)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:true] forKey:@"music"];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:true] forKey:@"firstTimeMusic"];

        }


        [[SimpleAudioEngine sharedEngine] preloadEffect:@"explo2.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"friendly.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"coin.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Xplode.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"thud.wav"];

            
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:(@"The Descent.mp3")];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:(@"The Descent.mp3") loop:YES];
            }
        }
        
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    //determine whether to push to tutorial layer
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 0 && [GameData sharedData].currentLevelSelected == 1)
    {
        [[CCDirector sharedDirector] pushScene: (CCScene *)[[TutorialLayer alloc]  init]];
    }
    
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 1 && [GameData sharedData].currentLevelSelected == 2)
    {
        NSLog(@"aqui");
        //give player 1 airstrike
        NSNumber *NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"];
        int numAvailable1 = [NSNumAvailable intValue];
        numAvailable1++;
        NSNumber *newNumAvailable1 = [NSNumber numberWithInt:numAvailable1];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable1 forKey: @"airstrikesAvailable"];
        [airstrikeCount setString:[NSString stringWithFormat:@"%@", newNumAvailable1]];
        
        //give player 1 immunity
        NSNumber *NSNumAvailable2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"];
        int numAvailable2 = [NSNumAvailable2 intValue];
        numAvailable2++;
        NSNumber *newNumAvailable2 = [NSNumber numberWithInt:numAvailable2];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable2 forKey: @"immunityAvailable"];
        [airstrikeCount setString:[NSString stringWithFormat:@"%@", newNumAvailable2]];
        
        //give player 1 reinforcements
        NSNumber *NSNumAvailable3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"];
        int numAvailable3 = [NSNumAvailable3 intValue];
        numAvailable3++;
        NSNumber *newNumAvailable3 = [NSNumber numberWithInt:numAvailable3];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable3 forKey: @"reinforcementsAvailable"];
        [airstrikeCount setString:[NSString stringWithFormat:@"%@", newNumAvailable3]];
        
        [[CCDirector sharedDirector] pushScene:(CCScene *)[[TutorialLayer alloc] init]];
    }
    
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 2 && [GameData sharedData].currentLevelSelected == 3)
    {
        NSLog(@"alla");
        [[CCDirector sharedDirector] pushScene:(CCScene *)[[TutorialLayer alloc]  init]];
    }

    
//    if(framecount % 500 == 0)
//    {
//        for(int i = 0; i < [goodGuysBottom count]; i++)
//        {
//            ((Character*)[goodGuysBottom objectAtIndex:i]).melee = true;
//        }
//    }
//    if(framecount % 800 == 0)
//    {
//        for(int i = 0; i < [goodGuysBottom count]; i++)
//        {
//            ((Character*)[goodGuysBottom objectAtIndex:i]).melee = false;
//        }
//    }
    

    /*
    goodTeamCounter.position = CGPointMake(bar - 40, goodTeamCounter.contentSize.height/2 - 35);
    badTeamCounter.position = CGPointMake(bar, badTeamCounter.contentSize.height/2 - 115);
    
    if(bar >= 480)
     
    {
       
            [self addLevel];
            NSLog(@"Starting level %d", level);
            bar = 240;
        
        
        //[[SimpleAudioEngine sharedEngine] playEffect:@"thatWasEasy.wav"];
    }
    if(bar <= 0)
    {
        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
    }
    */

    
   
    
    
//    if([badGuysBottom count] > 0 && [goodGuysBottom count] == 0)
//    {
//        deathFramecount--;
//        timeRemaining = (int)(deathFramecount/60);
//        [self timeRemaining];
//    }
//    if(deathFramecount <= 0)
//    {
//        [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
//    }
//    if([badGuysBottom count] == 0 && [goodGuysBottom count] > 0)
//    {
//        pointsFramecount++;
//        score += (int)(pointsFramecount/60);
//    }
    
//    if(framecount % 50 == 0)
//    {
//        CCSprite *fakeBullet = [[Character alloc] initWithGoodGuyBulletImage];
//        [self subtractBadBaseHealth:fakeBullet];
//        [self subtractGoodBaseHealth:fakeBullet];
//    }
    
//    if(framecount % 200 == 0)
//    {
//        NSLog(@"good guys bottom count = %lu, bad guys bottom count = %lu", (unsigned long)[goodGuysBottom count], (unsigned long)[badGuysBottom count]);
//    }
    
        framecount++;
    
    if([bananaArray count] > 0)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            CCSprite *blueOrb = [bananaArray objectAtIndex:i];
            if(blueOrb.position.x > winSize.width + 20 || blueOrb.position.x < -20 || blueOrb.position.y > winSize.height + 20)
            {
                [bananasToDelete addObject:blueOrb];
//                [bananaArray removeObject:blueOrb];
//                NSLog(@"recognized banana should be deleted");
            }
        }
    }
    
    for (CCSprite *s in bananasToDelete)
    {
        [bananaArray removeObject:s];
        [self removeChild:s cleanup:YES];
//        NSLog(@"removed banana");
//        orbsDeleted++;
//        NSLog(@"orbs deleted = %d", orbsDeleted);
    }
    [bananasToDelete removeAllObjects];
    
    if(Scenario2interlude == true)
    {
        scenario2interludeCounter++;
        if(scenario2interludeCounter % 40 == 0)
        {
            Scenario2interlude = false;
            Scenario2 = false;
            NSLog(@"scenario 2 = false");
            scenario2interludeCounter = 0;
        }
    }
    
    if(scenario2Prelude == true)
    {
        scenario2PreludeCounter++;
        if(scenario2PreludeCounter == 100)
        {
            Scenario2 = true;
            [self addFriendlyTank];
            scenario2Prelude = false;
            NSLog(@"scenario2 Prelude = false");
            scenario2PreludeCounter = 0;
        }
    }
    
    if(Scenario1 != true && scenario2Prelude != true && Scenario2 != true && Scenario3 != true && Scenario4 != true && waveChanging == false  && scenariosAvailable > 0)
    {
        scenarioDelayCounter++;
        
        if(scenarioDelayCounter % scenarioDelay == 0)
        {
            NSLog(@"called create scenario");
            [self createScenario];
            scenarioDelayCounter = 0;
        }
    }
    
    // b/c if all 3 friendlies are available, we want approx. 1 to come every X frames, or all three in a 3X frame cycle. baseCount * 100 should equal the total cycle, which should also be the plist value of friendlyFastShooter (if baseCount = 6, that means the big cycle and the plist value of friendlyFastShooter should be 600)
    
//    friendlyRegularShooterModifier;
//    friendlyMeleeModifier;
//    friendlyFastShooterModifier;
//    enemyMeleeModifier;
//    enemyRegularShooterModifier;
//    coinModifier;
//    scenarioModifier;
    
    
    if(framecount % enemyMeleeReinforcementFramecount == 0 && waveChanging == false && (framecount > startSpawnDelay || [GameData sharedData].currentLevelSelected < 3))
    {
        CCSprite *enemyMelee = [[Character alloc] initWithEnemyMeleeImage];
        enemyMelee.scale = .5;
        [self spawnBottom:enemyMelee :enemyMelee: NO];
        [self devil1walkAnimation:enemyMelee];
        NSLog(@"enemyMeleeReinforcementCount = %d", enemyMeleeReinforcementFramecount);
    }
    
    if(friendlyMeleeReinforcementFramecount > 0 && framecount % friendlyMeleeReinforcementFramecount == 0 && waveChanging == false)
    {
        CCSprite *friendlyMelee = [[Character alloc] initWithFriendlyMeleeImage];
        friendlyMelee.scale = .5;
        [self spawnBottom:friendlyMelee :friendlyMelee: YES];
        [self angel1walkAnimation:friendlyMelee];
    }
    
    if(framecount == 30)
    {
        [self addEnemyMelee:NO :NO];
    }
    
    if (Scenario1 != true && scenario2Prelude !=true && Scenario2 != true && Scenario3 != true && scenario3Interlude != true && Scenario4 != true && waveChanging == false)
    {
//        if((firstZigZag == true || zigZagDelayCounter % 250 == 0) && (firstBigMonster == true || bigMonsterDelayCounter % 200 == 0))
//        {
            //[self addBigGoodGuy];
            //[self addBigMonster];
            
            if((framecount + friendlyRegularShooterModifier) % friendlyRegularShooterFramecount == 0 && [GameData sharedData].friendlyRegularShooterAvailable == true)
            {
//                NSLog(@"add friendly regular shooter");
                [self addFriendlyRegularShooter];
                friendlyRegularShooterModifier = (int)(arc4random() * baseCount);
            }
            if((framecount + friendlyMeleeModifier) % friendlyMeleeFramecount == 0 && [GameData sharedData].friendlyMeleeAvailable == true)
            {
//                NSLog(@"add friendly melee");
                [self addFriendlyMelee];
                friendlyMeleeModifier = (int)(arc4random() * baseCount);
            }
            if((framecount + friendlyFastShooterModifier) % friendlyFastShooterFramecount == 0 && [GameData sharedData].friendlyFastShooterAvailable == true)
            {
//                NSLog(@"add friendly fast shooter");
                [self addFriendlyFastShooter];
                friendlyFastShooterModifier = (int)(arc4random() * baseCount);
            }
            if((framecount + enemyMeleeModifier) % enemyMeleeFramecount == 0 && enemyMeleeAvailable == true)
            {
//                NSLog(@"add enemy melee");
//  need to make it so that zizZag spawns sometimes          arc4random()
                if([GameData sharedData].currentLevelSelected > 1 && ([self generateRandomNumber:zigZagFrequency] == 1))
                {
                    [self addEnemyMelee:YES:NO];
                }
                else
                {
                    [self addEnemyMelee:NO:NO];
                }
                enemyMeleeModifier = (int)(arc4random() * baseCount);

            }
            if((framecount + enemyRegularShooterModifier) % enemyRegularShooterFramecount == 0 && enemyRegularShooterAvailable == true)
            {
//                NSLog(@"add enemy regular shooter");
                [self addEnemyRegularShooter];
                enemyRegularShooterModifier = (int)(arc4random() * baseCount);
            }
        
            if((framecount + enemyTankModifier) % enemyTankFramecount == 0 && enemyTankAvailable == true)
            {
                [self addEnemyTank];
                enemyTankModifier = (int)(arc4random() * baseCount);
            }
        
            if((framecount + coinModifier) % gameplayCoinFramecount == 0)
            {
                [self addCoin:NO];
                coinModifier = (arc4random() * gameplayCoinFramecount);
            }
        
        if(friendlyTankAvailable == true && framecount % friendlyTankFramecount == 0)
        {
            scenario2Prelude = true;
            NSLog(@"scenario2 prelude called");
        }
//        }
    }
    
//    if(framecount % 10 == 0 && calledYouWin == 0)
//    {
//        [self youWin];
//        calledYouWin++;
//    }
    if(scenario3Interlude == true)
    {
        scenario3InterludeCounter++;
        if(scenario3InterludeCounter == 80)
        {
            scenario3InterludeCounter = 0;
            scenario3Interlude = false;
            Scenario3 = true;
            [self zigZagScenario];
            NSLog(@"switched to scenario 3");
        }
    }
    
    if(waveChanging == true)
    {
        if(coinDelayCounter < 300)
        {
            coinDelayCounter++;
        }
        
        if((framecount % endgameCoinFramecount == 0) && (endgameCoinCount < endgameCoinTotal) && coinDelayCounter == 300)
        {
//            NSLog(@"should add coin");
            endgameCoinCount++;
            if(coinsInARow < 4 && firstTimeCoin == false)
            {
                [self addCoin:YES];
                coinsInARow++;
            }
            else
            {
                if(betweenCoinRowDelay == 1)
                {
                    [self addCoin:NO];
                    firstTimeCoin = false;
                    coinsInARow = 1;
                    betweenCoinRowDelay = 0;
                }
                else
                {
                    betweenCoinRowDelay++;
                }
                
            }
            
            if(endgameCoinTotal == endgameCoinCount)
            {
                coinInterlude = true;
            }
        }
        
        if(coinInterlude == true)
        {
            coinInterludeCounter++;
            if(coinInterludeCounter == 200)
            {
                coinInterlude = false;
                coinInterludeCounter = 0;
                waveChanging = false;
                if([GameData sharedData].coinsGained < 10 && [GameData sharedData].currentLevelSelected == 1)
                {
                    [self addCoins:(10 - [GameData sharedData].coinsGained)];
                }
                if([GameData sharedData].coinsGained < 15 && [GameData sharedData].currentLevelSelected == 2)
                {
                    [self addCoins:(15 - [GameData sharedData].coinsGained)];
                }
                if([GameData sharedData].coinsGained < 22 && [GameData sharedData].currentLevelSelected == 3)
                {
                    [self addCoins:(22 - [GameData sharedData].coinsGained)];
                }
                [[CCDirector sharedDirector] replaceScene: (CCScene*)[[VictoryLayer alloc] init]];
            }
        }
    }
    
    
//    if([badBulletArray count] > 0)
//    {
//        [self goodBaseCollisions];
//    }
//    if([goodBulletArray count] > 0)
//    {
//        [self badBaseCollisions];
//    }
    
    NSMutableArray* deadHelicopters = [[NSMutableArray alloc] init];
    
    if(enemyHelicopterCount > 0)
    {
//        NSLog(@"recognized enemy helicopters > 0");
        
        for(int i = 0; i < [badGuys count]; i++)
        {
            if(((Character*)[badGuys objectAtIndex:i]).type == BAD_HELICOPTER)
            {
                helicopter = [badGuys objectAtIndex:i];
                
                if(framecount % enemyBombFramecount == 0 && helicopter.position.x > 10 && helicopter.position.x < 470)
                {
                    bomb = [[Character alloc] initWithBadHelicopterBombImage];
                    
                    // Determine speed of the monster
                    int minDuration = ((Character*)bomb).fallSpeed - 1;
                    int maxDuration = ((Character*)bomb).fallSpeed + 1;
                    int rangeDuration = maxDuration - minDuration;
                    int actualDuration = (arc4random() % rangeDuration) + minDuration;
                    
                    bomb.scale = .6;
                    bomb.position = CGPointMake(helicopter.position.x, helicopter.position.y - helicopter.contentSize.height/4); //+ enemy.contentSize.height/2);
                    [self addChild:bomb z:2];
                    [badBombs addObject:bomb];
                    [badGuys addObject:bomb];
                    
                    // Create the actions
                    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                                position:ccp(bomb.position.x, -20)];
                    
                    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                    //            [node removeFromParentAndCleanup:YES];
                    //        }];
                    [bomb runAction:actionMove];
                }
                if(helicopter.position.x <= -20)
                {
                    [deadHelicopters addObject:helicopter];
                    Scenario1 = false;
                    NSLog(@"scenario 1 = false");
                    //NSLog(@"removed helicopter");
                    //spawnedHelicopters = 0;
                }
            }
        }
        for (CCSprite *s in deadHelicopters)
        {
            [badGuys removeObject:s];
            [self explosion:s :explosionAnimationLength :YES];
            enemyHelicopterCount--;
        }
        [deadHelicopters removeAllObjects];
    }
    
    NSMutableArray *deadBombers = [[NSMutableArray alloc] init];
    
    if ([bombers count] > 0)
    {
        for(int i = 0; i < [bombers count]; i++)
        {
            bomber = [bombers objectAtIndex:i];
            if(framecount % ((Character*)bomber).attackFrequency == 0 && bomber.position.x > 20 && bomber.position.x < winSize.width)
            {
                CGPoint bomberPosition = ccp(bomber.position.x, bomber.position.y - 12);

                bomb = [[Character alloc] initWithGoodHelicopterBombImage];
                int minDuration = ((Character*)bomb).fallSpeed - 1;
                int maxDuration = ((Character*)bomb).fallSpeed + 1;
                int rangeDuration = maxDuration - minDuration;
                int actualDuration = (arc4random() % rangeDuration) + minDuration;
                bomb.scale=.6;
                bomb.position = bomberPosition; //+ enemy.contentSize.height/2);
                [self addChild:bomb z:2];
                [goodBombs addObject:bomb];
//                [goodGuys addObject:bomb];
                
                CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                            position:ccp(bomb.position.x, -bomb.contentSize.height/2)];
                //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                //            [node removeFromParentAndCleanup:YES];
                //        }];
                [bomb runAction:actionMove];
            }
        
            if(bomber.position.x > winSize.width + 10)
            {
                [deadBombers addObject:bomber];
            }
        }
    }
    
    for(CCSprite *s in deadBombers)
    {
        [bombers removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    
    if(bigGoodGuysCounter > 0)
    {
        if(framecount % KmonsterFramecount == 0)
        {
            [self addKmonster];
            firstBigGoodGuy = false;
        }
    }
    
    NSMutableArray *deadKmonsters = [[NSMutableArray alloc] init];
        
    if([Kmonsters count] > 0)
    {
        for(int i = 0; i < [Kmonsters count]; i++)
        {
            CCSprite* kamikaze = [Kmonsters objectAtIndex:i];
            if(kamikaze.position.x < -30 || kamikaze.position.x > winSize.width + 30)
            {
                [deadKmonsters addObject:kamikaze];
            }
        }
    }
        
    for (CCSprite *s in deadKmonsters)
    {
        [Kmonsters removeObject:s];
        [badGuys removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    [deadKmonsters removeAllObjects];

//    if(Scenario3 == true)
//    {
//        zigZagDelayCounter++;
//        firstZigZag = false;
//        if(zigZagDelayCounter % 250 == 0)
//        {
//            Scenario3 = false;
//            zigZagScenarioCounter = 0;
//            NSLog(@"Scenario3 is false");
//        }
//    }
    if([goodGuys count] > 0 || [badGuys count] > 0 || [goodBombs count] > 0 || [badBombs count] > 0)
    {
        [self detectReachBottom];
    }
    if([bananaArray count] > 0 && [goodGuys count] > 0 && immunity == false)
    {
        [self detectBananaGoodGuyCollisions];
    }
    if([bananaArray count] > 0 && [badGuys count] > 0)
    {
        [self detectBananaBadGuyCollisions];
    }
    if ([Kmonsters count] > 0)
    {
        [self detectKmonsterCollisions];
    }
    
    NSMutableArray *deadCoins = [[NSMutableArray alloc] init];
    
    if([coinsArray count] > 0)
    {
        [self detectBananaCoinCollisions];
        
        for(int i = 0; i < [coinsArray count]; i++)
        {
            CCSprite *coin = [coinsArray objectAtIndex:i];
            if(coin.position.y < 30)
            {
                [deadCoins addObject:coin];
            }
        }
        
        for(CCSprite *s in deadCoins)
        {
            [coinsArray removeObject:s];
            [self removeChild:s cleanup:YES];
        }
        [deadCoins removeAllObjects];
    }

        
//    for(int i = 0; i < [goodGuysBottom count]; i++)
//    {
//        CCSprite* goodGuyBottom = [goodGuysBottom objectAtIndex:i];
//        ((Character*)goodGuyBottom).immunity++;
//    }
//    for(int i = 0; i < [badGuysBottom count]; i++)
//    {
//        CCSprite* badGuyBottom = [badGuysBottom objectAtIndex:i];
//        ((Character*)badGuyBottom).immunity++;
//    }
//
    
    if ([goodGuysBottom count] > 1)
    {
        [self goodGuysWalk];
    }
    if ([badGuysBottom count] > 1)
    {
        [self badGuysWalk];
    }

    if (([goodGuysBottom count] > 0 || [badGuysBottom count] > 0))
    {
        [self fight];
    }
    if([goodGuysBottom count] > 0 || [badGuysBottom count] > 0)
    {
        [self detectBulletSoldierCollisions];
    }
//    if(truckCount == 1)
//    {
//        [self truckGoodBottomOrBadBottomCollisions];
//        
//    }
//    if (truckCount > 0)
//    {
//        NSLog(@"truckcount > 0" );
//        if (truck.position.x >=50)
//        {
//            NSLog(@"truck position is more than 50");
//            if(framecount % 60 == 0)
//            {
//                GoodReinforcement = [[Character alloc] initWithSpartanImage];
//                GoodReinforcement.position = ccp(70, truck.position.y);
//                GoodReinforcement.scale = .1;
//                GoodReinforcement.color = ccc3(0,255,0);
//                [self addChild:GoodReinforcement z:10];
//                //int rangeX3 = 380;
//                int actualX3 = (arc4random() % 200) + 20;
//                CCMoveTo * spreadOut = [CCMoveTo actionWithDuration:2 position:ccp(actualX3, 30)];
//                [goodGuysBottom addObject:GoodReinforcement];
//                [GoodReinforcement runAction:spreadOut];
//                goodReinforcementCount++;
//            }
//        }
//    }
    
    
    if(immunity == true)
    {
        immunityFramecount++;
        
        int immunityLeft = immunityLength - immunityFramecount;
        [immunityCounterLabel setString:[NSString stringWithFormat:@"immunity: %d", (immunityLeft/60)]];
        
        if(addedImmunityCounter == false)
        {
            [self addChild:immunityCounterLabel];
            addedImmunityCounter = true;
        }
        
        if (immunityFramecount >= immunityLength)
        {
            immunity = false;
            immunityFramecount = 0;
            NSLog(@"immunity ended");
            [self removeChild:immunityCounterLabel];
            addedImmunityCounter = false;
        }
    }
    if(reinforcements == true)
    {
        if(framecount % reinforcementFramecount == 0 && reinforcementsSpawned < numReinforcments)
        {
            [self spawnReinforcement];
            reinforcementsSpawned++;
        }
        
        if(reinforcementsSpawned == numReinforcments)
        {
            reinforcementsSpawned = 0;
            reinforcements = false;
        }
    }
    
    if([GameData sharedData].wentToInGameStore == true)
    {
        [GameData sharedData].wentToInGameStore = false;
        
        int airstrikeNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"] intValue];
        [airstrikeCount setString:[NSString stringWithFormat:@"%d", airstrikeNum]];
        
        int immunityNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"] intValue];
        [immunityCount setString:[NSString stringWithFormat:@"%d", immunityNum]];
        
        int reinforcementsNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"] intValue];
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", reinforcementsNum]];
        
        [coinslabel setString:[NSString stringWithFormat:@"coins:%d", [[MGWU objectForKey:@"coins"] intValue]]];
        
    }
    
    if (currentLevelSelected == 16)
    {
        if(framecount% 80 == 0)
        {
            [self addFriendlyFastShooter];
            [self addFriendlyMelee];
            [self addFriendlyRegularShooter];
            [self addFriendlyTank];
            
            if (waveChanging == true)
            {
                [[CCDirector sharedDirector] replaceScene: (CCScene*)[[VictoryLayer alloc] init]];
            }
        }
    }
    
}


-(void) draw
{
//    [self drawBoundingBox:badMeleeBox];
//    [self drawBoundingBox:badRangeBox];
//    [self drawBoundingBox:goodMeleeBox];
//    [self drawBoundingBox:goodRangeBox];
//    [self drawBoundingBox:badBaseBox];
//    [self drawBoundingBox:goodBaseBox];
 
    
//    glColor4f(1.0, 0, 0, 1.0);
//    
//    glLineWidth(1.0f);
    
    
    for(int r = 0; r < [goodGuysBottom count]; r++)
    {
        [self drawBoundingBox: goodRangeBox];
    }
    
    for(int y = 0; y < [badGuysBottom count]; y++)
    {
        [self drawBoundingBox: badRangeBox];
    }
    
    [super draw];
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // Set up initial location of projectile
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"blue-energy.plist"];
    
    CCSpriteBatchNode *projectileSheet = [CCSpriteBatchNode batchNodeWithFile:@"blue-energy.png"];
    
    [self addChild:projectileSheet];
    
    bananaFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 1; ++i)
    {
        [bananaFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"blue-energy.png"]]];
        
        projectile = [[Character alloc] initWithBlueEnergyImage];
        
        projectile.anchorPoint = CGPointZero;
        
        projectile.scale=.25;
    }
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *rotating = [CCAnimation animationWithFrames: bananaFrames delay:0.1f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    rotateBanana = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:rotating restoreOriginalFrame:NO]];
    
    //tell the banana to rotate
    [projectile runAction:rotateBanana];
    
    //    projectile = [CCSprite spriteWithFile:@"banana.png"];
    //    projectile.position = ccp(220, FLOOR_HEIGHT);
    //    projectile.scale = .05;
    
    
    [bananaArray addObject:projectile];
    
//    projectile.position = CGPointMake(player.position.x, player.position.y);
//    projectile = [CCSprite spriteWithFile:@"blue-energy.png"];
//    [bananaArray addObject:projectile];
    
    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, projectile.position);
    
    // Bail out if you are shooting down
    if (location.y <= player.position.y)
    {
        return;
    }
    
    // Ok to add now - we've double checked position
    projectile.position = ccp(-20,-20);
    [self addChild:projectile z:2];
    [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
    
    int playerX = player.position.x;
    int playerY = player.position.y;
    
    float offX = location.x - playerX;
    float offY = location.y - playerY;
    
    float ydiff = winSize.height - playerY;
    float xdiff = (ydiff/offY) * offX;
    float xpos = winSize.width/2 + xdiff;
    float ypos = playerY + ydiff;
    
    float length = sqrtf((xdiff*xdiff)+(ydiff*ydiff));
    float velocity = 450/1;
    float realMoveDuration = length/velocity;
    
    
    CGPoint newlocation = CGPointMake(xpos, ypos);
    
    double delayInSeconds = .15;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        projectile.position = CGPointMake(player.position.x, player.position.y - 2);
        [projectile runAction:
         [CCSequence actions:
          [CCMoveTo actionWithDuration:realMoveDuration position:newlocation],
          [CCCallBlockN actionWithBlock:^(CCNode *node)
           {
               [node removeFromParentAndCleanup:YES];
           }],
          nil]];
    });
    
    
    //tell main character to animate based on location of touch
    
    int touchX = location.x;
    int direction;
    
    if(touchX < winSize.width/12)
    {
        direction = 1;
    }
    else if (touchX< winSize.width/6)
    {
        direction = 2;
    }
    else if(touchX < winSize.width/4)
    {
        direction = 3;
    }
    else if(touchX < winSize.width/3)
    {
        direction = 4;
    }
    else if(touchX < winSize.width/(12/5))
    {
        direction = 5;
    }
    else if(touchX < winSize.width/2)
    {
        direction = 6;
    }
    else if(touchX < winSize.width/(12/7))
    {
        direction = 7;
    }
    else if(touchX < winSize.width/1.5)
    {
        direction = 8;
    }
    else if(touchX < winSize.width/(4/3))
    {
        direction = 9;
    }
    else if(touchX < winSize.width/(6/5))
    {
        direction = 10;
    }
    else if(touchX < winSize.width/(12/11))
    {
        direction = 11;
    }
    else
    {
        direction = 12;
    }
    
    [self mainCharacterShootAnimation:player :direction];
    
}

//-(void) detectBombGoodGuysBottomCollisions
//{
//    NSMutableArray *deadGoodGuysBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *deadBombs = [[NSMutableArray alloc] init];
//    
//    for(int j = 0; j < [goodGuysBottom count]; j++)
//    {
//        for(int i = 0; i < [badGuys count]; i++)
//        {
//            if([badGuys count] > 0 && [goodGuysBottom count] > 0)
//            {
//                CCSprite* goodGuyBottom = [goodGuysBottom objectAtIndex:j];
//                CGRect goodGuyBottomRect = [goodGuyBottom boundingBox];
//                projectile = [badGuys objectAtIndex:i];
//                CGRect projectileBox = [projectile boundingBox];
//                if(((Character*)projectile).type == BAD_HELICOPTER_BOMB)
//                {
//                if(CGRectIntersectsRect(goodGuyBottomRect,projectileBox))
//                {
//                    if (projectile.position.y < 305)
//                    {
//                        if(((Character*)goodGuyBottom).health == 1)
//                        {
//                            [deadBombs addObject:projectile];
//                            [deadGoodGuysBottom addObject:goodGuyBottom];
//                            
//                            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
//                            {
//
//                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
//                            }
//                            
//                            //[self enemiesKilledTotal];
//                            //enemiesKilledCounter++;
//                        }
//                        else
//                        {
//                            ((Character*)goodGuy).health--;
//                            [deadBombs addObject:projectile];
//                        }
//                    }
//                }
//                }
//            }
//        }
//    }
//    for (CCSprite *s in deadBombs)
//    {
//        [badGuys removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [deadBombs removeAllObjects];
//    for (CCSprite *s in deadGoodGuysBottom)
//    {
//        [goodGuysBottom removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [deadGoodGuysBottom removeAllObjects];
//    
//    /*
//    for(int j=0; j < [goodGuysBottom count]; j++)
//    {
//           for (int i = 0; i < [badGuys count]; i++)
//           {
//               bomb = [badGuys objectAtIndex:i];
//               CGRect bombBox = [badGuy boundingBox];
//               bombBox.size.width *= 5;
//               bombBox.size.height *= 4;
//               goodGuy = [goodGuysBottom objectAtIndex:j];
//               CGRect goodGuyRect = [goodGuy boundingBox];
//               if(((Character*)bomb).type == BAD_HELICOPTER_BOMB)
//               {
//                    if(CGRectIntersectsRect(bombBox, goodGuyRect))
//                    {
//                            if(((Character*)goodGuy).health == 1)
//                            {
//                                [goodGuysBottom removeObjectAtIndex:j];
//                                [badGuys removeObjectAtIndex:i];
//                                [self removeChild:bomb cleanup:YES];
//                                [self removeChild:goodGuy cleanup:YES];
//                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
//                                NSLog(@"good guy removed");
//                            }
//                            else
//                            {
//                                ((Character*)goodGuy).health--;
//                                [badGuys removeObjectAtIndex:i];
//                                [self removeChild:bomb cleanup:YES];
//                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
//                                NSLog(@"collsion, health decreased");
//                            }
//                        
//                    }
//               }
//           
//           }
//    }
//     */
//}

//-(CGRect) explosionBox
//{
//    int dx = -200;
//    int dy = -100;
//    return CGRectInset(self.boundingBox, dx, dy);
//}

-(void) detectBananaGoodGuyCollisions
{
    NSMutableArray *deadBananas = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodGuys = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < [goodGuys count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if([bananaArray count] > 0 && [goodGuys count] > 0)
            {
                goodGuy = [goodGuys objectAtIndex:j];
                goodGuyRect = [goodGuy boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                
                if(CGRectIntersectsRect(goodGuyRect, projectileBox))
                {
                    //[enemiesToDelete addObject:badGuy];
                    //[bananasToDelete addObject:projectile];
                    
                    if (projectile.position.y < (winSize.height - 10))
                    {
                        [deadGoodGuys addObject:goodGuy];
                        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
                        {
                                [[SimpleAudioEngine sharedEngine] playEffect:@"friendly.wav"];
                    
                        }
                        [self explosion:goodGuy :explosionAnimationLength: NO];
                        if(((Character*)goodGuy).type == BIG_GOOD_GUY && Scenario2 == true)
                        {
                            Scenario2interlude = true;
                            bigGoodGuysCounter = 0;
                            NSLog(@"scenario 2 interlude = true");
                        }
                        if(((Character*)goodGuy).type == GOOD_REINFORCEMENT && Scenario3 == true)
                        {
                            Scenario3 = false;
                        }

                        [deadBananas addObject:projectile];
//                        ((Character*)goodGuy).health -= ((Character*)projectile).power;
//                        
//                        if(((Character*)goodGuy).health <= 0)
//                        {
//                            [deadGoodGuys addObject:goodGuy];
//                            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
//                            {
//                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
//                            }
//                            [self explosion:goodGuy :explosionAnimationLength: NO];
//                            if(((Character*)goodGuy).type == BIG_GOOD_GUY && Scenario2 == true)
//                            {
//                                Scenario2interlude = true;
//                                bigGoodGuysCounter = 0;
//                                NSLog(@"scenario 2 interlude = true");
//                            }
//                            if(((Character*)goodGuy).type == GOOD_HELICOPTER_BOMB)
//                            {
//                                NSLog(@"banana good guy collisions");
//                                NSLog(@"position = (%d,%d)", goodGuy.position.x, goodGuy.position.y);
//                            }
//                        }
                        
                        //}
                        /*
                         else
                         {
                         [goodGuys removeObjectAtIndex:j];
                         [bananaArray removeObjectAtIndex:i];
                         [self removeChild:goodGuy cleanup:YES];
                         [self removeChild:projectile cleanup:YES];
                         [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                         enemiesKilledCounter++;
                         //[enemiesToDelete addObject:badGuy];
                         //[bananasToDelete addObject:projectile];
                         }
                         //[enemiesToDelete removeAllObjects];
                         //[bananasToDelete removeAllObjects];
                         */
                    }
                }
            }
        }
    }
    for (CCSprite *s in deadBananas)
    {
        [bananaArray removeObject:s];
        [self removeChild:s cleanup:YES];
       // NSLog(@"removed banana");
    }
    [deadBananas removeAllObjects];
    
    for (CCSprite *s in deadGoodGuys)
    {
        [goodGuys removeObject:s];
        if(((Character*)s).type == GOOD_HELICOPTER_BOMB)
        {
            NSLog(@"here");
            [goodBombs removeObject:s];
        }
//        NSLog(@"removed from good guy array");
    }
    [deadGoodGuys removeAllObjects];
}

-(void) detectKmonsterCollisions
{
    NSMutableArray *deadKmonsters = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodGuys = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < [goodGuys count]; j++)
    {
        for(int i = 0; i < [Kmonsters count]; i++)
        {
            if([Kmonsters count] > 0 && [goodGuys count] > 0)
            {
                goodGuy = [goodGuys objectAtIndex:j];
                goodGuyRect = [goodGuy boundingBox];
                CCSprite* Kmonster = [Kmonsters objectAtIndex:i];
                CGRect KamikazeBox = [Kmonster boundingBox];
            
                if(CGRectIntersectsRect(goodGuyRect, KamikazeBox))
                {
                   // NSLog(@"intersect");

                        [deadKmonsters addObject:Kmonster];
                        [deadGoodGuys addObject:goodGuy];
                        [self enemiesKilledTotal];
                        [self explosion:goodGuy :explosionAnimationLength :NO];
                        Scenario2interlude = true;
                        bigGoodGuysCounter = 0;
                        NSLog(@"scenario 2 interlude = true");
                        
                        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
                        {
                            [[SimpleAudioEngine sharedEngine] playEffect:@"friendly.wav"];
                        }
                        if(((Character*)goodGuy).type == GOOD_HELICOPTER_BOMB)
                        {
                            NSLog(@"good guy Kmonster collisions");
                        }
                        //enemiesKilledCounter ++;
                }
            }
        }
    }
    
    for (CCSprite *s in deadKmonsters)
    {
        [Kmonsters removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    [deadKmonsters removeAllObjects];
    
    for (CCSprite *s in deadGoodGuys)
    {
        [goodGuys removeObject:s];
    }
    [deadGoodGuys removeAllObjects];
}

-(void) detectBananaBadGuyCollisions
{
    NSMutableArray *deadBananas = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadHelicopters = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < [badGuys count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if([bananaArray count] > 0 && [badGuys count] > 0)
            {
                badGuy = [badGuys objectAtIndex:j];
                badGuyRect = [badGuy boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                
                if(CGRectIntersectsRect(badGuyRect, projectileBox))
                {
                    if (projectile.position.y < winSize.height - 5)
                    {
                        ((Character*)badGuy).fallingHealth -= ((Character*)projectile).power;
                        [deadBananas addObject:projectile];
                        
                        if(((Character*)badGuy).fallingHealth <= 0)
                        {
                            [deadBadGuys addObject:badGuy];
                            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
                            {
                                if ((((Character*)badGuy).type) == BAD_KNIFE)
                                {
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"thud.wav"];
                                }
                                
                                else if ((((Character*)badGuy).type) == BAD_GUY)
                                {
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"thud.wav"];
                                }
                                
                                else if ((((Character*)badGuy).type) == BIG_MONSTER)
                                {
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"Xplode.wav"];
                                }
                                
                                else if ((((Character*)badGuy).type) == BAD_HELICOPTER)
                                {
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"Xplode.wav"];
                                }
                                
                                else
                                {
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"thud.wav"];
                                }
                                
                                
                            }
                            [self enemiesKilledTotal];
                            [self explosion:badGuy :explosionAnimationLength: NO];
//                            if(Scenario4 == false && Scenario3 == false && Scenario2 == false && Scenario1 == false)
//                            {
//                                enemiesKilledCounter ++;
//                            }
                            if(((Character*)badGuy).type == BAD_HELICOPTER)
                            {
                                Scenario1 = false;
                                NSLog(@"scenario 1 = false");
                            }
                            if(Scenario3 == true && ((Character*)badGuy).type == BAD_KNIFE && [zigZagScenarioEnemies containsObject:badGuy] == true)
                            {
                                [zigZagScenarioEnemies removeObject:badGuy];
                                if([zigZagScenarioEnemies count] == 0)
                                {
                                    Scenario3 = false;
                                    NSLog(@"scenario 3 = false 1");
                                }
                            }
                            if(Scenario4 == true && ((Character*)badGuy).type == BIG_MONSTER)
                            {
                                Scenario4 = false;
                                NSLog(@"scenario 4 = false");
                            }
                        }
                    }
                }
            }
        }
    }
    for (CCSprite *s in deadBananas)
    {
        [bananaArray removeObject:s];
        [self removeChild:s cleanup:YES];
        //NSLog(@"removed banana");
    }
    [deadBananas removeAllObjects];
    for (CCSprite *s in deadBadGuys)
    {
        [badGuys removeObject:s];
        if(((Character*)s).type == BAD_HELICOPTER_BOMB)
        {
            [badBombs removeObject:s];
        }
        if(((Character*)s).type == KAMIKAZE)
        {
            [Kmonsters removeObject:s];
        }
       // NSLog(@"removed goodGuy");
    }
    [deadBadGuys removeAllObjects];
}

-(void) detectBananaCoinCollisions
{
    NSMutableArray *deadBananas = [[NSMutableArray alloc] init];
    NSMutableArray *deadCoins = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < [coinsArray count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if([bananaArray count] > 0 && [coinsArray count] > 0)
            {
                CCSprite* coin = [coinsArray objectAtIndex:j];
                CGRect coinRect = [coin boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                
                if(CGRectIntersectsRect(coinRect, projectileBox))
                {
                    if (projectile.position.y < winSize.height - 5)
                    {
                        ((Character*)coin).health -= ((Character*)projectile).power;
                        [deadBananas addObject:projectile];
                        if(((Character*)coin).health <= 0)
                        {
                            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
                            {
                                [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav"];
                            }
                            [deadCoins addObject:coin];
                            [self addCoins:coinMultiplier];
                            
                        }
                    }
                }
            }
        }
    }
    for (CCSprite *s in deadBananas)
    {
        [bananaArray removeObject:s];
        [self removeChild:s cleanup:YES];
        //NSLog(@"removed banana");
    }
    [deadBananas removeAllObjects];
    for (CCSprite *s in deadCoins)
    {
        [coinsArray removeObject:s];
        [self dying:s :dyingAnimationLength];
        // NSLog(@"removed goodGuy");
    }
    [deadCoins removeAllObjects];

}

-(void)detectReachBottom
{
    NSMutableArray *deadGoodGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodBombs = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadBombs = [[NSMutableArray alloc] init];
    
    if(waveChanging == true)
    {
        return;
    }
    
    for(int i = 0; i < [goodGuys count]; i++)
    {
        if([goodGuys count] > 0)
        {
            goodGuy = [goodGuys objectAtIndex:i];
            
            if(goodGuy.position.y <= 20 && ((Character*)goodGuy).type != GOOD_HELICOPTER_BOMB)
            {
                if(((Character*)goodGuy).type == GOOD_GUY)
                {
                    //[self spawnGoodGuyBottom];
                    goodBottom = [[Character alloc] initWithFriendlyRegularShooterImage];
                    goodBottom.scale = 1.5;
                    [self spawnBottom:goodGuy :goodBottom :YES];
                    
                    //animation
                    
                    NSMutableArray *angel2moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel2move.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel2move.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    angel2moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 8; ++i)
                    {
                        [angel2moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a2-%d.png", i]]];
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *angel2moveAnimation = [CCAnimation animationWithFrames: angel2moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *angel2move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel2moveAnimation restoreOriginalFrame:NO]];
                    
                    
                    //tell the bear to run the taunting action
                    [goodBottom runAction:angel2move];
                    //NSLog(@"good guy animation started");
                }
                
                if(((Character*)goodGuy).type == SUPER_ZIG_ZAG_GUY)
                {
                    //[self spawnGoodZigZagBottom];
                    goodBottom = [[Character alloc] initWithSuperZigZagGuyImage];
                    [self spawnBottom:goodGuy :goodBottom :YES];
                }
                
                if(((Character*)goodGuy).type == BIG_GOOD_GUY)
                {

                    //[self spawnGoodBigGuyBottom];
                    goodBottom = [[Character alloc] initWithFriendlyTankImage];
          
                    [self spawnBottom:goodGuy :goodBottom :YES];
                    
                    //animation
                    
                    NSMutableArray *moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angeltankmove.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angeltankmove.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 4; ++i)
                    {
                        [moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a5-%d.png", i]]];
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *moveAnimation = [CCAnimation animationWithFrames: moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moveAnimation restoreOriginalFrame:NO]];
                    
                    
                    //tell the bear to run the taunting action
                    [goodBottom runAction:move];
                    //NSLog(@"good guy animation started");
                    
                    if(Scenario2 == true)
                    {
                        Scenario2 = false;
                        bigGoodGuysCounter = 0;
                        NSLog(@"scenario 2 = false");
                    }
                    if(Scenario3 == true)
                    {
                        Scenario3 = false;
                        NSLog(@"scenario 3 = false 2");
                    }
                }
                
                if(((Character*)goodGuy).type == GOOD_FASTSHOOTER)
                {
                    goodBottom = [[Character alloc] initWithFriendlyFastShooterImage];
                    [self spawnBottom:goodGuy :goodBottom :YES];
                    
                    //animation
                    
                    NSMutableArray *angel3moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel3move.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel3move.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    angel3moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 8; ++i)
                    {
                        [angel3moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a3-%d.png", i]]];
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *angel3moveAnimation = [CCAnimation animationWithFrames: angel3moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *angel3move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel3moveAnimation restoreOriginalFrame:NO]];
                    
                    //tell the bear to run the taunting action
                    [goodBottom runAction:angel3move];
                }
                
                if (((Character*)goodGuy).type == GOOD_KNIFE)
                {
                    goodBottom = [[Character alloc] initWithFriendlyMeleeImage];
                    [self spawnBottom:goodGuy :goodBottom :YES];
                    [self angel1walkAnimation:goodBottom];
                }
                
                if(((Character*)goodGuy).type == GOOD_REINFORCEMENT)
                {
                    goodBottom = [[Character alloc] initWithSpartanImage];
                    [self spawnBottom:goodGuy :goodBottom :YES];
                    [self spartanWalkAnimation:goodBottom];
                    Scenario3 = false;
                }
                    
//                ((Character*)goodBottom).health = ((Character*)goodGuy).health;
//                goodBottom.anchorPoint = CGPointZero;
//                goodBottom.position = ccp(goodGuy.position.x - 15, goodGuy.position.y - 20);
//                goodBottom.scale=.3;
//                [self addChild:goodBottom z:1];
//                [goodGuysBottom addObject:goodBottom];
                if(((Character*)goodBottom).type != BIG_GOOD_GUY)
                {
                    goodBottom.scale = .5;
                }
                else
                {
                    goodBottom.scale = .7;
                }
                
                [deadGoodGuys addObject:goodGuy];
  
               // NSLog(@"added to bottom array");
            }
        }
    }
    for(int i = 0; i < [badGuys count]; i++)
    {
        if([badGuys count] > 0)
        {
            badGuy = [badGuys objectAtIndex:i];

            if(badGuy.position.y <= 30 && ((Character*)badGuy).type != BAD_HELICOPTER_BOMB)
            {
                if(((Character*)badGuy).type == BAD_GUY)
                {
                    //[self spawnBadGuyBottom];
                    badBottom = [[Character alloc] initWithEnemyRegularShooterImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                    
                    //animation
                    
                    NSMutableArray *devil2moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil2move.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil2move.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    devil2moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 6; ++i)
                    {
                        [devil2moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d2-%d.png", i]]];
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *devil2moveAnimation = [CCAnimation animationWithFrames: devil2moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *devil2move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil2moveAnimation restoreOriginalFrame:NO]];
                    
                    //tell the bear to run the taunting action
                    [badBottom runAction:devil2move];
                    
                    
                    
                }
                if(((Character*)badGuy).type == DOUBLE_ENEMY)
                {
                    //[self spawnBadGuyBottom];
                    badBottom = [[Character alloc] initWithDoubleEnemyImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                    
                    
                }
                if(((Character*)badGuy).type == ZIG_ZAG)
                {
                    //[self spawnBadZigZagBottom];
                    badBottom = [[Character alloc] initWithZigZagImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                }

                if(((Character*)badGuy).type == BAD_KNIFE)
                {
                    //[self spawnBadZigZagBottom];
                    badBottom = [[Character alloc] initWithEnemyMeleeImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                    
                    if(Scenario3 == true && [zigZagScenarioEnemies containsObject:badGuy] == true)
                    {
                        [zigZagScenarioEnemies removeObject:badGuy];
                        if([zigZagScenarioEnemies count] == 0)
                        {
                            Scenario3 = false;
                            NSLog(@"scenario 3 = false 3");
                        }
                    }
                    
                    [self devil1walkAnimation:badBottom];
                }
                if(((Character*)badGuy).type == BAD_FASTSHOOTER)
                {
                    //[self spawnBadZigZagBottom];
                    badBottom = [[Character alloc] initWithEnemyFastShooterImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                    
                    //animation
                    
                    NSMutableArray *devil3moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil2move.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil2move.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    devil3moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 6; ++i)
                    {
                        [devil3moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d2-%d.png", i]]];
                        badBottom.color = ccc3(200, 0, 0);
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *devil3moveAnimation = [CCAnimation animationWithFrames: devil3moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *devil3move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil3moveAnimation restoreOriginalFrame:NO]];
                    
                    //tell the bear to run the taunting action
                    [badBottom runAction:devil3move];
                }
                
                if(((Character*)badGuy).type == BIG_MONSTER)
                {
                    badBottom = [[Character alloc] initWithEnemyTankImage];
                    [self spawnBottom:badGuy :badBottom :NO];
                    Scenario4 = false;
                    NSLog(@"scenario 4 = false");
                    
                    //animation
                    
                    NSMutableArray *moveFrames;
                    
                    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
                    
                    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"deviltankmove.plist"];
                    
                    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
                    
                    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil2tank.png"];
                    
                    [self addChild:spriteSheet];
                    
                    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
                    
                    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
                    
                    moveFrames = [NSMutableArray array];
                    
                    for(int i = 1; i <= 3; ++i)
                    {
                        [moveFrames addObject:
                         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d3-%d.png", i]]];
                    }
                    
                    //Create an animation from the set of frames you created earlier
                    
                    CCAnimation *moveAnimation = [CCAnimation animationWithFrames: moveFrames delay:0.25f];
                    
                    //Create an action with the animation that can then be assigned to a sprite
                    
                    CCAction *move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moveAnimation restoreOriginalFrame:NO]];
                    
                    
                    //tell the bear to run the taunting action
                    [badBottom runAction:move];
                    //NSLog(@"good guy animation started");
                }
                
                if(((Character*)badBottom).type != BIG_MONSTER)
                {
                    badBottom.scale = .5;
                }
                else
                {
                    badBottom.scale = .7;
                }
                
                [deadBadGuys addObject:badGuy];
            }
        }
    }
    for(int i = 0; i < [goodBombs count]; i++)
    {
        if([goodBombs count] > 0)
        {
            bomb = [goodBombs objectAtIndex:i];
            
            if(bomb.position.y <= 25)
            {
                [deadGoodBombs addObject:bomb];
            }
        }
    }

    for(int i = 0; i < [badBombs count]; i++)
    {
        if([badBombs count] > 0)
        {
            bomb = [badBombs objectAtIndex:i];
            
            if(bomb.position.y <= 20)
            {
                [deadBadBombs addObject:bomb];
            }
        }
    }
    
    if([deadGoodGuys count] > 0)
    {
        for (CCSprite *s in deadGoodGuys)
        {
            [goodGuys removeObject:s];
            [self removeChild:s cleanup:YES];
        }
        [deadGoodGuys removeAllObjects];
    }
    
    if([deadBadGuys count] > 0)
    {
        for (CCSprite *s in deadBadGuys)
        {
            [badGuys removeObject:s];
            [self removeChild:s cleanup:YES];
        }
        [deadBadGuys removeAllObjects];
    }
    if([deadBadBombs count] > 0)
    {
        for (CCSprite *s in deadBadBombs)
        {
            [badBombs removeObject:s];
            [badGuys removeObject:s];
            [self explosion:s :explosionAnimationLength :NO];
        }
        [deadBadBombs removeAllObjects];
    }
    if([deadGoodBombs count] > 0)
    {
        for (CCSprite *s in deadGoodBombs)
        {
            [goodBombs removeObject:s];
//            [goodGuys removeObject:s];
            [self explosion:s :explosionAnimationLength :NO];
        }
        [deadGoodBombs removeAllObjects];
    }
    
}
-(void)spawnBottom:(CCSprite *)original :(CCSprite *)new :(BOOL)friendly
{
    ((Character*)new).row = arc4random() % 5 + 1;
    new.anchorPoint = CGPointZero;
    ((Character*)new).health = ((Character*)original).health;
    int posHeight = 0 + (4 * ((Character*)badBottom).row);
    [self addChild:new z:(7 - ((Character*)new).row)];
    if(friendly == YES)
    {
        new.position = ccp(angelStartingWidth, posHeight);
        [goodGuysBottom addObject:new];
    }
    else
    {
        new.position = ccp(devilStartingWidth, posHeight);
        [badGuysBottom addObject:new];
    }

}

-(void) zigZagScenario
{
    CCSprite* zFriendly= [[Character alloc] initWithSpartanImage];
    zFriendly.scale = .6;
    zFriendly.position = CGPointMake(winSize.width/2, winSize.height * 1.15);
    [self addChild:zFriendly];
    [goodGuys addObject:zFriendly];
    
//    CCSprite *enemy1= [[Character alloc] initWithEnemyMeleeImage];
//    enemy1.scale=.3;
//    enemy1.position = CGPointMake(winSize.width * .125, winSize.height + 30); //+ enemy.contentSize.height/2);
//    [self addChild:enemy1];
//    [badGuys addObject:enemy1];
//    
//    CCSprite *enemy2= [[Character alloc] initWithEnemyMeleeImage];
//    enemy2.scale=.3;
//    enemy2.position = CGPointMake(winSize.width * .375, winSize.height + 30); //+ enemy.contentSize.height/2);
//    [self addChild:enemy2];
//    [badGuys addObject:enemy2];
//
//    CCSprite *enemy3= [[Character alloc] initWithEnemyMeleeImage];
//    enemy3.scale=.3;
//    enemy3.position = CGPointMake(winSize.width * .625, winSize.height + 30); //+ enemy.contentSize.height/2);
//    [self addChild:enemy3];
//    [badGuys addObject:enemy3];
//
//    CCSprite *enemy4= [[Character alloc] initWithEnemyMeleeImage];
//    enemy4.scale=.3;
//    enemy4.position = CGPointMake(winSize.width * .875, winSize.height + 30); //+ enemy.contentSize.height/2);
//    [self addChild:enemy4];
//    [badGuys addObject:enemy4];
//
//     [zigZagScenarioEnemies addObject:enemy1];
//     [zigZagScenarioEnemies addObject:enemy2];
//     [zigZagScenarioEnemies addObject:enemy3];
//     [zigZagScenarioEnemies addObject:enemy4];
    
    
//    zFriendly2= [CCSprite spriteWithFile:@"cat1-topdown.png"];
//    zFriendly2.scale=.15;
//    zFriendly2.position = CGPointMake(winSize.width/2, winSize.height);
//    [self addChild:zFriendly2];
//    [goodGuys addObject:zFriendly2];
//
//    zFriendly3= [CCSprite spriteWithFile:@"cat1-topdown.png"];
//    zFriendly3.scale=.15;
//    zFriendly3.position = CGPointMake(winSize.width/2, winSize.height);
//    [self addChild:zFriendly3];
//    [goodGuys addObject:zFriendly3];
//
//    zFriendly4= [CCSprite spriteWithFile:@"cat1-topdown.png"];
//    zFriendly4.scale=.15;
//    zFriendly4.position = CGPointMake(winSize.width/2, winSize.height);
//    [self addChild:zFriendly4];
//    [goodGuys addObject:zFriendly4];
//
//    
//    float timeInterval1 = 0.5f;
//    id delay1 = [CCDelayTime actionWithDuration:timeInterval1];
//    
//    float timeInterval2 = 2.0f;
//    id delay2 = [CCDelayTime actionWithDuration:timeInterval2];
//    
//    float timeInterval3 = 3.5f;
//    id delay3 = [CCDelayTime actionWithDuration:timeInterval3];
//    
//    float timeInterval4 = 5.0f;
//    id delay4 = [CCDelayTime actionWithDuration:timeInterval4];

//    minDuration = 6;
//    maxDuration = 8;
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration1 = (arc4random() % rangeDuration) + minDuration;
//    int actualDuration2 = (arc4random() % rangeDuration) + minDuration;
//    int actualDuration3 = (arc4random() % rangeDuration) + minDuration;
//    int actualDuration4 = (arc4random() % rangeDuration) + minDuration;
//    
//    CCMoveTo *actionMove1 = [CCMoveTo actionWithDuration:actualDuration1 position:ccp(enemy1.position.x, -20)];
//    [enemy1 runAction:actionMove1];
//    
//    CCMoveTo *actionMove2 = [CCMoveTo actionWithDuration:actualDuration2 position:ccp(enemy2.position.x, -20)];
//    [enemy2 runAction:actionMove2];
//    
//    CCMoveTo *actionMove3 = [CCMoveTo actionWithDuration:actualDuration3 position:ccp(enemy3.position.x, -20)];
//    [enemy3 runAction:actionMove3];
//    
//    CCMoveTo *actionMove4 = [CCMoveTo actionWithDuration:actualDuration4 position:ccp(enemy4.position.x, -20)];
//    [enemy4 runAction:actionMove4];
    
    CCSprite *mockEnemyMelee = [[Character alloc] initWithEnemyMeleeImage];
    double enemyMeleeFallSpeed = ((Character*)mockEnemyMelee).fallSpeed;
    double zigZagDuration = enemyMeleeFallSpeed/4.8;
    
        id leftTop = [CCMoveTo actionWithDuration:zigZagDuration
                                         position:ccp (winSize.width * .2, winSize.height * .9)];
        
        id rightTop = [CCMoveTo actionWithDuration:zigZagDuration
                                          position:ccp(winSize.width * .8, winSize.height * .6)];
        
        id leftMid = [CCMoveTo actionWithDuration:zigZagDuration
                                         position:ccp(winSize.width * .2, winSize.height * .3)];
        
        id rightMid = [CCMoveTo actionWithDuration:zigZagDuration
                                          position:ccp(winSize.width * .8, winSize.height * .0)];
//        
//        id leftLow = [CCMoveTo actionWithDuration:zigZagDuration
//                                         position:ccp(winSize.width * .2, winSize.height * .1)];
    

//        id drop = [CCMoveTo actionWithDuration:zigZagDuration position:ccp(winSize.width * .5, -20)];
//    
    //delay actual subtraction of health to allow time for animation to run
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [zFriendly runAction:[CCSequence actions: leftTop, rightTop, leftMid, rightMid, nil]];
        [self addEnemyMelee:NO:YES];
        [self addEnemyMelee:NO:YES];
        [self addEnemyMelee:NO:YES];
        [self addEnemyMelee:NO:YES];
    });
    

//            [zFriendly2 runAction:[CCSequence actions:delay2, leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];
//    
//            [zFriendly3 runAction:[CCSequence actions:delay3, leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];
//    
//            [zFriendly4 runAction:[CCSequence actions:delay4, leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];
    
}

-(void) enemiesKilledTotal
{
    enemiesKilled++;
    [enemiesKilledLabel setString:[NSString stringWithFormat:@"Enemies Killed:%d", enemiesKilled]];
}
-(void) timeRemaining
{
    timeRemaining--;
    [timeRemainingLabel setString:[NSString stringWithFormat:@"Time Remaining:%d", timeRemaining]];
}

-(void) subtractLevel
{
    level--;
    [levelLabel setString:[NSString stringWithFormat:@"Lvl:%d", level]];
}

-(void)shop:(CCMenuItemImage *)shopButton
{
//    [self addCoins:200];
    [[CCDirector sharedDirector] pushScene: (CCScene *)[[InGameShop alloc]  init]];
}

-(void) pauseMenu: (CCMenuItemImage *)pauseButton
{
    [[CCDirector sharedDirector] pushScene: (CCScene *)[[PauseMenuLayer alloc]  init]];
}

//-(void) changeLevel
//{
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    if (level ==0)
//    {
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//        background = [CCSprite spriteWithFile:@"sky.png"];
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//    
//    if (level ==1)
//    {
//
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//
//        background = [CCSprite spriteWithFile:@"sky.png"];
//
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//    
//    if (level ==2)
//    {
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//        background = [CCSprite spriteWithFile:@"sky.png"];
//
//        //player = [[Player alloc] initWithPlayerPicture];
//   
//    }
//    if (level ==3)
//    {
//
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//
//        background = [CCSprite spriteWithFile:@"sky.png"];
//    
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//    if (level ==4)
//    {
//        [self removeChild:background cleanup:YES];
//        [self removeChild:player];
//        
//        background = [CCSprite spriteWithFile:@"sky.png"];
//
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//    if (level ==5)
//    {
//
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//
//        background = [CCSprite spriteWithFile:@"sky.png"];
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//    
//    if (level==6)
//    {
//
//        [self removeChild:background cleanup: YES];
//        [self removeChild:player];
//
//        background = [CCSprite spriteWithFile:@"sky.png"];
//        //player = [[Player alloc] initWithPlayerPicture];
//    }
//
//    background.scale = 1;
//    background.anchorPoint = CGPointZero;
//    [self addChild:background z:-2];
//    
//}

-(void)createScenario
{
    if(scenariosAvailable > 0)
    {
        if(scenariosAvailable == 1)
        {
            scenarioNumber = 1;
        }
        else
        {
            scenarioNumber = [self generateRandomNumber:scenariosAvailable];
        }
    }
    if(scenarioNumber == 3)
    {
        scenarioNumber = 4;
    }
    if(scenarioNumber == 2)
    {
        scenarioNumber = 3;
    }
    NSLog(@"scenario number = %d", scenarioNumber);
    
    if (scenarioNumber == 1)
    {
        NSLog(@"scenario 1 begins");
        Scenario1 = true;
        spawnedHelicopters++;
        [self addEnemyHelicopter];
    }
    
    if (scenarioNumber == 3)
    {
        NSLog(@"scenario 3 begins");
        scenario3Interlude = true;
    }
    if (scenarioNumber == 4)
    {
        NSLog(@"scenario 4 begins");
        Scenario4 = true;
        [self addEnemyTank];
        bigMonstercount++;
    }
}

//-(void)createScenario
//{
//   if(waveChanging != true)
//   {
//       if(Scenario1 == true)
//       {
//           spawnedHelicopters++;
//           [self addBadHelicopter];
//    
//       }
//       if(Scenario2 == true)
//       {
//           [self addBigGoodGuy];
//       }
//       if(Scenario3 == true)
//       {
//           [self zigZagScenario];
//           zigZagScenarioCounter++;
//            
//        
//      
//       }
//       if(Scenario4 ==true)
//       {
//           [self addBigMonster];
//           bigMonstercount++;
//       }
//   }
//}

-(int)generateRandomNumber :(int)numScenariosAvailable
{
    int num = (arc4random() % numScenariosAvailable) + 1;
    return num;
    NSLog(@"scenario num returned = %d", num);
}

-(void) spawnGoodGuyBottom
{
  //  CGSize winSize = [CCDirector sharedDirector].winSize;
        
    //if([goodGuysBottom count] == 0)
    //{
        //((Character*)goodBottom).row = 1;
    //}
    //if([goodGuysBottom count] > 0)
    //{
        //int num = [goodGuysBottom count];
        //CCSprite *nextGuy = [goodGuysBottom objectAtIndex:(num - 1)];
        //if(((Character*)goodBottom).row == 6)
        //{
            //((Character*)goodBottom).row = 1;
        //}
    //}
    goodBottom = [[Character alloc] initWithFriendlyMeleeImage];
    ((Character*)goodBottom).row = arc4random() % 5 + 1;
    [goodGuysBottom addObject:goodBottom];
    goodBottom.anchorPoint = CGPointZero;
    int posHeight = -8 + (8 * ((Character*)goodBottom).row);
    goodBottom.position = ccp(0, posHeight);
    [self addChild:goodBottom z:(7 - ((Character*)goodBottom).row)];
    NSLog(@"spawned good guy bottom");
    //NSLog(@"row = %d", ((Character*)goodBottom).row);
    //NSLog(@"height = %d", posHeight);
    //NSLog(@"z = %d",7 - ((Character*)goodBottom).row);
    
    //animation
    
    NSMutableArray *angel1moveFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel1move.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel1move.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    angel1moveFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 8; ++i)
    {
        [angel1moveFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a1-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *angel1moveAnimation = [CCAnimation animationWithFrames: angel1moveFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel1move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel1moveAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [goodBottom runAction:angel1move];
    

}

-(void) spawnBadGuyBottom
{
   // CGSize winSize = [CCDirector sharedDirector].winSize;
    badBottom = [[Character alloc] initWithEnemyMeleeImage];
    ((Character*)badBottom).row = arc4random() % 5 + 1;
    badBottom.anchorPoint = CGPointZero;
    int posHeight = -8 + (8 * ((Character*)badBottom).row);
    badBottom.position = ccp(460, posHeight);
    [self addChild:badBottom z:(7 - ((Character*)badBottom).row)];
    [badGuysBottom addObject:badBottom];
    NSLog(@"spawned bad guy bottom");
//    NSLog(@"row = %d", ((Character*)badBottom).row);
//    NSLog(@"height = %d", posHeight);
//    NSLog(@"z = %d",7 - ((Character*)badBottom).row);
    
    //animation
    
    NSMutableArray *devil1moveFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil1move.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil1move.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    devil1moveFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 8; ++i)
    {
        [devil1moveFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d1-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *devil1moveAnimation = [CCAnimation animationWithFrames: devil1moveFrames delay:0.25f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *devil1move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil1moveAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [badBottom runAction:devil1move];
}

-(void) spawnGoodZigZagBottom
{
    //  CGSize winSize = [CCDirector sharedDirector].winSize;
    goodBottom = [[Character alloc] initWithSuperZigZagGuyImage];
    ((Character*)goodBottom).row = arc4random() % 5 + 1;
    goodBottom.anchorPoint = CGPointZero;
    goodBottom.scale=.15;
    int posHeight = -8 + (8 * ((Character*)goodBottom).row);
    goodBottom.position = ccp(460, posHeight);
    [self addChild:goodBottom z:(7 - ((Character*)goodBottom).row)];
    [goodGuysBottom addObject:goodBottom];
}

-(void) spawnGoodBigGuyBottom
{
    //  CGSize winSize = [CCDirector sharedDirector].winSize;
    goodBottom = [[Character alloc] initWithFriendlyTankImage];
    ((Character*)goodBottom).row = arc4random() % 5 + 1;
    goodBottom.anchorPoint = CGPointZero;
    goodBottom.scale=.15;
    int posHeight = -8 + (8 * ((Character*)goodBottom).row);
    goodBottom.position = ccp(460, posHeight);
    [self addChild:goodBottom z:(7 - ((Character*)goodBottom).row)];
    [goodGuysBottom addObject:goodBottom];
}

-(void) spawnBadZigZagBottom
{
    // CGSize winSize = [CCDirector sharedDirector].winSize;
    badBottom = [[Character alloc] initWithZigZagImage];
    ((Character*)badBottom).row = arc4random() % 5 + 1;
    badBottom.anchorPoint = CGPointZero;
    badBottom.scale=.15;
    int posHeight = -8 + (8 * ((Character*)badBottom).row);
    badBottom.position = ccp(460, posHeight);
    [self addChild:badBottom z:(7 - ((Character*)badBottom).row)];
    [badGuysBottom addObject:badBottom];
}
    
-(void) goodGuysWalk
{
    NSMutableArray *deadGoodGuysBottom = [[NSMutableArray alloc] init];
    
    if([goodGuysBottom count] > 1)
    {
        for(int q = 0; q < [goodGuysBottom count]; q++)
        {
            goodBottom = [goodGuysBottom objectAtIndex:q];
            
            if(((Character*)goodBottom).melee == true && goodBottom.position.x < winSize.width - 70)
            {
                int enemiesClose = 0;
                for(int i = 0; i < [badGuysBottom count]; i++)
                {
                    badBottom = [badGuysBottom objectAtIndex:i];

                    if(abs(badBottom.position.x - goodBottom.position.x) < 150)
                    {
                        enemiesClose++;
//                        NSLog(@"enemies close++");
                    }
                }
                if(enemiesClose > 0)
                {
                    ((Character*)goodBottom).melee = true;

                }
                else
                {
                    ((Character*)goodBottom).melee = false;
//                    NSLog(@"melee changed to false in good guys walk detection");
                }
            }
        
            if(((Character*)goodBottom).melee == false && ((Character*)goodBottom).type != GOOD_BASE)
            {
                goodBottom.position = ccp(goodBottom.position.x + .5,goodBottom.position.y);
                
                if (goodBottom.position.x > winSize.width)
                {
                    [deadGoodGuysBottom addObject:goodBottom];
                    //[goodGuysBottom removeObjectAtIndex:q];
                    //[self removeChild:goodBottom];
                }
            }
        }
    }
    for (CCSprite *s in deadGoodGuysBottom)
    {
        [goodGuysBottom removeObject:s];
        [self removeChild:s cleanup:YES];
    }

    [deadGoodGuysBottom removeAllObjects];
}

-(void) badGuysWalk
{
    NSMutableArray *deadBadGuysBottom = [[NSMutableArray alloc] init];
    if([badGuysBottom count] > 0)
    {
        for(int q = 0; q < [badGuysBottom count]; q++)
        {
            badBottom = [badGuysBottom objectAtIndex:q];
            if(((Character*)badBottom).melee == true && badBottom.position.x < winSize.width - 70)
            {
                int enemiesClose = 0;
                for(int i = 0; i < [goodGuysBottom count]; i++)
                {
                    goodBottom = [goodGuysBottom objectAtIndex:i];

                    if(abs(badBottom.position.x - goodBottom.position.x) < 150)
                    {
                        enemiesClose++;
                        //                        NSLog(@"enemies close++");
                    }
                }
                if(enemiesClose > 0)
                {
                    ((Character*)badBottom).melee = true;
                }
                else
                {
                    ((Character*)badBottom).melee = false;
//                    NSLog(@"melee changed to false in bad guys walk detection");
                }
            }
            
            if(((Character*)badBottom).melee == false)
            {
                badBottom.position = ccp(badBottom.position.x - .5, badBottom.position.y);
                
                if (badBottom.position.x < 0)
                {
                    [deadBadGuysBottom addObject:badBottom];
                }
            }
        }
    }
  
    for (CCSprite *s in deadBadGuysBottom)
    {
        [badGuysBottom removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    [deadBadGuysBottom removeAllObjects];
        
}

-(void) fight
{
    NSMutableArray *deadGoodGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadGuys = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < [goodGuysBottom count]; j++)
    {
        CCSprite *angel = [goodGuysBottom objectAtIndex:j];
        ((Character*)angel).attacked = false;
    }
    for (int f = 0; f < [badGuysBottom count]; f++)
    {
        CCSprite *devil = [badGuysBottom objectAtIndex:f];
        ((Character*)devil).attacked = false;
    }
    
    for(int j = 0; j < [goodGuysBottom count]; j++)
    {
        for (int f = 0; f < [badGuysBottom count]; f++)
        {
            if([goodGuysBottom count] > 1 || [badGuysBottom count] > 1)
            {
                CCSprite *fightingAngel = [goodGuysBottom objectAtIndex:j];
                goodMeleeBox = [fightingAngel boundingBox];
                goodMeleeBox.size.width -= 10;
                goodRangeBox = [fightingAngel boundingBox];
                goodRangeBox.size.width += 110;
                goodRangeBox.size.height += 10;
                
                CCSprite *fightingDevil = [badGuysBottom objectAtIndex:f];
                badMeleeBox = [fightingDevil boundingBox];
                badMeleeBox.size.width += 10;
                badRangeBox = [fightingDevil boundingBox];
                badRangeBox.size.width -= 110;
                badRangeBox.size.height += 10;
                
                
                if (CGRectIntersectsRect(goodMeleeBox, badMeleeBox))
                {
                    ((Character*)fightingAngel).melee = true;
                    ((Character*)fightingDevil).melee = true;
               
                    if(framecount % ((Character*)fightingAngel).attackFrequency == 0 && ((Character*)fightingAngel).type == GOOD_KNIFE && ((Character*)fightingAngel).attacked == false)
                    {
                        [self angel1attackAnimation:fightingAngel];
                        ((Character*)fightingAngel).attacked = true;
                        
                        if(((Character*)fightingDevil).type == BAD_BASE)
                        {
//                            NSLog(@"called subtract bad base health in melee");
                            [self subtractBadBaseHealth:fightingAngel];
                        }
                        else
                        {
                            //delay actual subtraction of health to allow time for animation to run
                            double delayInSeconds = 0.3;
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                [self subtractHealthFromDevil:fightingAngel :fightingDevil];
                            });
                        }
                    }
                    
                    if(framecount % ((Character*)fightingDevil).attackFrequency == 0 && immunity == false && ((Character*)fightingDevil).type == BAD_KNIFE && ((Character*)fightingDevil).attacked == false)
                    {
                        [self devil1attackAnimation:fightingDevil];
                        ((Character*)fightingDevil).attacked = true;
                        
                        if(((Character*)fightingAngel).type == GOOD_BASE && waveChanging == false)
                        {
//                            NSLog(@"called subtract good base health in melee");
                            [self subtractGoodBaseHealth:fightingDevil];
                        }
                        else
                        {
                            //delay actual subtraction of health to allow time for animation to run
                            double delayInSeconds = 0.3;
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                [self subtractHealthFromAngel:fightingDevil :fightingAngel];
                            });
                        }
                    }
                }
                
                if((CGRectIntersectsRect(goodRangeBox, badMeleeBox)) && ((Character*)fightingAngel).type != GOOD_KNIFE && ((Character*)fightingAngel).type != GOOD_BASE)
                {
                    if(framecount % ((Character*)fightingAngel).attackFrequency == 0)
                    {
                        if(((Character*)fightingAngel).type == GOOD_GUY)
                        {
                            [self angel2attackAnimation:fightingAngel];
                        }
                        if(((Character*)fightingAngel).type == GOOD_FASTSHOOTER)
                        {
                            [self angel3attackAnimation:fightingAngel];
                        }
                        if(((Character*)fightingAngel).type == BIG_GOOD_GUY)
                        {
//                            [self angelTankAttackAnimation:fightingAngel];
                        }
                        
                        //delay actual subtraction of health to allow time for animation to run
                        double delayInSeconds = 0.3;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self angelShoot:fightingAngel];
                        });
                        
                        //                        int angelAttackFrequency = ((Character*)fightingAngel).attackFrequency;
                        //                        NSLog(@"angel attack frequency = %d", angelAttackFrequency);
                    }
                }

                if((CGRectIntersectsRect(badRangeBox, goodMeleeBox)) && ((Character*)fightingDevil).type != BAD_KNIFE && ((Character*)fightingDevil).type != BAD_BASE)
                {
                    if(framecount % ((Character*)fightingDevil).attackFrequency == 0)
                    {
                        if(((Character*)fightingDevil).type == BAD_GUY)
                        {
                            [self devil2attackAnimation:fightingDevil];
//                            NSLog(@"devil regular shooter attack called");
                        }
                        if(((Character*)fightingDevil).type == BAD_FASTSHOOTER)
                        {
                            [self devil2attackAnimation:fightingDevil];
                        }
                        if(((Character*)fightingDevil).type == BIG_MONSTER)
                        {
//                            [self devilTankAttackAnimation:fightingDevil];
                            NSLog(@"devil tank attack called");
                        }
                        //delay actual subtraction of health to allow time for animation to run
                        double delayInSeconds = 0.15;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self devilShoot:fightingDevil];
                        });
                        
                    }
                }
                
                if(((Character*)fightingAngel).health <= 0)
                {
                    [deadGoodGuys addObject:fightingAngel];
                    if(((Character*)fightingDevil).type != BAD_BASE)
                    {
                        ((Character*)fightingDevil).melee = false;
                    }
//                    NSLog(@"dying method called for angel");
                }
                
                if(((Character*)fightingDevil).health <= 0)
                {
                    [deadBadGuys addObject:fightingDevil];
                    if(((Character*)fightingAngel).type != GOOD_BASE)
                    {
                        ((Character*)fightingAngel).melee = false;
                    }
//                    NSLog(@"dying method called for devil");
                }
                
                /*
                 badMeleeBox = [badBottom boundingBox];
                 badRangeBox = [badBottom boundingBox];
                 badRangeBox.size.width -= 110;
                 goodMeleeBox = [goodBottom boundingBox];
                 goodRangeBox = [goodBottom boundingBox];
                 goodRangeBox.size.width += 110;
                 badBaseBox = [badBase boundingBox];
                 goodBaseBox = [goodBase boundingBox];
                 
                 if(CGRectIntersectsRect(goodMeleeBox, badMeleeBox))
                 {
                 ((Character*)goodBottom).melee = true;
                 ((Character*)badBottom).melee = true;
                 
                 if(((Character*) goodBottom).type == GOOD_KNIFE)
                 {
                 [self angel1attackAnimation:goodBottom];
                 
                 if(framecount % 50 == 0)
                 {
                 if(((Character*)badBottom).health <= 2)
                 {
                 [deadBadGuys addObject:badBottom];
                 ((Character*)goodBottom).melee = false;
                 }
                 else
                 {
                 ((Character*)badBottom).health -= 2;
                 }
                 if(((Character*)goodBottom).health <= 1)
                 {
                 [deadGoodGuys addObject:goodBottom];
                 ((Character*)badBottom).melee = false;
                 }
                 else
                 {
                 ((Character*)goodBottom).health--;
                 }
                 //                        for (CCSprite *s in deadBadGuys)
                 //                        {
                 //                            [badGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                        for (CCSprite *s in deadGoodGuys)
                 //                        {
                 //                            [goodGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted good guy");
                 //                        }
                 }
                 
                 }
                 
                 if(((Character*) badBottom).type == BAD_KNIFE)
                 {
                 [self devil1attackAnimation:badBottom];
                 NSLog(@"recognized bad knife character");
                 
                 if(framecount % 50 == 0)
                 {
                 if(((Character*)badBottom).health <= 1)
                 {
                 [deadBadGuys addObject:badBottom];
                 ((Character*)goodBottom).melee = false;
                 }
                 else
                 {
                 ((Character*)badBottom).health--;
                 }
                 if(((Character*)goodBottom).health <= 2)
                 {
                 [deadGoodGuys addObject:goodBottom];
                 ((Character*)badBottom).melee = false;
                 }
                 else
                 {
                 ((Character*)goodBottom).health -= 2;
                 }
                 //                        for (CCSprite *s in deadBadGuys)
                 //                        {
                 //                            [badGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                        for (CCSprite *s in deadGoodGuys)
                 //                        {
                 //                            [goodGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 }
                 
                 }
                 
                 //                else if((((Character*) goodBottom).type == GOOD_KNIFE) && (((Character*) badBottom).type == BAD_KNIFE))
                 //                {
                 //                    if(framecount % 50 == 0)
                 //                    {
                 //                        if(((Character*)badBottom).health <= 2)
                 //                        {
                 //                            [deadBadGuys addObject:badBottom];
                 //                            ((Character*)goodBottom).melee = false;
                 //                        }
                 //                        else
                 //                        {
                 //                            ((Character*)badBottom).health -= 2;
                 //                        }
                 //                        if(((Character*)goodBottom).health <= 2)
                 //                        {
                 //                            [deadGoodGuys addObject:goodBottom];
                 //                            ((Character*)badBottom).melee = false;
                 //                        }
                 //                        else
                 //                        {
                 //                            ((Character*)goodBottom).health -= 2;
                 //                        }
                 //                        for (CCSprite *s in deadBadGuys)
                 //                        {
                 //                            [badGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                        for (CCSprite *s in deadGoodGuys)
                 //                        {
                 //                            [goodGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                    }
                 //
                 //                }
                 //
                 //                else
                 //                {
                 //                    if(framecount % 50 == 0)
                 //                    {
                 //                        if(((Character*)badBottom).health <= 1)
                 //                        {
                 //                            [deadBadGuys addObject:badBottom];
                 //                            ((Character*)goodBottom).melee = false;
                 //                        }
                 //                        else
                 //                        {
                 //                            ((Character*)badBottom).health--;
                 //                        }
                 //                        if(((Character*)goodBottom).health <= 1)
                 //                        {
                 //                            [deadGoodGuys addObject:goodBottom];
                 //                            ((Character*)badBottom).melee = false;
                 //                        }
                 //                        else
                 //                        {
                 //                            ((Character*)goodBottom).health--;
                 //                        }
                 //                        for (CCSprite *s in deadBadGuys)
                 //                        {
                 //                            [badGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                        for (CCSprite *s in deadGoodGuys)
                 //                        {
                 //                            [goodGuysBottom removeObject:s];
                 //                            [self removeChild:s cleanup:YES];
                 //                            // NSLog(@"deleted bad guy");
                 //                        }
                 //                    }
                 //                }
                 }
                 
                 else if(CGRectIntersectsRect(badRangeBox,goodMeleeBox) || CGRectIntersectsRect(badRangeBox, goodBaseBox))
                 {
                 if(((Character*) badBottom).type == BAD_FASTSHOOTER)
                 {
                 if(framecount % 50 == 0)
                 {
                 //NSLog(@"bad fast guy shooting");
                 float badX = badBottom.position.x;
                 float badY = badBottom.position.y;
                 
                 badBullet = [CCSprite spriteWithFile:@"lighting.png"];
                 badBullet.anchorPoint = CGPointZero;
                 badBullet.position = ccp(badX, badY + 10);
                 badBullet.scale=.15;
                 [self addChild:badBullet z:1];
                 [badBulletArray addObject:badBullet];
                 
                 CCMoveTo *shootLeft = [CCMoveTo actionWithDuration:25
                 position:ccp(-2000, badBullet.position.y)];
                 
                 [badBullet runAction:shootLeft];
                 //NSLog(@"bad bullet shot left");
                 }
                 }
                 
                 else if((((Character*) badBottom).type != BAD_FASTSHOOTER) && ((Character*) badBottom).type != BAD_KNIFE)
                 {
                 if(framecount % 100 == 0)
                 {
                 //NSLog(@"bad guy shooting");
                 float badX = badBottom.position.x;
                 float badY = badBottom.position.y;
                 
                 badBullet = [CCSprite spriteWithFile:@"lighting.png"];
                 badBullet.anchorPoint = CGPointZero;
                 badBullet.position = ccp(badX, badY + 10);
                 badBullet.scale=.15;
                 badBullet.color = ccc3(255, 0, 0);
                 [self addChild:badBullet z:1];
                 [badBulletArray addObject:badBullet];
                 
                 
                 CCMoveTo *shootLeft = [CCMoveTo actionWithDuration:25
                 position:ccp(-2000, badBullet.position.y)];
                 
                 [badBullet runAction:shootLeft];
                 //NSLog(@"bad bullet shot left");
                 }
                 }
                 }
                 
                 else if(CGRectIntersectsRect(goodRangeBox,badMeleeBox) || CGRectIntersectsRect(goodRangeBox, badBaseBox))
                 {
                 if(((Character*) goodBottom).type == GOOD_FASTSHOOTER)
                 {
                 if (framecount % 50 == 0)
                 {
                 //NSLog(@" good fast guy shooting");
                 float goodX = goodBottom.position.x;
                 float goodY = goodBottom.position.y;
                 
                 goodBullet = [CCSprite spriteWithFile:@"heart.png"];
                 goodBullet.anchorPoint = CGPointZero;
                 goodBullet.position = ccp(goodX, goodY + 12);
                 goodBullet.scale=.1;
                 [self addChild:goodBullet z:1];
                 [goodBulletArray addObject:goodBullet];
                 
                 CCMoveTo *shootRight = [CCMoveTo actionWithDuration:20
                 position:ccp(2000, goodBullet.position.y)];
                 [goodBullet runAction:shootRight];
                 }
                 }
                 
                 else if((((Character*) goodBottom).type != GOOD_FASTSHOOTER) && ((Character*) goodBottom).type != GOOD_KNIFE)
                 {
                 if(framecount % 100 == 0)
                 {
                 
                 //NSLog(@"good guy shooting");
                 float goodX = goodBottom.position.x;
                 float goodY = goodBottom.position.y;
                 
                 goodBullet = [CCSprite spriteWithFile:@"heart.png"];
                 goodBullet.anchorPoint = CGPointZero;
                 goodBullet.position = ccp(goodX, goodY + 12);
                 goodBullet.scale=.1;
                 goodBullet.color = ccc3(0, 255, 0);
                 [self addChild:goodBullet z:1];
                 [goodBulletArray addObject:goodBullet];
                 
                 CCMoveTo *shootRight = [CCMoveTo actionWithDuration:20
                 position:ccp(2000, goodBullet.position.y)];
                 [goodBullet runAction:shootRight];
                 }
                 }
                 }
                 */
            }
            
//            else if ([goodGuysBottom count] > 0)
//            {
//                badBaseBox = [badBase boundingBox];
//                CCSprite *fightingAngel = [goodGuysBottom objectAtIndex:j];
//                goodMeleeBox = [fightingAngel boundingBox];
//                goodMeleeBox.size.width -= 30;
//                goodRangeBox = [fightingAngel boundingBox];
//                goodRangeBox.size.width += 110;
//                goodRangeBox.size.height += 10;
//                
//                if(CGRectIntersectsRect(goodMeleeBox, badBaseBox))
//                {
//                    NSLog(@"good melee box, bad base box collision detected");
//                    ((Character*)fightingAngel).melee = true;
//                    
//                    if(framecount % ((Character*)fightingAngel).attackFrequency == 0)
//                    {
//                        [self subtractBadBaseHealth:fightingAngel];
//                    }
//                }
//                
//                if(CGRectIntersectsRect(goodRangeBox, badBaseBox))
//                {
//                    if(framecount % ((Character*)fightingAngel).attackFrequency == 0)
//                    {
//                        [self angelShoot:fightingAngel];
//                    }
//                }
//            }
//            
//            else if([badGuysBottom count] > 0)
//            {
//                goodBaseBox = [goodBase boundingBox];
//                CCSprite *fightingDevil = [badGuysBottom objectAtIndex:f];
//                badMeleeBox = [fightingDevil boundingBox];
//                badMeleeBox.size.width += 20;
//                badRangeBox = [fightingDevil boundingBox];
//                badRangeBox.size.width -= 110;
//                badRangeBox.size.height += 10;
//                
//                if(CGRectIntersectsRect(badMeleeBox, goodBaseBox))
//                {
//                    NSLog(@"bad melee box, good base box collision detected");
//                    ((Character*)fightingDevil).melee = true;
//                    
//                    if(framecount % ((Character*)fightingDevil).attackFrequency == 0)
//                    {
//                        [self subtractBadBaseHealth:fightingDevil];
//                    }
//                }
//                if(CGRectIntersectsRect(goodMeleeBox, badBaseBox))
//                {
//                    if(framecount % ((Character*)fightingDevil).attackFrequency == 0)
//                    {
//                        [self devilShoot:fightingDevil];
//                    }
//                }
//            }
        }
    }

    if([deadBadGuys count] > 0)
    {
        for (CCSprite *s in deadBadGuys)
        {
            [badGuysBottom removeObject:s];
            [self dying:s :dyingAnimationLength];
        }
        [deadBadGuys removeAllObjects];
    }

    if([deadGoodGuys count] > 0)
    {
        for (CCSprite *s in deadGoodGuys)
        {
            [goodGuysBottom removeObject:s];
            [self dying:s :dyingAnimationLength];
        }
        [deadGoodGuys removeAllObjects];
    }
}

//    else if([goodGuysBottom count] > 0  && [badGuysBottom count] == 0)
//    {
//        for(int i = 0; i < [goodGuysBottom count]; i++)
//        {
//            CCSprite *fightingAngel = [goodGuysBottom objectAtIndex:i];
//            goodMeleeBox = [fightingAngel boundingBox];
//            badBaseBox = [badBase boundingBox];
//            if(CGRectIntersectsRect(goodMeleeBox, badBaseBox))
//            {
//                if(framecount % ((Character*)fightingAngel).attackFrequency == 0)
//                {
//                    [self angel1attackAnimation:fightingAngel];
//                    NSLog(@"angel attack animation started");
//                    //delay actual subtraction of health to allow time for animation to run
//                    double delayInSeconds = 1.0;
//                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                        ((Character*)badBase).health -= (int)((Character*)fightingAngel).power;
//                        NSLog(@"angel actually attacks");
//                    });
//                    
//                }
//
//            }
//        }
//    }
    
    
   /*
    for(int j = 0; j < [goodGuysBottom count]; j++)
    {
        for (int f = 0; f < [badGuysBottom count]; f++)
        {
        if ([goodGuysBottom count] != 0)
        {
        goodBottom = [goodGuysBottom objectAtIndex:f];
    
//            
//        if(((Character*)goodBottom).type != GOOD_GUY)
//        {
            goodRangeBox = [goodBottom boundingBox];
            goodRangeBox.size.width += 100;
            
            NSLog(@"good range box made");
            if(CGRectIntersectsRect(goodRangeBox,badMeleeBox))
            {
                if(framecount % 100 == 0)
                {
                    
                NSLog(@"good guy shooting");
                float goodX = goodBottom.position.x;
                float goodY = goodBottom.position.y;
        
                goodBullet = [CCSprite spriteWithFile:@"heart.png"];
                goodBullet.anchorPoint = CGPointZero;
                goodBullet.position = ccp(goodX, goodY + 12);
                goodBullet.scale=.1;
                [self addChild:goodBullet z:1];
                [goodBulletArray addObject:goodBullet];

                CCMoveTo *shootRight = [CCMoveTo actionWithDuration:20
                                                       position:ccp(2000, goodBullet.position.y)];
            
                [goodBullet runAction:shootRight];
            }
        }
        
        }
        }
    }
    */

-(void)subtractHealthFromDevil:(CCSprite *)angel :(CCSprite *)devil
{
    if([goodGuysBottom containsObject:angel] == true)
    {
        ((Character*)devil).health -= (int)((Character*)angel).power;
    }
}

-(void)subtractHealthFromAngel:(CCSprite *)devil :(CCSprite *)angel
{
    if([badGuysBottom containsObject:devil] == true)
    {
        ((Character*)angel).health -= (int)((Character*)devil).power;
    }
}

-(void) angel1attackAnimation:(CCSprite*) angelOne
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel1attack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel1attack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 3; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a1-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.1f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCAnimate actionWithDuration:0.25f animation:attackAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [angelOne runAction:attack];
    //NSLog(@"knife angel attack");
}

-(void) angel1walkAnimation: (CCSprite*) goodBottom
{
    //animation
    
    NSMutableArray *angel1moveFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel1move.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel1move.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    angel1moveFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 8; ++i)
    {
        [angel1moveFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a1-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *angel1moveAnimation = [CCAnimation animationWithFrames: angel1moveFrames delay:0.15f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel1move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angel1moveAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [goodBottom runAction:angel1move];
}

-(void) angel2attackAnimation:(CCSprite*) angel
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel2attack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel2attack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a2-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *angel2attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:1.0f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *angel2attack = [CCAnimate actionWithDuration:3.0f animation:angel2attackAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [angel runAction:angel2attack];
}

-(void) angel3attackAnimation:(CCSprite*)angel
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angel3attack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angel3attack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a3-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.1f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCRepeat actionWithAction:[CCAnimate actionWithDuration:1.0f animation:attackAnimation restoreOriginalFrame:NO] times: 1];
    
    //tell the bear to run the taunting action
    [angel runAction:attack];
}

-(void) spartanAttackAnimation:(CCSprite *)spartan
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"spartanattack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"spartanattack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 3; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a6-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.1f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCAnimate actionWithDuration:.8f animation:attackAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [spartan runAction:attack];
}

-(void) angelTankAttackAnimation:(CCSprite*)angel
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angeltankattack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angeltankattack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a5-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCAnimate actionWithDuration:.6f animation:attackAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [angel runAction:attack];

}

-(void) devilTankAttackAnimation:(CCSprite*)devil
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"deviltankattack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"deviltankattack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d3-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.1f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCAnimate actionWithDuration:.6f animation:attackAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [devil runAction:attack];
}

-(void) angelShoot:(CCSprite*) angel
{
    if([goodGuysBottom containsObject:angel] == true)
    {
        float angelX = angel.position.x;
        float angelY = angel.position.y;
        
        if(((Character*)angel).bulletType == REGULAR_GOOD_BULLET)
        {
            goodBullet = [[Character alloc] initWithFriendlyRegularShooterBulletImage];
            goodBullet.scale = .25;
            goodBullet.color = ccBLACK;
            goodBullet.position = ccp(angelX + 40, angelY + 12);
            ((Character*)goodBullet).power = ((Character*)angel).power;
        }
        if(((Character*)angel).bulletType == SPEAR)
        {
            goodBullet = [[Character alloc] initWithSpearImage];
            goodBullet.scale = .7;
            goodBullet.position = ccp(angelX + 10, angelY + 10);
            ((Character*)goodBullet).power = ((Character*)angel).power;
        }
        if(((Character*)angel).bulletType == TANK_BOMB)
        {
            goodBullet = [[Character alloc] initWithTankBombImage];
            goodBullet.scale = .75;
            goodBullet.position = ccp(angelX + 60, angelY + 15);
            ((Character*)goodBullet).power = ((Character*)angel).power;
            [self tankBombAnimation:goodBullet];
        }
        
        goodBullet.anchorPoint = CGPointZero;
        
        [self addChild:goodBullet z:3];
        [goodBulletArray addObject:goodBullet];
        
        CCMoveTo *shootRight = [CCMoveTo actionWithDuration:25
                                                   position:ccp(2000, goodBullet.position.y)];
        
        //    //delay actual subtraction of health to allow time for animation to run
        //    double delayInSeconds = 0.3;
        //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [goodBullet runAction:shootRight];
        //    });

    }
}

-(void) devilShoot:(CCSprite*) devil
{
    if([badGuysBottom containsObject:devil] == true)
    {
        //NSLog(@"bad fast guy shooting");
        float devilX = devil.position.x;
        float devilY = devil.position.y;
        
        if(((Character*)devil).bulletType == REGULAR_BAD_BULLET)
        {
            badBullet = [[Character alloc] initWithEnemyRegularShooterBulletImage];
            badBullet.scale = .25;
            badBullet.color = ccBLACK;
            
            badBullet.position = ccp(devilX - 5, devilY + 10);
            ((Character*)badBullet).power = ((Character*)devil).power;
            badBullet.color = ccc3(100,0,0);
            NSLog(@"shot enemy regular bullet");
            
        }
        if(((Character*)devil).bulletType == TANK_BOMB)
        {
            badBullet = [[Character alloc] initWithTankBombImage];
            badBullet.scale = .75;
            ((Character*)badBullet).power = ((Character*)devil).power;
            badBullet.position = ccp(devilX - 10, devilY + 15);
            NSLog(@"shot enemy tank bomb");
            [self tankBombAnimation:badBullet];
        }
        
        badBullet.anchorPoint = CGPointZero;
        
        [self addChild:badBullet z:3];
        [badBulletArray addObject:badBullet];
        
        CCMoveTo *shootLeft = [CCMoveTo actionWithDuration:25
                                                  position:ccp(-2000, badBullet.position.y)];
        
        [badBullet runAction:shootLeft];
        
        //    //delay actual subtraction of health to allow time for animation to run
        //    double delayInSeconds = 0.3;
        //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //        [badBullet runAction:shootLeft];
        //    });

    }
        
}

-(void) devil1attackAnimation:(CCSprite*) devil
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil1attack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil1attack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 3; i++)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d1-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCRepeat actionWithAction:[CCAnimate actionWithDuration:0.6f animation:attackAnimation restoreOriginalFrame:NO] times: 1];
    
    //tell the bear to run the taunting action
    [devil runAction:attack];
    //NSLog(@"knife devil attack");
}

-(void)devil1walkAnimation:(CCSprite *)devil
{
    //animation
    
    NSMutableArray *devil1moveFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil1move.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil1move.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    devil1moveFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 8; ++i)
    {
        [devil1moveFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d1-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *devil1moveAnimation = [CCAnimation animationWithFrames: devil1moveFrames delay:0.15f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *devil1move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:devil1moveAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [devil runAction:devil1move];

}

-(void) devil2attackAnimation:(CCSprite *)devil
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"devil2attack.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"devil2attack.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; i++)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"d2-attack-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCRepeat actionWithAction:[CCAnimate actionWithDuration:0.6f animation:attackAnimation restoreOriginalFrame:NO] times: 1];
    
    //tell the bear to run the taunting action
    [devil runAction:attack];
}

-(void) tankBombAnimation:(CCSprite *)tankBomb
{
    //animation
    
    NSMutableArray *attackFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angeltankbomb.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angeltankbomb.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    attackFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 5; i++)
    {
        [attackFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"bomb-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *attackAnimation = [CCAnimation animationWithFrames: attackFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *attack = [CCRepeatForever actionWithAction:[CCAnimate actionWithDuration:0.6f animation:attackAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [tankBomb runAction:attack];
}

-(void) mainCharacterIdleAnimation:(CCSprite*)mainCharacter
{
    //animation
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"main-idle.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"main-idle.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *idleFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 20; ++i)
    {
        [idleFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"main-idle-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *idleAnimation = [CCAnimation animationWithFrames: idleFrames delay:0.12f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *idle = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:idleAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [mainCharacter runAction:idle];
}

-(void) mainCharacterShootAnimation:(CCSprite *)mainCharacter :(int)direction
{
    //animation
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"main-shoot.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"main-shoot.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *shootFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [shootFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"main-%d-%d.png",direction, i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *shootAnimation = [CCAnimation animationWithFrames: shootFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    //CCAction *shoot = [CCRepeat actionWithAction:[CCAnimate actionWithDuration:1.0f animation:shootAnimation restoreOriginalFrame:NO] times: 1];
    
    CCAction *shoot = [CCAnimate actionWithDuration:0.2f animation:shootAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [mainCharacter runAction:shoot];
}

-(void) explosion:(CCSprite *)character :(double)delay :(BOOL)big
{
    //NSLog(@"inside explosion method");
    double delayInSeconds = delay - .1;
    CCSprite *enemyBase = [CCSprite spriteWithFile:@"badbase-3.png"];
    CCSprite *friendlyBase = [CCSprite spriteWithFile:@"goodbase-3.png"];
    BOOL friendlyBaseExplosion = false;
    BOOL enemyBaseExplosion = false;
    if(((Character*)character).type == BAD_BASE)
    {
        enemyBase.position = ccp(winSize.width - 50, BASE_HEIGHT);
        enemyBase.scale = .5;
        [self addChild:enemyBase z:1];
        enemyBaseExplosion = true;
    }
    
    if(((Character*)character).type == GOOD_BASE)
    {
        friendlyBase.position = ccp(50, BASE_HEIGHT);
        friendlyBase.scale = .5;
        [self addChild:friendlyBase z:1];
        friendlyBaseExplosion = true;
        
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
 
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        if(((Character*)character).type == GOOD_BASE)
        {
            [goodGuysBottom removeObject:character];
            [self youLose];
            NSLog(@"called you lose");
        }
        if(((Character*)character).type == BAD_BASE)
        {
            NSLog(@"called you win");
            [badGuysBottom removeObject:character];
            [self youWin];
        }
        
        if(big == NO)
        {
            [self removeChild:character cleanup:YES];
        }
        
    });


    //animation
    
    if(big == NO)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"explosion.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"explosion.png"];
        [self addChild:spriteSheet];
    }
    else
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"bigExplosion.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"bigExplosion.png"];
        [self addChild:spriteSheet];
        NSLog(@"using big explosion frames");
    }
    
    
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    NSMutableArray *explosionFrames = [NSMutableArray array];
    
    if(big == NO)
    {
        for(int i = 1; i <= 4; i++)
        {
            [explosionFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"explode-%d.png", i]]];
        }
    }
    else
    {
        for(int i = 1; i <= 4; i++)
        {
            [explosionFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"explode-%d-big.png", i]]];
        }
    }
    
    float time = 0.1f;
    
    //Create an animation from the set of frames you created earlier

    CCAnimation *explosionAnimation = [CCAnimation animationWithFrames: explosionFrames delay:time];

    
    //Create an action with the animation that can then be assigned to a sprite
    
    if(big == NO)
    {
        CCAction *explode = [CCAnimate actionWithDuration:delayInSeconds  animation:explosionAnimation restoreOriginalFrame:NO];
            [character runAction:explode];
    }
    else
    {
        CCAction *explode = [CCAnimate actionWithDuration:delayInSeconds animation:explosionAnimation restoreOriginalFrame:YES];
        if(friendlyBaseExplosion == true)
        {
            [friendlyBase runAction:explode];
        }
        if(enemyBaseExplosion == true)
        {
            [enemyBase runAction:explode];
        }
    }
}

-(void) dying:(CCSprite*)character :(double) delay
{
    //NSLog(@"inside dying method");
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeChild:character cleanup:YES];
        //NSLog(@"called removeChild and cleanup for dying method");
    });
    
    
    //animation
    
    NSMutableArray *dyingFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"dying.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"dying.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    dyingFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [dyingFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"poof-%d.png", i]]];
//        if(i == 3 && waveChanging == true)
//        {
//            
//        }
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *dyingAnimation = [CCAnimation animationWithFrames: dyingFrames delay:0.15f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *dying = [CCAnimate actionWithDuration:(dyingAnimationLength + .1) animation:dyingAnimation restoreOriginalFrame:NO];
    
    //tell the bear to run the taunting action
    [character runAction:dying];
    //NSLog(@"was told to run dying animation");
    
}


- (void) detectBulletSoldierCollisions
{
    NSMutableArray *deadGoodGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadGuys = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodBullets = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadBullets = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodBombs = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadBombs = [[NSMutableArray alloc] init];
    NSMutableArray *deadBadGuysKilledByBombs = [[NSMutableArray alloc] init];
    NSMutableArray *deadGoodGuysKilledByBombs = [[NSMutableArray alloc] init];
    

    for (int b = 0; b < [goodBulletArray count]; b++)
    {
        if([goodBulletArray count] > 0)
        {
            CCSprite *goodBullet = [goodBulletArray objectAtIndex:b];
            
            if(goodBullet.position.x > 480 || goodBullet.position.x < 0 || goodBullet.position.y < 0)
            {
                [deadGoodBullets addObject:goodBullet];
                //            [goodBulletArray removeObjectAtIndex:b];
                //            [self removeChild:bullet cleanup:YES];
                // NSLog(@"removed bullet off screen");
            }

        }
            
    }
    
    for (int a = 0; a < [badBulletArray count]; a++)
    {
        if([badBulletArray count] > 0)
        {
            badBullet = [badBulletArray objectAtIndex:a];
            
            if(badBullet.position.x > 480 || badBullet.position.x < 0)
            {
                [deadBadBullets addObject:badBullet];
                //NSLog(@"removed bullet");
                //            [badBulletArray removeObjectAtIndex:a];
                //            [self removeChild:bullet cleanup:YES];
            }
        }
    }
    
    if(immunity == false)
    {
        for(int i = 0; i < [goodGuysBottom count]; i++)
        {
            for(int j = 0; j < [badBulletArray count]; j++)
            {
                if([badBulletArray count] > 0 && [goodGuysBottom count] > 0)
                {
                    goodBottom = [goodGuysBottom objectAtIndex:i];
                    goodBottomRect = [goodBottom boundingBox];
                    badBullet = [badBulletArray objectAtIndex:j];
                    badBulletBox = [badBullet boundingBox];
                    
                    //NSLog(NSStringFromCGRect(goodBottomRect));
                    //NSLog(NSStringFromCGRect(bulletBox));
                    
                    if(CGRectIntersectsRect(goodBottomRect,badBulletBox) && ((Character*)badBullet).attacked == false) /* && ((Character*)goodBottom).immunity >= immunityFramecount)*/
                    {
                        ((Character*)badBullet).attacked = true;
                        
                        if(((Character*)goodBottom).type == GOOD_BASE && waveChanging == false)
                        {
//                            NSLog(@"called subtract good base health in bullet detection");
                            [self subtractGoodBaseHealth:badBullet];
                        }
                        else
                        {
                            ((Character*)goodBottom).health -= ((Character*)badBullet).power;
                            if(((Character*)goodBottom).health <= 0)
                            {
                                [deadGoodGuys addObject:goodBottom];
                            }
                        }
                        [deadBadBullets addObject:badBullet];
                    
                            //                                    [goodGuysBottom removeObjectAtIndex:i];
                            //                                    [badBulletArray removeObjectAtIndex:j];
                            //                                    [self removeChild:goodBottom cleanup:YES];
                            //                                    [self removeChild:bullet cleanup:YES];
                            //   NSLog(@"good guy killed");
                    }
                }
            }
        }
    }

    for(int i = 0; i < [badGuysBottom count]; i++)
    {
        for(int j = 0; j < [goodBulletArray count]; j++)
        {
            if([goodBulletArray count] > 0 && [badGuysBottom count] > 0)
            {
                badBottom = [badGuysBottom objectAtIndex:i];
                badBottomRect = [badBottom boundingBox];
                goodBullet = [goodBulletArray objectAtIndex:j];
                goodBulletBox = [goodBullet boundingBox];
            
                if(CGRectIntersectsRect(badBottomRect,goodBulletBox) && ((Character*)goodBullet).attacked == false) //&& ((Character*)badBottom).immunity >= immunityFramecount)
                {
                    ((Character*)goodBullet).attacked = true;
                    
                    if(((Character*)badBottom).type == BAD_BASE)
                    {
//                        NSLog(@"called subtract bad base health in bullet detection");
                        [self subtractBadBaseHealth:goodBullet];
                    }
                    else
                    {
                        ((Character*)badBottom).health -= ((Character*)goodBullet).power;
                        if(((Character*)badBottom).health <= 0)
                        {
                            [deadBadGuys addObject:badBottom];
                        }
                    }
                    [deadGoodBullets addObject:goodBullet];
                }
            }
        }
    }
    
    for(int i = 0; i < [badGuysBottom count]; i++)
    {
        for(int j = 0; j < [goodBombs count]; j++)
        {
            if([goodBombs count] > 0 && [badGuysBottom count] > 0)
            {
                badBottom = [badGuysBottom objectAtIndex:i];
                badBottomRect = [badBottom boundingBox];
                goodBullet = [goodBombs objectAtIndex:j];
                goodBulletBox = [goodBullet boundingBox];
                goodBulletBox.size.height += 50;
                
                if(CGRectIntersectsRect(badBottomRect,goodBulletBox) && abs(goodBullet.position.y - badBottom.position.y) < 45)
                {

                    if(((Character*)badBottom).type == BAD_BASE)
                    {
                        [self subtractBadBaseHealth:goodBullet];
                        NSLog(@"good bomb detection - subtract base health");

                    }
                    else
                    {
                        ((Character*)badBottom).health -= ((Character*)goodBullet).power;
                        if(((Character*)badBottom).health <= 0)
                        {
                            [deadBadGuysKilledByBombs addObject:badBottom];
                        }
                    }
                    [deadGoodBombs addObject:goodBullet];
                }
            }
        }
    }
    
    for(int i = 0; i < [goodGuysBottom count]; i++)
    {
        for(int j = 0; j < [badBombs count]; j++)
        {
            if([badBombs count] > 0 && [goodGuysBottom count] > 0 && immunity == false)
            {
                goodBottom = [goodGuysBottom objectAtIndex:i];
                goodBottomRect = [goodBottom boundingBox];
                badBullet = [badBombs objectAtIndex:j];
                badBulletBox = [badBullet boundingBox];
                badBulletBox.size.height += 50;
                
                if(CGRectIntersectsRect(goodBottomRect,badBulletBox) && abs(goodBottom.position.y - badBullet.position.y) < 45)
                {
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
                    {
                        [[SimpleAudioEngine sharedEngine] playEffect:@"friendly.wav"];
                    }
                    
                    if(((Character*)goodBottom).type == GOOD_BASE && waveChanging == false)
                    {
                        [self subtractGoodBaseHealth:badBullet];
                        NSLog(@"bad bomb detection - subtract base health");
                    }
                    else
                    {
                        ((Character*)goodBottom).health -= ((Character*)badBullet).power;
                        if(((Character*)goodBottom).health <= 0)
                        {
                            [deadGoodGuysKilledByBombs addObject:goodBottom];
                        }
                    }
                    [deadBadBombs addObject:badBullet];
                }
            }
        }
    }

   // NSLog(@"yay");
    if([deadBadGuys count] > 0)
    {
        for (CCSprite *s in deadBadGuys)
        {
            [badGuysBottom removeObject:s];
            [self dying:s :dyingAnimationLength];
            //NSLog(@"inside bullet bad guy collision");
        }
        [deadBadGuys removeAllObjects];
    }
    if([deadGoodGuys count] > 0)
    {
        for (CCSprite *s in deadGoodGuys)
        {
            [goodGuysBottom removeObject:s];
            [self dying:s :dyingAnimationLength];
            //NSLog(@"inside bullet good guy collision");
            if(((Character*)s).type == GOOD_HELICOPTER_BOMB)
            {
                NSLog(@"1");
            }
        }
        [deadGoodGuys removeAllObjects];
    }
    if([deadGoodBullets count] > 0)
    {
        for (CCSprite *s in deadGoodBullets)
        {
            [goodBulletArray removeObject:s];
            [self removeChild:s cleanup:YES];
            //NSLog(@"deleted good bullet");
            if(((Character*)s).type == GOOD_HELICOPTER_BOMB)
            {
                NSLog(@"2");
            }
        }
        [deadGoodBullets removeAllObjects];
    }
    
    if([deadBadBullets count] > 0)
    {
        for (CCSprite *s in deadBadBullets)
        {
            [badBulletArray removeObject:s];
            [self removeChild:s cleanup:YES];
            //NSLog(@"deleted bad bullet");
        }
        [deadBadBullets removeAllObjects];
    }
    if([deadGoodBombs count] > 0)
    {
        for (CCSprite *s in deadGoodBombs)
        {
            [goodBombs removeObject:s];
//            [goodGuys removeObject:s];
            [self explosion:s :explosionAnimationLength :NO];
            //NSLog(@"deleted bad bullet");

        }
        [deadGoodBombs removeAllObjects];
    }
    if([deadBadBombs count] > 0)
    {
        for (CCSprite *s in deadBadBombs)
        {
            [badBombs removeObject:s];
            [self explosion:s :explosionAnimationLength :NO];
            //NSLog(@"deleted bad bullet");
        }
        [deadBadBombs removeAllObjects];
    }
    if([deadBadGuysKilledByBombs count] > 0)
    {
        for (CCSprite *s in deadBadGuysKilledByBombs)
        {
            [deadBadGuys removeObject:s];
            [self removeChild:s];
        }
        [deadBadGuysKilledByBombs removeAllObjects];
    }
    if([deadGoodGuysKilledByBombs count] > 0)
    {
        for (CCSprite *s in deadGoodGuysKilledByBombs)
        {
            [deadGoodGuys removeObject:s];
        }
        [deadGoodGuysKilledByBombs removeAllObjects];
    }
}

-(void) airstrike: (CCMenuItemImage *)airstrikePowerUp
{
    NSNumber* NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"];
    int numAvailable = [NSNumAvailable intValue];
    
    if(numAvailable > 0 && waveChanging == false)
    {
        NSNumber* levelnumber = [NSNumber numberWithInt:currentLevelSelected];
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: levelnumber, @"level_number", nil];
        [MGWU logEvent:@"airstrikeUsed" withParams:params];
        
        bomber = [[Character alloc] initWithGoodHelicopterImage];
        bomber.scale=.6;
        
        bomber.position = ccp(-20, winSize.height * .85); //+ enemy.contentSize.height/2);
        [self addChild:bomber];
        [bombers addObject:bomber];
        
        
        // Create the actions
        CCMoveTo * actionMove = [CCMoveTo actionWithDuration:5
                                                    position:ccp(winSize.width + 30, bomber.position.y)];
        
        [bomber runAction:actionMove];
        numAvailable--;

        
        //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"angelplanemove.plist"];
        
        //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"angelplanemove.png"];
        
        [self addChild:spriteSheet];
        
        //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
        
        //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
        
        NSMutableArray *angelPlaneMoveFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 8; ++i)
        {
            [angelPlaneMoveFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a4-%d.png", i]]];
        }
        
        //Create an animation from the set of frames you created earlier
        
        CCAnimation *angelPlaneMoveAnimation = [CCAnimation animationWithFrames: angelPlaneMoveFrames delay:0.25f];
        
        //Create an action with the animation that can then be assigned to a sprite
        
        CCAction *angelPlaneMove = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:angelPlaneMoveAnimation restoreOriginalFrame:NO]];
        
        //tell the bear to run the taunting action
        [bomber runAction:angelPlaneMove];
        
        [self removeChild:airstrikeCount];
        airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [airstrikeCount setString:[NSString stringWithFormat:@"%d", numAvailable]];
        airstrikeCount.position = CGPointMake(winSize.width * .08 + winSize.width *.005, winSize.height - winSize.height/8);
        airstrikeCount.color = ccBLACK;
        [self addChild:airstrikeCount z:5000];
    }
    
    NSNumAvailable = [NSNumber numberWithInt:numAvailable];
    [[NSUserDefaults standardUserDefaults] setObject:NSNumAvailable forKey: @"airstrikesAvailable"];
}

-(void)reinforcements: (CCMenuItemImage *) reinforcementPowerUp
{
//    truck = [CCSprite spriteWithFile: @"car-side.png"];
//    truck.scale =.5;
//    truck.position = ccp(-20,15);
//    [self addChild:truck z:10];
//    truckCount++;
//    
//    CCMoveTo * DriveIn = [CCMoveTo actionWithDuration:2 position:ccp(60, truck.position.y)];
//    CCMoveTo * NoMove = [CCMoveTo actionWithDuration:5 position:ccp(60, truck.position.y)];
//    CCMoveTo * DriveOut = [CCMoveTo actionWithDuration:2 position:ccp(-100, truck.position.y)];
//    
//    [truck runAction:[CCSequence  actions: DriveIn, NoMove, DriveOut, nil]];
    
   
    
    NSNumber* NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"];
    int numAvailable = [NSNumAvailable intValue];
    
    if(numAvailable > 0 && waveChanging == false)
    {
        NSNumber* levelnumber = [NSNumber numberWithInt:currentLevelSelected];
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: levelnumber, @"level_number", nil];
        [MGWU logEvent:@"reinforcementsUsed" withParams:params];
        reinforcements = true;
        numAvailable--;
    }
    
    NSNumAvailable = [NSNumber numberWithInt:numAvailable];
    [[NSUserDefaults standardUserDefaults] setObject:NSNumAvailable forKey: @"reinforcementsAvailable"];
    
    [self removeChild:reinforcemtsCount];
    reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
    [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", numAvailable]];
    reinforcemtsCount.position = CGPointMake(winSize.width * .08 + counterSpacing, winSize.height - winSize.height/8);
    reinforcemtsCount.color = ccBLACK;
    [self addChild:reinforcemtsCount z:5000];
}

-(void)spawnReinforcement
{
    CCSprite *reinforcement = [[Character alloc] initWithSpartanImage];
    ((Character*)reinforcement).row = arc4random() % 5 + 1;
    [goodGuysBottom addObject:reinforcement];
    reinforcement.anchorPoint = CGPointZero;
    int posHeight = -8 + (8 * ((Character*)reinforcement).row);
    reinforcement.position = ccp(angelStartingWidth, posHeight);
    [self addChild:reinforcement z:(7 - ((Character*)reinforcement).row)];
    
    reinforcement.scale = .5;
    
    //NSLog(@"row = %d", ((Character*)goodBottom).row);
    //NSLog(@"height = %d", posHeight);
    //NSLog(@"z = %d",7 - ((Character*)goodBottom).row);
    
    [self spartanWalkAnimation:reinforcement];
    
}

-(void) spartanWalkAnimation:(CCSprite *)reinforcement
{
    //animation
    
    NSMutableArray *moveFrames;
    
    //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"spartanmove.plist"];
    
    //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"spartanmove.png"];
    
    [self addChild:spriteSheet];
    
    //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
    
    //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
    
    moveFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 7; ++i)
    {
        [moveFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"a6-%d.png", i]]];
    }
    
    //Create an animation from the set of frames you created earlier
    
    CCAnimation *moveAnimation = [CCAnimation animationWithFrames: moveFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moveAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [reinforcement runAction:move];
}

-(void)immunityActivator: (CCMenuItemImage *) immunityPowerUp
{
    NSNumber* NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"];
    int numAvailable = [NSNumAvailable intValue];
    
    if(numAvailable > 0 && immunity == false && waveChanging == false)
    {
        NSNumber* levelnumber = [NSNumber numberWithInt:currentLevelSelected];
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: levelnumber, @"level_number", nil];
        [MGWU logEvent:@"immunityUsed" withParams:params];
        immunity = true;
        NSLog(@"immunity activated");
        numAvailable--;
    }
    
    NSNumAvailable = [NSNumber numberWithInt:numAvailable];
    [[NSUserDefaults standardUserDefaults] setObject:NSNumAvailable forKey: @"immunityAvailable"];
    
    [self removeChild:immunityCount];
    immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
    [immunityCount setString:[NSString stringWithFormat:@"%d", numAvailable]];
    immunityCount.position = CGPointMake(winSize.width * .08 + counterSpacing * 2, winSize.height - winSize.height/8);
    immunityCount.color = ccBLACK;
    [self addChild:immunityCount z:5000];


}

-(void) truckGoodBottomOrBadBottomCollisions
{
    NSMutableArray *runOverGoodGuys = [[NSMutableArray alloc] init];
    NSMutableArray *runOverBadGuys = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [badGuysBottom count]; i++)
    {
        if (truckCount == 1 && [goodGuysBottom count] > 0)
        {
            badBottom = [badGuysBottom objectAtIndex: i];
            badBottomRect = [badBottom boundingBox];
            truckBox = [truck boundingBox];
            if(CGRectIntersectsRect(badBottomRect, truckBox))
            {   NSLog(@"Run over bad guy");
                [runOverBadGuys addObject:badBottom];
                
            }
        }
    }
//    for (int i = 0; i < [goodGuysBottom count]; i++)
//    {
//        if (truckCount == 1 && [goodGuysBottom count] > 0)
//        {
//            goodBottom = [goodGuysBottom objectAtIndex: i];
//            goodBottomRect = [goodBottom boundingBox];
//            truckBox = [truck boundingBox];
//            if(CGRectIntersectsRect(goodBottomRect, truckBox))
//            {
//                // NSLog(@"Run over good guy");
//                [runOverGoodGuys addObject:goodBottom];
//            }
//        }
//    }
    for (CCSprite *d in runOverBadGuys)
    {
        [badGuysBottom removeObject:d];
        [self removeChild:d cleanup:YES];
        NSLog(@"deleted run over bad guy");
    }
    [runOverBadGuys removeAllObjects];
    
    for (CCSprite *d in runOverGoodGuys)
    {
        [goodGuysBottom removeObject:d];
        [self removeChild:d cleanup:YES];
        NSLog(@"deleted run over good guy");
    }
    [runOverGoodGuys removeAllObjects];
}

-(void) drawBoundingBox: (CGRect) rect
{
    
    CGPoint vertices[4]={
        
        ccp(rect.origin.x,rect.origin.y),
        
        ccp(rect.origin.x+rect.size.width,rect.origin.y),
        
        ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height),
        
        ccp(rect.origin.x,rect.origin.y+rect.size.height),
        
    };
    
    ccDrawPoly(vertices, 4, YES);
}

-(void) addBases
{
    goodBase = [[Character alloc] initWithGoodGuyBaseImage1];
    badBase = [[Character alloc] initWithBadGuyBaseImage1];
    goodBase.position = ccp(40, BASE_HEIGHT);
    badBase.position = ccp(winSize.width - 35, BASE_HEIGHT);
    goodBase.scale = .4;
    badBase.scale = .4;
    [self addChild:goodBase z:2];
    [self addChild:badBase z:2];
    [goodGuysBottom addObject:goodBase];
    [badGuysBottom addObject:badBase];
    
    NSLog(@"winSize.width = %d", (int)winSize.width);
}

-(void) youLose
{
//    NSMutableArray *eraseGoodGuys = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBadGuys = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseGoodGuysBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBadGuysBottom = [[NSMutableArray alloc] init];
//    
//    for(int x = 0; x < [badGuys count]; x++)
//    {
//        badGuy = [badGuys objectAtIndex:x];
//        [eraseBadGuys addObject:badGuy];
//    }
//    
//    for (CCSprite *s in eraseBadGuys)
//    {
//        [badGuys removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [eraseBadGuys removeAllObjects];
//    
//    for(int i = 0; i < [goodGuys count]; i++)
//    {
//        goodGuy = [goodGuys objectAtIndex:i];
//        [eraseGoodGuys addObject:goodGuy];
//    
//    }
//    
//    for (CCSprite *s in eraseGoodGuys)
//    {
//        [goodGuys removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [eraseGoodGuys removeAllObjects];
    
//
//    for(int x = 0; x < [badGuysBottom count]; x++)
//    {
//        badBottom = [badGuysBottom objectAtIndex:x];
//        if(((Character*)badBottom).type != BAD_BASE)
//        {
//            [eraseBadGuysBottom addObject:badBottom];
//        }
//    }
//    
//    for (CCSprite *s in eraseBadGuysBottom)
//    {
//        [badGuysBottom removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [eraseBadGuysBottom removeAllObjects];
//    
//    for(int i = 0; i<[goodGuysBottom count]; i++)
//    {
//        goodBottom = [goodGuysBottom objectAtIndex:i];
//        if(((Character*)goodBottom).type != GOOD_BASE)
//        {
//            [eraseGoodGuysBottom addObject:goodBottom];
//        }
//    }
//    
//    for (CCSprite *s in eraseGoodGuysBottom)
//    {
//        [goodGuysBottom removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseGoodGuysBottom removeAllObjects];
    
//    (((Character*)badBase).health) = 10;
//    [badBaseHealthLabel setString:[NSString stringWithFormat:@"Enemy Base Health: %d",((Character*) badBase).health]];
    //Scenario4 = true;
    int totalCoins = [[MGWU objectForKey:@"coins"] intValue];
    
    NSNumber* levelnumber = [NSNumber numberWithInt:currentLevelSelected];
    NSNumber* time = [NSNumber numberWithInt:(framecount/60)];
    NSNumber* coinsInTotal = [NSNumber numberWithInt:totalCoins];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: time, @"time", levelnumber, @"level_number", coinsInTotal, @"coinsInTotal", nil];
    [MGWU logEvent:@"lostLevel" withParams:params];
    
    
    waveChanging = true;

    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
}

-(void) youWin
{
//    NSMutableArray *eraseGoodGuys = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBadGuys = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseGoodGuysBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBadGuysBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseGoodBulletsBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBadBulletsBottom = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseCoins = [[NSMutableArray alloc] init];
//    NSMutableArray *eraseBases = [[NSMutableArray alloc] init];
    
    GameData *data = [GameData sharedData];
    data.score = wave;
    
    
    
//    for(int x = 0; x < [deadBases count]; x++)
//    {
//        CCSprite *base = [deadBases objectAtIndex:x];
//        [eraseBases addObject:base];
//    }
//    
//    for(CCSprite *s in eraseBases)
//    {
//        [deadBases removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [eraseBases removeAllObjects];
   
//    for(int x = 0; x<[badGuys count]; x++)
//    {
//        badGuy = [badGuys objectAtIndex:x];
//        [eraseBadGuys addObject:badGuy];
//    }
//    
//    for (CCSprite *s in eraseBadGuys)
//    {
//        [badGuys removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [eraseBadGuys removeAllObjects];
//    
//    
//    for(int i = 0; i < [goodGuys count]; i++)
//    {
//        goodGuy = [goodGuys objectAtIndex:i];
//        [eraseGoodGuys addObject:goodGuy];
//    }
//    
//    for (CCSprite *s in eraseGoodGuys)
//    {
//        [goodGuys removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseGoodGuys removeAllObjects];
//    
//    
//    for(int x = 0; x < [badGuysBottom count]; x++)
//    {
//        badBottom = [badGuysBottom objectAtIndex:x];
//        [eraseBadGuysBottom addObject:badBottom]; 
//    }
//    
//    for (CCSprite *s in eraseBadGuysBottom)
//    {
//        [badGuysBottom removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseBadGuysBottom removeAllObjects];
//    
//    
//    for(int i = 0; i<[goodGuysBottom count]; i++)
//    {
//        goodBottom = [goodGuysBottom objectAtIndex:i];
//        [eraseGoodGuysBottom addObject:goodBottom];
//    }
//    
//    for (CCSprite *s in eraseGoodGuysBottom)
//    {
//        [goodGuysBottom removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseGoodGuysBottom removeAllObjects];
//    
//    
//    for(int x = 0; x < [badBulletArray count]; x++)
//    {
//        badBottom = [badBulletArray objectAtIndex:x];
//        [eraseBadBulletsBottom addObject:badBottom];
//    }
//    
//    for (CCSprite *s in eraseBadBulletsBottom)
//    {
//        [badBulletArray removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseBadBulletsBottom removeAllObjects];
//    
//    
//    for(int i = 0; i<[goodBulletArray count]; i++)
//    {
//        goodBottom = [goodBulletArray objectAtIndex:i];
//        [eraseGoodBulletsBottom addObject:goodBottom];
//    }
//    
//    for (CCSprite *s in eraseGoodBulletsBottom)
//    {
//        [goodBulletArray removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseGoodBulletsBottom removeAllObjects];
//    
//    for(int i = 0; i<[coinsArray count]; i++)
//    {
//        goodBottom = [coinsArray objectAtIndex:i];
//        [eraseCoins addObject:goodBottom];
//    }
//    
//    for (CCSprite *s in eraseCoins)
//    {
//        [coinsArray removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    
//    [eraseCoins removeAllObjects];
//    

    
    
    
//    ((Character*)badBase).health = 10;
//    [badBaseHealthLabel setString:[NSString stringWithFormat:@"Enemy Base Health: %d",((Character*) badBase).health]];
    //Scenario4 = true;
    int totalCoins = [[MGWU objectForKey:@"coins"] intValue];
    
    NSNumber* levelnumber = [NSNumber numberWithInt:currentLevelSelected];
    NSNumber* time = [NSNumber numberWithInt:(framecount/60)];
    NSNumber* coinsWon = [NSNumber numberWithInt:[GameData sharedData].coinsGained];
    NSNumber* coinsInTotal = [NSNumber numberWithInt:totalCoins];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: time, @"time", levelnumber, @"level_number", coinsWon, @"coinsWon", coinsInTotal, @"coinsInTotal", nil];
    [MGWU logEvent:@"beatLevel" withParams:params];
    
    waveChanging = true;
    
    CCMoveTo *bonusCoinsLabelIn = [CCMoveTo actionWithDuration:2 position:ccp(winSize.width * .5, winSize.height * .7)];
    
    CCMoveTo *bonusCoinsLabelStay = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width * .5, winSize.height * .7)];
    
    CCMoveTo *bonusCoinsLabelOut = [CCMoveTo actionWithDuration:2 position:ccp(-winSize.width * .5, winSize.height * .7)];
    
    [bonusCoinsLabel runAction:[CCSequence actions:bonusCoinsLabelIn, bonusCoinsLabelStay, bonusCoinsLabelOut, nil]];
    
    NSNumber* NSHighestLevelUnlocked = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestLevelUnlocked"];
    int highestLevelUnlocked = [NSHighestLevelUnlocked intValue];
    if(currentLevelSelected == highestLevelUnlocked && highestLevelUnlocked < 16)
    {
        highestLevelUnlocked++;
        NSNumber *newHighestLevelUnlocked = [NSNumber numberWithInt:highestLevelUnlocked];
        [[NSUserDefaults standardUserDefaults] setObject:newHighestLevelUnlocked forKey:@"highestLevelUnlocked"];
        NSLog(@"new highest leel unlocked = %@", newHighestLevelUnlocked);
    }
    
//    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[VictoryLayer alloc] init]];
    
}

-(void) subtractGoodBaseHealth:(CCSprite*)fightingDevil
{
    if(immunity == false && waveChanging == false)
    {
        
        (((Character*)goodBase).health) -= ((Character*)fightingDevil).power;
        int healthCount = (((Character*)goodBase).health);
        if(healthCount >= 0)
        {
            [goodBaseHealthLabel setString:[NSString stringWithFormat:@"%d",((Character*)goodBase).health]];
        }
        else
        {
            [goodBaseHealthLabel setString:[NSString stringWithFormat:@"0"]];
        }
        
        if(((Character*)goodBase).health < (friendlyBaseStartingHealth/2) && ((Character*)goodBase).health > (friendlyBaseStartingHealth/4) && goodBaseImageChangeCount == 0)
        {
            [goodGuysBottom removeObject:goodBase];
            [self removeChild: goodBase cleanup:YES];
            goodBaseImageChangeCount = 1;
            
            goodBase = [[Character alloc] initWithGoodGuyBaseImage2];
            goodBase.position = ccp(40, BASE_HEIGHT);
            goodBase.scale =.4;
            ((Character*)goodBase).health = healthCount;
            [self addChild:goodBase z:2];
            [goodGuysBottom addObject:goodBase];
            NSLog(@"good base 2");
        }
        if(((Character*)goodBase).health <= (friendlyBaseStartingHealth/4) && ((Character*)goodBase).health > 0 && goodBaseImageChangeCount == 1)
        {
            [goodGuysBottom removeObject:goodBase];
            [self removeChild:goodBase cleanup:YES];
            goodBaseImageChangeCount = 2;
            goodBase = [[Character alloc] initWithGoodGuyBaseImage3];
            goodBase.position = ccp(40, BASE_HEIGHT);
            goodBase.scale =.4;
            ((Character*)goodBase).health = healthCount;
            [self addChild:goodBase z:3];
            [goodGuysBottom addObject:goodBase];
            NSLog(@"good base 3");
        }
        if(((Character*)goodBase).health <= 0 && goodBaseExploded == false)
        {
            NSLog(@"called good base explosion, goodBaseExploded = true");
            [self explosion:goodBase :1.5 :YES];
            goodBaseExploded = true;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] playEffect:@"Xplode.wav"];
            }
        }
    }
}
-(void) subtractBadBaseHealth:(CCSprite*)fightingAngel
{
        (((Character*)badBase).health) -= ((Character*)fightingAngel).power;
    
    
        int healthCount = (((Character*)badBase).health);
        if(healthCount >= 0)
        {
            [badBaseHealthLabel setString:[NSString stringWithFormat:@"%d",((Character*)badBase).health]];
        }
        else
        {
            [badBaseHealthLabel setString:[NSString stringWithFormat:@"0"]];
            
        }
    
        if(((Character*)badBase).health < (enemyBaseStartingHealth/2) && ((Character*)badBase).health >= (enemyBaseStartingHealth/4) && badBaseImageChangeCount == 0)

        {
            [badGuysBottom removeObject:badBase];
            [self removeChild:badBase cleanup:YES];
            badBaseImageChangeCount = 1;
            badBase = [[Character alloc] initWithBadGuyBaseImage2];
            badBase.position = ccp(winSize.width - 35, BASE_HEIGHT);
            badBase.scale = .4;
            ((Character*)badBase).health = healthCount;
            [self addChild:badBase z:2];
            [badGuysBottom addObject:badBase];
            NSLog(@"bad base 2");
        }
        if(((Character*)badBase).health < 4 && ((Character*)badBase).health > 0 && badBaseImageChangeCount == 1)
        {
            [badGuysBottom removeObject:badBase];
            [self removeChild:badBase cleanup:YES];
            badBaseImageChangeCount = 2;
            badBase = [[Character alloc] initWithBadGuyBaseImage3];
            badBase.position = ccp(winSize.width - 35, BASE_HEIGHT);
            badBase.scale = .4;
            ((Character*)badBase).health = healthCount;
            [self addChild:badBase z:3];
            [badGuysBottom addObject:badBase];
            NSLog(@"bad base 3");
        }
        if(((Character*)badBase).health <= 0 && badBaseExploded == false)
        {
            NSLog(@"called bad base explosion, badBaseExploded = true");
            [self explosion:badBase :0.35 :YES];
            badBaseExploded = true;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sfx"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] playEffect:@"Xplode.wav"];
            }
//            int delayInSeconds = 1.5;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                   
//                
//                });
        }
}

/*
-(void)goodBaseCollisions
{
    NSMutableArray *deadBadBullets = [[NSMutableArray alloc] init];
//    if([badGuysBottom count] > 0)
//    {
//        for (int i = 0; i < [badGuysBottom count]; i++)
//        {
//            CCSprite *fightingDevil = [badGuysBottom objectAtIndex: i];
//            badMeleeBox = [fightingDevil boundingBox];
//            goodBaseBox = [goodBase boundingBox];
//            if(CGRectIntersectsRect(badMeleeBox, goodBaseBox))
//            {
//                ((Character*)fightingDevil).melee = true;
//                
//                if(framecount % ((Character*)fightingDevil).attackFrequency == 0)
//                {
//                    [self subtractGoodBaseHealth:fightingDevil];
//                }
//            }
//        }
//    }
   
    if([badBulletArray count] > 0)
    {
        for(int j = 0; j < [badBulletArray count]; j++)
        {
            goodBaseBox = [goodBase boundingBox];
            badBullet = [badBulletArray objectAtIndex:j];
            badBulletBox = [badBullet boundingBox];
            
            if(CGRectIntersectsRect(goodBaseBox,badBulletBox))
            {
                
                [self subtractGoodBaseHealth:badBullet];
                [deadBadBullets addObject:badBullet];
            }
        }

    }
    for (CCSprite *s in deadBadBullets)
    {
        [badBulletArray removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    [deadBadBullets removeAllObjects];
    
}

-(void)badBaseCollisions
{
    NSMutableArray *deadGoodBullets = [[NSMutableArray alloc] init];
    
//    if([goodGuysBottom count] > 0)
//    {
//        for (int i = 0; i < [goodGuysBottom count]; i++)
//        {
//            CCSprite *fightingAngel = [goodGuysBottom objectAtIndex:i];
//            goodMeleeBox = [fightingAngel boundingBox];
//            badBaseBox = [badBase boundingBox];
//            if(CGRectIntersectsRect(goodMeleeBox, badBaseBox))
//            {
//                ((Character*)goodBottom).melee = true;
//                
//                if(framecount % ((Character*)fightingAngel).attackFrequency == 0)
//                {
//                    [self subtractBadBaseHealth:fightingAngel];
//                }
//            }
//        }
//    }
    
    if([goodBulletArray count] > 0)
    {
        for(int j = 0; j < [goodBulletArray count]; j++)
        {
            badBaseBox = [badBase boundingBox];
            goodBullet = [goodBulletArray objectAtIndex:j];
            goodBulletBox = [goodBullet boundingBox];
            
            if(CGRectIntersectsRect(badBaseBox,goodBulletBox))
            {
                [self subtractBadBaseHealth:goodBullet];
                [deadGoodBullets addObject:goodBullet];
            }
        }
    }
    
    for (CCSprite *s in deadGoodBullets)
    {
        [goodBulletArray removeObject:s];
        [self removeChild:s cleanup:YES];
    }
    [deadGoodBullets removeAllObjects];
    
//    NSMutableArray *deadGoodBullets = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < [goodGuysBottom count]; i++)
//    {
//        if([goodGuysBottom count] > 0)
//        {
//            goodBottom = [goodGuysBottom objectAtIndex: i];
//            goodMeleeBox = [goodBottom boundingBox];
//            badBaseBox = [badBase boundingBox];
//            goodRangeBox = [goodBottom boundingBox];
//            goodRangeBox.size.width += 110;
//            
//
//            if(CGRectIntersectsRect(goodMeleeBox, badBaseBox))
//            {
//                ((Character*)goodBottom).melee = true;
//                if(((Character*)badBase).health >= 1)
//                {
//                    if(framecount % 50 == 0)
//                    {
//                        [self subtractBadBaseHealth:];
//                    }
//                }
//                if(((Character*)badBase).health == 0)
//                {
//                    [self addWave];
//                }
//            }
//    }
//    
//    
//    
//    for(int j = 0; j < [goodBulletArray count]; j++)
//    {
//            badBaseBox = [badBase boundingBox];
//
//            goodBullet = [goodBulletArray objectAtIndex:j];
//            goodBulletBox = [goodBullet boundingBox];
//            
//            if(CGRectIntersectsRect(badBaseBox,goodBulletBox))
//            {
//                if(((Character*)badBase).health >= 1)
//                {
//                    [self subtractBadBaseHealth];
//                    [deadGoodBullets addObject:goodBullet];
//                    [self subtractBadBarHealth];
//                }
//                if(((Character*)badBase).health == 0)
//                {
//                    [self addWave];
//                    [deadGoodBullets addObject:goodBullet];
//                }
//                
//            }
//
//        }
//    }
//    
//    for (CCSprite *s in deadGoodBullets)
//    {
//        [goodBulletArray removeObject:s];
//        [self removeChild:s cleanup:YES];
//    }
//    [deadGoodBullets removeAllObjects];
}
*/
 
 
-(void) waveChangeAnimation
{
    
    if(firstTime == false)
    {
        CCSprite *waveImage = [CCSprite spriteWithFile:@"wave.png"];
        waveImage.anchorPoint = CGPointZero;
        waveImage.position = CGPointMake(50.0f, 350.0f);
        waveImage.scale = 1;
        [self addChild:waveImage z:1];
        
        
        CCSprite *complete = [CCSprite spriteWithFile:@"complete.png"];
        complete.anchorPoint = CGPointZero;
        complete.position = CGPointMake(200.0f, 350.0f);
        complete.scale = 1;
        [self addChild:complete z:1];
        
        id waveDrop = [CCMoveTo actionWithDuration:1.0 position:ccp(waveImage.position.x, 165)];
        id completeDrop = [CCMoveTo actionWithDuration:1.0 position:ccp(complete.position.x, 165)];
        id waveLeave = [CCMoveTo actionWithDuration:2.0 position:ccp(500, 165)];
        id completeLeave = [CCMoveTo actionWithDuration:2.0 position:ccp(650, 165)];
        
        id waveDelay = [CCDelayTime actionWithDuration:2.0f];
        
        id completeDelay = [CCDelayTime actionWithDuration:1.0f];
        
        id completeDropDelay = [CCDelayTime actionWithDuration:1.0f];
        
        
        [waveImage runAction:[CCSequence actions:waveDrop, waveDelay, waveLeave, nil]];
        
        [complete runAction:[CCSequence actions:completeDropDelay, completeDrop, completeDelay, completeLeave, nil]];
        
        if(waveImage.position.x > 480)
        {
            [self removeChild:waveImage cleanup:YES];
        }
        
        if(complete.position.x > 480)
        {
            [self removeChild:complete cleanup:YES];
        }
    }

}

//-(void) addBaseBars
//{
//    
//    CCSprite *goodGreen = [CCSprite spriteWithFile:@"whiteBar.png"];
//    goodGreen.color = ccc3(0, 255, 0);
//    goodGreen.anchorPoint = CGPointZero;
//    goodGreen.position = ccp(50, BASE_HEIGHT);
//    goodGreen.scale = .3;
//    [self addChild:goodGreen z:10];
//    
//    CCSprite *badGreen = [CCSprite spriteWithFile:@"whiteBar.png"];
//    badGreen.color = ccc3(0, 255, 0);
//    badGreen.anchorPoint = CGPointZero;
//    badGreen.position = ccp(winSize.height-50, BASE_HEIGHT);
//    badGreen.scale = .3;
//    [self addChild:badGreen z:10];
//}
//
//-(void) addBadRedBar
//{
//    badRed = [CCSprite spriteWithFile:@"whiteBar.png"];
//    badRed.color = ccc3(255, 0, 0);
//    badRed.anchorPoint = CGPointZero;
//    badRed.scale = .3;
//    badRed.position = ccp(480, 80);
//    [self addChild:badRed z:11];
//}
//
//-(void) subtractGoodBarHealth:(int)subtraction
//{
//    if(immunity == false)
//    {
//        CCSprite *goodRed = [CCSprite spriteWithFile:@"whiteBar.png"];
//        goodRed.color = ccc3(255, 0, 0);
//        goodRed.anchorPoint = CGPointZero;
//        goodRed.scale = .3;
//        
//        float healthcounter = (goodRed.contentSize.width * .3) / 10;
//        goodRed.position = ccp(-70,80);
//        goodRed.position = ccp(goodRed.position.x + (healthcounter*subtraction),goodRed.position.y);
//        
//        ((Character*)goodBase).health -= subtraction;
//        
//        if(((Character*)goodBase).health <= 0)
//        {
//            [self removeChild:goodRed cleanup:YES];
//        }
//    }
//}
//
//-(void) subtractBadBarHealth:(int)subtraction
//{
//    float healthcounter = (badRed.contentSize.width * .3) / 10;
//    
//    if(((Character*)badBase).health == 9)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter, 80)];
//        [badRed runAction:barMove];
//    }
//    
//    if(((Character*)badBase).health == 8)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 2, 80)];
//        [badRed runAction:barMove];
//    }
//    
//    if(((Character*)badBase).health == 7)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 3, 80)];
//        [badRed runAction:barMove];
//    }
//    
//    if(((Character*)badBase).health == 6)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 4, 80)];
//        [badRed runAction:barMove];
//
//
//    }
//    if(((Character*)badBase).health == 5)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 5, 80)];
//        [badRed runAction:barMove];
//
//
//    }
//    
//    if(((Character*)badBase).health == 4)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 6, 80)];
//        [badRed runAction:barMove];
//
//
//    }
//    
//    if(((Character*)badBase).health == 3)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 7, 80)];
//        [badRed runAction:barMove];
//    }
//
//    if(((Character*)badBase).health == 2)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 8, 80)];
//        [badRed runAction:barMove];
//    }
//    
//    if(((Character*)badBase).health == 1)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480 - healthcounter * 9, 80)];
//        [badRed runAction:barMove];
//    }
//    
//    if(((Character*)badBase).health == 0)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480, 80)];
//        [badRed runAction:barMove];
//
//    }
//    
//    if(((Character*)badBase).health == 10)
//    {
//        CCMoveTo * barMove = [CCMoveTo actionWithDuration:.1 position:ccp(480, 80)];
//        [badRed runAction:barMove];
//    }
//}

-(void) loadLevelSettings
{
    NSString *plistName = [NSString stringWithFormat:@"level%d", currentLevelSelected];
    NSLog(@"%@", plistName);
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableDictionary *enemyMeleeDict = [levelDictionary objectForKey:@"enemyMelee"];
    enemyMeleeFramecount = [[enemyMeleeDict objectForKey:@"spawnRate"] intValue];
    zigZagFrequency = [[enemyMeleeDict objectForKey:@"zigZagFrequency"] intValue];
    enemyMeleeAvailable = [[enemyMeleeDict objectForKey:@"available"] boolValue];
    enemyMeleeReinforcementFramecount = [[enemyMeleeDict objectForKey:@"reinforcementRate"] intValue];
    
    
    NSMutableDictionary *enemyRegularShooterDict = [levelDictionary objectForKey:@"enemyRegularShooter"];
    enemyRegularShooterFramecount = [[enemyRegularShooterDict objectForKey:@"spawnRate"] intValue];
    enemyRegularShooterAvailable = [[enemyRegularShooterDict objectForKey:@"available"] boolValue];
    
    NSMutableDictionary *enemyTankDict = [levelDictionary objectForKey:@"enemyTank"];
    enemyTankFramecount = [[enemyTankDict objectForKey:@"spawnRate"] intValue];
    enemyTankAvailable = [[enemyTankDict objectForKey:@"available"] boolValue];
    
    NSMutableDictionary *KmonsterDict = [levelDictionary objectForKey:@"Kmonster"];
    KmonsterFramecount = 30 - [[KmonsterDict objectForKey:@"spawnRate"] intValue];
    
    NSMutableDictionary *enemyHeliBombDict = [levelDictionary objectForKey:@"enemyBomb"];
    enemyBombFramecount = 30 + [[enemyHeliBombDict objectForKey:@"spawnRate"] intValue];
    
    scenarioDelay = [[levelDictionary objectForKey:@"scenarioDelay"] intValue];
    baseCount = [[levelDictionary objectForKey:@"baseFriendlyCount"] doubleValue];
    friendlyMeleeReinforcementFramecount = [[levelDictionary objectForKey:@"friendlyMeleeReinforcementRate"] intValue];
    
    coinMultiplier = [[levelDictionary objectForKey:@"coinMultiplier"] intValue];
    friendlyFallSpeed = 6;
    if([GameData sharedData].currentLevelSelected > 5)
    {
        friendlyFallSpeed = 6 - (([GameData sharedData].currentLevelSelected - 5) * .2);
    }
    if(friendlyFallSpeed < 4.6)
    {
        friendlyFallSpeed = 4.6;
    }
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
    NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path2];

    NSMutableDictionary* friendlyMeleeDict = [friendlies objectForKey:@"friendlyMelee"];
    [GameData sharedData].friendlyMeleeAvailable = true;
    friendlyMeleeFramecount = [[friendlyMeleeDict objectForKey:@"spawnRate"] intValue];
    if([GameData sharedData].friendlyRegularShooterAvailable == true && [GameData sharedData].friendlyFastShooterAvailable == false)
    {
        friendlyMeleeFramecount *= 2;
    }
    if([GameData sharedData].friendlyRegularShooterAvailable == true && [GameData sharedData].friendlyFastShooterAvailable == true)
    {
        friendlyMeleeFramecount *= 3;
    }
 
    NSMutableDictionary* friendlyRegularShooterDict = [friendlies objectForKey:@"friendlyRegularShooter"];
    [GameData sharedData].friendlyRegularShooterAvailable  = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterAvailable"] boolValue];
    friendlyRegularShooterFramecount = [[friendlyRegularShooterDict objectForKey:@"spawnRate"] intValue];
    if([GameData sharedData].friendlyFastShooterAvailable == true)
    {
        friendlyRegularShooterFramecount *= 1.5;
    }
    
    NSMutableDictionary* friendlyFastShooterDict = [friendlies objectForKey:@"friendlyFastShooter"];
    [GameData sharedData].friendlyFastShooterAvailable = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterAvailable"] boolValue];
    friendlyFastShooterFramecount = [[friendlyFastShooterDict objectForKey:@"spawnRate"] intValue];
    NSLog(@"friendly fast shooter available = %d", [GameData sharedData].friendlyFastShooterAvailable);
    
    friendlyTankAvailable = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankAvailable"] boolValue];
    friendlyTankFramecount = 1300;

    
    NSMutableDictionary* coinDict = [levelDictionary objectForKey:@"coin"];
    endgameCoinFramecount = 20 + [[coinDict objectForKey:@"endgameFrequency"] intValue];
    gameplayCoinFramecount = 1500 + [[coinDict objectForKey:@"gameplayFrequency"] intValue];
    endgameCoinTotal = [[coinDict objectForKey:@"endgameCoinTotal"] intValue];
    
    scenariosAvailable = [[levelDictionary objectForKey:@"scenariosAvailable"] intValue];
    NSLog(@"original scenarios available = %d", scenariosAvailable);
    
    friendlyBaseStartingHealth = [[levelDictionary objectForKey:@"friendlyBaseHealth"] intValue];
    enemyBaseStartingHealth = [[levelDictionary objectForKey:@"enemyBaseHealth"] intValue];
}

-(void) addCoins:(int)numCoins
{
    int currentCoins = [[MGWU objectForKey:@"coins"] intValue];
    int newCoins = currentCoins + numCoins;
    NSNumber *newNSCoins = [NSNumber numberWithInt:newCoins];
    [MGWU setObject:newNSCoins forKey:@"coins"];
    NSLog(@"coins = %@", newNSCoins);
    
    [GameData sharedData].coinsGained += numCoins;
    
    [self removeChild:coinslabel];
    coinslabel = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
    [coinslabel setString:[NSString stringWithFormat:@"coins:%d", [[MGWU objectForKey:@"coins"] intValue]]];
    coinslabel.position = ccp(winSize.width * .67,winSize.height * .95);
    coinslabel.color = ccBLACK;
    [self addChild:coinslabel z:4];
}

/*
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{

    {
        // controls how quickly velocity decelerates (lower = quicker to change direction)
        float deceleration = 0.2f;
        // determines how sensitive the accelerometer reacts (higher = more sensitive)
        float sensitivity = 15.0f;
        // how fast the velocity can be at most
        float maxVelocity = 15;
    	
        // adjust velocity based on current accelerometer acceleration
        float velocityX = player.velocity.x * deceleration + acceleration.y * sensitivity;
        
        // we must limit the maximum velocity of the player sprite, in both directions
        if (player.velocity.x > maxVelocity)
        {
            velocityX = maxVelocity;
        }
        else if (player.velocity.x < - maxVelocity)
        {
            velocityX = - maxVelocity;
        }
        
        player.velocity = ccp(velocityX, player.velocity.y);
    }


}
 */

@end


