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

-(id) initWithBigMonsterImage
{
    if((self = [super initWithFile:@"monster9.png"]))
    {
        health = 10;
        worth = 100;
        type = BIG_MONSTER;
    }
    return self;
}

-(id) initWithBigGoodGuyImage
{
    if((self = [super initWithFile:@"chest.png"]))
    {
        health = 1;
        worth = 100;
        type = BIG_GOOD_GUY;
    }
    return self;
}
-(id) initWithGoodGuyImage
{
    if((self = [super initWithFile:@"cat4.png"]))
    {
        worth = 50;
        health = 1;
        type = GOOD_GUY;
    }
    return self;
}

-(id) initWithBadGuyImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        worth = 50;
        health = 1;
        type = BAD_GUY;
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
    }
    return self;
}
-(id) initWithGoodHelicopterImage
{
    if((self = [super initWithFile:@"planet.png"]))
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
        health = 1;
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
        health = 1;
        type = DOUBLE_ENEMY;
    }
    return self;
}
-(id) initWithSuperZigZagGuyImage
{
    if(self = [super initWithFile:@"cat1-topdown.png"])
    {
        worth = 1;
        health = 1;
        type = SUPER_ZIG_ZAG_GUY;
    }
    return self;
}

-(id) initWithGoodBottomImage
{
    if((self = [super initWithFile:@"cat4.png"]))
    {
        health = 1;

        if(random() % 2 == 0)
        {
            direction = 1;
        }
        else
        {
            direction = 0;
        }
        
        type = GOOD_BOTTOM;
    }
    return self;
}

-(id) initWithBadBottomImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        health = 1;
        
        if(random() % 2 == 0)
        {
            direction = 1;
        }
        else
        {
            direction = 0;
        }
        type = BAD_BOTTOM;
    }
    return self;
}

@end
