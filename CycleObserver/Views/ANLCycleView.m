//
//  ANLCycleView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 12/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.

#import "ANLCycleView.h"
#import "ANLDurationLabel.h"
#import "ANLDurationBtn.h"
#import "ANLMeasure.h"
#import "ANLCycle.h"
#import "ANLSegment.h"
#import "ANLButton.h"



@interface ANLCycleView ()

@property (strong, nonatomic) NSArray *buttonsDurationLbl;
@property (strong, nonatomic) UIButton *removeButton;

@property (nonatomic, getter = isEditing) BOOL editing;

@end



@implementation ANLCycleView

#pragma mark - constants

+(CGFloat)height {
    
    return 30.0f;
}

+(CGFloat)barXOrigin {
    
    return 50.0f;
}

+(CGFloat)rightPad {
    
    return 20.0f;
}

+(CGFloat)barHeight {
    
    return 20.0f;
}

+(CGFloat)upEdge {
    
    return 5.0f;
}



#pragma mark - class methods

+(instancetype)cycleWithFrame:(CGRect)frame index:(NSInteger)index segments:(NSArray *)segments
       pixelsDurationRelation:(CGFloat)relation viewsType:(anlMeasuresViewsType)viewsType {

    ANLCycleView *cycle = [[ANLCycleView alloc] initWithFrame:frame];
    [cycle setSegments:[NSMutableArray arrayWithArray:segments]];
    [cycle setRelationPixelDuration:relation];
    [cycle setIndex:index];
    [cycle setBackgroundColor:[UIColor clearColor]];
    [cycle configureLabels];
    [cycle setViewsType:viewsType];
    [cycle setEditing:NO];
    
    return cycle;
}



#pragma mark - lifeCycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpGestures];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {

    if ([self viewsType] == anlMeasuresViewsTypeTimes) {
        
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat y = rect.origin.y + [ANLCycleView upEdge];
    __block CGFloat x = rect.origin.x + [ANLCycleView barXOrigin];
    __block CGFloat totalDuration = 0;
    
    [[self segments] enumerateObjectsUsingBlock:^(ANLSegment *segment, NSUInteger idx, BOOL *stop) {
        
        ANLButtonColor color = [[[segment button] color] integerValue];
        CGFloat duration = [self durationOfSegment:segment];
        
        NSString *title = [[[segment button] index] stringValue];
        UIColor *titleColor = color == anlButtonColorYellow ? [UIColor blackColor] : [UIColor whiteColor];
        NSDictionary *titleDic = @{NSFontAttributeName            : [UIFont spaghettiFontLightWithSize:8],
                                   NSForegroundColorAttributeName : titleColor};
        
        CGSize titleSize = [title sizeWithAttributes:titleDic];
        NSInteger width = duration * [self relationPixelDuration];

        CGContextSaveGState(context);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, width, [ANLCycleView barHeight])];
        [path addClip];
        [path removeAllPoints];
        
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = NULL;
        CGFloat locs[2] = {1, 0};
        switch (color) {
                
            case anlButtonColorGreen: {
                
                CGFloat components[8] = {0, 0.56, 0, 1, 0, 0.44, 0, 1};
                gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
                }
                break;
                
            case anlButtonColorYellow: {
                
                CGFloat components[8] = {1, 0.98, 0, 1, .88, .86, 0, 1};
                gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
                }
                break;
                
            case anlButtonColorRed: {
                
                CGFloat components[8] = {1, 0.15, 0, 1, .88, .03, 0, 1};
                gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
                }
                break;
                
            default:
            break;
        }
        
        CGFloat originY = y + [ANLCycleView barHeight];
        CGFloat finalY = y;

        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawLinearGradient(context, gradient,
                                    CGPointMake(rect.size.width / 2.0, originY),
                                    CGPointMake(rect.size.width / 2.0, finalY), 0);
        CGColorSpaceRelease(space);
        CGGradientRelease(gradient);
        
        CGContextRestoreGState(context);
        
        if (width > titleSize.width + 2) {
            
            CGPoint point = CGPointMake(x + 2, ([ANLCycleView barHeight] - titleSize.height) / 2);
            [title drawAtPoint:point withAttributes:titleDic];
        }
        x += width + 1;
        totalDuration += duration;
    }];
    [[self totalDurationBtn] setTitle:[@((NSInteger)totalDuration) stringValue] forState:UIControlStateNormal];
}

-(void)dealloc {
    
    [self tearDownGestures];
}



#pragma mark - setters and getters

-(void)setViewsType:(anlMeasuresViewsType)viewsType {
    
    if (_viewsType != viewsType) {

        _viewsType = viewsType;
        
        NSArray *durations;
        switch (_viewsType) {
            case anlMeasuresViewsTypeSegments:
                
                [self setUpGestures];
                [[self buttonsDurationLbl] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    [obj removeFromSuperview];
                }];
                break;
                
            case anlMeasuresViewsTypeTimes:
                
                [self tearDownGestures];
                durations = [self buttonsDuration];
                [[self buttonsDurationLbl] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    ANLDurationLabel *label = obj;
                    [label setText:[durations objectAtIndex:idx]];
                    [self addSubview:label];
                }];
                break;
        }
        [self setNeedsDisplay];
    }
}



