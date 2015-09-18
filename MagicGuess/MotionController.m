//
//  MotionController.m
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 18/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import <CoreMotion/CoreMotion.h>
#import "MotionController.h"


@interface MotionController ()

@property (strong, nonatomic) CMMotionManager *motionManager;

@end



@implementation MotionController


- (void) startMeasuringPosition {
    if (self.motionManager.deviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 1.0;

        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error == nil) {
                NSLog(@"Data: (x/pitch:%f, y/roll:%f, z/yaw:%f", motion.attitude.pitch, motion.attitude.roll, motion.attitude.yaw);
            }
        }];
    }
}


- (void) stopMeasuringPosition {
    [self.motionManager stopDeviceMotionUpdates];
}


#pragma mark - Lazy Instanciation

- (CMMotionManager *) motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    
    return _motionManager;
}

@end
