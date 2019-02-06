//
//  ANLVACardView.m
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
//    @"taktTime"       - The taktTime selected by the user.
//    @"totalCycle"     - The total of cycles in the measure.
//    @"percentageVA"   - The % of type VA on total.
//    @"percentageNVAi" - The % of type NVAi on total.
//    @"percentageNVA"  - The % of type NVA on total.
//    @"tasksVA"        - The number of VA tasks.
//    @"tasksNVAi"      - The number of VA tasks.
//    @"tasksNVA"       - The number of VA tasks.
//    @"completeData"   - An array with one dictionary for each step used in the measure. :
//                  @"name"    - The name of the step or VA noncyclical / NVA noncyclical for the noncyclical fields
//                  @"value"   - The average of all measures with this step
//                  @"type"    - VA_cyclical, VA_noncyclical, NVAi, NVA
//                  @"nCycles" - number of cycles that the tasks is present.
//

#import "ANLVACardView.h"



const struct ANLVACardKey ANLVACardKey = {
  
    .taktTime = @"taktTime",
    .totalCycles = @"totalCycles",
    .completeData = @"completeData",
    .name = @"name",
    .value = @"value",
    .type = @"type",
    .nCycles = @"nCycles",
    .percentageVA = @"percentageVA",
    .percentageNVAi = @"percentageNVAi",
    .percentageNVA = @"percentageNVA",
    .tasksVA = @"tasksVA",
    .tasksNVAi = @"tasksNVAi",
    .tasksNVA = @"tasksNVA",

};



@interface ANLVACardView ()

@property (strong, nonatomic) UIFont *smallFont;
@property (strong, nonatomic) NSNumber *avgSteps;
@property (strong, nonatomic) NSNumber *cycleMax;
@property (strong, nonatomic) NSNumber *cycleMin;
@property (strong, nonatomic) NSNumber *percentageVA;
@property (strong, nonatomic) NSNumber *percentageNVAi;
@property (strong, nonatomic) NSNumber *percentageNVA;
@property (strong, nonatomic) NSNumber *tasksVA;
@property (strong, nonatomic) NSNumber *tasksNVAi;
@property (strong, nonatomic) NSNumber *tasksNVA;


@end



@implementation ANLVACardView

+(CGFloat)labelGap {
    
    return 5.0f;
}

