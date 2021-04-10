//
//  ObjectTracker.m
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#import "ObjectTracker.h"

@interface ObjectTracker()
{    // platforms don't change throughout the game
    NSMutableArray *_platforms;
}

@end

@implementation ObjectTracker

// props
@synthesize player;
@synthesize enemy;
@synthesize ball;

@synthesize platforms=_platforms;


- (instancetype) init
{
    self = [super init];
    _platforms = [NSMutableArray array];
    return self;
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
