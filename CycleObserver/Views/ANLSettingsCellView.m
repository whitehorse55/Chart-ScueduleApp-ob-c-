//
//  ANLSettingsCellView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 25/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSettingsCellView.h"



@implementation ANLSettingsCellView

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor colorForGreyLine] CGColor]);
    
    CGContextMoveToPoint(context, [self leftEdge], rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
}

@end
