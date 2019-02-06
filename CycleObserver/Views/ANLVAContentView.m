//
//  ANLVAContentView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 31/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLVAContentView.h"



@interface ANLVAContentView ()

@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *completeData;
@property (strong, nonatomic) NSArray *cyclicalData;

@property (nonatomic) CGFloat taktTime;
@property (nonatomic) CGFloat completeTaktTime;
@property (nonatomic) CGFloat cyclicalTaktTime;

@end



@implementation ANLVAContentView

+(CGFloat)footer {
    
    return 15.0f;
}

+(CGFloat)leftGap {
    
    return 30.0f;
}

+(CGFloat)barWidth {

    return ([[UIScreen mainScreen] bounds].size.width > 320) ? 50.0f : 30.0f;
}

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setData:data];
        [self calculateStatistics];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    CGFloat x = [ANLVAContentView leftGap] + 0.5f;
    CGFloat gap = [ANLVAContentView footer];
    rect.size.height -= gap * 2;
    CGFloat barWidth = [ANLVAContentView barWidth];
    CGFloat labelsWidht = (rect.size.width - x * 2 - barWidth * 2 - gap * 2) / 2;
    CGFloat percLabelWidth = labelsWidht / 3 * 2;
    CGFloat floor = rect.size.height;
    CGFloat rightLimit = rect.size.width - gap;
    NSInteger higher = MAX(MAX([self completeTaktTime], [self taktTime]), [self cyclicalTaktTime]);
    CGFloat scale = (floor - gap) / higher * .97;
    
    UIColor *white = [UIColor whiteColor];
    UIColor *red = [UIColor colorWithSelectStateButtonColor:anlButtonColorRed];
    UIColor *yellow = [UIColor colorWithSelectStateButtonColor:anlButtonColorYellow];
    [white setStroke];
    [white setFill];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
    //  Draw the axis
    CGContextMoveToPoint(context, x, gap);
    CGContextAddLineToPoint(context, x, rect.size.height);
    CGContextAddLineToPoint(context, rightLimit, rect.size.height);
    CGContextStrokePath(context);
    
    //  Draw taktTime line
    CGContextSaveGState(context);
    
    CGFloat tt[2] = {5, 3};
    CGContextSetLineDash(context, 0, tt, 2);
    
    CGFloat yTaktTime = floor - [self taktTime] * scale;
    CGContextMoveToPoint(context, x, yTaktTime);
    CGContextAddLineToPoint(context, x + labelsWidht + percLabelWidth + gap + barWidth * 2 + 1.5, yTaktTime);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    //  Draw complete and cyclical taktTimes
    CGContextSaveGState(context);
    
    CGFloat dash[2] = {1, 3};
    CGContextSetLineDash(context, 0, dash, 2);
    
    CGFloat yCompleteTakt = floor - [self completeTaktTime] * scale;
    CGContextMoveToPoint(context, x, yCompleteTakt);
    CGContextAddLineToPoint(context, x + labelsWidht + percLabelWidth + gap * 2 + barWidth + 1.5, yCompleteTakt);
    CGContextStrokePath(context);
    
    CGFloat yCyclicalTakt = floor - [self cyclicalTaktTime] * scale;
    CGContextMoveToPoint(context, x, yCyclicalTakt);
    CGContextAddLineToPoint(context, x + percLabelWidth + gap + barWidth / 2, yCyclicalTakt);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    //  add taktTimes labels
    CGFloat radius = 7.0f;
    CGRect frame = CGRectMake(gap / 4, yCompleteTakt - radius , [ANLVAContentView leftGap] - gap / 2, radius * 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius];
    [path setLineWidth:2];
    [path stroke];
    [self addLabelWithFrame:frame text:[@((NSInteger)[self completeTaktTime]) stringValue] andColor:white];
    
    frame.origin.y = yCyclicalTakt - radius;
    path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius];
    [path setLineWidth:2];
    [path stroke];
    [self addLabelWithFrame:frame text:[@((NSInteger)[self cyclicalTaktTime]) stringValue] andColor:white];
    
    frame.origin.y = yTaktTime - radius;
    frame.origin.x--;
    frame.size.width += 2;
    frame.size.height += 2;
    path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius];
    [path fill];
    [self addLabelWithFrame:frame text:[@((NSInteger)[self taktTime]) stringValue]
                   andColor:[UIColor colorWithRed:0.251 green:0.322 blue:0.122 alpha:1]];
    
    //  Init var for draw bars and labels
    CGFloat totalVA = 0;
    CGFloat totalNVAi = 0;
    CGFloat totalNVA = 0;
    CGFloat y = floor;
    CGFloat xBar = x + percLabelWidth;
    
    //  Draw cyclicalBar with labels
    NSArray *data = [self cyclicalData];
    for (NSDictionary *bar in data) {
        
        NSNumber *value = [bar objectForKey:@"value"];
        CGFloat height = [value floatValue] * scale;
        y -= height;
        CGRect barFrame = CGRectMake(xBar, y, barWidth, height);
        CGContextStrokeRectWithWidth(context, barFrame, 2);
        
        anlStepType type = [[bar objectForKey:@"type"] integerValue];
        CGRect textFrame = CGRectMake(xBar + barWidth + 5, y + height / 2 - radius, labelsWidht, radius * 2);
        NSString *text = [NSString stringWithFormat:@"%@ %@", [@([value intValue]) stringValue], bar[@"name"]];
        [self addStepLabelWithFrame:textFrame text:text alignment:NSTextAlignmentLeft];
        
        totalVA += (type < anlStepTypeNVAi) ? [value floatValue] : 0;
        totalNVAi += (type == anlStepTypeNVAi) ? [value floatValue] : 0;
        totalNVA += (type == anlStepTypeNVA) ? [value floatValue] : 0;
    }
    //  Fill NVA and VAnon values
    if (totalVA > 0) {
        
        CGFloat vaHeight = totalVA * scale;
        CGFloat yOrigin = floor - vaHeight;
        CGRect textFrame = CGRectMake(x, yOrigin + vaHeight / 2 - radius * 2, percLabelWidth, radius * 4);
        NSString *perc = [[[self data] objectForKey:@"percentageVA"] stringValue];
        NSString *text = [NSString stringWithFormat:@"VA %@%%", perc];
        [self addPercentageLabelWithFrame:textFrame text:text size:10];
    }
    if (totalNVAi > 0) {
        
        CGContextSaveGState(context);
        CGFloat yOrigin = floor - (totalVA + totalNVAi) * scale;
        CGRect frame = CGRectMake(xBar, yOrigin, barWidth, totalNVAi * scale);
        UIBezierPath *pathVAnon = [self bezierPathWithRect:frame type:anlStepTypeVA_noncyclical];
        [yellow setStroke];
        [pathVAnon stroke];
        CGContextRestoreGState(context);
        
        CGRect textFrame = CGRectMake(x, yOrigin + frame.size.height / 2 - radius * 2, percLabelWidth, radius * 4);
        NSString *perc = [[[self data] objectForKey:@"percentageNVAi"] stringValue];
        NSString *text = [NSString stringWithFormat:@"NVAi %@%%", perc];
        [self addPercentageLabelWithFrame:textFrame text:text size:10];
    }
    if (totalNVA > 0) {
        
        CGContextSaveGState(context);
        CGFloat yOrigin = floor - (totalVA + totalNVAi + totalNVA) * scale;
        CGRect frame = CGRectMake(xBar, yOrigin, barWidth, totalNVA * scale);
        UIBezierPath *pathNVA = [self bezierPathWithRect:frame type:anlStepTypeNVA];
        [red setStroke];
        [pathNVA stroke];
        CGContextRestoreGState(context);
        
        CGRect textFrame = CGRectMake(x, yOrigin + frame.size.height / 2 - radius * 2, percLabelWidth, radius * 4);
        NSString *perc = [[[self data] objectForKey:@"percentageNVA"] stringValue];
        NSString *text = [NSString stringWithFormat:@"NVA %@%%", perc];
        [self addPercentageLabelWithFrame:textFrame text:text size:10];
    }
    //  Add texts labels in the footer
    frame = CGRectMake(xBar - barWidth / 2, rect.size.height, barWidth * 2, gap * 2);
    frame.origin.y += (barWidth > 30) ? 4 : 0;
    frame.size.height -= (barWidth > 30) ? gap : 0;
    
    NSString *text = [Language stringForKey:@"Average Cycle"];
    [self addPercentageLabelWithFrame:frame text:text size:12];

    //  Draw completeBar with labels
    totalVA = 0;
    totalNVAi = 0;
    totalNVA = 0;
    y = floor;
    xBar += barWidth + labelsWidht + gap;
    data = [self completeData];
    for (NSDictionary *bar in data) {
        
        NSNumber *value = [bar objectForKey:@"value"];
        CGFloat height = [value floatValue] * scale;
        y -= height;
        CGRect barFrame = CGRectMake(xBar, y, barWidth, height);
        CGContextStrokeRectWithWidth(context, barFrame, 2);
        
        CGRect textFrame = CGRectMake(xBar + barWidth + gap / 2, y + height / 2 - radius, labelsWidht, radius * 2);
        NSString *duration = [@([value intValue]) stringValue];
        NSString *text = [NSString stringWithFormat:@"%@ %@", [bar objectForKey:@"name"], duration];
        [self addStepLabelWithFrame:textFrame text:text alignment:NSTextAlignmentLeft];
        anlStepType type = [[bar objectForKey:@"type"] integerValue];

        totalVA += (type < anlStepTypeNVAi) ? [value floatValue] : 0;
        totalNVAi += (type == anlStepTypeNVAi) ? [value floatValue] : 0;
        totalNVA += (type == anlStepTypeNVA) ? [value floatValue] : 0;
    }
    //  Fill the NVAi and NVA values and percentage label
    if (totalNVAi > 0) {
    
        CGContextSaveGState(context);
        CGFloat yOrigin = floor - (totalVA + totalNVAi) * scale;
        CGRect frame = CGRectMake(xBar, yOrigin, barWidth, totalNVAi * scale);
        UIBezierPath *pathNVAi = [self bezierPathWithRect:frame type:anlStepTypeNVAi];
        [yellow setStroke];
        [pathNVAi stroke];
        CGContextRestoreGState(context);
    }
    if (totalNVA > 0) {
        
        CGContextSaveGState(context);
        CGFloat yOrigin = floor - (totalVA + totalNVAi + totalNVA) * scale;
        CGRect frame = CGRectMake(xBar, yOrigin, barWidth, totalNVA * scale);
        UIBezierPath *pathNVA = [self bezierPathWithRect:frame type:anlStepTypeNVA];
        [red setStroke];
        [pathNVA stroke];
        CGContextRestoreGState(context);
    }
    //  Add title for sum of cycles bar
    frame.origin.x = xBar - barWidth / 2;
    text = [Language stringForKey:@"Sum of tasks"];
    [self addPercentageLabelWithFrame:frame text:text size:12];
}

