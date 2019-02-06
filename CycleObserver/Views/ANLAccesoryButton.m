//
//  ANLAccesoryButton.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 01/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLAccesoryButton.h"



@implementation ANLAccesoryButton

+(instancetype)accesoryButtonWithFrame:(CGRect)frame color:(ANLButtonColor)color {
    
    ANLAccesoryButton *button = [ANLAccesoryButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:frame];
    [button setColorAttribute:color];
    [button setTag:color];
    
    return button;
}

- (void)drawRect:(CGRect)rect {

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height / 2];
    [path addClip];
    [path removeAllPoints];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    struct CGGradient *gradient = NULL;
    CGFloat locs[2] = {1, 0};
    switch ([self colorAttribute]) {
            
        case anlButtonColorGreen: {
            
            CGFloat components[8] = {0, 0.56, 0, 1, 0, 0.44, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        case anlButtonColorYellow: {
            
            CGFloat components[8] = {1, 0.98, 0, 1, .88, .86, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        case anlButtonColorRed: {
            
            CGFloat components[8] = {1, 0.15, 0, 1, .88, .03, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        default:
            break;
    }
    
    CGFloat originY = rect.size.height;
    CGFloat finalY = 0;
    
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(rect.size.width / 2.0, originY),
                                CGPointMake(rect.size.width / 2.0, finalY), 0);
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}

@end
