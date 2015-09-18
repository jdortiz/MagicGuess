//
//  MotionController.h
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 18/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Suites.h"


@protocol MotionControllerResultsDelegate;


@interface MotionController : NSObject

@property (weak, nonatomic) id<MotionControllerResultsDelegate> delegate;

- (void) startMeasuringPosition;
- (void) stopMeasuringPosition;

@end


@protocol MotionControllerResultsDelegate <NSObject>

- (void) motionController:(MotionController *)motionController result:(Suit)suit;

@end