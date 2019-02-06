//
//  ANLSegmentView.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLCycleView.h"



@class ANLCycle, ANLSegment, ANLTTView;

@protocol ANLSegmentViewDelegate

-(void)removeCycleAtIndex:(NSInteger)index;

@end



@interface ANLSegmentView : UIView <ANLCycleViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) ANLCycleView *currentCycle;
@property (strong, nonatomic) ANLCycleView *observedCycleView;
@property (strong, nonatomic, readonly) ANLTTView *ttView;
@property (weak, nonatomic) id<ANLSegmentViewDelegate> delegate;

@property (nonatomic) anlMeasuresViewsType viewsType;
@property (nonatomic) CGFloat taktTime;
@property (nonatomic) CGFloat pixelsRelation;

+(CGFloat)segmentGuide;

-(id)initWithFrame:(CGRect)frame cycles:(NSArray *)cycles pixelRelation:(CGFloat)relation
         viewsType:(anlMeasuresViewsType)viewsType;

//-(void)addAllCycles:(NSArray *)cycles;
//-(void)addNewCycle:(NSArray *)cycle;
-(void)addCycle:(ANLCycle *)cycle;
-(void)addSegment:(ANLSegment *)segment;
-(CGSize)contentSize;
-(CGFloat)taktTimeX;
//-(void)addNewSegment:(NSDictionary *)segment;
//-(void)closeCurrentCycleWithDuration:(CGFloat)duration;

@end
