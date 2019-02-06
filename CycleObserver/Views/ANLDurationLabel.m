//
//  ANLDurationLabel.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 02/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLDurationLabel.h"



@implementation ANLDurationLabel

+(instancetype)durationWithFrame:(CGRect)frame textSize:(CGFloat)textSize text:(NSString *)text {

    ANLDurationLabel *label = [[ANLDurationLabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setFont:[UIFont spaghettiFontWithSize:textSize]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    
    return label;
}

@end
