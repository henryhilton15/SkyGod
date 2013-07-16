//
//  doubleEnemy.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/12/13.
//
//

#import "doubleEnemy.h"

@implementation doubleEnemy

@synthesize health;

-(id) initWithDoubleEnemyImage
{
    if ((self = [super initWithFile:@"monster1.png"]))
    {
        health = 2;
    }
    return self;
}

@end
