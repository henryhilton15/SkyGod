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
    int zigZagFramecount;
    int helicoptersRemoved;
    int helicopterDelayCounter;
    int randNum;
    int KmonsterCounter;
    int bigGoodGuysCounter;
    int KmonsterMinY;
    int KmonsterMaxY;
    int zigZagDelayCounter;
    int zigZagScenarioCounter;
    //int levelFramecount;
    int goodGuyFramecount;
    int badGuyFramecount;
    int scenarioNumber;
    NSMutableArray *bananaArray;
    NSMutableArray *goodGuys;
    NSMutableArray *badGuys;
    NSMutableArray *zFriendlyArray;
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
    CCSprite *goodTeamCounter;
    CCSprite *badTeamCounter;
    Rect goodRect;
    Rect badRect;
    NSMutableArray *bananaFrames;
    NSMutableArray *bananasToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *Kmonsters;
    NSMutableArray *helicopters;
    NSMutableArray *bigGoodGuys;
    NSString *levelString;
    NSString *enemiesKilledString;
    CGRect badGuyRect;
    CGRect KamikazeBox;
    CGRect goodGuyRect;

    CCAction *taunt;
    NSMutableArray *tauntingFrames;
    CCAction *knightAttack;
    NSMutableArray *knightAttackFrames;


    BOOL Scenario1;
    BOOL Scenario2;
    BOOL Scenario3;
    BOOL Scenario4;
    BOOL firstHeli;
    BOOL firstBigGoodGuy;
    BOOL firstZigZag;

}

-(id) init;
-(void) update:(ccTime)delta;
-(void) draw;
-(void) detectBananaGoodGuyCollisions;
-(void) detectBananaBadGuyCollisions;
-(void) detectReachBottom;
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) addGoodGuy;
-(void) addBadGuy;
-(void) pauseMenu: (CCMenuItemImage *)pauseButton;
-(void) enemiesKilledTotal;
-(void) addZigZagBadGuy;
-(void) addBigMonster;
-(void) addBigGoodGuy;
-(void) addHelicopter;
-(void) addLevel;
-(void) subtractLevel;
-(void) changeLevel;
-(void) detectKmonsterWrongGuyCollisions;
-(void) ScenarioGenerator;
-(void) changeLevel;
-(void) detectKmonsterCollisions;
-(void) CreateScenario;
-(void) zigZagScenario;
-(void) randomNumberGenerator;

@end
