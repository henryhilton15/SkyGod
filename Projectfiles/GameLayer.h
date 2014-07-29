//
//  GameLayer.h
//  Gorilla
//
//  Created by maria hilton on 7/3/13.
//
//

#import "CCLayer.h"
#import "Player.h"
#import "Character.h"
#import "GameData.h"


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
    int friendlyRegularShooterFramecount;
    int enemyRegularShooterFramecount;
    int scenarioNumber;
    int enemiesKilledCounter;
    int bombCount;
    int goodReinforcementCount;
    int immunityFramecount;
    int pointsFramecount;
    int deathFramecount;
    int score;
    int timeRemaining;
    int enemyFrequency;
    int friendlyFrequency;
    int enemiesPassed;
    int friendliesPassed;
    int spawnedHelicopters;
    int truckCount;
    int wave;
    int friendlyFastShooterFramecount;
    int enemyFastShooterFramecount;
    int friendlyMeleeFramecount;
    int enemyMeleeFramecount;
    int bigMonstercount;
    int bigMonsterDelayCounter;
    int waveChangeCounter;
    int bigGoodGuyMinX;
    int bigGoodGuyMaxX;
    int bigGoodGuyDirection;
    int orbsDeleted;
    int immunityLength;
    int reinforcementFramecount;
    int numReinforcments;
    int reinforcementsSpawned;
    int currentLevelSelected;
    int enemyBombFramecount;
    int enemyHeliSpeed;
    int enemyHeliHealth;
    int scenarioDelayCounter;
    int scenarioDelay;
    int scenario2interludeCounter;
    int goodBaseImageChangeCount;
    int badBaseImageChangeCount;
    int enemyHelicopterCount;
    double zigZagPercentage;
    double explosionAnimationLength;
    double dyingAnimationLength;
    double KmonsterSpeed;
    double enemyBombSpeed;
    CGPoint loc;
    CGSize winSize;
    CCSprite *projectile;
    CCSprite *badGuy;
    CCSprite *enemy;
    CCSprite *goodGuy;
    CCSprite *bomb;
    CCSprite *droppingEnemy;
    CCSprite *princess;
    CCSprite *Kamikaze;
    CCSprite *helicopter;
    CCSprite *zenemy;
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
    CCSprite *angel1;
    CCSprite *angel2;
    CCSprite *angel3;
    CCSprite *devil1;
    CCSprite *devil2;
    CCSprite *devil3;
    CCSprite *devilHeli;
    CCSprite *player;
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
    NSMutableArray *goodBombs;
    NSMutableArray *zigZagScenarioEnemies;
//    NSMutableArray *badHelicopters;
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
    BOOL Scenario2interlude;
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
    BOOL immunity;
    BOOL reinforcements;
    BOOL enemyMeleeAvailable;
    BOOL enemyRegularShooterAvailable;
    BOOL enemyFastShooterAvailable;
    BOOL badBaseExploded;
    BOOL goodBaseExploded;
    CCLabelTTF *waveLabel;
    CCLabelTTF *goodBaseHealthLabel;
    CCLabelTTF *badBaseHealthLabel;
    CCLabelTTF *levelLabel;
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
-(void) addFriendlyRegularShooter;
-(void) addEnemyRegularShooter;
-(void) addFriendlyMelee;
-(void) addEnemyMelee;
-(void) addFriendlyFastShooter;
-(void) addEnemyFastShooter;
-(void) pauseMenu: (CCMenuItemImage *)pauseButton;
-(void) enemiesKilledTotal;
-(void) addZigZagBadGuy;
-(void) addEnemyTank;
-(void) addFriendlyTank;
-(void) addEnemyHelicopter;
-(void) addLevel;
-(void) subtractLevel;
-(void) changeLevel;
-(void) detectKmonsterWrongGuyCollisions;
-(void) scenarioGenerator;
-(void) changeLevel;
-(void) detectKmonsterCollisions;
-(void) zigZagScenario;
-(void) spawnGoodGuyBottom;
-(void) spawnBadGuyBottom;
-(void) createScenario;
-(int) generateRandomNumber;
-(void) fight;
-(void) angel1attackAnimation:(CCSprite*)angelOne;
-(void) angel2attackAnimation:(CCSprite*)angel;
-(void) angel3attackAnimation:(CCSprite*)angel;
-(void) devil1attackAnimation:(CCSprite*)devil;
-(void) devil2attackAnimation:(CCSprite*)devil;
-(void) spartanAttackAnimation:(CCSprite*)spartan;
-(void) angelShoot:(CCSprite*)angel;
-(void) devilShoot:(CCSprite*)devil;
-(void) mainCharacterIdleAnimation:(CCSprite*)mainCharacter;
-(void) mainCharacterShootAnimation:(CCSprite*)mainCharacter :(int)direction;
-(void) explosion:(CCSprite*)character :(double)delay :(BOOL)big;
-(void) dying:(CCSprite*)character :(double)delay;
-(void) detectBulletSoldierCollisions;
-(void) airstrike;
-(void) reinforcements;
-(void) spawnReinforcement;
-(void) immunityActivator;
-(void) drawBoundingBox:(CGRect)rect;
-(void) addBases;
-(void) badBaseCollisions;
-(void) goodBaseCollisions;
-(void) youLose;
-(void) youWin;
-(void) drawBoundingBox: (CGRect) rect;
-(void) addBaseBars;
-(void) addImmunity;
-(void) addBadRedBar;
-(void) loadLevelSettings;

@end
