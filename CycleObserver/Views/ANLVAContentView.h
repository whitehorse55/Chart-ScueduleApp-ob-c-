//
//  ANLVAContentView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 31/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, anlStepType) {
    
    anlStepTypeVA_cyclical,
    anlStepTypeVA_noncyclical,
    anlStepTypeNVAi,
    anlStepTypeNVA
};



@interface ANLVAContentView : UIView

@property (nonatomic) NSUInteger percentageVA;
@property (nonatomic) NSUInteger percentageNVAi;
@property (nonatomic) NSUInteger percentageNVA;

+(CGFloat)footer;
-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data;

@end
