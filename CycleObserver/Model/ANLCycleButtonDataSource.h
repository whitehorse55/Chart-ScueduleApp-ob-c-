//
//  ANLCycleButtonDataSource.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 07/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, anlCycleButtonType) {
    
    anlCycleButtonTypeNewCycle,
    anlCycleButtonTypeTwoSeconds,
    anlCycleButtonTypeOperationButton
};

@interface ANLCycleButtonDataSource : NSObject

+(NSString *)titleForType:(anlCycleButtonType)type;
+(NSString *)bodyForType:(anlCycleButtonType)type;
//+(UIColor *)colorForType:(anlCycleButtonType)type;

@end
