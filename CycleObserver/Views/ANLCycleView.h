//
//  ANLCycleView.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 12/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ANLCycleView, ANLDurationBtn, ANLSegment;

@protocol ANLCycleViewDelegate

-(void)cycleViewPrepareForRemove:(ANLCycleView *)cycleView;
-(void)removeCycleView:(ANLCycleView *)cycleView;

-(void)cycleViewToObserver:(ANLCycleView *)cycleView;
-(void)stopRemoveProcess;

@end



@interface ANLCycleView : UIView

@property (strong, nonatomic) NSMutableArray *segments;
@property (strong, nonatomic) ANLDurationBtn *totalDurationBtn;
@property (weak, nonatomic) id<ANLCycleViewDelegate> delegate;

@property (nonatomic) CGFloat relationPixelDuration;
@property (nonatomic) anlMeasuresViewsType viewsType;
@property (nonatomic) CGRect timesFrame;
@property (nonatomic) NSInteger index;

+(CGFloat)height;
+(CGFloat)barXOrigin;
+(CGFloat)rightPad;

+(instancetype)cycleWithFrame:(CGRect)frame index:(NSInteger)index segments:(NSArray *)segments
       pixelsDurationRelation:(CGFloat)relation viewsType:(anlMeasuresViewsType)viewsType;

-(void)addSegment:(ANLSegment *)segment;
-(void)closeCurrentSegmentWithDuration:(CGFloat)duration;
-(void)redraw;

@end
