//
//  ANLSegmentView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSegmentView.h"
#import "ANLTTView.h"
#import "ANLDurationBtn.h"
#import "ANLDeleteBtn.h"
#import "ANLMeasure.h"
#import "ANLCycle.h"
#import "ANLSegment.h"



@interface ANLSegmentView ()

@property (strong, nonatomic) UIView *taktView;
@property (strong, nonatomic) UIView *fakeView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) ANLCycleView *cycleToRemove;
@property (strong, nonatomic) ANLDeleteBtn *removeButton;
@property (strong, nonatomic) ANLTTView *ttView;

@end



@implementation ANLSegmentView

#pragma mark - constants

+(CGFloat)segmentGuide {
    
    return 47.5f;
}



#pragma mark - lifecycle

- (id)initWithFrame:(CGRect)frame cycles:(NSArray *)cycles
      pixelRelation:(CGFloat)relation viewsType:(anlMeasuresViewsType)viewsType {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setPixelsRelation:relation];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addCycles:cycles];
        [self setTtView:[[ANLTTView alloc] initWithFrame:frame Type:viewsType]];
        [self insertSubview:[self ttView] atIndex:0];
        [self setViewsType:viewsType];
    }
    return self;
}



#pragma mark - setters

-(void)setViewsType:(anlMeasuresViewsType)viewsType {
    
    if (_viewsType != viewsType) {
        
        _viewsType = viewsType;
        [[self ttView] setViewsType:viewsType];
        [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj respondsToSelector:@selector(setViewsType:)]) {
                
                [obj setViewsType:viewsType];
            }
        }];

        [[self taktView] setAlpha:(viewsType == anlMeasuresViewsTypeSegments) ? 1 : 0];
        
        [self setNeedsDisplay];
    }
}



#pragma mark - UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self;
}



#pragma mark - ANLCycleViewDelegate

-(void)cycleViewPrepareForRemove:(ANLCycleView *)cycleView {

    if ([self cycleToRemove]) {
        
        [self noRemove];
    }
    [self setCycleToRemove:cycleView];
    
    [self setTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noRemove)]];
    [self addGestureRecognizer:[self tapGesture]];
    
    CGRect frameBtn = [cycleView frame];
    frameBtn.size.width = [ANLSegmentView segmentGuide];
    
    ANLDeleteBtn *delete = [ANLDeleteBtn deleteButtonWithFrame:frameBtn];
    [self setRemoveButton:delete];
    [self addSubview:delete];
    
    // present remove button, this is not active until finish presentation
    [UIView animateWithDuration:0.5f animations:^{
        
        [[cycleView totalDurationBtn] setAlpha:0];
        [[self removeButton] setAlpha:1];
    } completion:^(BOOL finished) {
        //  Use a selector to avoid warnings
        SEL selector = NSSelectorFromString(@"removeCycleConfirmed:");
        [[self removeButton] addTarget:cycleView
                                action:selector
                      forControlEvents:UIControlEventTouchUpInside];
    }];

}

-(void)removeCycleView:(ANLCycleView *)cycleView {

    NSInteger index = [cycleView index];
    
    CGFloat height = [ANLCycleView height];
    NSInteger length = [[self subviews] count] - index - 2;
    NSArray *cyclesView = [[self subviews] subarrayWithRange:NSMakeRange(index + 1, length)];
    [self removeGestureRecognizer:[self tapGesture]];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [[self removeButton] setAlpha:0];
        [cycleView setAlpha:0];
        [cyclesView enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            ANLCycleView *view = obj;
            [view setIndex:[view index] - 1];
            CGPoint center = [view center];
            center.y -= height;
            [view setCenter:center];
        }];
        
    } completion:^(BOOL finished) {
        
        [[self removeButton] removeFromSuperview];
        [cycleView removeFromSuperview];
        [self setRemoveButton:nil];
        [self setCycleToRemove:nil];
        [self setHeight:[self height] - height];
        [self setWidth:[[[self subviews] valueForKeyPath:@"@max.width"] floatValue]];
        [[self ttView] setHeight:[[self ttView] height] - height];
        [[self delegate] removeCycleAtIndex:index];
    }];
}

-(void)cycleViewToObserver:(ANLCycleView *)cycleView {

    [self setObservedCycleView:cycleView];
}

-(void)stopRemoveProcess {
    
    if ([self cycleToRemove]) {
        
        [self noRemove];
    }
}



#pragma mark - actions

-(void)noRemove {
    
    ANLCycleView *cycle = [self cycleToRemove];
    UIButton *remove = [self removeButton];
    [self setCycleToRemove:nil];
    [self setRemoveButton:nil];
    
    [self removeGestureRecognizer:[self tapGesture]];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [[cycle totalDurationBtn] setAlpha:1];
        [remove setAlpha:0];
    } completion:^(BOOL finished) {
        
        [remove removeFromSuperview];
    }];
}



#pragma mark - custom methods

-(CGFloat)taktTimeX {
    
    return [[self ttView] taktTimeX];
}

-(CGSize)contentSize {
    
    return [[self ttView] size];
}

-(void)addCycles:(NSArray *)cycles {
    
    [cycles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self addCycle:obj];
    }];
}

-(void)addCycle:(ANLCycle *)cycle {
    
    CGFloat cycleHeight = [ANLCycleView height];
    CGFloat yOrigin = [[self subviews] count] * cycleHeight + (![self ttView] * cycleHeight);
    CGFloat duration = [[cycle cycleDuration] floatValue];
    if (duration == 0) {
        
        NSInteger scale = [[[cycle measure] timeScale] integerValue];
        CGFloat interval = [[[cycle activeSegment] initialTime] timeIntervalSinceNow] * -1;
        duration = interval * [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:scale] floatValue];
    }
    
    CGFloat width = duration / 0.75 * [self pixelsRelation] + [ANLSegmentView segmentGuide];
    
    CGRect cycleFrame = CGRectMake(0, yOrigin, width, cycleHeight);
    ANLCycleView *cycleView = [ANLCycleView cycleWithFrame:cycleFrame
                                                     index:[[cycle index] integerValue]
                                                  segments:[cycle sortedSegments]
                                    pixelsDurationRelation:[self pixelsRelation]
                                                 viewsType:[self viewsType]];
    [cycleView setDelegate:self];
    
    [self addSubview:cycleView];
    [self setCurrentCycle:cycleView];
    [self setObservedCycleView:cycleView];
    
    //  update height view if need
    CGSize size = [self frame].size;
    size.width = MAX(size.width, cycleFrame.size.width);
    size.height = MAX(size.height, cycleFrame.origin.y + cycleHeight * 2);
    [self setSize:size];
    
    [[self ttView] setHeight:size.height];
    [[self ttView] setNeedsDisplay];
    
    [self setNeedsDisplay];
}

-(void)addSegment:(ANLSegment *)segment {
    
    [[self currentCycle] addSegment:segment];
}

@end
