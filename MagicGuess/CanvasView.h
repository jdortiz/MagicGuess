//
//  CanvasView.h
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 17/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Suites.h"


@interface CanvasView : UIView

- (void) loadPathForSuit:(Suit)suit;
- (void) clear;

@end
