//
//  ANLAppDelegate.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>
//#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "ANLAppDelegate.h"
#import "ANLHomeViewController.h"
#import "ANLLabelViewController.h"
#import "ANLMeasuresViewController.h"
#import "ANLSummaryViewController.h"
#import "AGTCoreDataStack.h"
#import "ANLModel.h"
#import "ANLDummyData.h"
#import "ANLTabBar.h"



@implementation ANLAppDelegate

+(NSArray *)tabBarTitle {
    
    return @[[Language stringForKey:@"tabBarTitle.Home"], [Language stringForKey:@"tabBarTitle.MeasureData"],
             [Language stringForKey:@"tabBarTitle.Measures"], [Language stringForKey:@"tabBarTitle.Summary"],
             @"LeanGlobal"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [self wait:2];
    
//    [Fabric with:@[CrashlyticsKit]];
    
    [self setModel:[AGTCoreDataStack coreDataStackWithModelName:@"Model"]];
    if (CREATE_DUMMY_DATA) {
        
        [self createDummyData];
    }

    UITabBarController *tabBar = (UITabBarController *)[[self window] rootViewController];
    [self updateTabBarTitles:tabBar];
    [[tabBar viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if (idx < 4) {
            
            id vc = [obj topViewController];
            [vc setMoc:[[self model] context]];
        }
    }];
    
    BOOL active = [[NSUserDefaults standardUserDefaults] boolForKey:cycleObserverActiveSegmentIndexPrefKey];
    NSUInteger index = active ? 2 : 4;
    [tabBar setSelectedIndex:index];
    [(ANLTabBar *)[tabBar tabBar] prepareForAnimations];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:.18 green:.273 blue:.963 alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHue:0 saturation:0 brightness:.95 alpha:1]];
    
    return YES;
}

-(void)updateTabBarTitles:(UITabBarController *)tabBar {
    
    NSArray *tabBarTitle = [ANLAppDelegate tabBarTitle];
    [[tabBar viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *title = [tabBarTitle objectAtIndex:idx];
        id vc = [obj topViewController];
        [vc setTitle:title];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {

    [[self model] saveWithErrorBlock:^(NSError *error) {
        
        NSLog(@"Error saving model in:%s with error:%@", __PRETTY_FUNCTION__, error);
    }];
}

-(void)wait:(NSTimeInterval)duration {
    
    NSDate *initDate = [NSDate date];
    NSTimeInterval totalDuration = 0;

    while (totalDuration < duration) {
        
        totalDuration = [[NSDate date] timeIntervalSinceDate:initDate];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    [[self model] saveWithErrorBlock:^(NSError *error) {
        
        NSLog(@"Error saving model in:%s with error:%@", __PRETTY_FUNCTION__, error);
    }];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application
    //     state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate:
    //     when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    // Called as part of the transition from the background to the inactive state; here you can undo many of the
    //     changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    if ([[NSUserDefaults standardUserDefaults] boolForKey:cycleObserverActiveSegmentIndexPrefKey]) {
        
        UITabBarController *tabBar = (UITabBarController *)[[self window] rootViewController];
        [tabBar setSelectedIndex:2];
        
//        UINavigationController *nav = [[tabBar viewControllers] objectAtIndex:2];
//        [(ANLMeasuresViewController *)[nav topViewController] tooMuchLongCycle];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application
    //     was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {

    [[self model] saveWithErrorBlock:^(NSError *error) {
        
        NSLog(@"Error saving model in:%s with error:%@", __PRETTY_FUNCTION__, error);
    }];
    // Called when the application is about to terminate. Save data if appropriate.
    //     See also applicationDidEnterBackground:.
}



#pragma mark - custom methods

-(void)createDummyData {

    [[self model] zapAllData];
    
    ANLDummyData *data = [[ANLDummyData alloc] initWithModel:[self model]];
    [data generateMeasuresForTotalOrganizations:2 processInOrganizations:2
                            operationsInProcess:2 operatorsInOperation:2 inContext:[[self model] context]];
}

-(void)autoSave {
    
    if (AUTO_SAVE) {
        
        [[self model] saveWithErrorBlock:^(NSError *error) {
            
            NSLog(@"autoSave error: %@", error);
        }];
    }
}

@end
