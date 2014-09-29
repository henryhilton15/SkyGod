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

-(void) level1: (CCMenuItem *)menuItem;
-(void) level2: (CCMenuItem *)menuItem;
-(void) level3: (CCMenuItem *)menuItem;
-(void) level4: (CCMenuItem *)menuItem;
-(void) level5: (CCMenuItem *)menuItem;
-(void) level6: (CCMenuItem *)menuItem;
-(void) level7: (CCMenuItem *)menuItem;
-(void) level8: (CCMenuItem *)menuItem;
-(void) level9: (CCMenuItem *)menuItem;
-(void) level10: (CCMenuItem *)menuItem;
-(void) level11: (CCMenuItem *)menuItem;
-(void) level12: (CCMenuItem *)menuItem;
-(void) level13: (CCMenuItem *)menuItem;
-(void) level14: (CCMenuItem *)menuItem;
-(void) level15: (CCMenuItem *)menuItem;
-(void) level16: (CCMenuItem *)menuItem;
-(void) level17: (CCMenuItem *)menuItem;
-(void) level18: (CCMenuItem *)menuItem;
-(void) level19: (CCMenuItem *)menuItem;
-(void) level20: (CCMenuItem *)menuItem;
-(void) level21: (CCMenuItem *)menuItem;
-(void) level22: (CCMenuItem *)menuItem;
-(void) level23: (CCMenuItem *)menuItem;
-(void) level24: (CCMenuItem *)menuItem;
-(void) level25: (CCMenuItem *)menuItem;
-(void) level26: (CCMenuItem *)menuItem;
-(void) level27: (CCMenuItem *)menuItem;
-(void) level28: (CCMenuItem *)menuItem;
-(void) level29: (CCMenuItem *)menuItem;
-(void) level30: (CCMenuItem *)menuItem;
-(void) mainMenu: (CCMenuItemImage *) mainMenuButton;


@end
