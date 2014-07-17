//
//  PauseMenuLayer.h
//  Gorilla
//
//  Created by maria hilton on 7/4/13.
//
//

#import "CCLayer.h"

@interface PauseMenuLayer : CCLayer
{
    CCLabelTTF *PauseLabel;
    CGSize winSize;
}
- (id) init;
- (void) resumeGame;
- (void) restartGame;
- (void) mainMenu;
- (void) sfxToggle;
- (void) musicToggle;

@end
