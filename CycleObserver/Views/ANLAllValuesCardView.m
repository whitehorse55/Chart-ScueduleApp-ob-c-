//
//  ANLAllValuesCardView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//
/////////////////////////////////////////////////////////////////
//
//  The data is received with the next formate
//
//  NSDictionary with keys:
//    @"taktTime"    - the taktTime select by the user
//    @"avgTaktTime" - the average taktTime of all cycles
//    @"data"        - a NSArray with the total duration of each cycle
//

#import "ANLAllValuesCardView.h"
#import "ANLAllValuesScrollView.h"



const struct ANLAllValuesCardKey ANLAllValuesCardKey = {
    
    .taktTime = @"taktTime",
    .avgTaktTime = @"avgTaktTime",
    .data = @"data",
    .maxDuration = @"maxDuration",
    .minDuration = @"minDuration",
};



@interface ANLAllValuesCardView ()

@property (strong, nonatomic) ANLAllValuesScrollView *scrollView;
@property (strong, nonatomic) NSNumber *totalCycles;
@property (strong, nonatomic) NSNumber *taktTime;
@property (strong, nonatomic) NSNumber *avgTaktTime;
@property (strong, nonatomic) NSNumber *cycleMax;
@property (strong, nonatomic) NSNumber *cycleMin;

@end



@implementation ANLAllValuesCardView

+(CGFloat)labelGap {
    
    return 5.0f;
}

+(CGRect)sandClockFrame {
    
    CGFloat headHeight = [ANLCardView headHeight];
    CGFloat sandClockHeight = headHeight * .8f;
    CGFloat sandClockWidth = sandClockHeight * .66f;
    CGFloat gap = sandClockWidth / 10;
    return CGRectMake([ANLCardView gap] + gap, headHeight + gap - (sandClockHeight + [ANLCardView headHeight] / 12),
                      sandClockWidth - gap * 2, sandClockHeight - gap * 2);
}

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data {
    
    self = [super initWithOriginY:y type:anlCardTypeAllCycles];
    if (self) {
        
        [self setTaktTime:[data objectForKey:ANLAllValuesCardKey.taktTime]];
        [self setAvgTaktTime:[data objectForKey:ANLAllValuesCardKey.avgTaktTime]];
        [self setTotalCycles:@([[data objectForKey:ANLAllValuesCardKey.data] count])];
        [self setCycleMax:[data objectForKey:ANLAllValuesCardKey.maxDuration]];
        [self setCycleMin:[data objectForKey:ANLAllValuesCardKey.minDuration]];
        
        [self addLabels];
        [self addScrollViewWithData:data];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //  Dibujamos el reloj de arena
    CGRect clockFrame = [ANLAllValuesCardView sandClockFrame];
    CGFloat y = clockFrame.origin.y + clockFrame.size.height / 2;
    CGFloat x = clockFrame.origin.x + clockFrame.size.width / 2;

    CGContextMoveToPoint(context, x, y);
    
    x += clockFrame.size.width / 2;
    y += clockFrame.size.height / 2;
    CGContextAddLineToPoint(context, x, y);
    
    x -= clockFrame.size.width;
    CGContextAddLineToPoint(context, x, y);

    x += clockFrame.size.width / 2;
    y -= clockFrame.size.height / 2;
    CGContextAddLineToPoint(context, x, y);
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, x, y);
    x += clockFrame.size.width / 2;
    y -= clockFrame.size.height / 2;
    CGContextAddLineToPoint(context, x, y);
    
    x -= clockFrame.size.width;
    CGContextAddLineToPoint(context, x, y);
    
    x += clockFrame.size.width / 2;
    y += clockFrame.size.height / 2;
    CGContextAddLineToPoint(context, x, y);
    CGContextStrokePath(context);
}

-(void)addLabels {
    
    CGRect clockFrame = [ANLAllValuesCardView sandClockFrame];
    CGFloat x = clockFrame.origin.x + clockFrame.size.width + [ANLAllValuesCardView labelGap];
    CGFloat height = clockFrame.size.height / 2 + clockFrame.origin.y;
    NSString *title = [Language stringForKey:@"All cycles"];
    
    UIFont *bigFont = [[UIFont boldSystemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    NSDictionary *bigFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName            : bigFont};
    
    CGSize bigSize = [title sizeWithAttributes:bigFontAtt];
    CGRect bigLabelFrame = CGRectMake(x, 0, bigSize.width, bigSize.height);
    UILabel *cardName = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [cardName setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:bigFontAtt]];
    [cardName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardName];
    
    height = clockFrame.size.height / 2;
    title = [Language stringForKey:@"Cycle: max"];
    title = [NSString stringWithFormat:@"%@ %@", title, [[self cycleMax] stringValue]];
    NSString *localize = [Language stringForKey:@" - min"];
    localize = [NSString stringWithFormat:@"%@ %@", localize, [[self cycleMin] stringValue]];
    title = [title stringByAppendingString:localize];
    
    UIFont *smallFont = [[UIFont systemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    NSDictionary *smallFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName            : smallFont};
    
    CGSize smallSize = [title sizeWithAttributes:smallFontAtt];
    CGRect smallLabelFrame = CGRectMake(x, bigLabelFrame.origin.y + bigLabelFrame.size.height,
                                        smallSize.width, smallSize.height);
    
    UILabel *cardCycles = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [cardCycles setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:smallFontAtt]];
    [cardCycles setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardCycles];
    
    title = [Language stringForKey:@"Avg:"];
    title = [NSString stringWithFormat:@"%@ %@", title, [[self avgTaktTime] stringValue]];
    bigLabelFrame.size = [title sizeWithAttributes:bigFontAtt];
    bigLabelFrame.origin.x = [self bounds].size.width - (bigLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *avgLabel = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [avgLabel setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:bigFontAtt]];
    [avgLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:avgLabel];
    
    title = [Language stringForKey:@"Takt time"];
    title = [NSString stringWithFormat:@"%@ %@", title, [[self taktTime] stringValue]];
    smallLabelFrame.size = [title sizeWithAttributes:smallFontAtt];
    smallLabelFrame.origin.x = [self bounds].size.width - (smallLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *ttLabel = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [ttLabel setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:smallFontAtt]];
    [ttLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:ttLabel];
}

-(void)addScrollViewWithData:(NSDictionary *)data {
    
    CGFloat gap = [ANLCardView gap];
    CGRect frame = CGRectMake(gap, [ANLCardView headHeight],
                              [self bounds].size.width - gap * 2, [self bounds].size.height - [ANLCardView headHeight]);
    
    ANLAllValuesScrollView *scroll = [[ANLAllValuesScrollView alloc] initWithFrame:frame data:data];
    [self setScrollView:scroll];
    [self addSubview:scroll];
}

@end
