//
//  ScoreTracker.m
//  Assign3_Pong
//
//  Created by Sebastian Bejm on 2021-04-09.
//

#import "ScoreTracker.h"

@interface ScoreTracker() {
    int leftScore;
    int rightScore;
}

@end

@implementation ScoreTracker

@synthesize gameStarted;
@synthesize matchStarted;

- (id)init {
    if (self == [super init]) {
        gameStarted = false;
    }
    return self;
}

- (void) incrementPlayerScore
{
    leftScore++;
}

- (void) incrementEnemyScore
{
    rightScore++;
}

- (void)resetScores {
    leftScore = 0;
    rightScore = 0;
    gameStarted = true;
}

- (bool)gameEnded {
    if (leftScore == 3 || rightScore == 3) {
        return true;
    }
    return false;
}

- (NSString *)getWinnerString {
    NSString* winnerString = @"";
    if (leftScore == 3) {
        winnerString = @"The player wins!";
    } else if (rightScore == 3) {
        winnerString = @"The enemy wins!";
    }
    return winnerString;
}

- (NSString *)getScoreString {
    NSString* scoreString = [NSString stringWithFormat:@"%d : %d", leftScore, rightScore];
    return scoreString;
}

@end
