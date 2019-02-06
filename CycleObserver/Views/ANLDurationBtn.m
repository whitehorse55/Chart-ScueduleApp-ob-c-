//
//  ANLDurationBtn.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 05/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLDurationBtn.h"



@implementation ANLDurationBtn

+(instancetype)durationWithFrame:(CGRect)frame textSize:(CGFloat)textSize text:(NSString *)text {
    
    ANLDurationBtn *btn = [ANLDurationBtn buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont spaghettiFontWithSize:textSize]];
    [[btn titleLabel] setTextAlignment:NSTextAlignmentRight];
    [[btn titleLabel] setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    
    return btn;
}

@end
