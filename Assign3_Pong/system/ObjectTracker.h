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
#import <Foundation/Foundation.h>


@interface ObjectTracker : NSObject

@property(readonly) Player *player;
@property(readonly) Bullet *ball;
@property(readonly) Player *enemy;
@property(readonly) NSMutableArray *platforms;

- (void) addPlayer: (Player *) player;
- (void) addBall: (Bullet *) ball;
- (void) addEnemy: (Player *) enemy;
- (void) addPlatform: (GameObject *) platform;
- (void) cleanUp;

@end

#endif /* ObjectTracker_h */
