//
//  ANLCycleButtonDataSource.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 07/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLCycleButtonDataSource.h"
#import "Language.h"



@implementation ANLCycleButtonDataSource

#pragma mark - constants

+(NSString *)titleForType:(anlCycleButtonType)type {
    
    NSString *title;
    switch (type) {
        case anlCycleButtonTypeNewCycle:
            
            title = [Language stringForKey:@"title.newCycle"];
            break;
            
        case anlCycleButtonTypeTwoSeconds:
            
            title = [Language stringForKey:@"title.twoSeconds"];
            break;
            
        case anlCycleButtonTypeOperationButton:
            
            title = [Language stringForKey:@"title.operation"];
            break;
    }
    return title;
}

+(NSString *)bodyForType:(anlCycleButtonType)type {
    
    NSString *body;
    switch (type) {
        case anlCycleButtonTypeNewCycle:
            
            body = [Language stringForKey:@"body.newCycle"];
            break;
            
        case anlCycleButtonTypeTwoSeconds:
            
            body = [Language stringForKey:@"body.twoSeconds"];
            break;
            
        case anlCycleButtonTypeOperationButton:
            
            body = [Language stringForKey:@"body.operation"];
            break;
    }
    return body;
}

//+(UIColor *)colorForType:(anlCycleButtonType)type {
//    
//    return [UIColor colorWithNormalStateButtonColor:(ANLButtonColor)type];
//}

@end
