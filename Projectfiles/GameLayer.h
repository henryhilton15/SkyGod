//
//  GameLayer.h
//  Gorilla
//
//  Created by maria hilton on 7/3/13.
//
//

#import "CCLayer.h"


@interface GameLayer : CCLayer
{
    int collisioncount;
    int monstercount;
    int framecount;
    int level;
    int numberOfEnemies;
    int minDuration;
    int maxDuration;
    int enemiesKilled;
    int deaths;
    int bar;
    int distance;
    int moves;
    //int levelFramecount;
    int goodGuyFramecount;
    int badGuyFramecount;
    NSMutableArray *bananaArray;
    NSMutableArray *goodGuys;
    NSMutableArray *princesses;
    NSMutableArray *badGuys;
    //NSMutableArray *zenemies;
    CGPoint loc;
    CCSprite *projectile;
    CCSprite *badGuy;
    CCSprite *enemy;
    CCSprite *goodGuy;
    CCSprite *droppingEnemy;
    CCSprite *princess;
    CCSprite *background;
    CCSprite *player;
    CCSprite *zenemy;
    CCAction *rotateBanana;
    CCLabelTTF *LevelLabel;
    CCLabelTTF *enemiesKilledLabel;
    Rect goodRect;
    Rect badRect;
    NSMutableArray *bananaFrames;
    NSMutableArray *bananasToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *princessesToDelete;
    NSString *levelString;
    NSString *enemiesKilledString;


}
-(id) init;
-(void) update:(ccTime)delta;
-(void) draw;
-(void) detectBananaGoodGuyCollisions;
-(void) detectBananaBadGuyCollisions;
-(void) detectReachBottom;
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) addGoodGuy;
-(void) addBadGuy;
-(void) pauseMenu: (CCMenuItemImage *)pauseButton;
-(void) enemiesKilledTotal;
-(void) addZigZagBadGuy;

-(void) addLevel;
-(void) subtractLevel;
- (void) changeLevel;






@end
