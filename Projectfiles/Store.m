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

@implementation Store
-(id)init
{

    if ((self = [super init]))
    {
        
        if (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"music"] boolValue] == true)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Undaunted.wav"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Undaunted.wav" loop:YES];
            }
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"] == NULL) {
            
            NSNumber *set0 = [NSNumber numberWithInt:0];
            [[NSUserDefaults standardUserDefaults] setObject:set0 forKey: @"friendlyMeleeRank"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"] == NULL) {
            
            NSNumber *set0 = [NSNumber numberWithInt:0];
            [[NSUserDefaults standardUserDefaults] setObject:set0 forKey: @"friendlyRegularShooterRank"];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"] == NULL) {
            
            NSNumber *set0 = [NSNumber numberWithInt:0];
            [[NSUserDefaults standardUserDefaults] setObject:set0 forKey: @"friendlyFastShooterRank"];
        }
        
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"] == NULL) {
            
            NSNumber *set0 = [NSNumber numberWithInt:0];
            [[NSUserDefaults standardUserDefaults] setObject:set0 forKey: @"friendlyTankRank"];
        }
        
        NSNumber *NSRank1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"];
        int rank1 = [NSRank1 intValue];
        
            [GameData sharedData].meleePrice = (rank1 + 1) * 50;
        
        NSNumber *NSRank2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"];
        int rank2 = [NSRank2 intValue];
        
            [GameData sharedData].shootPrice = (rank2 + 1) * 50;
        
        NSNumber *NSRank3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
        int rank3 = [NSRank3 intValue];
        
            [GameData sharedData].fastShootPrice = (rank3 + 1) * 50;
        
        NSNumber *NSRank4 = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
        int rank4 = [NSRank4 intValue];
 
            [GameData sharedData].tankPrice = (rank4 + 1) * 50;
   
            [GameData sharedData].airPrice = 50;
   
            [GameData sharedData].reinforcePrice = 50;
   
            [GameData sharedData].immunityPrice = 50;
        
        
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCMenuItemImage *BuyButton1 = [CCMenuItemImage itemWithNormalImage:@"upgrades-button.png" selectedImage:@"upgrades-button.png"];
        BuyButton1.position= CGPointMake (100, 300);
        BuyButton1.scale = 0.1f;
        [self addChild:BuyButton1 z:50];
        BuyButton1.color = ccBLUE;
        
        NSCoins = [[NSUserDefaults standardUserDefaults] objectForKey:@"coins"];
        coins = [NSCoins intValue];
        
        //CCMenu *myMenu = [CCMenu menuWithItems:BuyButton, nil];
        //[self addChild:myMenu];
        
        CCSprite *background = [CCSprite spriteWithFile:@"sky.png"];
        background.position = CGPointMake(240,160);
        [self addChild:background z:-1];
        
        //            StoreLabel = [CCLabelTTF labelWithString:@"Store" fontName:@"Marker Felt" fontSize:40];
        //            StoreLabel.position = ccp(240,240);
        //            StoreLabel.color = ccBLUE;
        //            [self addChild:StoreLabel z:4];
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"main menu-button-n.png"
                                                                 selectedImage: @"main menu-button-d.png"
                                                                        target:self
                                                                      selector:@selector(mainMenu:)];
        
        
        
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
        
        
        int farLeftX = -(winSize.width * .375);
        int centerLeftX = -(winSize.width * .125);
        int centerRightX = winSize.width * .125;
        int farRightX = winSize.width * .375;
        meleeButton.position = CGPointMake(farLeftX ,320);
        regularShooterButton.position = CGPointMake(centerLeftX, 320);
        fastShooterButton.position = CGPointMake(centerRightX,320);
        tankButton.position = CGPointMake(farRightX,320);
        //            spartanButton.position = CGPointMake(farLeftX, 200);
        //            helicopterButton.position = CGPointMake(centerLeftX, 200);
        //            immunityButton.position = CGPointMake(centerRightX, 200);
        buyAirstrikeButton.position = CGPointMake(farLeftX, 160);
        buyReinforcementButton.position = CGPointMake(centerLeftX, 160);
        buyImmunityButton.position = CGPointMake(centerRightX, 160);
        mainMenuButton.position = CGPointMake(farRightX, 160);
        mainMenuButton.scale = 0.5;
        
        CCMenu* storeMenu = [CCMenu menuWithItems:mainMenuButton, regularShooterButton, fastShooterButton, meleeButton, tankButton, buyAirstrikeButton, buyReinforcementButton, buyImmunityButton, nil];
        [self addChild:storeMenu];
        
        meleePrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [meleePrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].meleePrice]];
        meleePrice.position = CGPointMake(winSize.width * .125, 290);
        meleePrice.color = ccBLACK;
        [self addChild:meleePrice z:4];
        
        shooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [shooterPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].shootPrice]];
        shooterPrice.position = CGPointMake(winSize.width * .375, 290);
        shooterPrice.color = ccBLACK;
        [self addChild:shooterPrice z:4];
        
        fastShooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [fastShooterPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].fastShootPrice]];
        fastShooterPrice.position = CGPointMake(winSize.width * .625, 290);
        fastShooterPrice.color = ccBLACK;
        [self addChild:fastShooterPrice z:4];
        
        tankPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [tankPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].tankPrice]];
        tankPrice.position = CGPointMake(winSize.width * .875, 290);
        tankPrice.color = ccBLACK;
        [self addChild:tankPrice z:4];
        
        airstrikePrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [airstrikePrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].airPrice]];
        airstrikePrice.position = CGPointMake(winSize.width * .125, 120);
        airstrikePrice.color = ccBLACK;
        [self addChild:airstrikePrice z:4];
        
        reinforcementsPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [reinforcementsPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].reinforcePrice]];
        reinforcementsPrice.position = CGPointMake(winSize.width * .375, 120);
        reinforcementsPrice.color = ccBLACK;
        [self addChild:reinforcementsPrice z:4];
        
        immunityPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [immunityPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].immunityPrice]];
        immunityPrice.position = CGPointMake(winSize.width * .625, 120);
        immunityPrice.color = ccBLACK;
        [self addChild:immunityPrice z:4];
        
        meleeRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [meleeRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"]]];
        meleeRank.position = CGPointMake(winSize.width * .125, 170);
        meleeRank.color = ccBLACK;
        [self addChild:meleeRank z:4];
        
        shooterRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [shooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"]]];
        shooterRank.position = CGPointMake(winSize.width * .375, 170);
        shooterRank.color = ccBLACK;
        [self addChild:shooterRank z:4];
        
        fastShooterRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [fastShooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"]]];
        fastShooterRank.position = CGPointMake(winSize.width * .625, 170);
        fastShooterRank.color = ccBLACK;
        [self addChild:fastShooterRank z:4];
        
        tankRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [tankRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"]]];
        tankRank.position = CGPointMake(winSize.width * .875, 170);
        tankRank.color = ccBLACK;
        [self addChild:tankRank z:4];
        
        
        if ([GameData sharedData].immunityCount == 0)
        {
            immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
            [immunityCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].immunityCount]];
            immunityCount.position = CGPointMake(winSize.width * .625, 40);
            immunityCount.color = ccBLACK;
            [self addChild:immunityCount z:4];
        }

        if ([GameData sharedData].reinforcementsCount == 0)
        {
            reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
            [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].reinforcementsCount]];
            reinforcemtsCount.position = CGPointMake(winSize.width * .375, 40);
            reinforcemtsCount.color = ccBLACK;
            [self addChild:reinforcemtsCount z:4];
        }

        if ([GameData sharedData].airstrikeCount == 0)
        {
            airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
            [airstrikeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].airstrikeCount]];
            airstrikeCount.position = CGPointMake(winSize.width * .125, 40);
            airstrikeCount.color = ccBLACK;
            [self addChild:airstrikeCount z:4];
        }

    }
    return self;
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

