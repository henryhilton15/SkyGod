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
    int coins;
    NSNumber *NSCoins;
    CGSize winSize;

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
@end
