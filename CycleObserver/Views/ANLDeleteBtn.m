//
//  ANLDeleteBtn.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 23/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLDeleteBtn.h"



@implementation ANLDeleteBtn

+(instancetype)deleteButtonWithFrame:(CGRect)frame {
    
    ANLDeleteBtn *btn = [ANLDeleteBtn buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setAlpha:0];
    
    return btn;
}

- (void)drawRect:(CGRect)rect {

    CGFloat height = rect.size.height;
    CGFloat length = height / 2;
    CGRect circleFrame = CGRectMake((rect.size.width - height) / 2, 0, height, height);
    CGPoint center = CGPointMake(circleFrame.origin.x + length, length);
    
    [[UIColor colorWithSelectStateButtonColor:anlButtonColorRed] setFill];
    [[UIColor whiteColor] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, circleFrame);
    CGContextFillPath(context);
    
    CGContextSetLineWidth(context, 3);
    
    CGContextMoveToPoint(context, center.x - length / 2, center.y - length / 2);
    CGContextAddLineToPoint(context, center.x + length / 2, center.y + length / 2);
    
    CGContextMoveToPoint(context, center.x - length / 2, center.y + length / 2);
    CGContextAddLineToPoint(context, center.x + length / 2, center.y - length / 2);
    CGContextStrokePath(context);
}

@end
