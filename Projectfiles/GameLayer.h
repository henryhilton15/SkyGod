//
//  GameLayer.h
//  Gorilla Game
//
//  Created by Ajay Shah on 7/3/13.
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
    int singleMonsterFramecount;
    int doubleMonsterFramecount;
    NSMutableArray *bananaArray;
    NSMutableArray *enemies;
    NSMutableArray *princesses;
    NSMutableArray *doubleEnemies;
    CGPoint loc;
    CCSprite *projectile;
    CCSprite *badGuy;
    CCSprite *enemy;
    CCSprite *droppingEnemy;
    CCSprite *princess;
    CCAction *rotateBanana;
    CCLabelTTF *LevelLabel;
    CCLabelTTF *enemiesKilledLabel;
    NSMutableArray *bananaFrames;
    NSMutableArray *bananasToDelete;
    NSMutableArray *enemiesToDelete;
    NSMutableArray *princessesToDelete;
    NSString *levelString;
    NSString *enemiesKilledString;
}

-(id) init;
-(void) update:(ccTime)delta;
-(void) detectBananaEnemyCollisions;
-(void) detectEnemyPrincessCollisions;
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) addMonster;
-(void) pauseMenu: (CCMenuItemImage *)pauseButton;
-(void) enemiesKilledTotal;
-(void) currentLevel;
-(void)addDoubleMonster;
@end
