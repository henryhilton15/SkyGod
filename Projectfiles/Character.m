//
//  BigMonster.m
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "Character.h"
#import "Player.h"

@implementation Character


@synthesize health;
@synthesize worth;
@synthesize direction;
@synthesize type;
@synthesize row;
@synthesize melee;
@synthesize left;
@synthesize right;
@synthesize unlockLevel;
@synthesize unlocked;
@synthesize power;
@synthesize attackFrequency;
@synthesize bulletPower;
@synthesize bulletType;
@synthesize fallSpeed;

-(id) initWithBigMonsterImage
{
    if((self = [super initWithFile:@"monster9.png"]))
    {
        health = 5;
        worth = 100;
        type = BIG_MONSTER;
        row = 0;
        melee = false;
        unlockLevel = 0;
        
    }
    return self;
}

-(id) initWithBigGoodGuyImage
{
    if((self = [super initWithFile:@"a5-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyTank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        

        worth = 100;
        type = BIG_GOOD_GUY;
        row = 0;
        melee = false;
        left = false;
        right = false;
        bulletType = GOOD_HELICOPTER_BOMB;
    }
    return self;
}
-(id) initWithFriendlyRegularShooterImage
{
    if((self = [super initWithFile:@"a2-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyRegularShooter"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        type = GOOD_GUY;
        row = 0;
        melee = false;
        bulletType = REGULAR_GOOD_BULLET;
        worth = 50;
    }
    return self;
}

-(id) initWithBadGuyImage
{
    if((self = [super initWithFile:@"d2-1.png"]))
    {
        worth = 50;
        health = 2;
        attackFrequency = 50;
        type = BAD_GUY;
        power = 1;
        //immunity = 0;
        row = 0;
        melee = false;
        unlockLevel = 0;
        bulletType = REGULAR_BAD_BULLET;
    }
    return self;
}
-(id) initWithZigZagImage
{
    if((self = [super initWithFile:@"d2-1.png"]))
    {
        worth = 50;
        health = 1;
        type = ZIG_ZAG;
        row = 0;
        melee = false;
        unlockLevel = 0;
    }
    return self;
}
-(id) initWithGoodHelicopterImage
{
    if((self = [super initWithFile:@"a4-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyPlane"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
      
        
        health = 5;
        type = GOOD_HELICOPTER;
    }
    return self;
}
-(id) initWithBadHelicopterImage
{
    if((self = [super initWithFile:@"d4-1.png"]))
    {
        health = 5;
        type = BAD_HELICOPTER;
    }
    return self;
}
-(id) initWithGoodHelicopterBombImage
{
    if((self = [super initWithFile:@"angel's bomb.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyHelicopterBomb"];
        
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        
        worth = 50;
        power = 3;
        type = GOOD_HELICOPTER_BOMB;
    }
    return self;
}
-(id) initWithBadHelicopterBombImage
{
    if((self = [super initWithFile:@"devil's bomb.png"]))
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
        power = 3;
    }
    return self;
}
-(id) initWithDoubleEnemyImage
{
    if((self = [super initWithFile:@"d2-1.png"]))
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
    if ((self = [super initWithFile: @"goodbase-1.png"]))
    {
        health = 10;
        type = GOOD_BASE;
    }
    return self;
    
}

-(id) initWithBadGuyBaseImage
{
    if ((self = [super initWithFile: @"badbase-1.png"]))
    {
        health = 10;
        type = BAD_BASE;
    }
    return self;
}
-(id) initWithFastShooterBadGuyImage
{
    if((self = [super initWithFile:@"d2-1.png"]))
    {
        health = 1;
        attackFrequency = 30;
        type = BAD_FASTSHOOTER;
        unlockLevel = 0;
        bulletType = REGULAR_BAD_BULLET;
    }
    return  self;
}
-(id) initWithFastShooterGoodGuyImage
{
    if((self = [super initWithFile:@"a3-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyFastShooter"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        
        type = GOOD_FASTSHOOTER;
        bulletType = REGULAR_GOOD_BULLET;
    }
return self;
}
-(id) initWithKnifeGoodGuyImage
{
    if ((self = [super initWithFile: @"a1-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyMelee"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        
        type = GOOD_KNIFE;
    }
    return self;
}
-(id) initWithKnifeBadGuyImage
{
    if ((self = [super initWithFile: @"d1-1.png"]))
    {
        health = 2;
        power = 1;
        attackFrequency = 150;
        type = BAD_KNIFE;
        unlockLevel = 0;
    }   
return self;
}
-(id) initWithGoodReinforcementImage
{
    if ((self = [super initWithFile:@"a6-1.png"]))
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
            NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
            
            NSMutableDictionary* d = [friendlies objectForKey:@"friendlySpartan"];
            
            unlocked = [[d objectForKey:@"available"] boolValue];
            health = [[d objectForKey:@"health"] intValue];
            power = [[d objectForKey:@"power"] intValue];
            attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
            fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
            type = GOOD_REINFORCEMENT;
            bulletType = SPEAR;
        }
        return  self;
}
-(id) initWithGoodGuyBulletImage
{
    if ((self = [super initWithFile:@"lighting.png"]))
    {
        power = 1;
    }
    return self;
}
-(id) initWithGoodGuyFastShooterBulletImage
{
    if ((self = [super initWithFile:@"lighting.png"]))
    {
        power = 1;
    }
    return self;
}
-(id) initWithBadGuyBulletImage
{
    if ((self = [super initWithFile:@"lighting.png"]))
    {
        power = 1;
    }
    return self;
}
-(id) initWithSpearImage
{
    if ((self = [super initWithFile:@"spear.png"]))
    {
        power = 1;
    }
    return self;
}
-(id) initWithBlueEnergyImage
{
    if ((self = [super initWithFile:@"blue-energy.png"]))
    {
        power = 1;
    }
    return self;
}

@end
