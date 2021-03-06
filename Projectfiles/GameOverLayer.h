//
//  GameOverLayer.h
//  Gorilla
//
//  Created by maria hilton on 7/5/13.
//
//

#import "CCLayer.h"

@interface GameOverLayer : CCLayer
{
    CCLabelTTF *GameOverLabel;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *newHighScoreLabel;
    CGSize winSize;
}

-(id) init;
-(void)restartGame: (CCMenuItem *)menuItem;
-(void)endGame:(CCMenuItem *)menuItem;

@end
