//
//  ANLTTView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 11/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLTTView.h"



@implementation ANLTTView

#pragma mark - constants

+(CGFloat)segmentGuide {
    
    return 47.5f;
}

-(id)initWithFrame:(CGRect)frame Type:(anlMeasuresViewsType)type {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTaktTimeX:frame.size.width * 0.75f];
        [self setViewsType:type];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    CGContextMoveToPoint(context, [ANLTTView segmentGuide], 0);
    CGContextAddLineToPoint(context, [ANLTTView segmentGuide], rect.size.height - 20.0f);
    CGContextStrokePath(context);
    
    if ([self viewsType] == anlMeasuresViewsTypeSegments) {
        
        CGFloat x = [self taktTimeX];
        CGContextSetLineWidth(context, 0.7f);
        CGContextMoveToPoint(context, x, 0);
        CGContextAddLineToPoint(context, x, rect.size.height - 20.0f);
        CGContextStrokePath(context);
    }
}

-(void)setViewsType:(anlMeasuresViewsType)viewsType {
    
    if (_viewsType != viewsType) {
        
        _viewsType = viewsType;
        [self setNeedsDisplay];
    }
}

@end
