//
//  BigMonster.h
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
#define GOOD_BASE 14
#define BAD_BASE 15
#define BAD_FASTSHOOTER 16
#define GOOD_FASTSHOOTER 17
#define BAD_KNIFE 18
#define GOOD_KNIFE 19
#define GOOD_REINFORCEMENT 20

@interface Character : CCSprite
@property int type;
@property int health;
@property int worth;
@property int direction;
@property int immunity;
@property int row;
@property bool melee;
@property bool left;
@property bool right;
@property int unlockLevel;
@property bool unlocked;

-(id) initWithBigMonsterImage;
-(id) initWithBigGoodGuyImage;
-(id) initWithGoodGuyImage;
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
-(id) initWithBadGuyBaseImage;
-(id) initWithGoodGuyBaseImage;
-(id) initWithFastShooterBadGuyImage;
-(id) initWithFastShooterGoodGuyImage;
-(id) initWithKnifeGoodGuyImage;
-(id) initWithKnifeBadGuyImage;
-(id) initWithGoodReinforcementImage;

@end
