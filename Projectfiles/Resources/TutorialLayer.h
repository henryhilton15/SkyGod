//
//  TutorialLayer.h
//  SkyGod
//
//  Created by Danny Laporte on 10/5/14.
//
//

#import "CCLayer.h"

@interface TutorialLayer : CCLayer
{
    CCLabelTTF *introLabel1;
    CCLabelTTF *introLabel2;
    CCLabelTTF *airstrikeWords;
    CCLabelTTF *level3Label;
    CCLabelTTF *immunityWords;
    CCLabelTTF *reinforcementWords;
    CCSprite *immunityIcon;
    CCSprite *airstrikeIcon;
    CCSprite *reinforcementsIcon;
    
    CGSize winSize;
}


-(id) init;
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) mainCharacterIdleAnimation:(CCSprite*)mainCharacter;

@end
