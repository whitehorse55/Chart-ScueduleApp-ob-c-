//
//  ANLHeadScrollView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 28/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLHeadScrollView.h"
#import "ANLTaktTimeView.h"
#import "ANLCycleView.h"



@interface ANLHeadScrollView ()

@property (strong, nonatomic) ANLTaktTimeView *taktTimeView;
@property (strong, nonatomic) UIView *labelsView;

@property (nonatomic) CGPoint segmentCenter;

@end



@implementation ANLHeadScrollView

-(id)initWithFrame:(CGRect)frame type:(anlMeasuresViewsType)type taktTime:(NSNumber *)taktTime {

    if (self = [super initWithFrame:frame]) {
        
        [self setTaktTimeView:[self addTaktTimeViewFor:[taktTime stringValue]]];
        [self setLabelsView:[self addLabelsView]];
        [self setType:type];
    }
    return self;
}



#pragma mark - setters && getters

-(void)setType:(anlMeasuresViewsType)type {

    if (_type != type) {
        
        _type = type;
        [self changeViewToType:_type];
    }
}



#pragma mark - customMethods

-(void)changeViewToType:(anlMeasuresViewsType)type {

    CGFloat alpha = 1;
    CGPoint center = [[self taktTimeView] center];
    center.x -= [[self taktTimeView] frame].origin.x;
    UIColor *color = [UIColor colorWithHue:0 saturation:0 brightness:1 alpha:0.9];

    if (type == anlMeasuresViewsTypeSegments) {
        
        alpha = 0;
        center = [self segmentCenter];
        color = [UIColor clearColor];
    }

    [UIView animateWithDuration:0.5f animations:^{
        
        [[self taktTimeView] setCenter:center];
        [[self labelsView] setAlpha:alpha];
        [self setBackgroundColor:color];
    }];
}

-(ANLTaktTimeView *)addTaktTimeViewFor:(NSString *)taktTime {
    
    CGRect frame = CGRectZero;
    CGFloat side = [self bounds].size.height;
    frame.size = CGSizeMake(side, side);

    ANLTaktTimeView *ttView = [ANLTaktTimeView taktViewWithFrame:frame taktTime:taktTime];
    
    CGPoint center = CGPointMake([self bounds].size.width * 0.75, [self bounds].size.height / 2);
    [self setSegmentCenter:center];
    if ([self type] == anlMeasuresViewsTypeSegments) {
        
        [ttView setCenter:center];
    }
    [self addSubview:ttView];

    return ttView;
}

-(UIView *)addLabelsView {

    CGFloat height = [@"8" sizeWithAttributes:@{NSFontAttributeName : [UIFont spaghettiFontWithSize:18]}].height;
    CGRect frame = [self bounds];
    frame.size.height = height;
    
    UIView *timesView = [[UIView alloc] initWithFrame:frame];
    [timesView setBackgroundColor:[UIColor clearColor]];
    [timesView setAlpha:0];
    
    CGFloat x = [ANLCycleView barXOrigin];
    CGFloat width = (frame.size.width - x - [ANLCycleView rightPad]) / 8;
    
    for (NSInteger n = 1; n < 9; n++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, height)];
        [label setFont:[UIFont spaghettiFontWithSize:18]];
        [label setText:[@(n) stringValue]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [label setTextColor:[UIColor blackColor]];

        [timesView addSubview:label];
        x += width;
    }
    [self addSubview:timesView];
    
    return timesView;
}

@end
