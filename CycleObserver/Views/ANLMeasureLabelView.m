//
//  ANLMeasureLabelView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 24/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLMeasureLabelView.h"



@implementation ANLMeasureLabelView

+(CGFloat)leftOffSet {
    
    return 15.0f;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor colorForGreyLine] CGColor]);
    
    CGContextMoveToPoint(context, [ANLMeasureLabelView leftOffSet], rect.size.height-1);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1);
    CGContextStrokePath(context);
}

@end
