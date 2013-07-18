//
//  BigMonster.m
//  Gorilla Game
//
//  Created by Danny Laporte on 7/18/13.
//
//

#import "Character.h"

@implementation Character

@synthesize health;
@synthesize worth;

-(id) initWithBigMonsterImage
{
    if((self = [super initWithFile:@"monster9.png"]))
    {
        health = 10;
        worth = 100;
    }
    return self;
}

-(id) initWithBigGoodGuyImage
{
    if((self = [super initWithFile:@"chest.png"]))
    {
        health = 3;
        worth = 100;
    }
    return self;
}
-(id) initWithGoodGuyImage
{
    if((self = [super initWithFile:@"cat4.png"]))
    {
        worth = 50;
    }
    return self;
}

-(id) initWithBadGuyImage
{
    if((self = [super initWithFile:@"monster1.png"]))
    {
        worth = 50;
    }
    return self;
}
-(id) initWithZigZagImage
{
    if((self = [super initWithFile:@"monster4.png"]))
    {
        worth = 50;
    }
    return self;
}
-(id) initWithGoodHelicopterImage
{
    if((self = [super initWithFile:@"planet.png"]))
    {
        health = 5;
    }
    return self;
}
-(id) initWithBadHelicopterImage
{
    if((self = [super initWithFile:@"barrell.png"]))
    {
        health = 5;
    }
    return self;
}
-(id) initWithGoodHelicopterBombImage
{
    if((self = [super initWithFile:@"basicbarrell.png"]))
    {
        worth = 50;
    }
    return self;
}
-(id) initWithBadHelicopterBombImage
{
    if((self = [super initWithFile:@"block.png"]))
    {
        worth = 50;
    }
    return self;
}

@end
