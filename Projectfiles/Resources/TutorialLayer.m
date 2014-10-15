//
//  TutorialLayer.m
//  SkyGod
//
//  Created by Danny Laporte on 10/5/14.
//
//

#import "TutorialLayer.h"
#import "GameLayer.h"

#define BASE_HEIGHT 50

@implementation TutorialLayer

-(id)init
{
    if ((self = [super init]))
    {
        winSize = [CCDirector sharedDirector].winSize;
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
        
        CCSprite* player = [CCSprite spriteWithFile:@"main-idle-1.png"];
        player.position = ccp(winSize.width * .5, winSize.height * .3);
        [self addChild:player z:1];
        [self mainCharacterIdleAnimation:player];
        
        CCSprite* goodBase = [[Character alloc] initWithGoodGuyBaseImage1];
        CCSprite* badBase = [[Character alloc] initWithBadGuyBaseImage1];
        goodBase.position = ccp(40, BASE_HEIGHT);
        badBase.position = ccp(winSize.width - 35, BASE_HEIGHT);
        goodBase.scale = .4;
        badBase.scale = .4;
        [self addChild:goodBase z:2];
        [self addChild:badBase z:2];
        
        int counterSpacing = (winSize.width *.085);
        
        NSNumber* NSNumAvailable1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"];
        int numAvailable1 = [NSNumAvailable1 intValue];
        
        CCLabelTTF* airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [airstrikeCount setString:[NSString stringWithFormat:@"%d", numAvailable1]];
        airstrikeCount.position = CGPointMake(winSize.width *.08 + winSize.width *.005, winSize.height - winSize.height/8);
        airstrikeCount.color = ccBLACK;
        [self addChild:airstrikeCount z:5000];
        
        NSNumber* NSNumAvailable2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"];
        int numAvailable2 = [NSNumAvailable2 intValue];
        
        CCLabelTTF* reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", numAvailable2]];
        reinforcemtsCount.position = CGPointMake(winSize.width *.08 + counterSpacing, winSize.height - winSize.height/8);
        reinforcemtsCount.color = ccBLACK;
        [self addChild:reinforcemtsCount z:5000];
        
        NSNumber* NSNumAvailable3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"];
        int numAvailable3 = [NSNumAvailable3 intValue];
        
        CCLabelTTF* immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [immunityCount setString:[NSString stringWithFormat:@"%d", numAvailable3]];
        immunityCount.position = CGPointMake(winSize.width *.08 + (counterSpacing * 2), winSize.height - winSize.height/8);
        immunityCount.color = ccBLACK;
        [self addChild:immunityCount z:5000];
        
        

        int buttonSpacing = winSize.width *.08;
        int farLeftX = winSize.width * .05;
        
        CCSprite *shopButton = [CCSprite spriteWithFile:@"shop-button-n.png"];
        shopButton.position = CGPointMake(winSize.width * .85, winSize.height * .93);
        shopButton.scale = .5;
        
        
        CCSprite *immunityPowerUp = [CCSprite spriteWithFile:@"immunity_btn.png"];
        immunityPowerUp.position= CGPointMake ((farLeftX + (2 * buttonSpacing)), winSize.height * .93);
        immunityPowerUp.scale = 0.7f;
        
        
        CCSprite *reinforcementPowerUp = [CCSprite spriteWithFile:@"reinforcement_btn.png"];
        reinforcementPowerUp.position= CGPointMake ((farLeftX + buttonSpacing), winSize.height * .93);
        reinforcementPowerUp.scale = .7f;
        
        
        CCSprite *airstrikePowerUp = [CCSprite spriteWithFile:@"airstrike_btn.png"];
        airstrikePowerUp.position= CGPointMake (farLeftX, winSize.height * .93);
        airstrikePowerUp.scale = 0.7f;
        
        [self addChild:shopButton];
        [self addChild:reinforcementPowerUp];
        [self addChild:immunityPowerUp];
        [self addChild:airstrikePowerUp];

        
        //level 1 labe
        introLabel1 = [CCLabelTTF labelWithString:@"tap to shoot DEVILS" fontName:@"Algerian" fontSize:30];
        introLabel2 = [CCLabelTTF labelWithString:@"don't shoot ANGELS" fontName:@"Algerian" fontSize:30];
        introLabel1.position = ccp(winSize.width/2, winSize.height * .7);
        introLabel2.position = ccp(winSize.width/2, winSize.height * .58);
        introLabel1.color = ccBLACK;
        introLabel2.color = ccBLACK;
        
        //level 2 labels
        level2Label = [CCLabelTTF labelWithString:@"Tap AIRSTRIKE, REINFORCEMENTS," fontName:@"Algerian" fontSize:25];
        level2Label.position = ccp(winSize.width/2, winSize.height * .7);
        level2Label.color = ccBLACK;
        
        level2XLabel = [CCLabelTTF labelWithString:@"or IMMUNITY buttons for a boost!" fontName:@"Algerian" fontSize:25];
        level2XLabel.position = ccp(winSize.width/2, winSize.height * .58);
        level2XLabel.color = ccBLACK;
        
        level3Label = [CCLabelTTF labelWithString:@"Get Stuck? Go to the SHOP!" fontName:@"Algerian" fontSize:30];

        level3Label.position = ccp(winSize.width/2, winSize.height * .7);
        level3Label.color = ccBLACK;
        
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 0)
        {
            [self addChild:introLabel1];
            [self addChild:introLabel2];
            
            int tutorialCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue];
            tutorialCount++;
            NSNumber *newTutorialCount = [NSNumber numberWithInt:tutorialCount];
            [[NSUserDefaults standardUserDefaults] setObject:newTutorialCount forKey:@"tutorialCount"];
            NSLog(@"new tutorial count = %@", newTutorialCount);
        }
        
        else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 1)
        {
           
            [self addChild:level2Label];
            [self addChild: level2XLabel];
            int tutorialCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue];
            tutorialCount++;
            NSNumber *newTutorialCount = [NSNumber numberWithInt:tutorialCount];
            [[NSUserDefaults standardUserDefaults] setObject:newTutorialCount forKey:@"tutorialCount"];
            NSLog(@"new tutorial count = %@", newTutorialCount);
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue] == 2)
        {
            [self addChild:level3Label];
            int tutorialCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialCount"] intValue];
            tutorialCount++;
            NSNumber *newTutorialCount = [NSNumber numberWithInt:tutorialCount];
            [[NSUserDefaults standardUserDefaults] setObject:newTutorialCount forKey:@"tutorialCount"];
            NSLog(@"new tutorial count = %@", newTutorialCount);
        }
        
        self.isTouchEnabled = YES;
    
    }
    return self;
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene: (CCScene*)[[GameLayer alloc] init]];
}

-(void) mainCharacterIdleAnimation:(CCSprite *)mainCharacter
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
    
    CCAnimation *idleAnimation = [CCAnimation animationWithFrames: idleFrames delay:0.2f];
    
    //Create an action with the animation that can then be assigned to a sprite
    
    CCAction *idle = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:idleAnimation restoreOriginalFrame:NO]];
    
    //tell the bear to run the taunting action
    [mainCharacter runAction:idle];
}

@end
