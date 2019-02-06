//
//  ANLTTView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 11/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLTTView : UIView

@property (nonatomic) anlMeasuresViewsType viewsType;
@property (nonatomic) CGFloat taktTimeX;


-(id)initWithFrame:(CGRect)frame Type:(anlMeasuresViewsType)type;

@end
