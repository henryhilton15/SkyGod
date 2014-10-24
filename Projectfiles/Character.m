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
@synthesize fallingHealth;
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
@synthesize attacked;
@synthesize endgameFallSpeed;

-(id) initWithEnemyTankImage
{
    if((self = [super initWithFile:@"d3-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *enemyTankDict = [levelDictionary objectForKey:@"enemyTank"];
        
        health = [[enemyTankDict objectForKey:@"health"] intValue];
        fallingHealth = 1 + [[enemyTankDict objectForKey:@"fallingHealth"] intValue];
        attackFrequency = [[enemyTankDict objectForKey:@"attackFrequency"] intValue];
        power = [[enemyTankDict objectForKey:@"damage"] intValue];
        fallSpeed = [[enemyTankDict objectForKey:@"fallSpeed"] intValue];
        worth = 100;
        type = BIG_MONSTER;
        row = 0;
        melee = false;
        unlockLevel = 0;
        bulletType = TANK_BOMB;
        attacked = false;
    }
    return self;
}

-(id) initWithFriendlyTankImage
{
    if((self = [super initWithFile:@"a5-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyTank"];
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + (200 + [rank intValue]);
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (10 * [rank intValue]);
        fallSpeed = [[d objectForKey:@"fallSpeed"] doubleValue];
        
        worth = 100;
        type = BIG_GOOD_GUY;
        row = 0;
        melee = false;
        left = false;
        right = false;
        bulletType = TANK_BOMB;
        attacked = false;
        
        if (rank == 2)
        {
            health+= 50;
            power+= 15;
        }
        
        if (rank == 3)
        {
            health += 100;
            power+= 30;
        }

        
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
        health = [[d objectForKey:@"health"] intValue] + [rank intValue] + (5 * [rank intValue]);
        power = [[d objectForKey:@"power"] intValue] + [rank intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
        fallSpeed = 5 + [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        fallingHealth = 1 + [[d objectForKey:@"fallingHealth"] intValue];

        type = GOOD_GUY;
        row = 0;
        melee = false;
        bulletType = REGULAR_GOOD_BULLET;
        worth = 50;
        attacked = false;
        
        if (rank == 2)
        {
            health+= 15;
            power+= 10;
        }
        
        if (rank == 3)
        {
            health += 30;
            power+= 20;
        }
        
    }
    return self;
}

-(id) initWithEnemyRegularShooterImage
{
    if((self = [super initWithFile:@"d2-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *enemyRegularShooterDict = [levelDictionary objectForKey:@"enemyRegularShooter"];
        
        health = [[enemyRegularShooterDict objectForKey:@"health"] intValue];
        fallingHealth = [[enemyRegularShooterDict objectForKey:@"fallingHealth"] intValue];
        attackFrequency = [[enemyRegularShooterDict objectForKey:@"attackFrequency"] intValue];
        power = [[enemyRegularShooterDict objectForKey:@"damage"] intValue];
        fallSpeed = [[enemyRegularShooterDict objectForKey:@"fallSpeed"] doubleValue];
        
        type = BAD_GUY;
        worth = 50;
        //immunity = 0;
        row = 0;
        melee = false;
        unlockLevel = 0;
        bulletType = REGULAR_BAD_BULLET;
        attacked = false;
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
        attacked = false;
    }
    return self;
}
-(id) initWithBadHelicopterImage
{
    if((self = [super initWithFile:@"d4-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *enemyHeliDict = [levelDictionary objectForKey:@"enemyHelicopter"];
        
        fallingHealth = 2 + [[enemyHeliDict objectForKey:@"health"] intValue];
        speed = 5 + [[enemyHeliDict objectForKey:@"speed"] intValue];
        type = BAD_HELICOPTER;
        power = 5;
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
        fallSpeed = [[d objectForKey:@"fallSpeed"] doubleValue];
        
        worth = 50;

        type = GOOD_HELICOPTER_BOMB;
    }
    return self;
}
-(id) initWithBadHelicopterBombImage
{
    if((self = [super initWithFile:@"devil's bomb.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *enemyBombDict = [levelDictionary objectForKey:@"enemyBomb"];
        
        power = 50 + [[enemyBombDict objectForKey:@"damage"] intValue];
        fallSpeed = 7 + [[enemyBombDict objectForKey:@"fallSpeed"] intValue];
        fallingHealth = 1 + [[enemyBombDict objectForKey:@"health"] intValue];
        worth = 50;

        type = BAD_HELICOPTER_BOMB;
        attacked = false;
    }
    return self;
}
-(id) initWithKamikazeImage
{
    if((self = [super initWithFile:@"d4-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *kamikazeDict = [levelDictionary objectForKey:@"Kmonster"];
        
        health = 1 + [[kamikazeDict objectForKey:@"health"] intValue];
        type = KAMIKAZE;
        power = 3 + [[kamikazeDict objectForKey:@"damage"] intValue];
        speed = 5 + [[kamikazeDict objectForKey:@"speed"] intValue];
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

-(id) initWithGoodGuyBaseImage1
{
    if ((self = [super initWithFile: @"goodbase-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        health = [[levelDictionary objectForKey:@"friendlyBaseHealth"] intValue];
        type = GOOD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithGoodGuyBaseImage2
{
    if ((self = [super initWithFile: @"goodbase-2.png"]))
    {
        type = GOOD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithGoodGuyBaseImage3
{
    if ((self = [super initWithFile: @"goodbase-3.png"]))
    {
        type = GOOD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithBadGuyBaseImage1
{
    if ((self = [super initWithFile: @"badbase-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        health = [[levelDictionary objectForKey:@"enemyBaseHealth"] intValue];
        type = BAD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithBadGuyBaseImage2
{
    if ((self = [super initWithFile: @"badbase-2.png"]))
    {
        type = BAD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithBadGuyBaseImage3
{
    if ((self = [super initWithFile: @"badbase-3.png"]))
    {
        type = BAD_BASE;
        melee = true;
    }
    return self;
}

-(id) initWithEnemyFastShooterImage
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
-(id) initWithFriendlyFastShooterImage
{
    if((self = [super initWithFile:@"a3-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyFastShooter"];
        
        NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue] + (3 *[rank intValue]);
        power = [[d objectForKey:@"power"] intValue] + (3 * [rank intValue]);
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
        fallSpeed = 5 + [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        type = GOOD_FASTSHOOTER;
        bulletType = REGULAR_GOOD_BULLET;
        attacked = false;
        
        if (rank == 2)
        {
            health+= 10;
            power+= 10;
        }
        
        if (rank == 3)
        {
            health += 20;
            power+= 20;
        }

        
    }
    return self;
}
-(id) initWithFriendlyMeleeImage
{
    if ((self = [super initWithFile: @"a1-1.png"]))
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
        NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary* d = [friendlies objectForKey:@"friendlyMelee"];
        
        int rank = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"] intValue];
        
        unlocked = [[d objectForKey:@"available"] boolValue];
        health = [[d objectForKey:@"health"] intValue];
        power = [[d objectForKey:@"power"] intValue];
        attackFrequency = [[d objectForKey:@"attackFrequency"] intValue];
        fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
        type = GOOD_KNIFE;
        attacked = false;
        
        if(rank == 2)
        {
            health += 10;
            power += 5;
            
        }
        
        if(rank == 3)
        {
            health += 20;
            power += 10;
            
        }
        
    }
    return self;
}
-(id) initWithEnemyMeleeImage
{
    if ((self = [super initWithFile: @"d1-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *enemyMeleeDict = [levelDictionary objectForKey:@"enemyMelee"];
        
        health = [[enemyMeleeDict objectForKey:@"health"] intValue];
        fallingHealth = [[enemyMeleeDict objectForKey:@"fallingHealth"] intValue];
        attackFrequency = [[enemyMeleeDict objectForKey:@"attackFrequency"] intValue];
        power = [[enemyMeleeDict objectForKey:@"damage"] intValue];
        fallSpeed = [[enemyMeleeDict objectForKey:@"fallSpeed"] doubleValue];
        type = BAD_KNIFE;
        unlockLevel = 0;
        attacked = false;
    }   
    return self;
}
-(id) initWithSpartanImage
{
    if ((self = [super initWithFile:@"a6-1.png"]))
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"friendlies" ofType:@"plist"];
            NSDictionary *friendlies = [NSDictionary dictionaryWithContentsOfFile:path];
            
            NSMutableDictionary* d = [friendlies objectForKey:@"friendlySpartan"];
            
            NSNumber *rank = [[NSUserDefaults standardUserDefaults] objectForKey:@"spartanRank"];
            
            unlocked = [[d objectForKey:@"available"] boolValue];
            health = [[d objectForKey:@"health"] intValue] + [rank intValue];
            power = [[d objectForKey:@"power"] intValue] + [rank intValue];
            attackFrequency = [[d objectForKey:@"attackFrequency"] intValue] - (5 * [rank intValue]);
            fallSpeed = [[d objectForKey:@"fallSpeed"] intValue] * 1.0;
            
            type = GOOD_REINFORCEMENT;
            bulletType = SPEAR;
            attacked = false;
        }
        return self;
}
-(id) initWithFriendlyRegularShooterBulletImage
{
    if ((self = [super initWithFile:@"bomb-1.png"]))
    {
        power = 0;
        attacked = false;
    }
    return self;
}
-(id) initWithFriendlyFastShooterBulletImage
{
    if ((self = [super initWithFile:@"bomb-1.png"]))
    {
        attacked = false;
        power = 0;
    }
    return self;
}
-(id) initWithEnemyRegularShooterBulletImage
{
    if ((self = [super initWithFile:@"bomb-1.png"]))
    {
        power = 0;
        attacked = false;
    }
    return self;
}
-(id) initWithSpearImage
{
    if ((self = [super initWithFile:@"spear.png"]))
    {
        power = 0;
        attacked = false;
    }
    return self;
}

-(id) initWithTankBombImage
{
    if ((self = [super initWithFile:@"bomb-1.png"]))
    {
        power = 0;
        attacked = false;
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

-(id) initWithCoinImage
{
    if((self = [super initWithFile:@"Dollar-1.png"]))
    {
        NSString *plistName = [NSString stringWithFormat:@"level%d", [GameData sharedData].currentLevelSelected];
        NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableDictionary *coinDict = [levelDictionary objectForKey:@"coin"];
        
        fallSpeed = [[coinDict objectForKey:@"gameplayFallSpeed"] intValue];
        endgameFallSpeed = [[coinDict objectForKey:@"endgameFallSpeed"] intValue];
        worth = 1;
        health = 1;
    }
    return self;
}

@end
