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
    int coins;
    NSNumber *NSCoins;
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
