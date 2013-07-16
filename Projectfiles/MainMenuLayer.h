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
}

-(id) init;
-(void) startGame;

@end
