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

- (float)getRandomSpeed
{
    float maxSpeed = 6;
    float minSpeed = 3;
    float speed = arc4random_uniform(maxSpeed - minSpeed) + minSpeed;
    
    float isPositive = arc4random_uniform(2);
    if (!isPositive)
    {
        speed = -speed;
    }
    
    return speed;
}

- (void)startMoving
{
    float velY = [self getRandomSpeed];
    velocity = b2Vec2(0, velY);
    self.body->SetLinearVelocity(velocity);
}


- (void)stopMoving
{
    velocity = b2Vec2(0, 0);
    self.body->SetLinearVelocity(velocity);
}

- (void)onCollision:(GameObject *)otherObj
{
    if ([otherObj isKindOfClass:[Platform class]])
    {
        // flip the direction
        velocity = b2Vec2(0, -velocity.y);
        self.body->SetLinearVelocity(velocity);
    }
    
    if ([otherObj isKindOfClass:[Bullet class]]) {
        velocity = b2Vec2(0, velocity.y);
        self.body->SetLinearVelocity(velocity);
    }
}
@end
