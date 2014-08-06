//
//  GameData.m
//  Gorilla Game
//
//  Created by Ajay Shah on 8/2/13.
//
//

#import "GameData.h"
#import "SimpleAudioEngine.h"

@implementation GameData

@synthesize score;
@synthesize sfx;
@synthesize musicPlaying;
@synthesize currentLevelSelected;
@synthesize friendlyMeleeAvailable;
@synthesize friendlyRegularShooterAvailable;
@synthesize friendlyFastShooterAvailable;
@synthesize meleePrice;
@synthesize shootPrice;
@synthesize fastShootPrice;
@synthesize tankPrice;
@synthesize airPrice;
@synthesize reinforcePrice;
@synthesize immunityPrice;
@synthesize airstrikeCount;
@synthesize reinforcementsCount;
@synthesize immunityCount;



//static variable - this stores our singleton instance
static GameData *sharedData = nil;

+(GameData*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[GameData alloc] init];
        
        NSNumber* goodGuyRank = 0;

    
        
        //collections (Sets, Dictionaries, Arrays) must be initialized
        //Note: our class does not contain properties, only the instance does
        //self.arrayOfDataToBeStored is invalid
        
        //sharedData.arrayOfDataToBeStored = [[NSMutableArray alloc] init];
        
        sharedData.currentLevelSelected = 1;
        
        
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

@end