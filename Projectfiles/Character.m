//
//  BigMonster.m
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "Character.h"

@implementation Character


@synthesize health;
@synthesize worth;
@synthesize direction;
@synthesize type;
@synthesize immunity;
@synthesize row;
@synthesize melee;
@synthesize left;
@synthesize right;

-(id) initWithBigMonsterImage
{
    if((self = [super initWithFile:@"monster9.png"]))
    {
        health = 5;
        worth = 100;
        type = BIG_MONSTER;
        immunity = 0;
        row = 0;
        melee = false;
        
    }
    return self;
}

-(id) initWithBigGoodGuyImage
{
    if((self = [super initWithFile:@"chest.png"]))
    {
        health = 2;
        worth = 100;
        type = BIG_GOOD_GUY;
        immunity = 0;
        row = 0;
        melee = false;
        left = false;
        right = false;
    }
    return self;
}
-(id) initWithGoodGuyImage
{
    if((self = [super initWithFile:@"cat4.png"]))
    {
        worth = 50;
        health = 2;
        type = GOOD_GUY;
        immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}

-(id) initWithBadGuyImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        worth = 50;
        health = 2;
        type = BAD_GUY;
        //immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}
-(id) initWithZigZagImage
{
    if((self = [super initWithFile:@"monster4.png"]))
    {
        worth = 50;
        health = 1;
        type = ZIG_ZAG;
        immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}
-(id) initWithGoodHelicopterImage
{
    if((self = [super initWithFile:@"jet.png"]))
    {
        health = 5;
        type = GOOD_HELICOPTER;
    }
    return self;
}
-(id) initWithBadHelicopterImage
{
    if((self = [super initWithFile:@"barrell.png"]))
    {
        health = 5;
        type = BAD_HELICOPTER;
    }
    return self;
}
-(id) initWithGoodHelicopterBombImage
{
    if((self = [super initWithFile:@"basicbarrell.png"]))
    {
        worth = 50;
        health = 1;
        type = GOOD_HELICOPTER_BOMB;
    }
    return self;
}
-(id) initWithBadHelicopterBombImage
{
    if((self = [super initWithFile:@"block.png"]))
    {
        worth = 50;
        health = 1;
        type = BAD_HELICOPTER_BOMB;
    }
    return self;
}
-(id) initWithKamikazeImage
{
    if((self = [super initWithFile:@"dragon-top.png"]))
    {
        health = 1;
        type = KAMIKAZE;
    }
    return self;
}
-(id) initWithDoubleEnemyImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        worth = 50;
        health = 2;
        type = DOUBLE_ENEMY;
        //immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}
-(id) initWithSuperZigZagGuyImage
{
    if(self = [super initWithFile:@"cat1-topdown.png"])
    {
        worth = 1;
        health = 2;
        type = SUPER_ZIG_ZAG_GUY;
        immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}

-(id) initWithGoodBottomImage
{
    if((self = [super initWithFile:@"cat4.png"]))
    {
        health = 1;

//        if(random() % 2 == 0)
//        {
//            direction = 1;
//        }
//        else
//        {
//            direction = 0;
//        }
        
        type = GOOD_BOTTOM;
        immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}

-(id) initWithBadBottomImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        health = 1;
        
//        if(random() % 2 == 0)
//        {
//            direction = 1;
//        }
//        else
//        {
//            direction = 0;
//        }
        
        type = BAD_BOTTOM;
        //immunity = 0;
        row = 0;
        melee = false;
    }
    return self;
}

-(id) initWithGoodGuyBaseImage
{
    if ((self = [super initWithFile: @"car-topdown.png"]))
    {
        health = 10;
        type = GOOD_BASE;
    }
    return self;
    
}

-(id) initWithBadGuyBaseImage
{
    if ((self = [super initWithFile: @"rocket.png"]))
    {
        health = 10;
        type = BAD_BASE;
    }
    return self;
}
-(id) initWithFastShooterBadGuyImage
{
    if((self = [super initWithFile:@"monster2.png"]))
    {
        health = 1;
        type = BAD_FASTSHOOTER;
    }
    return  self;
}
-(id) initWithFastShooterGoodGuyImage
{
    if((self = [super initWithFile:@"spaceman.png"]))
    {
        health = 1;
        type = GOOD_FASTSHOOTER;
    }
return self;
}
-(id) initWithKnifeGoodGuyImage
{
    if ((self = [super initWithFile: @"sidekick.png"]))
    {
        health = 3;
        type = GOOD_KNIFE;
    }
return self;
}
-(id) initWithKnifeBadGuyImage
{
    if ((self = [super initWithFile: @"stickman.png"]))
    {
        health = 3;
        type = BAD_KNIFE;
    }   
return self;
}
-(id) initWithGoodReinforcementImage
{
    if ((self = [super initWithFile:@"ufo.png"]))
        {
            health = 1;
            type = GOOD_REINFORCEMENT;
        }
        return  self;
}


@end
