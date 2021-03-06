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
    bool sfx;
    bool music;
    CCSprite *sfxNo;
    CCSprite *musicNo;
    int sfxRedXWidth;
    int musicRedXWidth;
    int redXHeight;
    
    CGSize winSize;
}
- (id) init;
- (void) resumeGame;
- (void) restartGame;
- (void) mainMenu;
-(void) update;
- (void) sfxToggle;
- (void) musicToggle;

@end
