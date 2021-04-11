//
//  Bullet.h
//  WizQuest
//
//  Created by socas on 2021-04-06.
//

#ifndef Bullet_h
#define Bullet_h

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "Player.h"
#import "Enemy.h"
#import "Player.h"
#import "Wall.h"
#import "ScreenInfo.h"

@interface Bullet: GameObject
@property int hitWall;

- (void)startMoving;
- (void)stopMoving;
@end
#endif 
