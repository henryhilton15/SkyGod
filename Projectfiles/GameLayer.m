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

    CCSprite * enemy = [CCSprite spriteWithFile:@"cat4.png"];
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
    int minDuration = 3.5;
    int maxDuration = 6.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    doubleEnemy *enemy= [[doubleEnemy alloc] initWithDoubleEnemyImage];
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


-(id) init
{
	if ((self = [super init]))
	{
        [self setIsTouchEnabled:YES];
        
        bananasToDelete = [[NSMutableArray alloc] init];
        enemiesToDelete= [[NSMutableArray alloc] init];
       
        bananaArray = [[NSMutableArray alloc] init];
        goodGuys = [[NSMutableArray alloc] init];
      
        badGuys = [[NSMutableArray alloc] init];
        
        framecount = 0;
        goodGuyFramecount = 150;
        badGuyFramecount = 150;
        monstercount = 0;
        numberOfEnemies = 10;
        level = 3;
        deaths = 0;

        enemiesKilled = 0;
        bar = 240;
        
        //Background and placeholders -Henry
        
        [self setIsTouchEnabled:YES];
        if (level==0)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"background_desert-topdown.png"];
            sprite.scale = .5;
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
        

            sprite = [CCSprite spriteWithFile:@"monster4.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];
        }

        
        if (level ==1)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"background_grass-top.png"];
            sprite.scale = .5;
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
            
            sprite = [CCSprite spriteWithFile:@"monster8.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.position = CGPointMake(180.0f, 10.0f);
            sprite.scale=.5;
            [self addChild:sprite z:0];
        }
        if (level ==2)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"background_grid.png"];
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
            
            sprite = [CCSprite spriteWithFile:@"monster9.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.scale=.5;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];
        }
        if (level ==3)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"background_grass-topdown.png"];
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
            
            sprite = [CCSprite spriteWithFile:@"animation_knight-1.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.scale=.5;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];

        }
        if (level ==4)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"city-back.png"];
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
            
            sprite = [CCSprite spriteWithFile:@"cat-main.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.scale=.5;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];
        }
        if (level ==5)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"city-front.png"];
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
            
            sprite = [CCSprite spriteWithFile:@"cat3.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.scale=.5;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];
        }
        if (level==6)
        {
            CCSprite *sprite = [CCSprite spriteWithFile:@"background_topofcastle.png"];
            sprite.anchorPoint = CGPointZero;
            [self addChild:sprite z:-1];
        
            sprite = [CCSprite spriteWithFile:@"cat1.png"];
            sprite.anchorPoint = CGPointZero;
            sprite.scale=.5;
            sprite.position = CGPointMake(180.0f, 10.0f);
            [self addChild:sprite z:0];
        }
       
        
            enemiesKilledLabel = [CCLabelTTF labelWithString:@"Enemies Killed:0" fontName:@"Marker Felt" fontSize:18];
        enemiesKilledLabel.position = ccp(360, 300);
        enemiesKilledLabel.color = ccBLUE;
        [self addChild:enemiesKilledLabel z:4];
        
        LevelLabel = [CCLabelTTF labelWithString:@"Level:3" fontName:@"Marker Felt" fontSize:18];
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
    if(bar >= 480)
    {
        if(level >=3)
        {
            [self addLevel];
            NSLog(@"Starting level %d", level);
            bar =240;
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
        }
        else
        {
            [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
        }
    }

    framecount++;
    {
        if(framecount % goodGuyFramecount == 0)
        {
            [self addGoodGuy];
        }
    
        if((framecount - 50) % badGuyFramecount == 0)
        {
            [self addBadGuy];
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
                if(level<3)
                {
                    bar+=100 + ((3 - level) * 5) ;
                }
                bar += 50;
            }
        }
    }
    
    for(int i = 0; i < [badGuys count]; i++)
    {
        if([badGuys count] > 0)
        {
            badGuy = [badGuys objectAtIndex:i];

           
            if(badGuy.position.y <= FLOOR_HEIGHT)

            if(badGuy.position.y <= FLOOR_HEIGHT)

            {
                [badGuys removeObject:badGuy];
                [self removeChild:badGuy cleanup:YES];
                [[SimpleAudioEngine sharedEngine] playEffect:@"Pow.caf"];
                if(level>3)
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
    [LevelLabel setString:[NSString stringWithFormat:@"Level:%d", level]];
}
-(void) subtractLevel
{
    level--;
    [LevelLabel setString:[NSString stringWithFormat:@"Level:%d", level]];
}


-(void) pauseMenu: (CCMenuItemImage *)pauseButton
{
    [[CCDirector sharedDirector] pushScene: (CCScene *)[[PauseMenuLayer alloc]  init]];
}
@end
