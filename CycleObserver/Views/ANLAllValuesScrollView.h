//
//  ANLAllValuesScrollView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 29/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLAllValuesScrollView : UIScrollView

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data;
-(void)addCyclesMeasuresOfArray:(NSArray *)measures;

@end
