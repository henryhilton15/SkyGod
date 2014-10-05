//
//  InGameShop.h
//  SkyGod
//
//  Created by Danny Laporte on 10/4/14.
//
//

#import "CCLayer.h"


@interface InGameShop : CCLayer
{
    CCLabelTTF *StoreLabel;
    CCLabelTTF *meleePrice;
    CCLabelTTF *shooterPrice;
    CCLabelTTF *fastShooterPrice;
    CCLabelTTF *tankPrice;
    CCLabelTTF *airstrikePrice;
    CCLabelTTF *reinforcementsPrice;
    CCLabelTTF *immunityPrice;
    CCLabelTTF *meleeRank;
    CCLabelTTF *shooterRank;
    CCLabelTTF *fastShooterRank;
    CCLabelTTF *tankRank;
    CCLabelTTF *immunityCount;
    CCLabelTTF *airstrikeCount;
    CCLabelTTF *reinforcemtsCount;
    CCLabelTTF *coinsLabel;
    int coins;
    NSNumber *NSCoins;
    CGSize winSize;
    
}

-(id) init;
-(void) resume;
-(void) upgradeFriendlyRegularShooter;
-(void) upgradeFriendlyMelee;
-(void) upgradeFriendlyFastShooter;
-(void) upgradeSpartan;
-(void) upgradeFriendlyHelicopter;
-(void) upgradeFriendlyTank;
-(void) upgradeImmunity;
@end

