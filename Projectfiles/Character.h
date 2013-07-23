//
//  BigMonster.h
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "CCSprite.h"

@interface Character : CCSprite
@property int health;
@property int worth;
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
