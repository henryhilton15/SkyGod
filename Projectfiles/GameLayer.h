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
    int bigGoodGuysScenarioDelayCounter;
    //int levelFramecount;
    int goodGuyFramecount;
    int badGuyFramecount;
    int scenarioNumber;
    int enemiesKilledCounter;
    int bombCount;
    int badReinforcementCount;
    int immunityFramecount;
    int pointsFramecount;
    int deathFramecount;
    int score;
    int timeRemaining;
    int enemyFrequency;
    int friendlyFrequency;
    int enemiesPassed;
    int friendliesPassed;
    int helicopters;
    int spawnedHelicopters;
    int truckCount;
    int wave;
    int goodFastShooterFramecount;
    int badFastShooterFramecount;
    int goodKnifeGuyFramecount;
    int badKnifeGuyFrameCount;
    int bigMonstercount;
    int bigMonsterDelayCounter;
    int waveChangeCounter;
    int bigGoodGuyMinX;
    int bigGoodGuyMaxX;
    int bigGoodGuyDirection;
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
    CCSprite *goodBottom;
    CCSprite *badBottom;
    CCSprite *truck;
    CCSprite *goodTeamCounter;
    CCSprite *badTeamCounter;
    CCSprite *goodBullet;
    CCSprite *badBullet;
    CCSprite *bomber;
    CCSprite *GoodReinforcement;
    CCSprite *BadReinforcement;
    CCSprite *goodBase;
    CCSprite *badBase;
    CCSprite *badRed;
    CCSprite *titleImage;
    
    Rect goodRect;
    Rect badRect;
    //  NSMutableArray *helicopters;
    //NSMutableArray *zenemies;
    NSMutableArray *bananaFrames;
    NSMutableArray *bananasToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *bananaArray;
    NSMutableArray *goodGuys;
    NSMutableArray *badGuys;
    NSMutableArray *zFriendlyArray;
    NSMutableArray *Kmonsters;
    NSMutableArray *bigGoodGuys;
    NSMutableArray *goodGuysBottom;
    NSMutableArray *badGuysBottom;
    NSMutableArray *goodBulletArray;
    NSMutableArray *badBulletArray;
    NSMutableArray *bombers;
    NSMutableArray *knightAttackFrames;
    NSMutableArray *tauntingFrames;
    NSMutableArray *GoodGuysToDelete;
    NSMutableArray *badBars;
    NSString *levelString;
    NSString *enemiesKilledString;
    CGRect badGuyRect;
    CGRect KamikazeBox;
    CGRect goodGuyRect;
    CGRect truckBox;
    CGRect goodMeleeBox;
    CGRect badMeleeBox;
    CGRect goodRangeBox;
    CGRect badRangeBox;
    CGRect goodBaseBox;
    CGRect badBaseBox;
    CGRect goodBottomRect;
    CGRect badBottomRect;
    CGRect goodBulletBox;
    CGRect badBulletBox;
    CCAction *taunt;
    CCAction *knightAttack;
    CCAction *rotateBanana;
    BOOL Scenario1;
    BOOL Scenario2;
    BOOL Scenario3;
    BOOL Scenario4;
    BOOL isWalking;
    BOOL firstHeli;
    BOOL firstBigGoodGuy;
    BOOL firstZigZag;
    BOOL firstBigMonster;
    BOOL canUseJet;
    BOOL waveChanging;
    BOOL firstTime;
    CCLabelTTF *waveLabel;
    CCLabelTTF *goodBaseHealthLabel;
    CCLabelTTF *badBaseHealthLabel;
    CCLabelTTF *LevelLabel;
    CCLabelTTF *enemiesKilledLabel;
    CCLabelTTF *timeRemainingLabel;
    

    

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
-(void) spawnGoodGuyBottom;
-(void) spawnBadGuyBottom;
-(void) randomNumberGenerator;
-(void) fight;
-(void) detectBulletSoldierCollisions;
-(CGRect) explosionBox;
-(void) airstrike;
-(void) reinforcements;
-(void) addBases;
-(void) badBaseCollisions;
-(void) goodBaseCollisions;
-(void) subtractWave;
-(void) addWave;
-(void) drawBoundingBox: (CGRect) rect;
-(void) addBaseBars;
-(void) addBadRedBar;
@end
