//
//  ObjectTracker.h
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#ifndef ObjectTracker_h
#define ObjectTracker_h

#import "Player.h"
#import "Bullet.h"
#import "Enemy.h"
#import <Foundation/Foundation.h>


@interface ObjectTracker : NSObject

@property Player *player;
@property Bullet *ball;
@property Enemy *enemy;
@property(readonly) NSMutableArray *platforms;

- (void) addPlatform: (GameObject *) platform;
- (void) cleanUp;

@end

#endif /* ObjectTracker_h */
