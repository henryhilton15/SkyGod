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
        
        CCSprite *photo = [CCSprite spriteWithFile:@"block.png"];
        photo.position = ccp(winSize.width * .25, winSize.height/2);
        [self addChild:photo];
        
        CCLabelTTF* henryBio = [CCLabelTTF labelWithString:@"Henry..." fontName:@"BenguiatItcTEE-Book" fontSize:12];
        henryBio.position = ccp(winSize.width * .75, winSize.height * .25);
        [self addChild:henryBio];
        
        CCLabelTTF* dannyBio = [CCLabelTTF labelWithString:@"Danny..." fontName:@"BenguiatItcTEE-Book" fontSize:12];
        dannyBio.position = ccp(winSize.width * .75, winSize.height * .75);
        [self addChild:dannyBio];
        
        
        

    }
    return self;
}

@end
