//
//  CanvasView.m
//  MagicGuess
//
//  Created by Jorge D. Ortiz Fuentes on 17/9/15.
//  Copyright (c) 2015 powwau. All rights reserved.
//


#import "CanvasView.h"


@interface CanvasView ()

@property (strong, nonatomic) UIBezierPath *bezierPath;

@end



@implementation CanvasView

#pragma mark - Constants & Parameters

const CGFloat defaultLineWidth = 4.0;

#pragma mark - Initializer

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpBezierPath];
    }
    return self;
}


- (void) setUpBezierPath {
    _bezierPath = [UIBezierPath bezierPath];
    _bezierPath.lineWidth = defaultLineWidth;
}


#pragma mark - UI Actions

- (void) clear {
    [self.bezierPath removeAllPoints];
    [self setNeedsDisplay];
}


#pragma mark - Custom drawing

- (void) drawRect:(CGRect)rect {
    [[UIColor darkGrayColor] setStroke];
    [self.bezierPath stroke];
}


#pragma mark - Touch handling

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self.bezierPath moveToPoint:[touch locationInView:self]];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self.bezierPath addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}


- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

@end
