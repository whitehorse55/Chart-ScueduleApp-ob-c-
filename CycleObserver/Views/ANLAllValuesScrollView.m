//
//  ANLAllValuesScrollView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 29/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLAllValuesScrollView.h"
#import "ANLBarView.h"



@interface ANLAllValuesScrollView ()

@property (strong, nonatomic) NSArray *cycles;

@property (nonatomic) NSUInteger taktTime;
@property (nonatomic) NSUInteger avgTaktTime;
@property (nonatomic) CGFloat scale;

@end



@implementation ANLAllValuesScrollView

+(CGFloat)footerHeight {
    
    return 30.0f;
}

+(CGFloat)barWidth {
    
    return 30.0f;
}

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        
        [self parseData:data];
        [self addCyclesMeasuresOfArray:[self cycles]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [[UIColor whiteColor] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
    CGFloat y = rect.size.height - [ANLAllValuesScrollView footerHeight];
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, rect.size.width, y);
    CGContextStrokePath(context);
    
    CGFloat yTT = y - [self taktTime] * [self scale] - 4;
    CGFloat tt[2] = {4, 2};
    CGContextSetLineDash(context, 0, tt, 2);
    CGContextMoveToPoint(context, 0, yTT);
    CGContextAddLineToPoint(context, rect.size.width, yTT);
    CGContextStrokePath(context);
    
    CGFloat yAvg = y - [self avgTaktTime] * [self scale] - 4;
    CGFloat avg[2] = {1, 2};
    CGContextSetLineDash(context, 0, avg, 2);
    CGContextMoveToPoint(context, 0, yAvg);
    CGContextAddLineToPoint(context, rect.size.width, yAvg);
    CGContextStrokePath(context);
}

-(void)parseData:(NSDictionary *)data {
    
    [self setTaktTime:[[data objectForKey:@"taktTime"] integerValue]];
    [self setAvgTaktTime:[[data objectForKey:@"avgTaktTime"] integerValue]];
    [self setCycles:[data objectForKey:@"data"]];
    
    CGFloat height = [self bounds].size.height - [ANLAllValuesScrollView footerHeight] - 4;
    [self setScale:height * 0.75 / MAX([self taktTime], [self avgTaktTime])];
}

-(void)addCyclesMeasuresOfArray:(NSArray *)measures {
    
    __block CGSize contentSize = CGSizeMake(0, [self bounds].size.height);
    __block CGFloat x = 0;
    CGFloat barWidth = [ANLAllValuesScrollView barWidth];
    
    [measures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGFloat measure = [obj floatValue];
        CGRect frame = CGRectMake(x, 0, barWidth, contentSize.height);
        ANLBarView *bar = [[ANLBarView alloc] initWithFrame:frame
                                                     footer:[ANLAllValuesScrollView footerHeight]
                                                  barHeight:measure * [self scale]
                                                      index:idx + 1
                                                    measure:measure];
        [self addSubview:bar];
        contentSize.width += barWidth;
        x += barWidth;
    }];
    [self setContentSize:contentSize];
}

@end
