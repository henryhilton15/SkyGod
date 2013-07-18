//
//  Store.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/17/13.
//
//

#import "Store.h"

@implementation Store
 -(id)init
{
    
if ((self = [super init]))
        {
            CCMenuItemImage *BuyButton1 = [CCMenuItemImage itemWithNormalImage:@"upgrades-button.png" selectedImage:@"upgrades-button.png"];
            BuyButton1.position= CGPointMake (100, 300);
            BuyButton1.scale = 0.1f;
            [self addChild:BuyButton1 z:50];
            BuyButton1.color = ccBLUE;
            
            
            
            //CCMenu *myMenu = [CCMenu menuWithItems:BuyButton, nil];
            //[self addChild:myMenu];
            
            CCSprite *background = [CCSprite spriteWithFile:@"background_grass-top.png"];
            background.position = CGPointMake(240,160);
            [self addChild:background z:-1];
            
            StoreLabel = [CCLabelTTF labelWithString:@"Store" fontName:@"Marker Felt" fontSize:40];
            StoreLabel.position = ccp(240,240);
            StoreLabel.color = ccBLUE;
            [self addChild:StoreLabel z:4];

                                          
                        
            
            

                }
            
            
    return self;
            
        }
@end
