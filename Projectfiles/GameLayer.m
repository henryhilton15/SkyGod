#import "GameLayer.h"
#import "PauseMenuLayer.h"
#import "GameOverLayer.h"
#import "SimpleAudioEngine.h"
#import "doubleEnemy.h"

#define FLOOR_HEIGHT 35.0f



@implementation GameLayer

-(void) addMonster
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 2;
    int maxX = winSize.width - 2;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
     minDuration = 3.0;
     maxDuration = 7.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
   
        // Create the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        CCSprite * enemy = [CCSprite spriteWithFile:@"monster2.png"];
        enemy.scale=.1;
    enemy.position = ccp(actualX, winSize.height); //+ enemy.contentSize.height/2);
        [self addChild:enemy];
        [enemies addObject:enemy];
        
        // Create the actions
        CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                    position:ccp(actualX, -enemy.contentSize.height/2)];
//        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
//            [node removeFromParentAndCleanup:YES];
//        }];
    [enemy runAction:actionMove];//[CCSequence actions:actionMove, actionMoveDone, nil]];
                                         
}

-(void) addDoubleMonster
{
    // Determine where to spawn the monster along the X axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = 2;
    int maxX = winSize.width - 2;
    int rangeX = maxX - minX;
    int actualX = arc4random() % rangeX;
    
    // Determine speed of the monster
    int minDuration = 3.0;
    int maxDuration = 7.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    doubleEnemy *enemy= [[doubleEnemy alloc] initWithDoubleEnemyImage];
    enemy.scale=.1;
    enemy.position = CGPointMake(actualX, winSize.height); //+ enemy.contentSize.height/2);
    [self addChild:enemy];
    [doubleEnemies addObject:enemy];
    
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
    princessesToDelete= [[NSMutableArray alloc] init];
    bananaArray = [[NSMutableArray alloc] init];
    enemies = [[NSMutableArray alloc] init];
    princesses = [[NSMutableArray alloc] init];
    doubleEnemies=[[NSMutableArray alloc] init];
    
    framecount = 0;
    singleMonsterFramecount = 150;
    doubleMonsterFramecount = 250;
    monstercount = 0;
    numberOfEnemies = 10;
    level = 1;
    deaths = 0;
    enemiesKilled=0;
    
        //Background and placeholders -Henry
    
        [self setIsTouchEnabled:YES];
    
        CCSprite *sprite = [CCSprite spriteWithFile:@"city-back.png"];
        sprite.anchorPoint = CGPointZero;
        [self addChild:sprite z:-1];
        
        sprite = [CCSprite spriteWithFile:@"gorilla.png"];
        sprite.anchorPoint = CGPointZero;
         sprite.scale=.2;
        sprite.position = CGPointMake(180.0f, FLOOR_HEIGHT + 21.5);
        [self addChild:sprite z:0];
        
        sprite = [CCSprite spriteWithFile:@"Princess.png"];
        sprite.anchorPoint = CGPointZero;
       sprite.scale=.2;
        sprite.position = CGPointMake(0.0f, FLOOR_HEIGHT);
        [self addChild:sprite z:0];
        [princesses addObject:sprite];
        
        sprite = [CCSprite spriteWithFile:@"Princess.png"];
        sprite.anchorPoint = CGPointZero;
        sprite.scale=.2;
        sprite.position = CGPointMake(80.0f, FLOOR_HEIGHT);
        [self addChild:sprite z:0];
        [princesses addObject:sprite];
        
        sprite = [CCSprite spriteWithFile:@"Princess.png"];
        sprite.anchorPoint = CGPointZero;
        sprite.scale=.2;
        sprite.position = CGPointMake(320.0f, FLOOR_HEIGHT);
        [self addChild:sprite z:0];
        [princesses addObject:sprite];
        
        sprite = [CCSprite spriteWithFile:@"Princess.png"];
        sprite.anchorPoint = CGPointZero;
         sprite.scale=.2;
        sprite.position = CGPointMake(400.0f, FLOOR_HEIGHT);
        [self addChild:sprite z:0];
        [princesses addObject:sprite];
        
        sprite = [CCSprite spriteWithFile:@"bananas.png"];
        sprite.anchorPoint = CGPointZero;
        sprite.scale=.2;
        sprite.position = CGPointMake(175.0f, FLOOR_HEIGHT);
        [self addChild:sprite z:0];
        
        CCMenuItemImage *pauseButton = [CCMenuItemImage itemWithNormalImage:@"button_pausebutton.png"
                                                              selectedImage: @"button_pausebutton.png"
                                                                     target:self
                                                                   selector:@selector(pauseMenu:)];
        pauseButton.position = CGPointMake(225, 145);
        pauseButton.scale = 0.15f;
        //  [self addChild:pauseButton z:100];
        
        CCMenu *myMenu = [CCMenu menuWithItems:pauseButton, nil];
        [self addChild: myMenu z:100];
        
        [self scheduleUpdate];
        enemiesKilledLabel = [CCLabelTTF labelWithString:@"Enemies Killed:0" fontName:@"Marker Felt" fontSize:18];
        enemiesKilledLabel.position = ccp(360, 300);
        [self addChild:enemiesKilledLabel z:4];
    
        LevelLabel = [CCLabelTTF labelWithString:@"Level:1" fontName:@"Marker Felt" fontSize:18];
        LevelLabel.position = ccp(360, 280);
        [self addChild:LevelLabel z:4];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    framecount++;
    {
        if(framecount % singleMonsterFramecount == 0)
        {
            [self addMonster];
            monstercount++;
            if(monstercount == numberOfEnemies)
            {
                [self currentLevel];
                singleMonsterFramecount -=10;
                monstercount = 0;
                numberOfEnemies += 5;
                minDuration -= .2;
                maxDuration -= .2;
                NSLog(@"Starting level %d", level);
            }
        }
        if(framecount % doubleMonsterFramecount == 0)
        {
            [self addDoubleMonster];
            monstercount++;
            if(monstercount == numberOfEnemies)
            {
                [self currentLevel];
                doubleMonsterFramecount -=10;
                monstercount = 0;
                numberOfEnemies += 5;
                minDuration -= .2;
                maxDuration -= .2;
                NSLog(@"Starting level %d", level);
            }
        }

    }

    if([enemies count] > 0)
    {
        
        [self detectEnemyPrincessCollisions];
    }
    if([bananaArray count] > 0 && [enemies count] > 0)
    {
        [self detectBananaEnemyCollisions];
        
    }
    if([bananaArray count] > 0 && [doubleEnemies count] > 0)
    {
        [self detectBananaDoubleEnemyCollisions];
    }

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
        
        CCAnimation *rotating = [CCAnimation animationWithFrames: bananaFrames delay:0.15f];
        
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

-(void) detectBananaEnemyCollisions
{
    for(int j = 0; j < [enemies count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if ([bananaArray count] > 0 && [enemies count] > 0)
            {
            badGuy = [enemies objectAtIndex:j];
            CGRect badGuyRect = [badGuy boundingBox];
            projectile = [bananaArray objectAtIndex:i];
            CGRect projectileBox = [projectile boundingBox];
           
            if(CGRectIntersectsRect(badGuyRect,projectileBox))
            {
                if (projectile.position.y<305)
                {
                [enemies removeObjectAtIndex:j];
                [bananaArray removeObjectAtIndex:i];
                [self removeChild:badGuy cleanup:YES];
                [self removeChild:projectile cleanup:YES];
                
                [self enemiesKilledTotal];
                //[enemiesToDelete addObject:badGuy];
                //[bananasToDelete addObject:projectile];
                }
            }
                
            }
                
        }
            
    }
    //[enemiesToDelete removeAllObjects];
    //[bananasToDelete removeAllObjects];
    
}

-(void) detectBananaDoubleEnemyCollisions
{
    for(int j = 0; j < [doubleEnemies count]; j++)
    {
        for(int i = 0; i < [bananaArray count]; i++)
        {
            if ([bananaArray count] > 0 && [doubleEnemies count] > 0)
            {
                badGuy = [doubleEnemies objectAtIndex:j];
                CGRect badGuyRect = [badGuy boundingBox];
                projectile = [bananaArray objectAtIndex:i];
                CGRect projectileBox = [projectile boundingBox];
                
                if(CGRectIntersectsRect(badGuyRect,projectileBox))
                {
                    if (projectile.position.y < 305)
                    {
                        if(((doubleEnemy*)badGuy).health == 1)
                        {
                            [doubleEnemies removeObjectAtIndex:j];
                            [bananaArray removeObjectAtIndex:i];
                            [self removeChild:badGuy cleanup:YES];
                            [self removeChild:projectile cleanup:YES];
                            [self enemiesKilledTotal];
                            //[enemiesToDelete addObject:badGuy];
                            //[bananasToDelete addObject:projectile];
                        }
                        else
                        {
                            ((doubleEnemy*)badGuy).health--;
                            [self removeChild:projectile cleanup:YES];
                            [bananaArray removeObjectAtIndex:i];
                        }
                    }
                }
                
            }
            
        }
        
    }

}

-(void)detectEnemyPrincessCollisions
{
    for(int i = 0; i < [enemies count]; i++)
    {
        if([enemies count] > 0)
        {
            badGuy = [enemies objectAtIndex:i];
            princess = [princesses objectAtIndex:0];
            if(badGuy.position.y <= FLOOR_HEIGHT + 10)
            {
                deaths++;
                [enemies removeObject:badGuy];
                [princesses removeObject:princess];
                [self removeChild:badGuy cleanup:YES];
                [self removeChild:princess cleanup:YES];
                if(deaths == 4)
                {
                    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
                }
            }
        }
     }
    
    for(int i = 0; i < [doubleEnemies count]; i++)
    {
        if([doubleEnemies count] > 0)
        {
            badGuy = [doubleEnemies objectAtIndex:i];
            princess = [princesses objectAtIndex:0];
            if(badGuy.position.y <= FLOOR_HEIGHT + 10)
            {
                deaths++;
                [doubleEnemies removeObject:badGuy];
                [princesses removeObject:princess];
                [self removeChild:badGuy cleanup:YES];
                [self removeChild:princess cleanup:YES];
                if(deaths == 4)
                {
                    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameOverLayer alloc] init]];
                }
            }
        }
    }
  }



-(void) pauseMenu: (CCMenuItemImage *)pauseButton
{
    [[CCDirector sharedDirector] pushScene: (CCScene *)[[PauseMenuLayer alloc]  init]];
}
-(void) enemiesKilledTotal
{
    enemiesKilled++;
    [enemiesKilledLabel setString:[NSString stringWithFormat:@"Enemies Killed:%d", enemiesKilled]];
}

-(void) currentLevel
{
    level++;
    [LevelLabel setString:[NSString stringWithFormat:@"Level:%d", level]];
}
@end
