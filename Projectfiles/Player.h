//
//  Player.h
//  Gorilla Game
//
//  Created by Ajay Shah on 8/14/13.
//
//

#import "CCSprite.h"

@interface Player : CCSprite
{
}
@property (nonatomic, assign) CGPoint velocity;
-(id)initWithPlayerPicture;

@end
