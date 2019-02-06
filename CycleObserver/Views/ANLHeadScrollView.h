//
//  ANLHeadScrollView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 28/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ANLTaktTimeView;

@interface ANLHeadScrollView : UIView

@property (strong, nonatomic, readonly) ANLTaktTimeView *taktTimeView;
@property (nonatomic) anlMeasuresViewsType type;

-(id)initWithFrame:(CGRect)frame type:(anlMeasuresViewsType)type taktTime:(NSNumber *)taktTime;

@end
