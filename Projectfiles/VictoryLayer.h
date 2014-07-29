//
//  VictoryLayer.h
//  Gorilla Game
//
//  Created by Danny Laporte on 7/11/14.
//
//

#import "CCLayer.h"

@interface VictoryLayer : CCLayer
{
    CGSize winSize;
}

-(id) init;
-(void) nextLevel;
-(void) shop;
-(void) levelSelect;

@end
