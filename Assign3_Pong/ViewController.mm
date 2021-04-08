//
//  ViewController.m
//  glesbasics
//
//  Created by Borna Noureddin on 2020-01-14.
//  Copyright © 2020 BCIT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GameManager *manager;

}

@end

@implementation ViewController

// MARK: Handle actions



// MARK: OpenGL setup in ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up the opengl window and draw
    // set up the manager
    GLKView *view = (GLKView *)self.view;
    manager = [[GameManager alloc] init];
    [manager initManager:view];

    
}

- (void)update
{
    //GLKMatrix4 modelViewMatrix = [playerTransformations getModelViewMatrix];
    [manager update:self.timeSinceLastUpdate];
    
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [manager draw]; // ###
}

@end
