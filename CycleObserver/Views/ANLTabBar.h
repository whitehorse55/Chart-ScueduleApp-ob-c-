//
//  ANLTabBar.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 10/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ANLTabBar : UITabBar

-(void)prepareForAnimations;
-(void)showTabBarAnimated:(BOOL)animated;
-(void)hideTabBarAnimated:(BOOL)animated;

@end
