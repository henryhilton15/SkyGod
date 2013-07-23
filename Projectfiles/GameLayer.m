//
//  GameLayer.m
//  Gorilla
//
//  Created by henry hilton on 7/3/13.
//
//

#import "GameLayer.h"
#import "PauseMenuLayer.h"
#import "GameOverLayer.h"
#import "SimpleAudioEngine.h"
#import "Character.h"

#define FLOOR_HEIGHT 20.0f
 
@implementation GameLayer

-(void) addKmonster
{
    CCSprite * Kmonster = [[Character alloc] initWithKamikazeImage];
    Kmonster.scale=.2;
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = 60;
    int maxY = 300;
    int rangeY = maxY - minY;
    int actualY = arc4random() % rangeY + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    Kmonster.position = ccp(winSize.width + Kmonster.contentSize.width/2, actualY);
    [self addChild:Kmonster];
    [Kmonsters addObject:Kmonster];
    
    // Determine speed of the monster
    int minDuration2 = 3.0;
    int maxDuration2 = 5.0;
    int rangeDuration2 = maxDuration2 - minDuration2;
    int actualDuration2 = (arc4random() % rangeDuration2) + minDuration2;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration2
                                                position:ccp(-Kmonster.contentSize.width/2, actualY)];
   // CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        //[node removeFromParentAndCleanup:YES];
    //}];
    
        [Kmonster runAction:[CCSequence actions:actionMove, nil]];
 

}

-(void) addGoodGuy
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 8;
    int maxX = winSize.width - 8;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
    minDuration = 3.5;
    maxDuration = 6.0;

    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above

    enemy = [[Character alloc] initWithGoodGuyImage];
    enemy.scale=.5;

    enemy.position = ccp(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [goodGuys addObject:enemy];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -enemy.contentSize.height/2)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];

    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];    
}

-(void) addBadGuy
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 10;
    int maxX = winSize.width - 10;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
    minDuration = 3.5;
    maxDuration = 6.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    enemy= [[Character alloc] initWithBadGuyImage];
    enemy.scale=.15;
    enemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [badGuys addObject:enemy];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -enemy.contentSize.height/2)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
    
}
-(void) addHelicopter
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = 250;
    int maxY = 290;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Determine speed of the monster
    minDuration = 6.0;
    maxDuration = 8.0;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    //if(level < 3)
    //{
        enemy = [[Character alloc] initWithGoodHelicopterImage];
    //}
    //if(level > 3)
    //{
      //  enemy = [[Character alloc] initWithBadHelicopterImage];
    //}
    enemy.scale=.5;
    
    enemy.position = ccp(-enemy.contentSize.width, actualY); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [helicopters addObject:enemy];
    [badGuys addObject: enemy];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(winSize.width + enemy.contentSize.width/2, actualY)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
    
}


- (void) addZigZagBadGuy
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 80;
    int maxX = winSize.width - 40;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX + minX;


//    minDuration = 3.5;
//    maxDuration = 6.0;
//    
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    

    
    zenemy = [[Character alloc] initWithZigZagImage];
    zenemy.scale=.15;
    zenemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
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

-(void) addBigGoodGuy
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 200;
    int maxX = 280;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX + minX;
    
    minDuration = 8.0;
    maxDuration = 10.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    enemy = [[Character alloc] initWithBigGoodGuyImage];
    enemy.scale=.5;
    enemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [goodGuys addObject:enemy];
    [bigGoodGuys addObject:enemy];
    
    CCMoveTo *actionMove = [CCMoveTo actionWithDuration:actualDuration
                                               position:ccp(actualX, -enemy.contentSize.height/2)];
    [enemy runAction:actionMove];
}

-(void) addBigMonster
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 100;
    int maxX = 380;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX + minX;
    
    // Determine speed of the monster
    minDuration = 6.0;
    maxDuration = 18.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    enemy= [[Character alloc] initWithBigMonsterImage];
    enemy.scale=.5;
    enemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [badGuys addObject:enemy];
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(actualX, -enemy.contentSize.height/2)];
    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
    //            [node removeFromParentAndCleanup:YES];
    //        }];
    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
}


