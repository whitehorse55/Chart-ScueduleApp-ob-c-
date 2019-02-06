//
//  ANLGeneralDataView.m
//  Chrono
//
//  Created by Amador Navarro Lucas on 14/1/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLGeneralDataView.h"



@implementation ANLGeneralDataView

+(CGFloat)heightCell {
    
    return 50.0f;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor colorForGreyLine] CGColor]);
    
    for (NSInteger idx = 1; idx < 7; idx++) {
        
        CGFloat y = idx * [ANLGeneralDataView heightCell];
        CGContextSetLineWidth(context, (idx == 5) ? 2 : 1);
        CGContextMoveToPoint(context, rect.origin.x, y);
        CGContextAddLineToPoint(context, rect.size.width, y);
        CGContextStrokePath(context);
    }
}

@end
