//
//  Store.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/17/13.
//
//

#import "Store.h"
#import "MainMenuLayer.h"
#import "Character.h"
#import "GameData.h"
#import "SimpleAudioEngine.h"
#import "Levelselect.h"
#import "TutorialLayer.h"

#define displayLength 200

@implementation Store
-(id)init
{

    if ((self = [super init]))
    {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"beenInStoreBefore"] boolValue] == false)
        {
            [[CCDirector sharedDirector] pushScene: (CCScene *)[[TutorialLayer alloc]  init]];
            
            NSLog(@"first time");
            NSNumber *trueBool = [NSNumber numberWithBool:true];
            [[NSUserDefaults standardUserDefaults] setObject:trueBool forKey:@"beenInStoreBefore"];
            
            NSNumber *zero = [NSNumber numberWithInt:0];
            NSNumber *one = [NSNumber numberWithInt:1];
            [[NSUserDefaults standardUserDefaults] setObject:one forKey:@"friendlyMeleeRank"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"friendlyRegularShooterRank"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"friendlyFastShooterRank"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"friendlyTankRank"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"immunityAvailable"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"airstrikesAvailable"];
            [[NSUserDefaults standardUserDefaults] setObject:zero forKey:@"reinforcementsAvailable"];
        }
        
        winSize = [CCDirector sharedDirector].winSize;
        
        successfulUpgradeCounter = 0;
        successfulPurchaseCounter = 0;
        failedUpgradeCounter = 0;
        displayingSuccessfulPurchase = false;
        displayingSuccessfulUpgrade = false;
        displayingFailedUpgrade = false;
        
        int upperLeftX = winSize.width * .2;
        int upperLeftY = winSize.height * .85;
        
        cantAffordThat = [CCLabelTTF labelWithString:@"Can't afford that!" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        cantAffordThat.position = ccp(upperLeftX, upperLeftY);
        cantAffordThat.color = ccRED;
        
        
        
        upgraded = [CCLabelTTF labelWithString:@"Upgraded!" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        upgraded.position = ccp(upperLeftX, upperLeftY);
        upgraded.color = ccBLUE;
        
        purchased = [CCLabelTTF labelWithString:@"Purchased!" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        purchased.position = ccp(upperLeftX, upperLeftY);
        purchased.color = ccBLUE;
        
        //shop label
        shopInstructions = [CCLabelTTF labelWithString:@"tap to buy!" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        shopInstructions.position = ccp(upperLeftX, upperLeftY);
        shopInstructions.color = ccBLUE;
        [self addChild:shopInstructions];
        
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Undaunted.wav"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Undaunted.wav" loop:YES];
            }
        }
        
        NSCoins = [[NSUserDefaults standardUserDefaults] objectForKey:@"coins"];
        coins = [NSCoins intValue];
        
        int friendlyMeleeRankInt = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"] intValue];
        NSNumber *NSFriendlyMeleePrice = [NSNumber numberWithInt:((friendlyMeleeRankInt + 1) * 10)];
        [[NSUserDefaults standardUserDefaults] setObject:NSFriendlyMeleePrice forKey:@"friendlyMeleePrice"];
        
        int friendlyRegularShooterRankInt = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"] intValue];
        NSNumber *NSFriendlyRegularShooterPrice = [NSNumber numberWithInt:(40 + (friendlyRegularShooterRankInt * 15))];
        [[NSUserDefaults standardUserDefaults] setObject:NSFriendlyRegularShooterPrice forKey:@"friendlyRegularShooterPrice"];
        
        int friendlyFastShooterRankInt = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"] intValue];
        NSNumber *NSFriendlyFastShooterPrice = [NSNumber numberWithInt:(60 + (friendlyFastShooterRankInt * 30))];
        [[NSUserDefaults standardUserDefaults] setObject:NSFriendlyFastShooterPrice forKey:@"friendlyFastShooterPrice"];
        
        int friendlyTankRankInt = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"] intValue];
        NSNumber *NSFriendlyTankPrice = [NSNumber numberWithInt:(100 + ( friendlyTankRankInt * 30))];
        [[NSUserDefaults standardUserDefaults] setObject:NSFriendlyTankPrice forKey:@"friendlyTankPrice"];
   
        [GameData sharedData].airPrice = 40;
        [GameData sharedData].reinforcePrice = 75;
        [GameData sharedData].immunityPrice = 15;
        
//        CCMenuItemImage *BuyButton1 = [CCMenuItemImage itemWithNormalImage:@"upgrades-button.png" selectedImage:@"upgrades-button.png"];
//        BuyButton1.position= CGPointMake (100, 300);
//        BuyButton1.scale = 0.1f;
//        [self addChild:BuyButton1 z:50];
//        BuyButton1.color = ccBLUE;
//        

        
        //CCMenu *myMenu = [CCMenu menuWithItems:BuyButton, nil];
        //[self addChild:myMenu];
        
        CCSprite *background = [CCSprite spriteWithFile:@"sky-ip5.png"];
        background.position = CGPointMake(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        //            StoreLabel = [CCLabelTTF labelWithString:@"Store" fontName:@"BenguiatItcTEE-Book" fontSize:40];
        //            StoreLabel.position = ccp(240,240);
        //            StoreLabel.color = ccBLUE;
        //            [self addChild:StoreLabel z:4];
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-n.png"
                                                                 selectedImage: @"main menu-button-d.png"
                                                                        target:self
                                                                      selector:@selector(mainMenu:)];
        
        CCMenuItemImage *continueButton = [CCMenuItemImage itemWithNormalImage:@"continue-button-n.png"
                                                                 selectedImage: @"continue-button-d.png"
                                                                        target:self
                                                                      selector:@selector(levelSelect:)];
        
        
        CCMenuItemImage *regularShooterButton = [CCMenuItemImage itemWithNormalImage:@"a2-1.png"
                                                                       selectedImage:@"a2-1.png"
                                                                              target:self
                                                                            selector:@selector(upgradeRegularShooter:)];
        
        CCMenuItemImage *fastShooterButton = [CCMenuItemImage itemWithNormalImage:@"a3-1.png"
                                                                    selectedImage:@"a3-1.png"
                                                                           target:self
                                                                         selector:@selector(upgradeFastShooter:)];
        
        CCMenuItemImage *meleeButton = [CCMenuItemImage itemWithNormalImage:@"a1-1.png"
                                                              selectedImage:@"a1-1.png"
                                                                     target:self
                                                                   selector:@selector(upgradeMelee:)];
        //
        //            CCMenuItemImage *spartanButton = [CCMenuItemImage itemWithNormalImage:@"a6-1.png"
        //                                                                           selectedImage:@"a6-1.png"
        //                                                                                  target:self
        //                                                                                selector:@selector(upgradeSpartan:)];
        
        CCMenuItemImage *tankButton = [CCMenuItemImage itemWithNormalImage:@"a5-1.png"
                                                             selectedImage:@"a5-1.png"
                                                                    target:self
                                                                  selector:@selector(upgradeTank:)];
        
        //            CCMenuItemImage *helicopterButton = [CCMenuItemImage itemWithNormalImage:@"a4-1.png"
        //                                                                           selectedImage:@"a4-1.png"
        //                                                                                  target:self
        //                                                                                selector:@selector(upgradeHelicopter:)];
        
        //            CCMenuItemImage *immunityButton = [CCMenuItemImage itemWithNormalImage:@"immunity_btn.png"
        //                                                                       selectedImage:@"immunity_btn.png"
        //                                                                              target:self
        //                                                                            selector:@selector(upgradeImmunity:)];
        
        CCMenuItemImage *buyAirstrikeButton = [CCMenuItemImage itemWithNormalImage:@"airstrike_btn.png"         selectedImage:@"airstrike_btn.png" target:self selector:@selector(buyAirstrike:)];
        
        CCMenuItemImage *buyReinforcementButton = [CCMenuItemImage itemWithNormalImage:@"reinforcement_btn.png"        selectedImage:@"reinforcement_btn.png" target:self selector:@selector(buyReinforcement:)];
        
        CCMenuItemImage *buyImmunityButton = [CCMenuItemImage itemWithNormalImage:@"immunity_btn.png"
                                                                    selectedImage:@"immunity_btn.png"
                                                                           target:self
                                                                         selector:@selector(buyImmunity:)];
        
        
        regularShooterButton.scale = .75;
        fastShooterButton.scale = .75;
        meleeButton.scale = .75;
        tankButton.scale = .75;
        
        int farLeftX = -(winSize.width * .375);
        int centerLeftX = -(winSize.width * .125);
        int centerRightX = winSize.width * .125;
        int farRightX = winSize.width * .375;
        int topRowPriceY = winSize.height * .73;
        int topRowAngelY = winSize.height * .6;
        int topRowLevelY = winSize.height * .43;
        int bottomRowPriceY = winSize.height * .31;
        int bottomRowLogoY = winSize.height * .19;
        int bottomRowAvailableY = winSize.height * .07;
        
        meleeButton.position = CGPointMake(farLeftX , topRowAngelY);
        regularShooterButton.position = CGPointMake(centerLeftX, topRowAngelY);
        fastShooterButton.position = CGPointMake(centerRightX, topRowAngelY);
        tankButton.position = CGPointMake(farRightX, topRowAngelY - 3);
        //            spartanButton.position = CGPointMake(farLeftX, 200);
        //            helicopterButton.position = CGPointMake(centerLeftX, 200);
        //            immunityButton.position = CGPointMake(centerRightX, 200);
        buyAirstrikeButton.position = CGPointMake(farLeftX, bottomRowLogoY);
        buyReinforcementButton.position = CGPointMake(centerLeftX, bottomRowLogoY);
        buyImmunityButton.position = CGPointMake(centerRightX, bottomRowLogoY);
        mainMenuButton.position = CGPointMake(farRightX, bottomRowLogoY + winSize.height * .1);
        mainMenuButton.scale = 0.45;
        continueButton.position = CGPointMake(farRightX, bottomRowLogoY - winSize.height * .05);
        continueButton.scale = 0.45;
        
        CCMenu* storeMenu = [CCMenu menuWithItems:mainMenuButton, continueButton, regularShooterButton, fastShooterButton, meleeButton, tankButton, buyAirstrikeButton, buyReinforcementButton, buyImmunityButton, nil];

        storeMenu.position = ccp(winSize.width/2, 0);

        [self addChild:storeMenu];
        
        CCLabelTTF *shopLabel = [CCLabelTTF labelWithString:@"SHOP" fontName:@"Algerian" fontSize: 50];
        shopLabel.position = ccp(winSize.width * .5, winSize.height * .87);
        shopLabel.color = ccBLACK;
        [self addChild:shopLabel z:4];
        
        coinsLabel = [CCLabelTTF labelWithString:@"coins: " fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        coinsLabel.position = ccp(winSize.width * .8, winSize.height * .85);
        coinsLabel.color = ccBLACK;
        [self addChild:coinsLabel z:4];
        
        meleePrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [meleePrice setString:[NSString stringWithFormat:@"Price:%d", [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleePrice"] intValue]]];
        meleePrice.position = CGPointMake(winSize.width * .125, topRowPriceY);
        meleePrice.color = ccBLACK;
        [self addChild:meleePrice z:4];
        
        shooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [shooterPrice setString:[NSString stringWithFormat:@"Price:%d", [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterPrice"] intValue]]];
        shooterPrice.position = CGPointMake(winSize.width * .375, topRowPriceY);
        shooterPrice.color = ccBLACK;
        [self addChild:shooterPrice z:4];
        
        fastShooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [fastShooterPrice setString:[NSString stringWithFormat:@"Price:%d", [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterPrice"] intValue]]];
        fastShooterPrice.position = CGPointMake(winSize.width * .625, topRowPriceY);
        fastShooterPrice.color = ccBLACK;
        [self addChild:fastShooterPrice z:4];
        
        tankPrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [tankPrice setString:[NSString stringWithFormat:@"Price:%d", [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankPrice"] intValue]]];
        tankPrice.position = CGPointMake(winSize.width * .875, topRowPriceY);
        tankPrice.color = ccBLACK;
        [self addChild:tankPrice z:4];
        
        airstrikePrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [airstrikePrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].airPrice]];
        airstrikePrice.position = CGPointMake(winSize.width * .125, bottomRowPriceY);
        airstrikePrice.color = ccBLACK;
        [self addChild:airstrikePrice z:4];
        
        reinforcementsPrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [reinforcementsPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].reinforcePrice]];
        reinforcementsPrice.position = CGPointMake(winSize.width * .375, bottomRowPriceY);
        reinforcementsPrice.color = ccBLACK;
        [self addChild:reinforcementsPrice z:4];
        
        immunityPrice = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [immunityPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].immunityPrice]];
        immunityPrice.position = CGPointMake(winSize.width * .625, bottomRowPriceY);
        immunityPrice.color = ccBLACK;
        [self addChild:immunityPrice z:4];
        
        meleeRank = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [meleeRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"]]];
        meleeRank.position = CGPointMake(winSize.width * .125, topRowLevelY);
        meleeRank.color = ccBLACK;
        [self addChild:meleeRank z:4];
        
        shooterRank = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [shooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"]]];
        shooterRank.position = CGPointMake(winSize.width * .375, topRowLevelY);
        shooterRank.color = ccBLACK;
        [self addChild:shooterRank z:4];
        
        fastShooterRank = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [fastShooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"]]];
        fastShooterRank.position = CGPointMake(winSize.width * .625, topRowLevelY);
        fastShooterRank.color = ccBLACK;
        [self addChild:fastShooterRank z:4];
        
        tankRank = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [tankRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"]]];
        tankRank.position = CGPointMake(winSize.width * .875, topRowLevelY);
        tankRank.color = ccBLACK;
        [self addChild:tankRank z:4];
        
        
        immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [immunityCount setString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"]]];
        immunityCount.position = CGPointMake(winSize.width * .625, bottomRowAvailableY);
        immunityCount.color = ccBLACK;
        [self addChild:immunityCount z:4];
        
        reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"]]];
        reinforcemtsCount.position = CGPointMake(winSize.width * .375, bottomRowAvailableY);
        reinforcemtsCount.color = ccBLACK;
        [self addChild:reinforcemtsCount z:4];

        airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"BenguiatItcTEE-Book" fontSize:18];
        [airstrikeCount setString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"]]];
        airstrikeCount.position = CGPointMake(winSize.width * .125, bottomRowAvailableY);
        airstrikeCount.color = ccBLACK;
        [self addChild:airstrikeCount z:4];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    if((displayingSuccessfulUpgrade == true || displayingSuccessfulPurchase == true || displayingFailedUpgrade == true) && shopInstructionsRemoved == false)
    {
        [self removeChild:shopInstructions];
    }
    
    if(displayingFailedUpgrade == true)
    {
        if(failedUpgradeCounter == 0)
        {
            [self addChild:cantAffordThat];
        }
        failedUpgradeCounter++;
        if(failedUpgradeCounter == displayLength)
        {
            failedUpgradeCounter = 0;
            displayingFailedUpgrade = false;
            [self removeChild:cantAffordThat];
        }
    }
    if(displayingSuccessfulPurchase == true)
    {
        if(successfulPurchaseCounter == 0)
        {
            [self addChild:purchased];
        }
        successfulPurchaseCounter++;
        if(successfulPurchaseCounter == displayLength)
        {
            successfulPurchaseCounter = 0;
            displayingSuccessfulPurchase = false;
            [self removeChild:purchased];
        }
    }
    if(displayingSuccessfulUpgrade == true)
    {
        if(successfulUpgradeCounter == 0)
        {
            [self addChild:upgraded];
        }
        successfulUpgradeCounter++;
        if(successfulUpgradeCounter == displayLength)
        {
            successfulUpgradeCounter= 0;
            displayingSuccessfulUpgrade = false;
            [self removeChild:upgraded];
        }
    }
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

- (void) levelSelect: (CCMenuItemImage *) continueButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[Levelselect alloc]  init]];
}

- (void) upgradeRegularShooter: (CCMenuItemImage *) regularShooterButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"];
    int rank = [NSRank intValue];
    int price = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterPrice"] intValue];
    if(coins >= price)
    {
        [GameData sharedData].friendlyRegularShooterAvailable = true;
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyRegularShooterRank"];
        NSLog(@"friendly regular shooter rank = %@", newRank);
        NSNumber *unlocked = [NSNumber numberWithBool:true];
        [[NSUserDefaults standardUserDefaults] setObject:unlocked forKey:@"friendlyRegularShooterAvailable"];
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        price = 30 + (rank * 15);
        NSNumber* NSPrice = [NSNumber numberWithInt:price];
        [[NSUserDefaults standardUserDefaults] setObject:NSPrice forKey:@"friendlyRegularShooterPrice"];
        [shooterPrice setString:[NSString stringWithFormat:@"Price:%d", price]];
        [shooterRank setString:[NSString stringWithFormat:@"Lvl:%d/5", rank]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulUpgrade];

    }
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }

}

- (void) upgradeMelee: (CCMenuItemImage *) meleeButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"];
    int rank = [NSRank intValue];
    int price = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleePrice"] intValue];
    if(coins >= price)
    {
        [GameData sharedData].friendlyMeleeAvailable = true;
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyMeleeRank"];
        NSLog(@"friendly melee rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        price = (rank + 1) * 10;
        NSNumber* NSPrice = [NSNumber numberWithInt:price];
        [[NSUserDefaults standardUserDefaults] setObject:NSPrice forKey:@"friendlyMeleePrice"];
        [meleePrice setString:[NSString stringWithFormat:@"Price:%d", price]];
        [meleeRank setString:[NSString stringWithFormat:@"Lvl:%d/5", rank]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulUpgrade];
    }
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }
}

- (void) upgradeFastShooter: (CCMenuItemImage *) fastShooterButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
    int rank = [NSRank intValue];
    int price = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterPrice"] intValue];
    if(coins >= price)
    {
        [GameData sharedData].friendlyFastShooterAvailable = true;
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyFastShooterRank"];
        NSLog(@"friendly fast shooter rank = %@", newRank);
        NSNumber *unlocked = [NSNumber numberWithBool:true];
        [[NSUserDefaults standardUserDefaults] setObject:unlocked forKey:@"friendlyFastShooterAvailable"];
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        price = 60 + (rank * 30);
        NSNumber* NSPrice = [NSNumber numberWithInt:price];
        [[NSUserDefaults standardUserDefaults] setObject:NSPrice forKey:@"friendlyFastShooterPrice"];
        [fastShooterPrice setString:[NSString stringWithFormat:@"Price:%d", price]];
        [fastShooterRank setString:[NSString stringWithFormat:@"Lvl:%d/5", rank]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulUpgrade];
    }
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }
}

//-(void) upgradeSpartan: (CCMenuItemImage *) spartanButton
//{
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//
//    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"spartanRank"];
//    int rank = [NSRank intValue];
//    int price = [GameData sharedData].reinforcePrice;
//    if(coins > price)
//    {
//        rank++;
//        NSNumber *newRank = [NSNumber numberWithInt:rank];
//        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"spartanRank"];
//        NSLog(@"friendly spartan rank = %@", newRank);
//        coins -= price;
//        NSCoins = [NSNumber numberWithInt:coins];
//        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
//        NSLog(@"coins = %@", NSCoins);
//        
//    }
//    else
//    {
//        NSLog(@"can't afford that!");
//    }
//}
//
//-(void) upgradeHelicopter: (CCMenuItemImage *) helicopterButton
//{
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//
//    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyHelicopterRank"];
//    int rank = [NSRank intValue];
//    int price = [GameData sharedData].airPrice;
//    if(coins > price)
//    {
//        rank++;
//        NSNumber *newRank = [NSNumber numberWithInt:rank];
//        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyHelicopterRank"];
//        NSLog(@"friendly helicopter rank = %@", newRank);
//        coins -= price;
//        NSCoins = [NSNumber numberWithInt:coins];
//        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
//        NSLog(@"coins = %@", NSCoins);
//    }
//    else
//    {
//        NSLog(@"can't afford that!");
//    }
//}

-(void) upgradeTank: (CCMenuItemImage *) tankButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
    int rank = [NSRank intValue];
    int price = [[[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankPrice"] intValue];
    if(coins >= price)
    {
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyTankRank"];
        NSLog(@"friendly tank rank = %@", newRank);
        NSNumber *unlocked = [NSNumber numberWithBool:true];
        [[NSUserDefaults standardUserDefaults] setObject:unlocked forKey:@"friendlyTankAvailable"];
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        price = (rank * 50) + 100;
        NSNumber* NSPrice = [NSNumber numberWithInt:price];
        [[NSUserDefaults standardUserDefaults] setObject:NSPrice forKey:@"friendlyTankPrice"];
        [tankPrice setString:[NSString stringWithFormat:@"Price:%d", price]];
        [tankRank setString:[NSString stringWithFormat:@"Lvl:%d/5", rank]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulUpgrade];
    }
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }
}

//-(void) upgradeImmunity: (CCMenuItemImage *) immunityButton
//{
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//
//    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityRank"];
//    int rank = [NSRank intValue];
//    int price = [GameData sharedData].immunityPrice;
//    if(coins > price)
//    {
//        rank++;
//        NSNumber *newRank = [NSNumber numberWithInt:rank];
//        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"immunityRank"];
//        NSLog(@"immunity rank = %@", newRank);
//        coins -= price;
//        NSCoins = [NSNumber numberWithInt:coins];
//        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
//        NSLog(@"coins = %@", NSCoins);
//    }
//    else
//    {
//        NSLog(@"can't afford that!");
//    }
//}

-(void) buyImmunity: (CCMenuItemImage *) buyImmunityButton
{
    int immunityPrice = [GameData sharedData].immunityPrice;
    
    if(coins >= immunityPrice)
    {
        NSNumber *NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityAvailable"];
        
        int numAvailable = [NSNumAvailable intValue];
        numAvailable++;
        NSNumber *newNumAvailable = [NSNumber numberWithInt:numAvailable];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable forKey: @"immunityAvailable"];
        NSLog(@"immunity available = %@", newNumAvailable);
        coins -= immunityPrice;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        [immunityCount setString:[NSString stringWithFormat:@"%@", newNumAvailable]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulPurchase];
    }
    
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }

}

-(void) buyAirstrike: (CCMenuItemImage *) buyAirstrikeButton
{
    int airstrikePrice = [GameData sharedData].airPrice;
    
    if(coins >= airstrikePrice)
    {
        NSNumber *NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"airstrikesAvailable"];
        
        int numAvailable = [NSNumAvailable intValue];
        numAvailable++;
        NSNumber *newNumAvailable = [NSNumber numberWithInt:numAvailable];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable forKey: @"airstrikesAvailable"];
        coins -= airstrikePrice;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"airstrike available = %@", newNumAvailable);
        NSLog(@"coins = %@", NSCoins);
        
        [airstrikeCount setString:[NSString stringWithFormat:@"%@", newNumAvailable]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulPurchase];
    }
    
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }
}

