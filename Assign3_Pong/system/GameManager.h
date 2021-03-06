//
//  GameManager.h
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#ifndef GameManager_h
#define GameManager_h
#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GameObject.h"
#import "Player.h"
#import "Wall.h"
#import "Platform.h"
#import "Enemy.h"
#import "Renderer.h"
#import "ObjectTracker.h"
#import "Transformations.h"
#import "PhysicsWorld.h"
#import "PhysicsBodyTypeEnum.h"
#import "Bullet.h"
#import "ScoreTracker.h"

@interface GameManager : NSObject

- (void) initManager:(GLKView *)view;
- (ScoreTracker*)getScoreTracker;
- (void) startGame;
- (void) applyImpulseOnPlayer:(float)x Y:(float)y;
- (void) update:(float) deltaTime;
- (void) draw;
- (void) reset;

@end


#endif /* GameManager_h */
