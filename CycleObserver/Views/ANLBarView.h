//
//  ANLBarView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 29/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLBarView : UIView

-(instancetype)initWithFrame:(CGRect)frame footer:(CGFloat)footer
                   barHeight:(CGFloat)height index:(NSUInteger)index measure:(NSInteger)measure;

@end
