//
//  ObjectTracker.m
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#import "ObjectTracker.h"

@interface ObjectTracker()
{
    // track player separately due to UI
    Player *_player;
    
    // track player separately due to UI
    Bullet *_ball;
    
    // track player separately due to UI
    Player *_enemy;

    // platforms don't change throughout the game
    NSMutableArray *_platforms;
}

@end

@implementation ObjectTracker

// props
@synthesize player=_player;

@synthesize platforms=_platforms;


- (instancetype) init
{
    self = [super init];
    _platforms = [NSMutableArray array];
    return self;
}

- (void) addPlayer: (Player *) player
{
    _player = player;
}

- (void) addBall: (Bullet *) ball
{
    _ball = ball;
}

- (void) addEnemy: (Player *) enemy
{
    _enemy = enemy;
}

- (void) addPlatform: (GameObject *) platform
{
    [_platforms addObject:platform];
}


// check and see if we need to delete
// any objects from the array.
- (void) cleanUp
{
    
}

@end
