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


@interface Character : CCSprite
@property int type;
@property int health;
@property int worth;
@property int direction;
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

@end
