//
//  ANLMeasuresScrollView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 28/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLMeasuresScrollView.h"
#import "ANLCycleView.h"
#import "ANLTaktTimeView.h"
#import "ANLMeasure.h"



@interface ANLMeasuresScrollView ()

@property (strong, nonatomic) ANLSegmentView *segmentView;
@property (nonatomic, getter = isChangingType) BOOL changingType;
@property (nonatomic) CGFloat headHeight;

@end



@implementation ANLMeasuresScrollView

-(void)poblateContentViewWithMeasure:(ANLMeasure *)measure type:(anlMeasuresViewsType)type
                 segmentViewDelegate:(id<ANLSegmentViewDelegate>)delegate headHeight:(CGFloat)headHeight {
    
    [self setHeadHeight:headHeight];
    NSArray *cycles = [measure arrayWithSortedCycles];
    CGRect frame = CGRectZero;
    frame.size = CGSizeMake([self bounds].size.width, [cycles count] * [ANLCycleView height] + headHeight);
    
    CGFloat width = [self bounds].size.width * 0.75 - [ANLSegmentView segmentGuide];
    CGFloat ttScale = width / [measure taktTimeValue];
    
    ANLSegmentView *view = [[ANLSegmentView alloc] initWithFrame:frame cycles:cycles
                                                   pixelRelation:ttScale viewsType:type];
    [view setDelegate:delegate];
    [view addObserver:self
           forKeyPath:@"observedCycleView"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    
    [self setSegmentView:view];
    [self setDelegate:view];
    
    [self removeAllSubviews];
    [self addSubview:view];
    [self setContentSize:[view contentSize]];
    [[self pinchGestureRecognizer] setEnabled:NO];
    
    if ([view frame].size.height > [self frame].size.height) {
        
        [self scrollRectToVisible:[[[self segmentView] currentCycle] frame] animated:YES];
    }
}

-(void)removeObservers {
    
    [[self segmentView] removeObserver:self forKeyPath:@"observedCycleView"];
}

-(void)dealloc {
    
    [self removeObservers];
}



#pragma mark - setters

-(void)setTypeView:(anlMeasuresViewsType)typeView {

    if (_typeView != typeView) {
        
        _typeView = typeView;
        [self changeViewsForType:typeView];
    }
}



#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                       change:(NSDictionary *)change context:(void *)context {
    
    [self resizeScrollView];
}



#pragma mark - custom Methods

-(void)updateCurrentCycle {

    if (![self isChangingType]) {
        
        ANLCycleView *current = [[self segmentView] currentCycle];
        [current redraw];
        
        CGRect segmentFrame = [[self segmentView] frame];
        segmentFrame.size.width = MAX(segmentFrame.size.width, [current frame].size.width);
        [[self segmentView] setFrame:segmentFrame];
        
        if (current == [[self segmentView] observedCycleView] && [self typeView] == anlMeasuresViewsTypeSegments) {
            
            [self resizeScrollView];
        }
    }
}

-(void)addNewCycle:(ANLCycle *)cycle {

    ANLSegmentView *segmentView = [self segmentView];
    [segmentView addCycle:cycle];

    [self setContentSize:[segmentView contentSize]];
    
    if ([segmentView height] > [self height] || [self zoomScale] < 1) {
    
        [self zoomToRect:[[segmentView currentCycle] frame] animated:YES];
    }
}

-(void)addNewSegment:(ANLSegment *)segment {
    
    [[self segmentView] addSegment:segment];
}

-(void)changeViewsForType:(anlMeasuresViewsType)type {
    
    [self setChangingType:YES];
    
    //  Hide the view with fade
    [UIView animateWithDuration:0.25f animations:^{
        
        [[self segmentView] setAlpha:0];
    } completion:^(BOOL finished) {
        
        [[self segmentView] setViewsType:type];
        if (type == anlMeasuresViewsTypeSegments) {
            
            [self resizeScrollView];
        } else {
            //  If the view are times, change contentSize and scale to correct values
            [self setContentSize:CGSizeMake([UIDevice anlScreenwidth], [self contentSize].height)];
            [self setZoomScale:1];
            [self setContentOffset:CGPointMake(0, [self contentOffset].y)];
        }
        [UIView animateWithDuration:0.25f animations:^{
            
            [[self segmentView] setAlpha:1];
        } completion:^(BOOL finished) {
            
            [self setChangingType:NO];
        }];
    }];
}

-(void)resizeScrollView {

    ANLCycleView *observed = [[self segmentView] observedCycleView];
    if ([observed width] > [self width]) {
        
        [self zoomToRect:[observed frame] animated:YES];
    }
    if ([self typeView] == anlMeasuresViewsTypeSegments) {
        
        CGPoint ttPoint = [self convertPoint:CGPointMake([[self segmentView] taktTimeX], 0)
                                    fromView:(UIView *)[[self segmentView] ttView]];
        
        CGFloat duration = (ABS(ttPoint.x - [[self taktTimeView] centerX]) > 20) ? 0.25f : 0;
        [UIView animateWithDuration:duration animations:^{
            
            [[self taktTimeView] setCenterX:ttPoint.x];
        }];
    }
}

-(void)cycleDidRemove {

    [self setContentSize:[[self segmentView] size]];
}

@end
