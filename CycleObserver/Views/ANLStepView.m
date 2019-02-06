//
//  ANLStepView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 30/3/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLStepView.h"



@interface ANLStepView ()

@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) UIFont *font;

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat scale;

@end



@implementation ANLStepView

+(CGFloat)footerHeight {
    
    return 40.0f;
}

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data
                        font:(UIFont *)font radius:(CGFloat)radius scale:(CGFloat)scale {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setRadius:radius];
        [self setFont:font];
        [self setData:data];
        [self setScale:scale];
        [self addLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4);
    
    CGFloat relation = [self scale];
    CGFloat radius = [self radius];
    CGFloat base = rect.size.height - [ANLStepView footerHeight] - 4;

    CGFloat centerX = rect.size.width / 4;
    CGFloat y = base - [[[self data] objectForKey:@"max"] floatValue] * relation - radius;
    CGRect aboveCircle = CGRectMake(centerX - radius, y, radius * 2, radius * 2);
    CGContextFillEllipseInRect(context, aboveCircle);

    CGRect downCircle = aboveCircle;
    downCircle.origin.y = base - [[[self data] objectForKey:@"min"] floatValue] * relation - radius;
    CGContextFillEllipseInRect(context, downCircle);

    CGContextMoveToPoint(context, centerX, aboveCircle.origin.y + radius);
    CGContextAddLineToPoint(context, centerX, downCircle.origin.y + radius);
    
    NSNumber *avg = @([[[self data] objectForKey:@"avg"] intValue]);
    CGFloat med = base - [avg floatValue] * relation;
    CGContextMoveToPoint(context, centerX - radius, med);
    CGContextAddLineToPoint(context, centerX + radius, med);
    
    NSString *text = [avg stringValue];
    NSDictionary *att = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSFontAttributeName            : [self font]};
    
    CGSize size = [text sizeWithAttributes:att];
    CGFloat pointX = centerX + radius + (rect.size.width / 2 - size.width) / 3;
    [text drawAtPoint:CGPointMake(pointX, med - size.height / 2) withAttributes:att];
    CGContextStrokePath(context);
}

-(void)addLabel {
    
    CGFloat footerHeight = [ANLStepView footerHeight] / 6;
    CGRect frame = CGRectMake(0, [self bounds].size.height - footerHeight * 6 + 4,
                              [self bounds].size.width / 2, footerHeight * 2);

    NSString *text = [NSString stringWithFormat:@"%@x", [[self data] objectForKey:@"nCycles"]];
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setText:text];
    [lbl setFont:[self font]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [self addSubview:lbl];
    
    frame.origin.y += [lbl height];
    UILabel *name = [[UILabel alloc] initWithFrame:frame];
    [name setText:[[self data] objectForKey:@"name"]];
    [name setFont:[self font]];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setTextColor:[UIColor whiteColor]];
    [self addSubview:name];
}

@end
