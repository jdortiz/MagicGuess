//
//  ViewController.m
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 17/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import "ViewController.h"
#import "CanvasView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet CanvasView *canvasView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - UI Actions

- (IBAction)clearCanvas:(id)sender {
    [self.canvasView clear];
}

@end
