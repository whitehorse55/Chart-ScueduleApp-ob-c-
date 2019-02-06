//
//  ANLStepsCardView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//
/////////////////////////////////////////////////////////////////
//
//  The data is received with the next formate
//
//  NSDictionary with the next keys
//    @"totalCycles" - number of cycles
//    @"steps"       - NSArray with one dictionary for each step used
//  The dictionary for the steps data have the keys
//      @"max" - The maximum duration in a cycle
//      @"avg" - The average duration
//      @"min" - The minimum duration
//      @"nCycles" - The number of the cycles that the steps is used
//      @"name" - The name of the step
//

#import "ANLStepsCardView.h"
#import "ANLStepsContentView.h"



const struct ANLStepsCardKey ANLStepsCardKey = {
    
    .totalCycles = @"totalCycles",
    .steps = @"steps",
    .max = @"max",
    .avg = @"avg",
    .min = @"min",
    .nCycles = @"nCycles",
    .name = @"name",
};



@interface ANLStepsCardView ()

@property (strong, nonatomic) ANLStepsContentView *contentView;
@property (strong, nonatomic) UIFont *smallFont;
@property (strong, nonatomic) NSNumber *totalCycles;
@property (strong, nonatomic) NSNumber *nSteps;
@property (strong, nonatomic) NSNumber *allCycles;

@property (nonatomic) CGFloat radius;


@end



@implementation ANLStepsCardView

+(CGFloat)labelGap {
    
    return 5.0f;
}

+(CGRect)iconFrame {
    
    CGFloat headHeight = [ANLCardView headHeight];
    CGFloat iconHeight = headHeight * .8f;
    CGFloat iconWidth = iconHeight * .66f;
    return CGRectMake([ANLCardView gap], headHeight - (iconHeight + [ANLCardView headHeight] / 12),
                      iconWidth, iconHeight);
}

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data {
    
    self = [super initWithOriginY:y type:anlCardTypeSteps];
    if (self) {
        
        [self calculateHeadDataWithData:data];
        [self setRadius:[ANLStepsCardView iconFrame].size.height / 4.5];
        
        [self addLabels];
        [self setContentView:[self addStepsWithData:data]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4);

    CGRect iconFrame = [ANLStepsCardView iconFrame];
    CGFloat radius = [self radius];
    
    CGFloat centerX = iconFrame.origin.x + iconFrame.size.width / 2;
    
    CGRect circle = CGRectMake(centerX - radius, iconFrame.origin.y, radius * 2, radius * 2);
    CGContextFillEllipseInRect(context, circle);

    circle.origin.y = iconFrame.origin.y + iconFrame.size.height - radius * 2;
    CGContextFillEllipseInRect(context, circle);
    
    CGContextMoveToPoint(context, centerX, iconFrame.origin.y + radius);
    CGContextAddLineToPoint(context, centerX, circle.origin.y + radius);
    
    CGContextStrokePath(context);
}

-(void)calculateHeadDataWithData:(NSDictionary *)data {
    
    NSArray *dic = [data objectForKey:ANLStepsCardKey.steps];
    NSInteger total = [[data objectForKey:ANLStepsCardKey.totalCycles] integerValue];
    
    __block NSUInteger inAllCycles = 0;
    [dic enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSInteger cycles = [[obj objectForKey:ANLStepsCardKey.nCycles] integerValue];
        inAllCycles += (cycles == total) ? 1 : 0;
    }];
    
    [self setTotalCycles:@(total)];
    [self setAllCycles:@(inAllCycles)];
    [self setNSteps:@([dic count])];
}

-(void)addLabels {
    
    CGRect iconFrame = [ANLStepsCardView iconFrame];
    CGFloat x = iconFrame.origin.x + iconFrame.size.width + [ANLStepsCardView labelGap];
    CGFloat height = iconFrame.origin.y + iconFrame.size.height / 2;
    NSString *title = [Language stringForKey:@"Tasks"];
    
    UIFont *bigFont = [[UIFont boldSystemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    NSDictionary *bigFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName            : bigFont};
    
    CGSize bigSize = [title sizeWithAttributes:bigFontAtt];
    CGRect bigLabelFrame = CGRectMake(x, 0, bigSize.width, bigSize.height);
    UILabel *cardName = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [cardName setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:bigFontAtt]];
    [cardName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardName];
    
    height = iconFrame.size.height / 2;
    title = [Language stringForKey:@"Total cycles:"];
    title = [title stringByAppendingString:[[self totalCycles] stringValue]];
    
    UIFont *smallFont = [[UIFont systemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    [self setSmallFont:smallFont];
    NSDictionary *smallFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName            : smallFont};
    
    CGSize smallSize = [title sizeWithAttributes:smallFontAtt];
    CGRect smallLabelFrame = CGRectMake(x, bigLabelFrame.origin.y + bigLabelFrame.size.height,
                                        smallSize.width, smallSize.height);
    
    UILabel *cardCycles = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [cardCycles setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:smallFontAtt]];
    [cardCycles setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardCycles];
    
    title = [Language stringForKey:@"#tasks:"];
    title = [NSString stringWithFormat:@"%@ %@", title, [[self nSteps] stringValue]];
    bigLabelFrame.size = [title sizeWithAttributes:bigFontAtt];
    bigLabelFrame.origin.x = [self bounds].size.width - (bigLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *stepsLabel = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [stepsLabel setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:bigFontAtt]];
    [stepsLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:stepsLabel];
    
    title = [Language stringForKey:@"Tasks in all cycles"];
    title = [NSString stringWithFormat:@"%@ %@", title, [[self allCycles] stringValue]];
    smallLabelFrame.size = [title sizeWithAttributes:smallFontAtt];
    smallLabelFrame.origin.x = [self bounds].size.width - (smallLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *allLabel = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [allLabel setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:smallFontAtt]];
    [allLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:allLabel];
}

-(ANLStepsContentView *)addStepsWithData:(NSDictionary *)data {
    
    CGRect frame = CGRectMake([ANLCardView gap], [ANLCardView headHeight],
                              [self bounds].size.width - [ANLCardView gap] * 2,
                              [self bounds].size.height - [ANLCardView headHeight]);
    
    ANLStepsContentView *content = [[ANLStepsContentView alloc] initWithFrame:frame data:data
                                                                         font:[self smallFont] radius:[self radius]];
    [self addSubview:content];
    
    return content;
}

@end
