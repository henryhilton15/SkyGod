//
//  Character.m
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "Character.h"
#import "Player.h"
#import "GameLayer.h"
#import "GameData.h"

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
@synthesize speed;

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
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + [rank intValue];
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
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
        
        NSDictionary* d = [friendlies objectForKey:@"friendlyRegularShooter"];
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + [rank intValue];
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
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
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyHelicopterRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
        
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
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyHelicopterBombRank"];
        
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
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

-(id) initWithGoodGuyBaseImage1
{
    if ((self = [super initWithFile: @"goodbase-1.png"]))
    {
        health = 10;
        type = GOOD_BASE1;
    }
    return self;
}

-(id) initWithGoodGuyBaseImage2
{
    if ((self = [super initWithFile: @"goodbase-2.png"]))
    {
        health = 6;
        type = GOOD_BASE2;
    }
    return self;
}

-(id) initWithGoodGuyBaseImage3
{
    if ((self = [super initWithFile: @"goodbase-3.png"]))
    {
        health = 3;
        type = GOOD_BASE3;
    }
    return self;
}

-(id) initWithBadGuyBaseImage1
{
    if ((self = [super initWithFile: @"badbase-1.png"]))
    {
        health = 10;
        type = BAD_BASE1;
    }
    return self;
}

-(id) initWithBadGuyBaseImage2
{
    if ((self = [super initWithFile: @"badbase-2.png"]))
    {
        health = 6;
        type = BAD_BASE2;
    }
    return self;
}

-(id) initWithBadGuyBaseImage3
{
    if ((self = [super initWithFile: @"badbase-3.png"]))
    {
        health = 3;
        type = BAD_BASE3;
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
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + [rank intValue];
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
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
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + [rank intValue];
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
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
            
            NSMutableDictionary* d = [friendlies objectForKey:@"spartan"];
            
            NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"spartanRank"];
            
            unlocked = [[d objectForKey:@"available"] boolValue];
            health = [[d objectForKey:@"health"] intValue] + [rank intValue];
            power = [[d objectForKey:@"power"] intValue] + [rank intValue];
            attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
            fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
            
            type = GOOD_REINFORCEMENT;
            bulletType = SPEAR;
        }
        return self;
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
