//
//  Player.m
//  Gorilla Game
//
//  Created by Ajay Shah on 8/14/13.
//
//

#import "Player.h"

@implementation Player
@synthesize velocity;

- (id)initWithPlayerPicture {
    self = [super initWithFile:@"animation_knight-1.png"];
    
    if (self)
    {
        // knight is initally not moving
        self.velocity = ccp(0,0);
    }
    return  self;
}

@end
