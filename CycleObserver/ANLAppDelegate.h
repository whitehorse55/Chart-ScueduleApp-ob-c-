//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@class AGTCoreDataStack;

@interface ANLAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AGTCoreDataStack *model;
@property (strong, nonatomic) CLLocationManager *lm;


-(void)updateTabBarTitles:(UITabBarController *)tabBar;
-(void)createDummyData;

@end