-(UIBezierPath *)bezierPathWithRect:(CGRect)frame type:(anlStepType)type {

    //  Ajustamos los colores dentro de su marco.
    CGRect pathFrame = frame;
    pathFrame.origin.x++;
    pathFrame.origin.y++;
    pathFrame.size.width -= 2;
    pathFrame.size.height -= 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:pathFrame];
    [path addClip];
    [path removeAllPoints];
    [path setLineWidth:[ANLVAContentView barWidth] / 10];
    
    BOOL toLeft = (type == anlStepTypeNVAi || type == anlStepTypeVA_noncyclical);
    CGFloat space = [ANLVAContentView barWidth] / 3;
    space *= toLeft ? 1 : -1;
    CGFloat x = toLeft ? frame.origin.x + 5 : frame.origin.x + frame.size.width - 5;
    CGFloat height = frame.size.height - 0;
    CGFloat finalY = frame.origin.y - 1;
    CGFloat y = finalY + height + 2;
    height *= toLeft ? -1 : 1;
    BOOL complete = NO;
    
    while (!complete) {

        [path moveToPoint:CGPointMake(x, y)];
        [path addLineToPoint:CGPointMake(x + height, finalY)];
        x += space;
        complete = toLeft ? x + height > frame.origin.x + frame.size.width : x + height < frame.origin.x;
    }
    return path;
}

