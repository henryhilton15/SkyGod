//
//  Character.h
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "CCSprite.h"

#define BIG_MONSTER 0
#define BIG_GOOD_GUY 1
#define GOOD_GUY 2
#define BAD_GUY 3
#define ZIG_ZAG 4
#define GOOD_HELICOPTER 5
#define BAD_HELICOPTER 6
#define GOOD_HELICOPTER_BOMB 7
#define BAD_HELICOPTER_BOMB 8
#define KAMIKAZE 9
#define GOOD_BOTTOM 10
#define BAD_BOTTOM 11
#define SUPER_ZIG_ZAG_GUY 12
#define DOUBLE_ENEMY 13
#define GOOD_BASE1 14
#define BAD_BASE1 15
#define BAD_FASTSHOOTER 16
#define GOOD_FASTSHOOTER 17
#define BAD_KNIFE 18
#define GOOD_KNIFE 19
#define GOOD_REINFORCEMENT 20
#define REGULAR_GOOD_BULLET 21
#define SPEAR 22
#define REGULAR_BAD_BULLET 23
#define GOOD_BASE2 24
#define GOOD_BASE3 25
#define BAD_BASE2 26
#define BAD_BASE3 27

@interface Character : CCSprite
@property int type;
@property int health;
@property int worth;
@property int direction;
@property int row;
@property bool melee;
@property bool left;
@property bool right;
@property int unlockLevel;
@property bool unlocked;
@property int power;
@property int attackFrequency;
@property int bulletPower;
@property int bulletType;
@property double speed;
@property double fallSpeed;

-(id) initWithBigMonsterImage;
-(id) initWithBigGoodGuyImage;
-(id) initWithFriendlyRegularShooterImage;
-(id) initWithBadGuyImage;
-(id) initWithZigZagImage;
-(id) initWithGoodHelicopterImage;
-(id) initWithBadHelicopterImage;
-(id) initWithGoodHelicopterBombImage;
-(id) initWithBadHelicopterBombImage;
-(id) initWithKamikazeImage;
-(id) initWithDoubleEnemyImage;
-(id) initWithGoodBottomImage;
-(id) initWithBadBottomImage;
-(id) initWithSuperZigZagGuyImage;
-(id) initWithBadGuyBaseImage1;
-(id) initWithBadGuyBaseImage2;
-(id) initWithBadGuyBaseImage3;
-(id) initWithGoodGuyBaseImage1;
-(id) initWithGoodGuyBaseImage2;
-(id) initWithGoodGuyBaseImage3;
-(id) initWithFastShooterBadGuyImage;
-(id) initWithFastShooterGoodGuyImage;
-(id) initWithKnifeGoodGuyImage;
-(id) initWithKnifeBadGuyImage;
-(id) initWithGoodReinforcementImage;
-(id) initWithGoodGuyBulletImage;
-(id) initWithGoodGuyFastShooterBulletImage;
-(id) initWithBadGuyBulletImage;
-(id) initWithSpearImage;
-(id) initWithBlueEnergyImage;

@end