-(id) init
{
	if ((self = [super init]))
	{
        //bear animations
        //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"bearFrames.plist"];
        
        //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"bearFrames.png"];
        
        [self addChild:spriteSheet];
        
        //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
        
        //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
        
        tauntingFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 7; ++i)
        {
            [tauntingFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"bear%d.png", i]]];
            
        }
        
        //knight animations
        //Load the plist which tells Kobold2D how to properly parse your spritesheet. If on a retina device Kobold2D will automatically use bearframes-hd.plist
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"knightframesflipped.plist"];
        
        //Load in the spritesheet, if retina Kobold2D will automatically use bearframes-hd.png
        
        spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"knightFramesFlipped.png"];
        
        [self addChild:spriteSheet];
        
        //Define the frames based on the plist - note that for this to work, the original files must be in the format bear1, bear2, bear3 etc...
        
        //When it comes time to get art for your own original game, makegameswith.us will give you spritesheets that follow this convention, <spritename>1 <spritename>2 <spritename>3 etc...
        
        knightAttackFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 5; ++i)
        {
            [knightAttackFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"animation_knight-%dFlipped.png", i]]];
            
        }
        
        [self setIsTouchEnabled:YES];
        
        bananasToDelete = [[NSMutableArray alloc] init];
        enemiesToDelete= [[NSMutableArray alloc] init];
        helicopters = [[NSMutableArray alloc] init];
        bananaArray = [[NSMutableArray alloc] init];
        goodGuys = [[NSMutableArray alloc] init];
        badGuys = [[NSMutableArray alloc] init];
        Kmonsters = [[NSMutableArray alloc] init];
        goodGuysBottom = [[NSMutableArray alloc] init];
        badGuysBottom = [[NSMutableArray alloc] init];
        framecount = 0;
        goodGuyFramecount = 150;
        badGuyFramecount = 150;
        helicopterBombFramecount = 75;
        monstercount = 0;
        numberOfEnemies = 10;
        KmonsterFramecount=75;
        helicopterFramecount = 200;
        zigZagFramecount = 300;
        level = 3;
        deaths = 0;
        enemiesKilled = 0;
        bar = 240;
        helicoptersRemoved = 0;
        Scenario1 = false;
        Scenario2 = false;
        Scenario3 = false;
        Scenario4 = false;
        isWalking = true;
        
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
   
        
        //Background and placeholders -Henry
        
            enemiesKilledLabel = [CCLabelTTF labelWithString:@"Enemies Killed:0" fontName:@"Marker Felt" fontSize:18];
        enemiesKilledLabel.position = ccp(360, 300);
        enemiesKilledLabel.color = ccBLUE;
        [self addChild:enemiesKilledLabel z:4];

        
        LevelLabel = [CCLabelTTF labelWithString:@"Level:0" fontName:@"Marker Felt" fontSize:18];
        LevelLabel.position = ccp(360, 280);
        LevelLabel.color = ccBLUE;
        [self addChild:LevelLabel z:4];

        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemWithNormalImage:@"button_pausebutton.png"
                                                              selectedImage: @"button_pausebutton.png"
                                                                     target:self
                                                                   selector:@selector(pauseMenu:)];
        pauseButton.position = CGPointMake(225, 145);
        pauseButton.scale = 0.15f;
    
        CCMenuItemImage *PowerUpButton1 = [CCMenuItemImage itemWithNormalImage:@"button-top.png" selectedImage:@"button-top.png"];
        PowerUpButton1.position= CGPointMake (25, 300);
        PowerUpButton1.scale = 0.25f;
        [self addChild:PowerUpButton1 z:50];
        PowerUpButton1.color = ccBLUE;
        
        CCMenuItemImage *PowerUpButton2 = [CCMenuItemImage itemWithNormalImage:@"button-top.png" selectedImage:@"button-top.png"];
        PowerUpButton2.position= CGPointMake (65, 300);
        PowerUpButton2.scale = 0.25f;
        [self addChild:PowerUpButton2 z:50];
        PowerUpButton2.color = ccGREEN;
        
        CCMenuItemImage *PowerUpButton3 = [CCMenuItemImage itemWithNormalImage:@"button-top.png" selectedImage:@"button-top.png"];
        PowerUpButton3.position= CGPointMake (105, 300);
        PowerUpButton3.scale = 0.25f;
        [self addChild:PowerUpButton3 z:50];
        PowerUpButton3.color = ccRED;
        
     
        //  [self addChild:pauseButton z:100];
        
        CCMenu *myMenu = [CCMenu menuWithItems:pauseButton, nil];
        [self addChild: myMenu z:100];
        
        [self changeLevel];
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"explo2.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Pow.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"thatWasEasy.wav"];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    goodTeamCounter.position = CGPointMake(bar - 40, goodTeamCounter.contentSize.height/2 - 35);
    badTeamCounter.position = CGPointMake(bar, badTeamCounter.contentSize.height/2 - 115);

    if(bar >= 480)
    {
        if(level >=3)
        {
            [self addLevel];
            NSLog(@"Starting level %d", level);
            bar = 240;
            [self changeLevel];
        }
        else
        {
            [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
        }
        //[[SimpleAudioEngine sharedEngine] playEffect:@"thatWasEasy.wav"];
    }
    if(bar<=0)
    {
        if(level<=3)
        {
            [self subtractLevel];
            NSLog(@"Starting level %d", level);
            bar = 240;
            [self changeLevel];
        }
        else
        {
            [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
        }
    }

    //if (level != 3)
    //{
        [self ScenarioGenerator];
        [self CreateScenario];
    //{

    framecount++;
    if (Scenario1 != true && Scenario2 != true && Scenario3 != true && Scenario4 != true)
    {
        //[self addBigGoodGuy];
        //[self addBigMonster];

        
        if(framecount % goodGuyFramecount == 0)
        {
            [self addGoodGuy];
        }
    }
    if(Scenario1 != true && Scenario2 != true && Scenario3 != true && Scenario4 != true)
    {
        if((framecount - (int)(.5 * goodGuyFramecount)) % badGuyFramecount == 0)
        {
          //  [self addBadGuy];
                if(random() % 2 == 0)
                {
                    [self addBadGuy];
                }
                else
                {
                    [self addZigZagBadGuy];
                }
        }
    }

    
    if([helicopters count] > 0)
    {
        for(int i = 0; i < [helicopters count]; i++)
        {
            helicopter = [helicopters objectAtIndex:i];
            if(framecount%helicopterBombFramecount == 0 && helicopter.position.x > 10 && helicopter.position.x < 470)
            {
                CGPoint helicopterPosition = ccp(helicopter.position.x, helicopter.position.y);
                // Determine speed of the monster
                int minDuration = 4.0;
                int maxDuration = 6.0;
                int rangeDuration = maxDuration - minDuration;
                int actualDuration = (arc4random() % rangeDuration) + minDuration;
                
                // Create the monster slightly off-screen along the right edge,
                // and along a random position along the Y axis as calculated above
                if(level > 3)
                {
                    bomb = [[Character alloc] initWithBadHelicopterBombImage];
                    bomb.scale=.15;
                    bomb.position = helicopterPosition; //+ enemy.contentSize.height/2);
                    [self addChild:bomb z:2];
                    [badGuys addObject:bomb];
                }
                if(level < 3)
                {
                    bomb = [[Character alloc] initWithGoodHelicopterBombImage];
                    bomb.scale=.15;
                    bomb.position = helicopterPosition; //+ enemy.contentSize.height/2);
                    [self addChild:bomb z:2];
                    [badGuys addObject:bomb];
                }
                // Create the actions
                CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                            position:ccp(helicopterPosition.x, -bomb.contentSize.height/2)];
                    //        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                //            [node removeFromParentAndCleanup:YES];
                //        }];
                [bomb runAction:actionMove];
            }
            if(helicopter.position.x == 480 + helicopter.contentSize.width/2)
            {
                [helicopters removeObject:helicopter];
                [badGuys removeObject:helicopter];
                [self removeChild:helicopter cleanup:YES];
                [self removeChild:helicopter cleanup:YES];
                NSLog(@"removed helicopter");
                helicoptersRemoved++;
                if(helicoptersRemoved%2 == 0)
                {
                    Scenario1 = false;
                }
            }
        }
    }
    if([bigGoodGuys count] > 0)
    {
        if(framecount % KmonsterFramecount)
        {
            [self addKmonster];
            if([Kmonsters count] > 10)
            {
                Scenario2 = false;
            }
        }
    }
    if([goodGuys count] > 0 || [badGuys count] > 0)
    {
        [self detectReachBottom];
    }
    if([bananaArray count] > 0 && [goodGuys count] > 0)
    {
        [self detectBananaGoodGuyCollisions];
    }
    if([bananaArray count] > 0 && [badGuys count] > 0)
    {
        [self detectBananaBadGuyCollisions];
    }
    if ([goodGuys count] > 0 && [Kmonsters count] > 0)
    {
        [self detectKmonsterCollisions];
    }
    if ([badGuys count] > 0 && [Kmonsters count] > 0)
    {
        [self detectKmonsterCollisions];
    }
    if ([goodGuysBottom count] > 0)
    {
        
        [self goodGuysWalk];
    }
    if ([badGuysBottom count] > 0)
    {
        [self badGuysWalk];
    }
    if([goodGuysBottom count] > 0 && [badGuysBottom count] > 0)
    {
        [self fight];
    }
}

