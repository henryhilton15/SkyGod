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
    CCLabelTTF *shopInstructions;
    
    NSNumber *NSCoins;
    CGSize winSize;
    
    CCLabelTTF *cantAffordThat;
    CCLabelTTF *upgraded;
    CCLabelTTF *purchased;
    int coins;
    int failedUpgradeCounter;
    int successfulUpgradeCounter;
    int successfulPurchaseCounter;
    BOOL displayingSuccessfulUpgrade;
    BOOL displayingSuccessfulPurchase;
    BOOL displayingFailedUpgrade;
    BOOL shopInstructionsRemoved;
    
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
-(void) successfulUpgrade;
-(void) successfulPurchase;
-(void) failedUpgrade;
-(void) update:(ccTime)delta;
@end

