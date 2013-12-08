//
//  LILinearInterpView.m
//  Lines
//
//  Created by Yasser Al-Khder on 12/3/2013.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import "LILinearInterpView.h"

@interface LILinearInterpView ()

@property (strong, nonatomic) UIBezierPath *path;

@end

@implementation LILinearInterpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.path = [UIBezierPath bezierPath];
        self.path.lineWidth = 2.0;
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
    [[UIColor blackColor] setStroke];
    [self.path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path moveToPoint:p];
    NSLog(@"%@", event);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


@end
