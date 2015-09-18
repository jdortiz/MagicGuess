//
//  MotionController.m
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 18/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import <CoreMotion/CoreMotion.h>
#import "MotionController.h"


typedef NS_ENUM(NSInteger, TrickState) {
    TrickStateDrawing,
    TrickStateLearning
};


@interface MotionController ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (assign, nonatomic) TrickState trickState;

@end



@implementation MotionController

#pragma mark - Constants & Parameters

const double angleThreshold = 0.05;
const double deltaThreshold = 0.4;


#pragma mark - Obtain position and act

- (void) startMeasuringPosition {
    self.trickState = TrickStateDrawing;
    if (self.motionManager.deviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 1.0;

        __weak typeof(self)weakSelf = self;
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error == nil) {
                static double prevPitch;
                static double prevRoll;
                double deltaPitch;
                double deltaRoll;
                Suit suit;
            
                NSLog(@"Data: (x/pitch:%f, y/roll:%f, z/yaw:%f", motion.attitude.pitch, motion.attitude.roll, motion.attitude.yaw);
            
                switch (weakSelf.trickState) {
                    case TrickStateDrawing:
                        if ((fabs(motion.attitude.pitch) < angleThreshold) && (M_PI - fabs(motion.attitude.roll) < angleThreshold)) {
                            NSLog(@"****** Ask the user to tell you the number. ******");
                            prevPitch = motion.attitude.pitch;
                            prevRoll = motion.attitude.roll;
                            weakSelf.trickState = TrickStateLearning;
                        }
                        break;
                    case TrickStateLearning:
                        deltaPitch = motion.attitude.pitch - prevPitch;
                        deltaRoll = motion.attitude.roll - prevRoll;
                        if ((fabs(deltaPitch) > deltaThreshold) || (fabs(deltaRoll) > deltaThreshold)) {
                            if (fabs(deltaPitch) > deltaThreshold) {
                                if (motion.attitude.pitch > 0) {
                                    NSLog(@"Option Spade");
                                    suit = SuitSpade;
                                } else if (motion.attitude.pitch < 0) {
                                    NSLog(@"Option Heart");
                                    suit = SuitHeart;
                                }
                            } else {
                                if (motion.attitude.roll > 0) {
                                    NSLog(@"Option Diamond");
                                    suit = SuitDiamond;
                                } else if (motion.attitude.roll < 0) {
                                    NSLog(@"Option Club");
                                    suit = SuitClub;
                                }
                            }
                            [self.delegate motionController:self result:suit];
                            [weakSelf.motionManager stopDeviceMotionUpdates];
                            weakSelf.trickState = TrickStateDrawing;
                        }
                    break;
                }
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
