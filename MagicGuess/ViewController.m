//
//  ViewController.m
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 17/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import "ViewController.h"
#import "CanvasView.h"
#import "MotionController.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet CanvasView *canvasView;
@property (strong, nonatomic) MotionController *motionController;

@end



@implementation ViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.motionController = [[MotionController alloc] init];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.motionController startMeasuringPosition];
}


- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.motionController stopMeasuringPosition];
}


#pragma mark - UI Actions

- (IBAction) clearCanvas:(id)sender {
    [self.canvasView clear];
}

@end
