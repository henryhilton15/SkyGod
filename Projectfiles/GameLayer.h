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
    int KmonsterFramecount;
    int helicopterBombFramecount;
    int helicopterFramecount;
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
    CCSprite *bomb;
    CCSprite *droppingEnemy;
    CCSprite *princess;
    CCSprite *background;
    CCSprite *Kamikaze;
    CCSprite *helicopter;
    CCSprite *player;
    CCSprite *zenemy;
    CCSprite *zFriendly1;
    CCSprite *zFriendly2;
    CCSprite *zFriendly3;
    CCSprite *zFriendly4;
    CCAction *rotateBanana;
    CCLabelTTF *LevelLabel;
    CCLabelTTF *enemiesKilledLabel;
    Rect goodRect;
    Rect badRect;
    NSMutableArray *bananaFrames;
    NSMutableArray *bananasToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *Kmonsters;
    NSMutableArray *princessesToDelete;
    NSMutableArray *helicopters;
    NSString *levelString;
    NSString *enemiesKilledString;
    CGRect badGuyRect;
    CGRect KamikazeBox;
    CGRect goodGuyRect;
    CGSize winSize;


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

-(void) addHelicopter;
-(void) addLevel;
-(void) subtractLevel;
- (void) changeLevel;

-(void) detectKmonsterWrongGuyCollisions;

-(void) zigLeft;
-(void) zagRight;




@end
