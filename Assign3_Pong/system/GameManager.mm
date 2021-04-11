//
//  GameManager.m
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#import "GameManager.h"

const GLKVector3 initialPlayerPosition = GLKVector3Make(SCREEN_WIDTH/6, SCREEN_HEIGHT/2, DEPTH);
const GLKVector3 initialEnemyPosition = GLKVector3Make(SCREEN_WIDTH/6 * 5, SCREEN_HEIGHT/2, DEPTH);
const GLKVector3 initialBallPosition = GLKVector3Make(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, DEPTH);

@interface GameManager()
{
    Renderer *renderer;
    ObjectTracker *tracker;
    PhysicsWorld *physics;
    ScoreTracker *scoreTracker;
}

@end

@implementation GameManager

- (void) initManager:(GLKView *)view
{
    renderer = [[Renderer alloc] init];
    [renderer setup:view];
    
    tracker = [[ObjectTracker alloc] init];
    
    scoreTracker = [[ScoreTracker alloc] init];
    
    physics = [[PhysicsWorld alloc] init];
    [self createGameScene];
}

- (ScoreTracker*) getScoreTracker {
    return scoreTracker;
}


// add platforms, and enemies to the tracker
- (void) createGameScene
{
    @autoreleasepool {
        // note: models only accept "cube" or "sphere"
        
        // moving objects
        float padHeight = 2;
        float padWidth = 0.5;
        Player *playerPad = [[Player alloc] init];
        [playerPad initPosition:initialPlayerPosition Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(padWidth, padHeight, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        
        // tracker tracks things to be used for render and physics
        tracker.player = playerPad;
        
        // physics tracks things for box2D
        [physics addObject:playerPad];
        
        Enemy *enemyPad = [[Enemy alloc] init];
        [enemyPad initPosition:initialEnemyPosition Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(padWidth, padHeight, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        tracker.enemy = enemyPad;
        [physics addObject:enemyPad];
        
        Bullet *ball = [[Bullet alloc] init];
        [ball initPosition:initialBallPosition Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(0.5, 0.5, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        tracker.ball = ball;
        [physics addObject:ball];
        
        
        // make the walls
        float platformThickness = 1;
        Wall *leftWall = [[Wall alloc] init];
        [leftWall initPosition:GLKVector3Make(0 - platformThickness, SCREEN_HEIGHT / 2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(platformThickness, SCREEN_HEIGHT, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        leftWall.side = RIGHT_WALL;
        [tracker addPlatform:leftWall];
        [physics addObject:leftWall];
        
        Wall *rightWall = [[Wall alloc] init];
        [rightWall initPosition:GLKVector3Make(SCREEN_WIDTH + platformThickness, SCREEN_HEIGHT / 2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(platformThickness, SCREEN_HEIGHT, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        rightWall.side = RIGHT_WALL;
        [tracker addPlatform:rightWall];
        [physics addObject:rightWall];
        
        Platform *ceiling = [[Platform alloc] init];
        [ceiling initPosition:GLKVector3Make(SCREEN_WIDTH/2, SCREEN_HEIGHT, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(SCREEN_WIDTH, platformThickness, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:ceiling];
        [physics addObject:ceiling];
        
        Platform *floor = [[Platform alloc] init];
        [floor initPosition:GLKVector3Make(SCREEN_WIDTH/2, 0, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(SCREEN_WIDTH, platformThickness, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:floor];
        [physics addObject:floor];

    }
}

- (void) startGame
{
    [tracker.ball startMoving];
    [tracker.enemy startMoving];
}

- (void) reset
{
    tracker.ball.hitWall = 0;
    
    // set velocity
    [tracker.enemy stopMoving];
    [tracker.ball stopMoving];
    
    // set position
    [tracker.player setPosition:initialPlayerPosition];
    [tracker.enemy setPosition:initialEnemyPosition];
    [tracker.ball setPosition:initialBallPosition];
}

// for the player
- (void)applyImpulseOnPlayer:(float)x Y:(float)y
{
    tracker.player.body->ApplyLinearImpulse(b2Vec2(x, y), tracker.player.body->GetPosition(), true);
}

// update the player movement and any physics here
- (void) update:(float) deltaTime
{
    // update physics engine
    [physics update:deltaTime];
    
    // update each object's position based on physics engine's data
    // this is required for non-static physics bodies
    [tracker.player update];
    
    // update the enemy
    [tracker.enemy update];
    
    [tracker.ball update];
    
    if (tracker.ball.hitWall > 0)
    {
        if (tracker.ball.hitWall == LEFT_WALL)
        {
            [scoreTracker incrementEnemyScore];
        }
        else if (tracker.ball.hitWall == RIGHT_WALL)
        {
            [scoreTracker incrementPlayerScore];
        }
        [self reset];
    }
    // platforms don't need to be updated
    
}

- (void) draw
{
    [renderer clear];
    [renderer draw:tracker.player];
    [renderer draw:tracker.ball];
    [renderer draw:tracker.enemy];
    
    
    for (GameObject *platform in tracker.platforms)
    {
        [renderer draw:platform];
    }
    
}

@end
