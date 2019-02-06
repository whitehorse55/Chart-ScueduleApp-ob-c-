//
//  UIColor+ANLButtonColor.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 02/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "UIColor+ANLButtonColor.h"



@implementation UIColor (ANLButtonColor)

+(instancetype)colorWithH:(CGFloat)hue S:(CGFloat)saturation B:(CGFloat)brightness {
    
    return [UIColor colorWithH:hue S:saturation B:brightness A:100];
}

+(instancetype)colorWithH:(CGFloat)hue S:(CGFloat)saturation B:(CGFloat)brightness A:(CGFloat)alpha {
    
    return [UIColor colorWithHue:hue / 360 saturation:saturation / 100 brightness:brightness / 100 alpha:alpha / 100];
}

+(instancetype)colorWithNormalStateButtonColor:(ANLButtonColor)buttonColor {

    UIColor *color = nil;
    switch (buttonColor) {
            
        case anlButtonColorGreen:
            
            color = [UIColor colorWithRed:0 green: 0.56f blue:0 alpha:1];
            break;
            
        case anlButtonColorYellow:
            
            color = [UIColor colorWithRed:1.0f green:0.98f blue:0 alpha:1];
            break;
            
        case anlButtonColorRed:
            
            color = [UIColor colorWithRed:1.0f green:0.15f blue:0 alpha:1];
            break;
            
        case anlButtonColorGrey:
            
            color = [UIColor colorWithRed:0.565f green:0.565f blue:0.565 alpha:1];
            break;
    }
    return color;
}

+(instancetype)colorWithSelectStateButtonColor:(ANLButtonColor)buttonColor {
    
    UIColor *color = nil;
    switch (buttonColor) {
            
        case anlButtonColorGreen:
            
            color = [UIColor colorWithRed:0 green: 0.9f blue:0 alpha:1];
            break;
            
        case anlButtonColorYellow:
            
            color = [UIColor colorWithRed:0.88f green:0.81f blue:0.32f alpha:1];
            break;
            
        case anlButtonColorRed:
            
            color = [UIColor colorWithRed:0.9f green:0 blue:0 alpha:1];
            break;
            
        case anlButtonColorGrey:
            
            color = [UIColor clearColor];
            break;
    }
    return color;
}

+(instancetype)colorWithIntermediateButtonColor:(ANLButtonColor)buttonColor {
    
    UIColor *color = nil;
    switch (buttonColor) {
            
        case anlButtonColorGreen:
            
            color = [UIColor colorWithRed:0 green: 0.75f blue:0 alpha:1];
            break;
            
        case anlButtonColorYellow:
            
            color = [UIColor colorWithRed:.78 green:.77 blue:.29 alpha:1];
            break;
            
        case anlButtonColorRed:
            
            color = [UIColor colorWithRed:0.75f green:0 blue:0 alpha:1];
            break;
            
        case anlButtonColorGrey:
            
            color = [UIColor clearColor];
            break;
    }
    return color;
}

+(instancetype)colorForBackGroundsViews {
    
    return [UIColor whiteColor];
}

+(instancetype)colorForBottonsFrame {
    
    return [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1];
}

+(instancetype)colorForBars {
    
    return [UIColor colorWithRed:.98f green:.98f blue:.97f alpha:1];
}

+(instancetype)colorForActiveIcons {
    
    return [UIColor colorWithRed:.37f green:.58f blue:.79f alpha:1];
}

+(instancetype)colorForInactiveIcons {
    
    return [UIColor colorWithRed:.796f green:.796f blue:.796f alpha:1];
}

+(instancetype)colorForBlueText {
    
    return [UIColor colorWithRed:.2f green:.4f blue:1 alpha:1];
}

+(instancetype)colorForBackgroundGrey {
    
    return [UIColor colorWithRed: 0.9f green:0.9f blue:0.96f alpha:1];
}

+(instancetype)colorForGreyLine {
    
    return [UIColor colorWithRed:0.784f green:0.780f blue:0.8f alpha:1];
}

+(instancetype)colorForBackgroundGreyWithAlpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed: 0.9f green:0.9f blue:0.96f alpha:alpha];
}

+(instancetype)colorForBlueHighlightsElements {
    
    return [UIColor colorWithRed:22 green:126 blue:251 alpha:1];
}

@end
