//
//  ANLMeasuresScrollView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 28/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLSegmentView.h"



@class ANLMeasure, ANLCycle, ANLSegment, ANLTaktTimeView;

@interface ANLMeasuresScrollView : UIScrollView 

@property (strong, nonatomic, readonly) ANLSegmentView *segmentView;
@property (strong, nonatomic) ANLTaktTimeView *taktTimeView;
@property (nonatomic) anlMeasuresViewsType typeView;



-(void)poblateContentViewWithMeasure:(ANLMeasure *)measure type:(anlMeasuresViewsType)type
                 segmentViewDelegate:(id<ANLSegmentViewDelegate>)delegate headHeight:(CGFloat)headHeight;

-(void)addNewCycle:(ANLCycle *)cycle;
-(void)addNewSegment:(ANLSegment *)segment;
-(void)updateCurrentCycle;
-(void)changeViewsForType:(anlMeasuresViewsType)type;
-(void)removeObservers;
-(void)cycleDidRemove;

@end
