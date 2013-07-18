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
#import "doubleEnemy.h"

 #define FLOOR_HEIGHT 20.0f
 

 
 @implementation GameLayer

- (void) addKmonster
{
    
    CCSprite * Kmonster = [CCSprite spriteWithFile:@"dragon-top.png"];
    Kmonster.scale=.25;
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = Kmonster.contentSize.height / 2;
    int maxY = winSize.height - Kmonster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = arc4random() % rangeY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    Kmonster.position = ccp(winSize.width + Kmonster.contentSize.width/2, actualY);
    [self addChild:Kmonster];
    [Kmonsters addObject:Kmonster];
    
    // Determine speed of the monster
    int minDuration2 =3.0;
    int maxDuration2 = 5.0;
    int rangeDuration2 = maxDuration2 - minDuration2;
    int actualDuration2 = (arc4random() % rangeDuration2) + minDuration2;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration2
                                                position:ccp(-Kmonster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    [Kmonster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void) addGoodGuy
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 3;
    int maxX = winSize.width - 3;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
    minDuration = 3.5;

     maxDuration = 6.0;

    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above

    enemy = [CCSprite spriteWithFile:@"cat4.png"];
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
    int minX = 3;
    int maxX = winSize.width - 3;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
    minDuration = 3.5;
    maxDuration = 6.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    enemy= [[doubleEnemy alloc] initWithDoubleEnemyImage];
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
    int maxY = 310;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Determine speed of the monster
    minDuration = 6.0;
    maxDuration = 8.0;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    if(level < 3)
    {
        enemy = [CCSprite spriteWithFile:@"planet.png"];
    }
    if(level > 3)
    {
        enemy = [CCSprite spriteWithFile:@"barrell.png"];
    }
    enemy.scale=.5;
    
    enemy.position = ccp(-enemy.contentSize.width, actualY); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [helicopters addObject:enemy];
    
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
    int minX = 3;
    int maxX = winSize.width - 3;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;


//    minDuration = 3.5;
//    maxDuration = 6.0;
//    
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    

    
    zenemy= [CCSprite spriteWithFile:@"monster4.png"];
    zenemy.scale=.15;
    zenemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:zenemy];
    [badGuys addObject:zenemy];

    
    int x = zenemy.position.x;
    int y = zenemy.position.y;
    
    float timeInterval = 2.0f;

    
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
        framecount = 0;
        goodGuyFramecount = 150;
        badGuyFramecount = 150;
        helicopterBombFramecount = 75;
        monstercount = 0;
        numberOfEnemies = 10;
        KmonsterFramecount=250;
        helicopterFramecount = 200;
        level = 3;
        deaths = 0;
        enemiesKilled = 0;
        bar = 240;
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
        badTeamCounter.position = CGPointMake(bar + 40, badTeamCounter.contentSize.height/2 - 35);
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
        
        //  [self addChild:pauseButton z:100];
        
        CCMenu *myMenu = [CCMenu menuWithItems:pauseButton, nil];
        [self addChild: myMenu z:100];
        
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
    badTeamCounter.position = CGPointMake(bar + 5, badTeamCounter.contentSize.height/2 - 105);
    
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

    framecount++;
    if(framecount % goodGuyFramecount == 0)
    {
        [self addGoodGuy];
    }
    
    if((framecount - (int)(.5 * goodGuyFramecount)) % badGuyFramecount == 0)
    {
        if(random() % 2 == 0)
        {
            [self addBadGuy];
        }
        else
        {
            [self addZigZagBadGuy];
        }

    }
    if(framecount % helicopterFramecount && level !=3 && [helicopters count] == 0)
    {
        [self addHelicopter];
    }
    
    if([helicopters count] > 0)
    {
        for(int i = 0; i < [helicopters count]; i++)
        {
            if(framecount%helicopterBombFramecount == 0)
            {
                helicopter = [helicopters objectAtIndex:i];
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
                    bomb = [CCSprite spriteWithFile:@"basicbarrell.png"];
                    bomb.scale=.15;
                    bomb.position = helicopterPosition; //+ enemy.contentSize.height/2);
                    [self addChild:bomb];
                    [badGuys addObject:bomb];
                }
                if(level < 3)
                {
                    bomb = [CCSprite spriteWithFile:@"block.png"];
                    bomb.scale=.15;
                    bomb.position = helicopterPosition; //+ enemy.contentSize.height/2);
                    [self addChild:bomb];
                    [goodGuys addObject:bomb];
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
                [self removeChild:helicopter cleanup:YES];
                NSLog(@"removed helicopter");
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
    
    if(level<=2 || level>=4)
    {
        if(framecount % KmonsterFramecount == 0)
        {
    
      [self addKmonster];
        }
    }
    if ([goodGuys count] > 0 && [Kmonsters count] > 0)
     {
        [self detectKmonsterWrongGuyCollisions];

     }
    if ([badGuys count] > 0 && [Kmonsters count] > 0)
    {
        [self detectKmonsterWrongGuyCollisions];
        
    }
    
    }



-(void) draw
{
    ccColor4F red = ccc4f(255, 0, 0, 1);
    ccDrawSolidRect(CGPointMake(0,0), CGPointMake(480,40), red);
    ccColor4F green = ccc4f(0, 255, 0, 1);
    ccDrawSolidRect(CGPointMake(0,0), CGPointMake(bar, 40), green);
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
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
        projectile.position = CGPointMake(220.0f, FLOOR_HEIGHT);
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
    
    // Bail out if you are shooting down or backwards
    if (offset.y <= 0) return;
    
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
                CGRect goodGuyRect = [goodGuy boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                if(CGRectIntersectsRect(goodGuyRect,projectileBox))
                {
                    if (projectile.position.y<305)
                    {
                    [goodGuys removeObjectAtIndex:j];
                    [bananaArray removeObjectAtIndex:i];
                    [self removeChild:goodGuy cleanup:YES];
                    [self removeChild:projectile cleanup:YES];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                    
                    //[enemiesToDelete addObject:badGuy];
                    //[bananasToDelete addObject:projectile];
                        
                        
                        
                    }
                    
                }
                
                }
            }
            
        }
        
    }
    //[enemiesToDelete removeAllObjects];
    //[bananasToDelete removeAllObjects];

-(void) detectKmonsterWrongGuyCollisions
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
                    if (Kamikaze.position.y < 315)
                    {
                        [badGuys removeObjectAtIndex:j];
                        [Kmonsters removeObjectAtIndex:i];
                        [self removeChild:badGuy cleanup:YES];
                        [self removeChild:Kamikaze cleanup:YES];

                    }
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
                        [badGuys removeObjectAtIndex:j];
                        [bananaArray removeObjectAtIndex:i];
                        [self removeChild:badGuy cleanup:YES];
                        [self removeChild:projectile cleanup:YES];
                        [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav"];
                        [self enemiesKilledTotal];
                            //[enemiesToDelete addObject:badGuy];
                            //[bananasToDelete addObject:projectile];
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
                if(level>3)
                {
                    bar+=100 + ((3 - level) * 5) ;
                }
                else
                {
                    bar += 50;
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
                if(level<3)
                {
                    bar -= 100 + ((level - 3) * 5);
                }
                bar -=50;
            }
        }
    }
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
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"background_desert-topdown.png"];

        player = [CCSprite spriteWithFile:@"monster4.png"];
       
    }
    
    if (level ==1)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"background_grass-top.png"];

        player = [CCSprite spriteWithFile:@"monster8.png"];
    }
    
    if (level ==2)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"background_grid.png"];
         
        player = [CCSprite spriteWithFile:@"monster9.png"];
   
    }
    if (level ==3)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"background_grass-topdown.png"];

        player = [CCSprite spriteWithFile:@"animation_knight-1.png"];
   
        
    }
    if (level ==4)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"city-back.png"];

        player = [CCSprite spriteWithFile:@"cat-main.png"];

    }
    if (level ==5)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"city-front.png"];
        player = [CCSprite spriteWithFile:@"cat3.png"];
        
    }
    if (level==6)
    {
        [self removeChild:background];
        [self removeChild:player];
        background = [CCSprite spriteWithFile:@"background_topofcastle.png"];
       
        player = [CCSprite spriteWithFile:@"cat1.png"];
     
    }

    background.scale = 1;
    background.anchorPoint = CGPointZero;
    [self addChild:background z:-1];
    
    player.anchorPoint = CGPointZero;
    
    player.position = CGPointMake(180.0f, 20.0f);
    player.scale = .3;

    [self addChild:player z:0];
}


@end