#pragma mark - custom methods

-(void)addSegment:(ANLSegment *)segment {
    
    [[self segments] addObject:segment];
    [self redraw];
}

-(void)closeCurrentSegmentWithDuration:(CGFloat)duration {
    
    NSMutableDictionary *dic = [[self segments] lastObject];
    [dic setObject:@(duration) forKey:@"duration"];
    [dic setObject:[NSNull null] forKey:@"initialTime"];
    [self setNeedsDisplay];
}

-(void)redraw {

    if ([self viewsType] == anlMeasuresViewsTypeSegments) {
        
        CGRect frame = [self frame];
        __block CGFloat totalDuration = 0;
        [[self segments] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            totalDuration += [self durationOfSegment:obj];
        }];
        totalDuration *= [self relationPixelDuration];
        CGFloat width = totalDuration + [ANLCycleView barXOrigin] * 2;
        frame.size.width = MAX(width, [[UIScreen mainScreen] bounds].size.width);
        [self setFrame:frame];
        
        [self setNeedsDisplay];
    } else {
        
        NSArray *durations = [self buttonsDuration];
        [[self buttonsDurationLbl] enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            
            [label setText:[durations objectAtIndex:idx]];
        }];
    }
}

-(CGFloat)durationOfSegment:(ANLSegment *)segment {
    
    CGFloat duration = [segment durationValue];
    if (duration == 0) {
        
        NSTimeInterval interval = [[segment initialTime] timeIntervalSinceNow] * -1;
        NSInteger idx = [[[[segment cycle] measure] timeScale] integerValue];
        duration = interval / [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:idx] floatValue];
    }
    return duration;
}

-(void)configureLabels {
    
    // configure without text totalDurationLabel:
    CGRect labelFrame = CGRectMake(0, 0, [ANLCycleView barXOrigin], [ANLCycleView height]);
    ANLDurationBtn *btn = [ANLDurationBtn durationWithFrame:labelFrame textSize:20 text:nil];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(removeCycle:)];
    [btn addGestureRecognizer:longTap];

    [self setTotalDurationBtn:btn];
    [self addSubview:btn];
    
    // configure whitout texts all buttons duration labels but no add them to view
    CGRect rect = [self frame];
    rect.size.width = [[UIScreen mainScreen] bounds].size.width;
    
    NSArray *durations = [self buttonsDuration];
    CGSize viewSize = rect.size;
    CGFloat width = (viewSize.width - [ANLCycleView barXOrigin] - [ANLCycleView rightPad]) / 8;
    
    __block CGFloat x = [ANLCycleView barXOrigin];
    __block NSMutableArray *labelsArray = [[NSMutableArray alloc] init];
    CGFloat labelWidth = width;

    [durations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ANLDurationLabel *label = [ANLDurationLabel durationWithFrame:CGRectMake(x, 0, labelWidth, viewSize.height)
                                                             textSize:12
                                                                 text:obj];
        [labelsArray addObject:label];
        x += width;
    }];
    [self setButtonsDurationLbl:[NSArray arrayWithArray:labelsArray]];
}

-(NSArray *)buttonsDuration {
    
    __block CGFloat totalDuration = 0;
    NSInteger timeScale = [[[[[[self segments] firstObject] cycle] measure] timeScale] integerValue];
    
    NSMutableArray *durations = [@[@0, @0, @0, @0, @0, @0, @0, @0] mutableCopy];
    [[self segments] enumerateObjectsUsingBlock:^(ANLSegment *segment, NSUInteger idx, BOOL *stop) {
        
        CGFloat duration = [self durationOfSegment:segment];
        totalDuration += duration;
        NSInteger index = (NSInteger)[[segment button] indexValue] - 1;
        
        NSNumber *dur = @([[durations objectAtIndex:index] floatValue] + duration);
        [durations replaceObjectAtIndex:index withObject:dur];
    }];
    
    NSMutableArray *texts = [[NSMutableArray alloc] init];
    [durations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *text = [ANLMeasure stringFormatForDuration:obj withScale:timeScale];
        [texts addObject:text];
    }];
    
    [[self totalDurationBtn] setTitle:[@((NSInteger)totalDuration) stringValue] forState:UIControlStateNormal];

    return [NSArray arrayWithArray:texts];
}

-(void)setUpGestures {
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(adjustsSuperViewWidth)];
    [self addGestureRecognizer:gesture];
}

-(void)tearDownGestures {
    
    [[self gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self removeGestureRecognizer:obj];
    }];
}



#pragma mark - delegate methods

-(void)removeCycle:(UIGestureRecognizer *)gesture {

    if (![self isEditing]) {
        
        [self setEditing:YES];
        [[self delegate] cycleViewPrepareForRemove:self];
    }
}

-(void)removeCycleConfirmed:(id)sender {
    
    [[self delegate] removeCycleView:self];
}

-(void)adjustsSuperViewWidth {
    
    [self setEditing:NO];
    [[self delegate] stopRemoveProcess];
    [[self delegate] cycleViewToObserver:self];

}

@end