-(void) draw
{
    ccColor4F red = ccc4f(255, 0, 0, 1);
    ccDrawSolidRect(CGPointMake(0,0), CGPointMake(480,40), red);
    ccColor4F green = ccc4f(0, 255, 0, 1);
    ccDrawSolidRect(CGPointMake(0,0), CGPointMake(bar, 40), green);
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Set up initial location of projectile
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"bananaFrames.plist"];
    
    CCSpriteBatchNode *projectileSheet = [CCSpriteBatchNode batchNodeWithFile:@"bananaFrames.png"];
    
    [self addChild:projectileSheet];
    
    bananaFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i)
    {
        [bananaFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"banana%d.png", i]]];
        
        projectile = [CCSprite spriteWithSpriteFrameName:@"banana1.png"];
        
        projectile.anchorPoint = CGPointZero;
        projectile.position = CGPointMake(player.position.x, player.position.y);
        projectile.scale=.05;
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
    
    
    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, projectile.position);
    
    // Bail out if you are shooting down
    if (offset.y <= FLOOR_HEIGHT)
    {
        CCMoveTo *movePlayer = [CCMoveTo actionWithDuration:.5 position:ccp(location.x, FLOOR_HEIGHT)];
        [player runAction:movePlayer];
        return;
    }
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    float offX = location.x - projectile.position.x;
    float offY = location.y - projectile.position.y;
    
    float ydiff = winSize.height - projectile.position.y;
    float xdiff = (ydiff/offY) * offX;
    float xpos = projectile.position.x + xdiff;
    float ypos = projectile.position.y + ydiff;
    
    float length = sqrtf((xdiff*xdiff)+(ydiff*ydiff));
    float velocity = 350/1;
    float realMoveDuration = length/velocity;
    
    
    CGPoint newlocation = CGPointMake(xpos, ypos);
    
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:newlocation],
      [CCCallBlockN actionWithBlock:^(CCNode *node)
       {
           [node removeFromParentAndCleanup:YES];
       }],
      nil]];
}

