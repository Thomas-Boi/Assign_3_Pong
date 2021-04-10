//
//  Enemy.m
//  Assign3_Pong
//
//  Created by socas on 2021-04-10.
//

#import "Enemy.h"
const int speed = 2;

@interface Enemy()
{
    b2Vec2 velocity;
}
@end

@implementation Enemy

-(id)init
{
    if (self = [super init])
    {
        velocity = b2Vec2(0, speed);
    }
    return self;
}

- (void)update
{
    self.body->SetLinearVelocity(velocity);
    [super update];
}

- (void)onCollision:(GameObject *)otherObj
{
    if ([otherObj isKindOfClass:[Platform class]])
    {
        // flip the direction
        velocity = b2Vec2(0, -velocity.y);
    }
}
@end
