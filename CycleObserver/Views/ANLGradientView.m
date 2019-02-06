//
//  ANLGradientView.m
//  Chrono
//
//  Created by Amador Navarro Lucas on 15/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLGradientView.h"



@implementation ANLGradientView

- (void)drawRect:(CGRect)rect {
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {1, 1, 1, 0, 1, 1, 1, 1};
    CGFloat locs[2] = {1, 0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
    
    CGFloat originY = rect.size.height * .6f;
    CGFloat finalY = rect.size.height * 0.1f;
    CGGradientDrawingOptions option = kCGGradientDrawsBeforeStartLocation;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(rect.size.width / 2.0, originY),
                                CGPointMake(rect.size.width / 2.0, finalY),
                                option);
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}

@end
