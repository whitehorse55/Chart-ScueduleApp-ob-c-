//
//  ANLBarView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 29/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLBarView.h"



@interface ANLBarView ()

@property (nonatomic) CGFloat footerHeight;
@property (nonatomic) CGFloat barHeight;
@property (nonatomic) NSUInteger index;
@property (nonatomic) NSInteger measure;

@end



@implementation ANLBarView

-(instancetype)initWithFrame:(CGRect)frame footer:(CGFloat)footer
                   barHeight:(CGFloat)height index:(NSUInteger)index measure:(NSInteger)measure {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFooterHeight:footer];
        [self setBarHeight:height];
        [self setMeasure:measure];
        [self addLabelWithIndex:index];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [[UIColor whiteColor] setFill];
    
    CGFloat width = rect.size.width / 2;
    CGFloat base = rect.size.height - [self footerHeight] - 4;
    CGFloat height = [self barHeight];
    BOOL broken = (base - height) < 2;
    CGFloat yOrigin = MAX(base - height, 4);
    CGRect rectPath = CGRectMake(width / 2, yOrigin, width, base - yOrigin);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rectPath cornerRadius:2];
    [path fill];
    
    if (broken) {
        
        [path removeAllPoints];
        [path setLineWidth:2];
        UIColor *color = [UIColor colorWithRed:0.808 green:0.153 blue:0.122 alpha:1];
        [color setStroke];
        
        CGFloat heightLine = 4.0f;
        CGPoint point = CGPointMake(rectPath.origin.x - 1, rectPath.size.height / 2);
        [path moveToPoint:point];
        point.x += rectPath.size.width * 0.75;
        point.y -= heightLine;
        [path addLineToPoint:point];
        point.x -= rectPath.size.width * 0.33;
        point.y -= heightLine / 2;
        [path addLineToPoint:point];
        point.x = rectPath.origin.x + rectPath.size.width + 1;
        point.y -= heightLine;
        [path addLineToPoint:point];
        [path stroke];
        
        CGRect frame = rectPath;
        frame.size.height = heightLine * 4;
        UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:[@([self measure]) stringValue]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:color];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl adjustsFontSizeToFitWidth];
        [self addSubview:lbl];
    }
}

-(void)addLabelWithIndex:(NSUInteger)index {
    
    NSString *title = [@(index) stringValue];
    CGFloat height = [self footerHeight] / 2;
    UIFont *font = [[UIFont systemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    
    CGRect frame = CGRectMake(0, [self bounds].size.height - [self footerHeight] + 4, [self bounds].size.width, height);
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:title];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:font];
    
    [self addSubview:lbl];
}

@end
