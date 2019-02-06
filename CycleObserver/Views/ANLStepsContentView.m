//
//  ANLStepsContentView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 30/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLStepsContentView.h"
#import "ANLStepView.h"



@interface ANLStepsContentView ()

@property (strong, nonatomic) NSNumber *totalCycles;
@property (strong, nonatomic) NSArray *steps;
@property (strong, nonatomic) UIFont *font;

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat scale;

@end



@implementation ANLStepsContentView

+(CGFloat)footerHeight {
    
    return 40.0f;
}

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data font:(UIFont *)font radius:(CGFloat)radius {
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *steps = [data objectForKey:@"steps"];
        CGFloat max = [[steps valueForKeyPath:@"@max.max"] floatValue];
        CGFloat scale = (frame.size.height - [ANLStepsContentView footerHeight]) * 0.8 / max;

        [self setBackgroundColor:[UIColor clearColor]];
        [self setTotalCycles:[data objectForKey:@"totalCycles"]];
        [self setSteps:steps];
        [self setRadius:radius];
        [self setFont:font];
        [self setScale:scale];
        [self addSteps:steps];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [[UIColor whiteColor] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    //  Footer line
    CGFloat y = rect.size.height - [ANLStepsContentView footerHeight];
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, rect.size.width, y);
    CGContextStrokePath(context);
}

-(void)addSteps:(NSArray *)steps {
    
    __block CGFloat x = 0;
    CGFloat width = [self bounds].size.width / [steps count];
    
    [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGRect frame = CGRectMake(x, 0, width, [self bounds].size.height);
        ANLStepView *step = [[ANLStepView alloc] initWithFrame:frame data:obj
                                                          font:[self font] radius:[self radius] scale:[self scale]];
        [self addSubview:step];
        x += width;
    }];
}

@end
