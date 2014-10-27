//
//  AboutLayer.m
//  SkyGod
//
//  Created by maria hilton on 10/27/14.
//
//

#import "AboutLayer.h"

@implementation AboutLayer

-(id) init
{
	if ((self = [super init]))
	{
        winSize = [CCDirector sharedDirector].winSize;

        CCSprite *background = [CCSprite spriteWithFile:@"sky-ip5.png"];
        background.position = CGPointMake(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];

    }
    return self;
}

@end
