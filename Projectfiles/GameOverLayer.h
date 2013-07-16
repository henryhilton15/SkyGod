//
//  GameOverLayer.h
//  Gorilla Game
//
//  Created by Ajay Shah on 7/3/13. 
//
//

#import "CCLayer.h"

@interface GameOverLayer : CCLayer
{CCLabelTTF *GameOverLabel;
}
-(id) init;
-(void) restartGame:(CCMenuItem *)menuItem;
-(void) endGame:(CCMenuItem *)menuItem;
-(void) GameOver;
@end