-(void)addLabelWithFrame:(CGRect)frame text:(NSString *)text andColor:(UIColor *)color {
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:text];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:color];
    [lbl setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:lbl];
}

-(void)addStepLabelWithFrame:(CGRect)frame text:(NSString *)text alignment:(NSTextAlignment)alignment {
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:text];
    [lbl setTextAlignment:alignment];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:[UIFont systemFontOfSize:10]];
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
    if (size.width > frame.size.width) {
        
        frame.origin.y -= frame.size.height / 2;
        frame.size.height *= 2;
        [lbl setFrame:frame];
        [lbl setNumberOfLines:2];
    }
    [lbl adjustsFontSizeToFitWidth];
    [self addSubview:lbl];
}

-(void)addPercentageLabelWithFrame:(CGRect)frame text:(NSString *)text size:(CGFloat)size{
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:text];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:[UIFont systemFontOfSize:size]];
    [lbl setNumberOfLines:2];
    [self addSubview:lbl];
}

-(void)calculateStatistics {
    
    NSArray *textSuffix = @[@" VA", @" VA", @" NVAi", @" NVA"];
    NSDictionary *data = [self data];
    [self setTaktTime:[[data objectForKey:@"taktTime"] floatValue]];
    
    NSArray *completeData = [data objectForKey:@"completeData"];
    [self setCompleteData:completeData];
    [self setCompleteTaktTime:[[completeData valueForKeyPath:@"@sum.value"] floatValue]];
    
    NSInteger totalCycles = [data[@"totalCycles"] integerValue];
    CGFloat otherValue = 0;
    anlStepType lastType = anlStepTypeVA_noncyclical;
    NSMutableArray *cyclicalData = [[NSMutableArray alloc] init];
    
    for (NSDictionary *task in completeData) {
        
        anlStepType type = [task[@"type"] integerValue];
        //  If the type is different to the current, save other duration and start new other
        if (type > lastType) {

            NSString *name = [Language stringForKey:@"vaContentView.cyclicalBar.Other"];
            name = [name stringByAppendingString:[textSuffix objectAtIndex:lastType]];
            [cyclicalData addObject:@{@"name" : name, @"value" : @(otherValue), @"type" : @(lastType)}];
            
            otherValue = 0;
            lastType = type;
        }
        //  If the task are in all cycles, save in the cyclicalData, else add duration to others
        if ([task[@"nCycles"] integerValue] == totalCycles) {
            
            [cyclicalData addObject:task];
        } else {
            
            otherValue += [task[@"value"] floatValue];
        }
    }
    if (otherValue > 0) {
        
        NSString *name = [Language stringForKey:@"vaContentView.cyclicalBar.Other"];
        name = [name stringByAppendingString:[textSuffix objectAtIndex:lastType]];
        [cyclicalData addObject:@{@"name" : name, @"value" : @(otherValue), @"type" : @(lastType)}];
    }
    [self setCyclicalData:[cyclicalData copy]];
    [self setCyclicalTaktTime:[[cyclicalData valueForKeyPath:@"@sum.value"] floatValue]];
}

@end