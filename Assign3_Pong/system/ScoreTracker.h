//
//  ScoreTracker.h
//  Assign3_Pong
//
//  Created by Sebastian Bejm on 2021-04-09.
//

#ifndef ScoreTracker_h
#define ScoreTracker_h

#import <Foundation/Foundation.h>

@interface ScoreTracker : NSObject

- (void) incrementPlayerScore;
- (void) incrementEnemyScore;
- (void) resetScores;
- (bool) gameEnded;
- (NSString *) getWinnerString;
- (NSString *) getScoreString;

@property bool gameStarted;

@end

#endif /* ScoreTracker_h */
