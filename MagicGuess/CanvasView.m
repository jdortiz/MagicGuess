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
@property (strong, nonatomic) NSFileManager *fileManager;

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
    [self loadPathForSuit:3];
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


#pragma mark - Save and restore Bezier paths

- (void) saveCurrentPath {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];

    NSURL *fileURL = [[[self.fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.path", [dateFormatter stringFromDate:[NSDate date]]]];
    [NSKeyedArchiver archiveRootObject:self.bezierPath toFile:[fileURL path]];
    
}


- (void) loadPathForSuit:(NSUInteger)suit {
    NSString *suitString;
    switch (suit) {
        case 0:
            suitString = @"Spade";
            break;
        case 1:
            suitString = @"Diamond";
            break;
        case 2:
            suitString = @"Heart";
            break;
        case 3:
            suitString = @"Club";
            break;
            
        default:
            break;
    }
    NSURL *fileURL = [[[self.fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.path", suitString]];
    self.bezierPath = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileURL path]];
}



#pragma mark - Lazy instanciation

- (NSFileManager *) fileManager {
    if (_fileManager == nil) {
        _fileManager = [NSFileManager defaultManager];
    }
    
    return _fileManager;
}

@end