- (void) upgradeRegularShooter: (CCMenuItemImage *) regularShooterButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].shootPrice;
    if(coins > price)
    {
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
        
        [GameData sharedData].shootPrice = rank * 50 + 50;
        
        [self removeChild:shooterPrice];
        
        shooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [shooterPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].shootPrice]];
        shooterPrice.position = CGPointMake(winSize.width * .375, 290);
        shooterPrice.color = ccBLACK;
        [self addChild:shooterPrice z:4];
        
        [self removeChild:shooterRank];
        
        shooterRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [shooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"]]];
        shooterRank.position = CGPointMake(winSize.width * .375, 170);
        shooterRank.color = ccBLACK;
        [self addChild:shooterRank z:4];

    }
    else
    {
        NSLog(@"can't afford that!");
    }

}

- (void) upgradeMelee: (CCMenuItemImage *) meleeButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].meleePrice;
    if(coins > price)
    {
 
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyMeleeRank"];
        NSLog(@"friendly melee rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        [GameData sharedData].meleePrice = rank * 50 + 50;
        
        [self removeChild:meleePrice];
        
        meleePrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [meleePrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].meleePrice]];
        meleePrice.position = CGPointMake(winSize.width * .125, 290);
        meleePrice.color = ccBLACK;
        [self addChild:meleePrice z:4];

        
        [self removeChild:meleeRank];

        meleeRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [meleeRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"]]];
        meleeRank.position = CGPointMake(winSize.width * .125, 170);
        meleeRank.color = ccBLACK;
        [self addChild:meleeRank z:4];

    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

- (void) upgradeFastShooter: (CCMenuItemImage *) fastShooterButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].fastShootPrice;
    if(coins > price)
    {
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
        
        [GameData sharedData].fastShootPrice = rank * 50 + 50;
        
        [self removeChild:fastShooterPrice];
        
        fastShooterPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [fastShooterPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].fastShootPrice]];
        fastShooterPrice.position = CGPointMake(winSize.width * .625, 290);
        fastShooterPrice.color = ccBLACK;
        [self addChild:fastShooterPrice z:4];
        
        [self removeChild:fastShooterRank];
        
        fastShooterRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [fastShooterRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"]]];
        fastShooterRank.position = CGPointMake(winSize.width * .625, 170);
        fastShooterRank.color = ccBLACK;
        [self addChild:fastShooterRank z:4];
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeSpartan: (CCMenuItemImage *) spartanButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"spartanRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].reinforcePrice;
    if(coins > price)
    {
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"spartanRank"];
        NSLog(@"friendly spartan rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeHelicopter: (CCMenuItemImage *) helicopterButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyHelicopterRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].airPrice;
    if(coins > price)
    {
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyHelicopterRank"];
        NSLog(@"friendly helicopter rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeTank: (CCMenuItemImage *) tankButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].tankPrice;
    if(coins > price)
    {
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"friendlyTankRank"];
        NSLog(@"friendly tank rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
        
        [GameData sharedData].tankPrice = rank * 50 + 50;
        
        [self removeChild:tankPrice];
        
        tankPrice = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [tankPrice setString:[NSString stringWithFormat:@"Price:%d", [GameData sharedData].tankPrice]];
        tankPrice.position = CGPointMake(winSize.width * .875, 290);
        tankPrice.color = ccBLACK;
        [self addChild:tankPrice z:4];
        
        [self removeChild:tankRank];
        
        tankRank = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [tankRank setString:[NSString stringWithFormat:@"Lvl:%@/5", [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"]]];
        tankRank.position = CGPointMake(winSize.width * .875, 170);
        tankRank.color = ccBLACK;
        [self addChild:tankRank z:4];
        
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeImmunity: (CCMenuItemImage *) immunityButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityRank"];
    int rank = [NSRank intValue];
    int price = [GameData sharedData].immunityPrice;
    if(coins > price)
    {
        rank++;
        NSNumber *newRank = [NSNumber numberWithInt:rank];
        [[NSUserDefaults standardUserDefaults] setObject:newRank forKey: @"immunityRank"];
        NSLog(@"immunity rank = %@", newRank);
        coins -= price;
        NSCoins = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setObject:NSCoins forKey:@"coins"];
        NSLog(@"coins = %@", NSCoins);
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}
-(void) buyImmunity: (CCMenuItemImage *) buyImmunityButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    int immunityPrice = [GameData sharedData].immunityPrice;
    
    if(coins > immunityPrice)
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
        
        [self removeChild:immunityCount];
        [GameData sharedData].immunityCount++;
        immunityCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [immunityCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].immunityCount]];
        immunityCount.position = CGPointMake(winSize.width * .625, 40);
        immunityCount.color = ccBLACK;
        [self addChild:immunityCount z:4];
        
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }

}

-(void) buyAirstrike: (CCMenuItemImage *) buyAirstrikeButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    int airstrikePrice = [GameData sharedData].airPrice;
    
    if(coins > airstrikePrice)
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
        
        [self removeChild:airstrikeCount];
        [GameData sharedData].airstrikeCount++;
        airstrikeCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [airstrikeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].airstrikeCount]];
        airstrikeCount.position = CGPointMake(winSize.width * .125, 40);
        airstrikeCount.color = ccBLACK;
        [self addChild:airstrikeCount z:4];
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) buyReinforcement: (CCMenuItemImage *) buyReinforcementButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;

    int reinforcementPrice = [GameData sharedData].reinforcePrice;
    
    if(coins > reinforcementPrice)
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
        
        [self removeChild:reinforcemtsCount];
        [GameData sharedData].reinforcementsCount++;
        reinforcemtsCount = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
        [reinforcemtsCount setString:[NSString stringWithFormat:@"%d", [GameData sharedData].reinforcementsCount]];
        reinforcemtsCount.position = CGPointMake(winSize.width * .375, 40);
        reinforcemtsCount.color = ccBLACK;
        [self addChild:reinforcemtsCount z:4];
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }
}



@end
