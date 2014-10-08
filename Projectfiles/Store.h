//
//  Store.h
//  Gorilla Game
//
//  Created by Ajay Shah on 7/17/13.
//
//

#import "CCLayer.h"

@interface Store : CCLayer
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
    
    CCLabelTTF *cantAffordThat;
    CCLabelTTF *upgraded;
    CCLabelTTF *purchased;
    CCLabelTTF *shopInstructions;

    int failedUpgradeCounter;
    int successfulUpgradeCounter;
    int successfulPurchaseCounter;
    BOOL displayingSuccessfulUpgrade;
    BOOL displayingSuccessfulPurchase;
    BOOL displayingFailedUpgrade;
    BOOL shopInstructionsRemoved;

}

-(id) init;
-(void) mainMenu;
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