+(CGRect)iconFrame {
    
    CGFloat headHeight = [ANLCardView headHeight];
    CGFloat iconHeight = headHeight * .8f;
    CGFloat iconWidth = iconHeight * .66f;
    CGFloat gap = iconWidth / 10;
    return CGRectMake([ANLCardView gap] + gap, headHeight + gap - (iconHeight + [ANLCardView headHeight] / 12),
                      iconWidth - gap * 2, iconHeight - gap * 2);
}

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data {
    
    if (self = [super initWithOriginY:y type:anlCardTypeVa_nva]) {
        
        NSInteger avg = [[[data objectForKey:ANLVACardKey.completeData] valueForKeyPath:@"@sum.value"] intValue];
        [self setAvgSteps:@(avg)];
        [self setPercentageVA:[data objectForKey:ANLVACardKey.percentageVA]];
        [self setPercentageNVAi:[data objectForKey:ANLVACardKey.percentageNVAi]];
        [self setPercentageNVA:[data objectForKey:ANLVACardKey.percentageNVA]];
        [self setTasksVA:[data objectForKey:ANLVACardKey.tasksVA]];
        [self setTasksNVAi:[data objectForKey:ANLVACardKey.tasksNVAi]];
        [self setTasksNVA:[data objectForKey:ANLVACardKey.tasksNVA]];
        
        [self addLabels];
        [self addContentViewWithData:data];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {

    [super drawRect:rect];

    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    //  Dibujamos el icono de barra
    CGRect iconRect = [ANLVACardView iconFrame];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:iconRect cornerRadius:1];
    [path setLineWidth:2];
    [path stroke];
    
    iconRect.origin.y += iconRect.size.height / 3;
    iconRect.size.height *= 0.66f;
    path = [UIBezierPath bezierPathWithRoundedRect:iconRect cornerRadius:1];
    [path fill];
}

-(void)addLabels {
    
    CGRect iconFrame = [ANLVACardView iconFrame];
    CGFloat x = iconFrame.origin.x + iconFrame.size.width + [ANLVACardView labelGap];
    CGFloat height = iconFrame.origin.y + iconFrame.size.height / 2;
    NSString *title = [Language stringForKey:@"VA / NVA"];
    
    UIFont *bigFont = [[UIFont boldSystemFontOfSize:18] adjustSizeToFitText:title inHeight:height];
    NSDictionary *bigFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName            : bigFont};
    
    CGSize bigSize = [title sizeWithAttributes:bigFontAtt];
    CGRect bigLabelFrame = CGRectMake(x, 0, bigSize.width, bigSize.height);
    UILabel *cardName = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [cardName setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:bigFontAtt]];
    [cardName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardName];
    
    NSString *tasksTitle = [Language stringForKey:@"Tasks"];
    tasksTitle = [NSString stringWithFormat:@"%@: %@ VA, %@ NVAi, %@ NVA", tasksTitle, [[self tasksVA] stringValue],
                                                        [[self tasksNVAi] stringValue], [[self tasksNVA] stringValue]];
    
    NSString *percTitle = [NSString stringWithFormat:@"VA:%@%% NVAi:%@%% NVA:%@%%", [self percentageVA],
                                                                        [self percentageNVAi], [self percentageNVA]];
    NSString *totalText = [NSString stringWithFormat:@"%@  %@", percTitle, tasksTitle];
    
    CGSize textSize = CGSizeMake([self width] - [ANLCardView gap] * 2 - x, iconFrame.size.height / 2);
    UIFont *smallFont = [[UIFont systemFontOfSize:18] adjustSizeToFitText:totalText inSize:textSize];
    [self setSmallFont:smallFont];
    NSDictionary *smallFontAtt = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName            : smallFont};
    
    CGSize smallSize = [percTitle sizeWithAttributes:smallFontAtt];
    CGRect smallLabelFrame = CGRectMake(x, bigLabelFrame.origin.y + bigLabelFrame.size.height,
                                        smallSize.width, smallSize.height);
    
    UILabel *cardCycles = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [cardCycles setAttributedText:[[NSAttributedString alloc] initWithString:percTitle attributes:smallFontAtt]];
    [cardCycles setBackgroundColor:[UIColor clearColor]];
    [self addSubview:cardCycles];
    
    NSString *averageTitle = [Language stringForKey:@"∑avg tasks"];
    averageTitle = [NSString stringWithFormat:@"%@ %@", averageTitle, [[self avgSteps] stringValue]];
    bigLabelFrame.size = [averageTitle sizeWithAttributes:bigFontAtt];
    bigLabelFrame.origin.x = [self bounds].size.width - (bigLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *stepsLabel = [[UILabel alloc] initWithFrame:bigLabelFrame];
    [stepsLabel setAttributedText:[[NSAttributedString alloc] initWithString:averageTitle attributes:bigFontAtt]];
    [stepsLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:stepsLabel];
    
    smallLabelFrame.size = [tasksTitle sizeWithAttributes:smallFontAtt];
    smallLabelFrame.origin.x = [self bounds].size.width - (smallLabelFrame.size.width + [ANLCardView gap]);
    
    UILabel *allLabel = [[UILabel alloc] initWithFrame:smallLabelFrame];
    [allLabel setAttributedText:[[NSAttributedString alloc] initWithString:tasksTitle attributes:smallFontAtt]];
    [allLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:allLabel];
}

-(void)addContentViewWithData:(NSDictionary *)data {
    
    CGRect frame = CGRectMake([ANLCardView gap], [ANLCardView headHeight],
                              [self bounds].size.width - [ANLCardView gap] * 2,
                              [self bounds].size.height - [ANLCardView headHeight]);
    
    ANLVAContentView *content = [[ANLVAContentView alloc] initWithFrame:frame data:data];
    [self addSubview:content];
}

@end
