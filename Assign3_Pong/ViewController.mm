//
//  ViewController.m
//  glesbasics
//
//  Created by Borna Noureddin on 2020-01-14.
//  Copyright © 2020 BCIT. All rights reserved.
//

#import "ViewController.h"
#import "ScoreTracker.h"

const int speedY = 2;

@interface ViewController () {
    GameManager *manager;
    ScoreTracker *scoreTracker;
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@end

@implementation ViewController

// MARK: Handle actions

- (IBAction)startGame:(UITapGestureRecognizer *)sender {
    NSLog(@"Game started - tap is disabled");
    //self.tapGesture.enabled = false;
    self.startLabel.hidden = true;
    [self.winnerLabel setText:@""];
    
    // start game here...
    if (!manager.getScoreTracker.gameStarted) {
        manager.getScoreTracker.matchStarted = true;
        manager.getScoreTracker.gameStarted = true;
        [manager.getScoreTracker resetScores];
        [manager startGame];
    }
    
    if (!manager.getScoreTracker.matchStarted) {
        manager.getScoreTracker.matchStarted = true;
        [manager startGame];
    }

    //[manager startGame];

}

- (IBAction)movePaddle:(UIPanGestureRecognizer *)sender {
    CGPoint vel = [sender velocityInView:self.view];
    
    // add code to move paddle here
    if (vel.y > 0) { // panning down
        [manager applyImpulseOnPlayer:0 Y:-speedY];
    } else { // panning up
        [manager applyImpulseOnPlayer:0 Y:speedY];
    }
}

// MARK: OpenGL setup in ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up the opengl window and draw
    // set up the manager
    GLKView *view = (GLKView *)self.view;
    manager = [[GameManager alloc] init];
    [manager initManager:view];
    
    [self.winnerLabel setText:@""];
    
}

- (void)update
{
    //GLKMatrix4 modelViewMatrix = [playerTransformations getModelViewMatrix];
    [manager update:self.timeSinceLastUpdate];
    
    // get current score string
    [self.scoreLabel setText:[manager.getScoreTracker getScoreString]];
    
    if ([manager.getScoreTracker gameEnded]) {
        manager.getScoreTracker.gameStarted = false;
        manager.getScoreTracker.matchStarted = false;
        
        NSString* winnerString = [manager.getScoreTracker getWinnerString];
        [self.winnerLabel setText:winnerString];
        
        //self.tapGesture.enabled = true;
        self.startLabel.hidden = false;
    }
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [manager draw]; // ###
}

@end
