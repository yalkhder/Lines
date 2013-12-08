//
//  LICachedView.m
//  Lines
//
//  Created by Yasser Al-Khder on 12/6/2013.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import "LICachedView.h"

@interface LICachedView ()

@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) UIImage *incrementalImage;
@property (nonatomic) unsigned int counter;

@end

@implementation LICachedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.path = [UIBezierPath bezierPath];
        self.multipleTouchEnabled = NO;
        self.path.lineWidth = 10.0;
        self.counter = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.incrementalImage drawInRect:rect];
    [self.path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.counter++;
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path moveToPoint:p];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.counter++;
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p];
    if (self.counter >= 200) {
        NSLog(@"BAM!!");
        [self drawBitmap];
        [self.path removeAllPoints];
        [self.path moveToPoint:p];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p];
    [self drawBitmap];
    [self setNeedsDisplay];
    [self.path removeAllPoints];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [[UIColor blackColor] setStroke];
    if (!self.incrementalImage) {
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectPath fill];
    }
    [self.incrementalImage drawAtPoint:CGPointZero];
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.counter = 0;
}

@end
