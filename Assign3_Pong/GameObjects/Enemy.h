//
//  Enemy.h
//  Assign3_Pong
//
//  Created by socas on 2021-04-10.
//

#ifndef Enemy_h
#define Enemy_h

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "Platform.h"

@interface Enemy : GameObject

- (void)startMoving;
- (void)stopMoving;
@end

#endif /* Enemy_h */
