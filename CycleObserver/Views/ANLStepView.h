//
//  ANLStepView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 30/3/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLStepView : UIView

-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data
                        font:(UIFont *)font radius:(CGFloat)radius scale:(CGFloat)scale;

@end
