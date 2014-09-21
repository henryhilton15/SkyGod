//
//  Levelselect.h
//  Gorilla Game
//
//  Created by Ajay Shah on 11/3/13.
//
//

#import "CCLayer.h"

@interface Levelselect : CCLayer
{
    NSNumber *NSHighestLevelUnlocked;
    int highestLevelUnlocked;
    CGSize winSize;
}
-(void) setUpMenus;
-(void) level1;
-(void) level2;

@end
