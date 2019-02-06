//
//  ANLTabBar.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 10/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLTabBar.h"



@interface ANLTabBar ()

@property (nonatomic, getter = isShowed) BOOL showed;
@property (nonatomic) CGPoint showCenter;
@property (nonatomic) CGPoint hideCenter;

@end



@implementation ANLTabBar

-(void)prepareForAnimations {
    
    [self setShowed:YES];
    
    CGPoint center = [self center];
    [self setShowCenter:center];
    
    center.y += [self bounds].size.height;
    [self setHideCenter:center];
}

-(void)showTabBarAnimated:(BOOL)animated {

    if (![self isShowed]) {
        
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [self setCenter:[self showCenter]];
            [self setShowed:YES];
        } completion:NULL];
    }
}

-(void)hideTabBarAnimated:(BOOL)animated {

    if ([self isShowed]) {
        
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self setCenter:[self hideCenter]];
            [self setShowed:NO];
        } completion:NULL];
    }
}

@end
