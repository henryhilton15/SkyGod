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
    NSNumber *newGoodGuyRank;
}

-(id) init;
-(void) mainMenu;
-(void) upgradeGoodGuy;
@end
