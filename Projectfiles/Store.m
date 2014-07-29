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
        buyAirstrikeButton.position = CGPointMake(farLeftX, 200);
        buyReinforcementButton.position = CGPointMake(centerLeftX, 200);
        buyImmunityButton.position = CGPointMake(centerRightX, 200);
        mainMenuButton.position = CGPointMake(farRightX, 200);
        mainMenuButton.scale = 0.5;
        
        CCMenu* storeMenu = [CCMenu menuWithItems:mainMenuButton, regularShooterButton, fastShooterButton, meleeButton, tankButton, buyAirstrikeButton, buyReinforcementButton, buyImmunityButton, nil];
        [self addChild:storeMenu];
    }
    return self;
}

- (void) mainMenu: (CCMenuItemImage *) mainMenuButton
{
    [[CCDirector sharedDirector] replaceScene: (CCScene *)[[MainMenuLayer alloc]  init]];
}

- (void) upgradeRegularShooter: (CCMenuItemImage *) regularShooterButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyRegularShooterRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

- (void) upgradeMelee: (CCMenuItemImage *) meleeButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyMeleeRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

- (void) upgradeFastShooter: (CCMenuItemImage *) fastShooterButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyFastShooterRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeSpartan: (CCMenuItemImage *) spartanButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"spartanRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyHelicopterRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"friendlyTankRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    }
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) upgradeImmunity: (CCMenuItemImage *) immunityButton
{
    NSNumber *NSRank = [[NSUserDefaults standardUserDefaults] objectForKey:@"immunityRank"];
    int rank = [NSRank intValue];
    int price = 50 + (50 * rank);
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
    int immunityPrice = 50;
    
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
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }

}

-(void) buyAirstrike: (CCMenuItemImage *) buyAirstrikeButton
{
    int airstrikePrice = 50;
    
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
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }
}

-(void) buyReinforcement: (CCMenuItemImage *) buyReinforcementButton
{
    int reinforcementPrice = 50;
    
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
    }
    
    else
    {
        NSLog(@"can't afford that!");
    }
}



@end
