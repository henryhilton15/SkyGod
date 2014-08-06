//
//  GameData.h
//  Gorilla Game
//
//  Created by Ajay Shah on 8/2/13.
//
//

#import <Foundation/Foundation.h>

//an NSObject is the most basic Objective-C object
//We subclass it since our singleton is nothing more than a wrapper around several properties
@interface GameData : NSObject

//the keyword "nonatomic" is a property declaration
//nonatomic properties have better performance than atomic properties (so use them!)

@property (nonatomic) int score;
@property int rank;
@property (nonatomic) BOOL sfx;
@property (nonatomic) BOOL musicPlaying;
@property (nonatomic) int currentLevelSelected;
@property (nonatomic) BOOL friendlyRegularShooterAvailable;
@property (nonatomic) BOOL friendlyMeleeAvailable;
@property (nonatomic) BOOL friendlyFastShooterAvailable;
@property (nonatomic) int meleePrice;
@property (nonatomic) int shootPrice;
@property (nonatomic) int fastShootPrice;
@property (nonatomic) int tankPrice;
@property (nonatomic) int airPrice;
@property (nonatomic) int reinforcePrice;
@property (nonatomic) int immunityPrice;
@property (nonatomic) int meleeLevel;
@property (nonatomic) int shootLevel;
@property (nonatomic) int fastShootLevel;
@property (nonatomic) int tankLevel;




//Static (class) method:
+(GameData*) sharedData;
@end



