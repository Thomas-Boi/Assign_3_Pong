//
//  Bullet.m
//  WizQuest
//
//  Created by socas on 2021-03-02.
//

#import "Bullet.h"
@interface Bullet()
{
    b2Vec2 velocity;
}

@end

@implementation Bullet
@synthesize hitWall;

- (float)getRandomSpeed
{
    float maxSpeed = 4;
    float minSpeed = 2;
    float speed = arc4random_uniform(maxSpeed - minSpeed) + minSpeed;
    
    float isPositive = arc4random_uniform(2);
    if (!isPositive)
    {
        speed = -speed;
    }
    
    return speed;
}

-(void)startMoving {
    float velX = [self getRandomSpeed];
    float velY = [self getRandomSpeed];
    velocity = b2Vec2(velX, velY);
    self.body->SetLinearVelocity(velocity);
}


- (void)stopMoving
{
    velocity = b2Vec2(0, 0);
    self.body->SetLinearVelocity(velocity);
}

- (void) onCollision:(GameObject *)otherObj
{
    if ([otherObj isKindOfClass:[Wall class]])
    {
        hitWall = ((Wall *)otherObj).side;
        return;
    }
        
    // reverse x direction if hit pads
    if ([otherObj isKindOfClass:[Player class]] || [otherObj isKindOfClass:[Enemy class]])
    {
        velocity = b2Vec2(-velocity.x, velocity.y);
    }
    else if ([otherObj isKindOfClass:[Platform class]])
    {
        velocity = b2Vec2(velocity.x, -velocity.y);
    }
    self.body->SetLinearVelocity(velocity);
}

@end

