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
@property (nonatomic) int currentLevelSelected;
@property (nonatomic) BOOL friendlyRegularShooterAvailable;
@property BOOL friendlyMeleeAvailable;
@property (nonatomic) BOOL friendlyFastShooterAvailable;






//Static (class) method:
+(GameData*) sharedData;
@end



