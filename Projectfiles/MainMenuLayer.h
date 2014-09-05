//
//  MainMenuLayer.h
//  Gorilla
//
//  Created by maria hilton on 7/5/13.
//
//

#import "CCLayer.h"

@interface MainMenuLayer : CCLayer
{
    CCLabelTTF *TitleLabel;
    CCMenu *myMenu;
    CGSize winSize;
}

-(id) init;
-(void) startGame;
-(void) enterStore;
-(void) selectLevel;
-(void) update:(ccTime)delta;
@end
