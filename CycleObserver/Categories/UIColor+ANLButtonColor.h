//
//  UIColor+ANLButtonColor.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 02/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, ANLButtonColor) {
    
    anlButtonColorGreen,
    anlButtonColorYellow,
    anlButtonColorRed,
    anlButtonColorGrey
};

@interface UIColor (ANLButtonColor)

+(instancetype)colorWithH:(CGFloat)hue S:(CGFloat)saturation B:(CGFloat)brightness;
+(instancetype)colorWithH:(CGFloat)hue S:(CGFloat)saturation B:(CGFloat)brightness A:(CGFloat)alpha;









+(instancetype)colorWithNormalStateButtonColor:(ANLButtonColor)buttonColor;
+(instancetype)colorWithSelectStateButtonColor:(ANLButtonColor)buttonColor;
+(instancetype)colorWithIntermediateButtonColor:(ANLButtonColor)buttonColor;
+(instancetype)colorForBackgroundGrey;
+(instancetype)colorForGreyLine;
+(instancetype)colorForBackgroundGreyWithAlpha:(CGFloat)alpha;
+(instancetype)colorForBlueHighlightsElements;
+(instancetype)colorForBackGroundsViews;
+(instancetype)colorForBottonsFrame;
+(instancetype)colorForBars;
+(instancetype)colorForActiveIcons;
+(instancetype)colorForInactiveIcons;
+(instancetype)colorForBlueText;

@end
