
//
//  SampleGameLayer.m
//  Gorilla Game
//
//  Created by Ajay Shah on 7/5/13.
//
//

/*#import "SampleGameLayer.h"

@implementation SampleGameLayer
-(id) init
{
	if ((self = [super init]))
	{ //create an object that will check for collisions
		contactListener = new ContactListener();
		world->SetContactListener(contactListener);
        
        
		// Define the static container body, which will provide the collisions at screen borders.
		b2BodyDef screenBorderDef;
		screenBorderDef.position.Set(0, 0);
        screenBorderBody = world->CreateBody(&screenBorderDef);
		b2EdgeShape screenBorderShape;
        
        screenBorderShape.Set(lowerLeftCorner, lowerRightCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        
        screenBorderShape.Set(lowerRightCorner, upperRightCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        
        screenBorderShape.Set(upperRightCorner, upperLeftCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        
        screenBorderShape.Set(upperLeftCorner, lowerLeftCorner);
        screenBorderBody->CreateFixture(&screenBorderShape, 0);
        
        
        //Check through all the bullets and blocks and see if they intersect
        -(void) detectCollisions
        {
            for(int i = 0; i < [bullets count]; i++)
            {
                for(int j = 0; j < [blocks count]; j++)
                {
                    if([bullets count]>0)
                    {
                        NSInteger first = i;
                        NSInteger second = j;
                        block = [blocks objectAtIndex:second];
                        projectile = [bullets objectAtIndex:first];
                        
                        firstrect = [projectile textureRect];
                        secondrect = [block textureRect];
                        //check if their x coordinates match
                        if(projectile.position.x == block.position.x)
                        {
                            //check if their y coordinates are within the height of the block
                            if(projectile.position.y < (block.position.y + 23.0f) && projectile.position.y > block.position.y - 23.0f)
                            {
                                if([block isKindOfClass:[Seal class]])
                                {
                                    //the program doesn't know that the block is actually a Seal object; we must cast it to a seal
                                    if (((Seal*)block).health==1)
                                    {
                                        [self removeChild:block cleanup:YES];
                                        [self removeChild:projectile cleanup:YES];
                                        [blocks removeObjectAtIndex:second];
                                        [bullets removeObjectAtIndex:first];
                                    }
                                    else
                                    {
                                        ((Seal*)block).health--;
                                        [self removeChild:projectile cleanup:YES];
                                        [bullets removeObjectAtIndex:first];
                                    }
                                }
                                else
                                {
                                    [self removeChild:block cleanup:YES];
                                    [self removeChild:projectile cleanup:YES];
                                    [blocks removeObjectAtIndex:second];
                                    [bullets removeObjectAtIndex:first];





@end
 */
