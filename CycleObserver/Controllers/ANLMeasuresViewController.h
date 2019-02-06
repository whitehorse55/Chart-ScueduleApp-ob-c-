//
//  ANLMeasureViewController.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLSegmentView.h"
#import "ANLButtonContentView.h"



typedef NS_ENUM(NSUInteger, anlCycleButtonType) {
    
    anlCycleButtonTypeNew,
    anlCycleButtonTypeTwoSeconds,
    anlCycleButtonTypeOperation
};

extern NSString *const cycleObserverActiveSegmentIndexPrefKey;

@interface ANLMeasuresViewController : UIViewController<ANLSegmentViewDelegate, ANLButtonDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *moc;

-(void)tooMuchLongCycle;

@end