-(void) buyReinforcement: (CCMenuItemImage *) buyReinforcementButton
{
    int reinforcementPrice = [GameData sharedData].reinforcePrice;
    
    if(coins >= reinforcementPrice)
    {
        NSNumber *NSNumAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:@"reinforcementsAvailable"];
        
        int numAvailable = [NSNumAvailable intValue];
        numAvailable++;
        NSNumber *newNumAvailable = [NSNumber numberWithInt:numAvailable];
        [[NSUserDefaults standardUserDefaults] setObject:newNumAvailable forKey: @"reinforcementsAvailable"];
        coins -= reinforcementPrice;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"reinforcement available = %@", newNumAvailable);
        NSLog(@"coins = %@", NSCoins);
        
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%@", newNumAvailable]];
        [coinsLabel setString:[NSString stringWithFormat:@"coins:%d", coins]];
        
        [self successfulPurchase];
    }
    
    else
    {
        NSLog(@"can't afford that!");
        [self failedUpgrade];
    }
}

-(void) successfulUpgrade
{
    if(displayingSuccessfulUpgrade == false)
    {
        displayingSuccessfulUpgrade = true;
    }
    if(displayingSuccessfulPurchase == true)
    {
        displayingSuccessfulPurchase = false;
        successfulPurchaseCounter = 0;
        [self removeChild:purchased];
    }
    if(displayingFailedUpgrade == true)
    {
        displayingFailedUpgrade = false;
        failedUpgradeCounter = 0;
        [self removeChild:cantAffordThat];
    }
}

-(void) successfulPurchase
{
    if(displayingSuccessfulPurchase == false)
    {
        displayingSuccessfulPurchase = true;
    }
    if(displayingFailedUpgrade == true)
    {
        displayingFailedUpgrade = false;
        failedUpgradeCounter = 0;
        [self removeChild:cantAffordThat];
    }
    if(displayingSuccessfulUpgrade == true)
    {
        displayingSuccessfulUpgrade = false;
        successfulUpgradeCounter = 0;
        [self removeChild:upgraded];
    }
}

-(void) failedUpgrade
{
    if(displayingFailedUpgrade == false)
    {
        displayingFailedUpgrade = true;
    }
    if(displayingSuccessfulPurchase == true)
    {
        displayingSuccessfulPurchase = false;
        successfulPurchaseCounter = 0;
        [self removeChild:purchased];
    }
    if(displayingSuccessfulUpgrade == true)
    {
        displayingSuccessfulUpgrade = false;
        successfulUpgradeCounter = 0;
        [self removeChild:upgraded];
    }
}


@end
