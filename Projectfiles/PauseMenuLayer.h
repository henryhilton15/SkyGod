//
//  PauseMenuLayer.h
//  Gorilla Game
//
//  Created by Ajay Shah on 7/11/13.
//
//

#import "CCLayer.h"

@interface PauseMenuLayer : CCLayer
{
    CCLabelTTF *PauseLabel;
}
- (id) init;
- (void) resumeGame;
- (void) restartGame;
- (void) mainMenu;

@end
