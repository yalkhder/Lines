//
//  LISmoothedBIView.m
//  Lines
//
//  Created by Yasser Al-Khder on 1/17/2014.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "LISmoothedBIView.h"

@interface LISmoothedBIView () {
    CGPoint pts[5]; // I hate doing this
}

@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) UIImage *incrementalImage;
@property (nonatomic) unsigned int pathCounter;
@property (nonatomic) unsigned int performanceCounter;

@end

@implementation LISmoothedBIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.multipleTouchEnabled = NO;
        self.path = [UIBezierPath bezierPath];
        self.path.lineWidth = 2.0;
        self.performanceCounter = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self.incrementalImage drawInRect:rect];
    [self.path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.performanceCounter++;
    self.pathCounter = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    self.pathCounter++;
    pts[self.pathCounter] = p;
    if (self.pathCounter == 4) {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        [self.path moveToPoint:pts[0]];
        [self.path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
        [self setNeedsDisplay];
        pts[0] = pts[3];
        pts[1] = pts[4];
        self.pathCounter = 1;
    }
    self.performanceCounter++;
    if (self.performanceCounter >= 200) {
        [self drawBitmap];
        [self.path removeAllPoints];
        [self.path moveToPoint:pts[0]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmap];
    [self setNeedsDisplay];
    [self.path removeAllPoints];
    self.pathCounter = 0;
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    if(!self.incrementalImage) {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [self.incrementalImage drawAtPoint:CGPointZero];
    [[UIColor blackColor] setStroke];
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.performanceCounter = 0;
}

@end
