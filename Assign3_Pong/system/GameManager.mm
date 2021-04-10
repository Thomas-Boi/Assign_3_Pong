//
//  GameManager.m
//  WizQuest
//
//  Created by socas on 2021-02-23.
//

#import "GameManager.h"

const GLKVector2 MONSTER_SPAWN_POSITION = GLKVector2Make(SCREEN_WIDTH/2, SCREEN_HEIGHT);

@interface GameManager()
{
    Renderer *renderer;
    ObjectTracker *tracker;
    PhysicsWorld *physics;
    ScoreTracker *scoreTracker;
    
    float elapsedMonsterSpawnTime;
    bool playerDirection;
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
    
    playerDirection = true;
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
        Player *playerPad = [[Player alloc] init];
        [playerPad initPosition:GLKVector3Make(SCREEN_WIDTH/4, SCREEN_HEIGHT/2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(1, padHeight, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        
        // tracker tracks things to be used for render and physics
        [tracker addPlayer:playerPad];
        
        // physics tracks things for box2D
        [physics addObject:playerPad];
        
        Player *enemyPad = [[Player alloc] init];
        [enemyPad initPosition:GLKVector3Make(SCREEN_WIDTH/4 * 3, SCREEN_HEIGHT/2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(1, padHeight, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        [tracker addEnemy:enemyPad];
        [physics addObject:enemyPad];
        
        Bullet *ball = [[Bullet alloc] init];
        [ball initPosition:GLKVector3Make(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(1, 1, 1) VertShader:@"PlayerShader.vsh" AndFragShader:@"PlayerShader.fsh" ModelName:@"cube" PhysicsBodyType:DYNAMIC];
        [tracker addBall:ball];
        [physics addObject:ball];
        
        
        // make the walls
        float platformThickness = 1;
        Wall *leftWall = [[Wall alloc] init];
        [leftWall initPosition:GLKVector3Make(0, SCREEN_HEIGHT / 2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(platformThickness, SCREEN_HEIGHT, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:leftWall];
        [physics addObject:leftWall];
        
        Wall *rightWall = [[Wall alloc] init];
        [rightWall initPosition:GLKVector3Make(SCREEN_WIDTH, SCREEN_HEIGHT / 2, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(platformThickness, SCREEN_HEIGHT, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:rightWall];
        [physics addObject:rightWall];
        
        GameObject *ceiling = [[GameObject alloc] init];
        [ceiling initPosition:GLKVector3Make(SCREEN_WIDTH/2, SCREEN_HEIGHT, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(SCREEN_WIDTH, platformThickness, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:ceiling];
        [physics addObject:ceiling];
        
        GameObject *floor = [[GameObject alloc] init];
        [floor initPosition:GLKVector3Make(SCREEN_WIDTH/2, 0, DEPTH) Rotation:GLKVector3Make(0, 0, 0) Scale:GLKVector3Make(SCREEN_WIDTH, platformThickness, 1) VertShader:@"PlatformShader.vsh" AndFragShader:@"PlatformShader.fsh" ModelName:@"cube" PhysicsBodyType:STATIC];
        [tracker addPlatform:floor];
        [physics addObject:floor];

    }
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
    
    // platforms don't need to be updated
    
}

- (void) direction:(bool) d
{
    playerDirection = d;
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