-(void) detectBananaGoodGuyCollisions
{
    for(int j = 0; j < [goodGuys count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if([bananaArray count] > 0 && [goodGuys count] > 0)
                {
                    goodGuy = [goodGuys objectAtIndex:j];
                    CGRect badGuyRect = [goodGuy boundingBox];
                    projectile = [bananaArray objectAtIndex:i];
                    CGRect projectileBox = [projectile boundingBox];
                    
                    if(CGRectIntersectsRect(badGuyRect,projectileBox))
                    {
                        if (projectile.position.y < 305)
                        {
                            if([goodGuy isKindOfClass:[Character class]])
                            {
                                if(((Character*)goodGuy).health == 1)
                                {
                                    [goodGuys removeObjectAtIndex:j];
                                    [bananaArray removeObjectAtIndex:i];
                                    [self removeChild:goodGuy cleanup:YES];
                                    [self removeChild:projectile cleanup:YES];
                                    [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                                    [self enemiesKilledTotal];
                                }
                                else
                                {
                                    ((Character*)goodGuy).health--;
                                    [bananaArray removeObjectAtIndex:i];
                                    [self removeChild:projectile cleanup:YES];
                                }
                            }
                            else
                            {
                                [goodGuys removeObjectAtIndex:j];
                                [bananaArray removeObjectAtIndex:i];
                                [self removeChild:goodGuy cleanup:YES];
                                [self removeChild:projectile cleanup:YES];
                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                                //[enemiesToDelete addObject:badGuy];
                                //[bananasToDelete addObject:projectile];
                            }
                            //[enemiesToDelete removeAllObjects];
                            //[bananasToDelete removeAllObjects];
                        }
                    }
                }
        }
    }
}

-(void) detectKmonsterCollisions
{
    if(level<=2)
    {
        for(int j=0; j < [badGuys count]; j++)
        {
            for (int i = 0; i < [Kmonsters count]; i++)
            {
                if ([Kmonsters count ] > 0 && [badGuys count] > 0)
                {
                        badGuy = [badGuys objectAtIndex:j];
                        CGRect badGuyRect = [badGuy boundingBox];
                        Kamikaze= [Kmonsters objectAtIndex:i];
                        CGRect KamikazeBox = [Kamikaze boundingBox];
                }
                if(CGRectIntersectsRect(badGuyRect,KamikazeBox))
                {
                        [badGuys removeObjectAtIndex:j];
                        [Kmonsters removeObjectAtIndex:i];
                        [self removeChild:badGuy cleanup:YES];
                        [self removeChild:Kamikaze cleanup:YES];
                }
            }
        }
    }
    if(level>=4)
    {
        for(int j = 0; j < [badGuys count]; j++)
        {
            for (int i = 0; i < [Kmonsters count]; i++)
            {
                if ([Kmonsters count ] > 0 && [badGuys count] > 0)
                {
                    badGuy = [badGuys objectAtIndex:j];
                    CGRect badGuyRect = [badGuy boundingBox];
                    Kamikaze= [Kmonsters objectAtIndex:i];
                    CGRect KamikazeBox = [Kamikaze boundingBox];
                }
                if(CGRectIntersectsRect(badGuyRect,KamikazeBox))
                {
                    [badGuys removeObjectAtIndex:j];
                    [Kmonsters removeObjectAtIndex:i];
                    [self removeChild:badGuy cleanup:YES];
                    [self removeChild:Kamikaze cleanup:YES];
                }
            }
        }
    }
    for(int i = 0; i < [Kmonsters count]; i++)
    {
        for(int j = 0; j < [bananaArray count]; j++)
        {
            badGuy = [Kmonsters objectAtIndex:i];
            CGRect badGuyRect = [badGuy boundingBox];
            projectile = [bananaArray objectAtIndex:j];
            CGRect projectileBox = [projectile boundingBox];
            
            if(CGRectIntersectsRect(badGuyRect,projectileBox))
            {
                if (projectile.position.y < 305)
                {
                    //if([goodGuy isKindOfClass:[Character class]])
                    //{
                        if(((Character*)goodGuy).health == 1)
                        {
                            [Kmonsters removeObjectAtIndex:i];
                            [bananaArray removeObjectAtIndex:j];
                            [self removeChild:badGuy cleanup:YES];
                            [self removeChild:projectile cleanup:YES];
                            [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                            [self enemiesKilledTotal];
                        }
                        else
                        {
                            ((Character*)badGuy).health--;
                            [bananaArray removeObjectAtIndex:j];
                            [self removeChild:projectile cleanup:YES];
                        }
                    /*
                    }
                    else
                    {
                        [goodGuys removeObjectAtIndex:j];
                        [bananaArray removeObjectAtIndex:i];
                        [self removeChild:goodGuy cleanup:YES];
                        [self removeChild:projectile cleanup:YES];
                        [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
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
    if(level>=4)
    {
        for(int j=0; j < [goodGuys count]; j++)
        {
            for (int i = 0; i < [Kmonsters count]; i++)
            {
                if ([Kmonsters count ] > 0 && [goodGuys count] > 0)
                    
                {
                    goodGuy = [goodGuys objectAtIndex:j];
                    CGRect goodGuyRect = [goodGuy boundingBox];
                    Kamikaze= [Kmonsters objectAtIndex:i];
                    CGRect KamikazeBox = [Kamikaze boundingBox];
                }
                if(CGRectIntersectsRect(goodGuyRect,KamikazeBox))
                {
                    if (Kamikaze.position.y < 315)
                    {
                        [goodGuys removeObjectAtIndex:j];
                        [Kmonsters removeObjectAtIndex:i];
                        [self removeChild:goodGuy cleanup:YES];
                        [self removeChild:Kamikaze cleanup:YES];
                    }
                }
            }
        }
    }
}

-(void) detectBananaBadGuyCollisions
{
    for(int j = 0; j < [badGuys count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if ([bananaArray count] > 0 && [badGuys count] > 0)
            {
                badGuy = [badGuys objectAtIndex:j];
                CGRect badGuyRect = [badGuy boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                
                if(CGRectIntersectsRect(badGuyRect,projectileBox))
                {
                    if (projectile.position.y < 305)
                    {
                        if([badGuy isKindOfClass:[Character class]])
                        {
                            if(((Character*)badGuy).health == 1)
                            {
                                [badGuys removeObjectAtIndex:j];
                                [bananaArray removeObjectAtIndex:i];
                                [self removeChild:badGuy cleanup:YES];
                                [self removeChild:projectile cleanup:YES];
                                [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                                [self enemiesKilledTotal];
                            }
                            else
                            {
                                ((Character*)badGuy).health--;
                                [bananaArray removeObjectAtIndex:i];
                                [self removeChild:projectile cleanup:YES];
                            }
                        }
                        else
                        {
                            [badGuys removeObjectAtIndex:j];
                            [bananaArray removeObjectAtIndex:i];
                            [self removeChild:badGuy cleanup:YES];
                            [self removeChild:projectile cleanup:YES];
                            [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                            [self enemiesKilledTotal];
                            //[self ScenarioGenerator];
                            //[enemiesToDelete addObject:badGuy];
                            //[bananasToDelete addObject:projectile];
                        }
                    }
                }
            }
        }
    }
}

-(void)detectReachBottom
{
    for(int i = 0; i < [goodGuys count]; i++)
    {
        if([goodGuys count] > 0)
        {
            goodGuy = [goodGuys objectAtIndex:i];
            if(goodGuy.position.y <= FLOOR_HEIGHT)
            {
                [goodGuys removeObject:goodGuy];
                [self removeChild:goodGuy cleanup:YES];
                [[SimpleAudioEngine sharedEngine] playEffect:@"Pow.caf"];
                [self spawnGoodGuyBottom];
            
                if(level>3)
                {
                    bar += ((Character*)goodGuy).worth;
                }
                else 
                {
                    bar += ((Character*)goodGuy).worth;
                }
            }
        }
    }
    
    for(int i = 0; i < [badGuys count]; i++)
    {
        if([badGuys count] > 0)
        {
            badGuy = [badGuys objectAtIndex:i];

            if(badGuy.position.y <= FLOOR_HEIGHT)
            {
                [badGuys removeObject:badGuy];

                [self removeChild:badGuy cleanup:YES];
                [[SimpleAudioEngine sharedEngine] playEffect:@"Pow.caf"];
                [self spawnBadGuyBottom];
                if(level<3)
                {
                    bar -= ((Character*)badGuy).worth;
                }
                bar -= ((Character*)badGuy).worth;
            }
        }
    }
}

-(void) zigZagScenario
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    zFriendly1= [CCSprite spriteWithFile:@"cat1-topdown.png"];
    zFriendly1.scale=.2;
    zFriendly1.position = CGPointMake(winSize.width/2, winSize.height);
    [self addChild:zFriendly1];
    [goodGuys addObject:zFriendly1];
    
    CCSprite *enemy1= [[Character alloc] initWithDoubleEnemyImage];
    enemy1.scale=.15;
    enemy1.position = CGPointMake(50, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy1];
    [badGuys addObject:enemy1];
    
    CCSprite *enemy2= [[Character alloc] initWithDoubleEnemyImage];
    enemy2.scale=.15;
    enemy2.position = CGPointMake(170, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy2];
    [badGuys addObject:enemy2];

    CCSprite *enemy3= [[Character alloc] initWithDoubleEnemyImage];
    enemy3.scale=.15;
    enemy3.position = CGPointMake(290, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy3];
    [badGuys addObject:enemy3];

    CCSprite *enemy4= [[Character alloc] initWithDoubleEnemyImage];
    enemy4.scale=.15;
    enemy4.position = CGPointMake(410, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy4];
    [badGuys addObject:enemy4];

    
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
    
    
    
    CCMoveTo *actionMove1 = [CCMoveTo actionWithDuration:10.0 position:ccp(enemy1.position.x, -enemy1.contentSize.height/2)];
    [enemy1 runAction:actionMove1];
    
    CCMoveTo *actionMove2 = [CCMoveTo actionWithDuration:10.0 position:ccp(enemy2.position.x, -enemy2.contentSize.height/2)];
    [enemy2 runAction:actionMove2];
    
    CCMoveTo *actionMove3 = [CCMoveTo actionWithDuration:10.0 position:ccp(enemy3.position.x, -enemy3.contentSize.height/2)];
    [enemy3 runAction:actionMove3];
    
    CCMoveTo *actionMove4 = [CCMoveTo actionWithDuration:10.0 position:ccp(enemy4.position.x, -enemy4.contentSize.height/2)];
    [enemy4 runAction:actionMove4];
    
        
        id leftTop = [CCMoveTo actionWithDuration:1.0
                                         position:ccp (50, 300)];
        
        
        id rightTop = [CCMoveTo actionWithDuration:1.0
                                          position:ccp(430, 240)];
        
        id leftMid = [CCMoveTo actionWithDuration:1.0
                                         position:ccp(50, 180)];
        
        id rightMid = [CCMoveTo actionWithDuration:1.0
                                          position:ccp(430, 120)];
        
        
        
        id leftLow = [CCMoveTo actionWithDuration:1.0
                                         position:ccp(50, 60)];
        
        
        id rightLow = [CCMoveTo actionWithDuration:1.0
                                          position:ccp(430, 0)];
    
        
        
            [zFriendly1 runAction:[CCSequence actions: leftTop, rightTop, leftMid, rightMid, leftLow, rightLow, nil]];

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

-(void) addLevel
{
    level++;
    [LevelLabel setString:[NSString stringWithFormat:@"Level:%d", level - 3]];
}

-(void) subtractLevel
{
    level--;
    [LevelLabel setString:[NSString stringWithFormat:@"Level:%d", level - 3]];
}


-(void) pauseMenu: (CCMenuItemImage *)pauseButton
{
    [[CCDirector sharedDirector] pushScene: (CCScene *)[[PauseMenuLayer alloc]  init]];
}

-(void) changeLevel
{
    if (level==0)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"background_desert-topdown.png"];

        player = [CCSprite spriteWithFile:@"monster4.png"];
    }
    
    if (level ==1)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"background_grass-top.png"];

        player = [CCSprite spriteWithFile:@"monster8.png"];
    }
    
    if (level ==2)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"background_grid.png"];
         
        player = [CCSprite spriteWithFile:@"monster9.png"];
   
    }
    if (level ==3)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        
        background = [CCSprite spriteWithFile:@"background_grass-topdown.png"];
        
        player = [CCSprite spriteWithFile:@"animation_knight-1.png"];
        
       
        
    }
    if (level ==4)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"city-back.png"];

        player = [CCSprite spriteWithFile:@"cat-main.png"];

    }
    if (level ==5)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"city-front.png"];
        player = [CCSprite spriteWithFile:@"cat3.png"];
    }
    if (level==6)
    {
        [self removeChild:background cleanup:YES];
        [self removeChild:player cleanup:YES];
        background = [CCSprite spriteWithFile:@"background_topofcastle.png"];
        player = [CCSprite spriteWithFile:@"cat1.png"];
    }

    background.scale = 1;
    background.anchorPoint = CGPointZero;
    [self addChild:background z:-1];
    
    player.anchorPoint = CGPointZero;
    player.position = CGPointMake(180.0f, 20.0f);
    player.scale = .3;

    [self addChild:player z:1];
}

-(void)ScenarioGenerator
{
    if (enemiesKilled >= 20)
    {
        //if (level >=4 || level <= 2)
        //{
        
       // scenarioNumber = arc4random() % 4;
       // scenarioNumber = 1;
        
//        if(random() % 2 == 0)
//        {
//            scenarioNumber = 1;
//        }
//        if(random() % 2 == 1)
//        {
//            scenarioNumber = 3;
//        }
        scenarioNumber = 3;
        
            if (scenarioNumber == 1)
            {
                Scenario1 = true;
                enemiesKilled = 0;
            }
            if (scenarioNumber == 2)
            {
                Scenario2 = true;
                enemiesKilled = 0;
            }
            if (scenarioNumber == 3)
            {
                Scenario3 = true;
                enemiesKilled = 0;
            }
            if (scenarioNumber == 4)
            {
                Scenario4 = true;
                enemiesKilled = 0;
            }
        //}
    }
}


-(void)CreateScenario
{
    if(Scenario1 == true)
    {
        if(framecount % helicopterFramecount == 0)
        {
            NSLog(@"adding helicopter");
            [self addHelicopter];
        }
    }
    if(Scenario2 == true)
    {
        if(framecount % (int)(helicopterFramecount * 2) == 0)
        {
            NSLog(@"spawning big good guy");
            [self addBigGoodGuy];
        }
    }
    if(Scenario3 == true)
    {
//        if(framecount % zigZagFramecount == 0)
//        {
//
//            for (int x = 0; x < 3; x++)
//            {
//        
                if(framecount % zigZagFramecount == 0)
                {
                    NSLog(@"zig zag scenario");
                    [self zigZagScenario];
                }
//            }
//        }
    }
    if(Scenario4 ==true)
    {
        
    }
}

-(void) spawnGoodGuyBottom
{
  //  CGSize winSize = [CCDirector sharedDirector].winSize;
    goodBottom = [[Character alloc] initWithGoodBottomImage];
     goodBottom.anchorPoint = CGPointZero;
    goodBottom.position = ccp(0,0);
    goodBottom.scale=.3;
    [self addChild:goodBottom z:1];
    [goodGuysBottom addObject:goodBottom];
}

-(void) spawnBadGuyBottom
{
   // CGSize winSize = [CCDirector sharedDirector].winSize;
    badBottom = [[Character alloc] initWithBadBottomImage];
    badBottom.anchorPoint = CGPointZero;
    badBottom.scale=.15;
    badBottom.position = ccp(460, 0);
    [self addChild:badBottom z:1];
    [badGuysBottom addObject:badBottom];
}

-(void) goodGuysWalk
{
    for(int q=0; q<[goodGuysBottom count]; q++)
    {
        goodBottom = (CCSprite *)[goodGuysBottom objectAtIndex:q];
        
        //CCMoveTo * gBmove = [CCMoveTo actionWithDuration:0.1
        //                    position:ccp(goodBottom.position.x + 1, goodBottom.position.y)];
        
        //[goodBottom runAction:gBmove];
        goodBottom.position = ccp(goodBottom.position.x + .5,goodBottom.position.y);

    }
}

-(void) badGuysWalk
{
    for(int q=0; q<[badGuysBottom count]; q++)
    {
        badBottom = (CCSprite *)[badGuysBottom objectAtIndex:q];
        //badBottom.position = ccp(badBottom.position.x - 0.1, badBottom.position.y);
        //CCMoveTo * bBmove = [CCMoveTo actionWithDuration:0.1
                                   //     position:ccp(badBottom.position.x - 1, badBottom.position.y)];
        badBottom.position = ccp(badBottom.position.x - .5,badBottom.position.y);
        //[badBottom runAction:bBmove];
        
        if (badBottom.position.x < 0)
        {
            [[CCDirector sharedDirector] replaceScene: (CCScene *)[[GameOverLayer alloc]  init]];

        }
    }
}



-(void) fight
{
//    CGRect goodBottomRect = [goodGuy boundingBox];
//    CGRect badBottomRect = [goodGuy boundingBox];
    for(int j = 0; j < [goodGuysBottom count]; j++)
    {
        for(int i = 0; i < [badGuysBottom count]; i++)
        {
            if([goodGuysBottom count] > 0 && [badGuysBottom count] > 0)
            {
                goodBottom = [goodGuysBottom objectAtIndex:j];
                CGRect goodBottomRect = [goodBottom boundingBox];
                badBottom = [badGuysBottom objectAtIndex:i];
                CGRect badBottomRect = [badBottom boundingBox];
                
                if(CGRectIntersectsRect(badBottomRect,goodBottomRect))
                {
                    
                            if(((Character*)goodBottom).health == 1)
                            {
                                [goodGuysBottom removeObjectAtIndex:j];
                                [self removeChild:goodBottom cleanup:YES];
                                
                            }
                    
                            if(((Character*)goodBottom).health == 1)
                            {
                                    [badGuysBottom removeObjectAtIndex:i];
                                    [self removeChild:badBottom cleanup:YES];
                            }
                            else
                            {
                                ((Character*)goodBottom).health--;
                                
                                
                                
                                // put in fight part and use for both good and bad
                            }
                        
   
                    }
                }
            }
        }
}






@end
