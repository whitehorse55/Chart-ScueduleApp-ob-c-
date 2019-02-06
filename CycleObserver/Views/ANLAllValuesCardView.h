//
//  ANLAllValuesCardView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCardView.h"



extern const struct ANLAllValuesCardKey {
    
    __unsafe_unretained NSString *taktTime;
    __unsafe_unretained NSString *avgTaktTime;
    __unsafe_unretained NSString *data;
    __unsafe_unretained NSString *maxDuration;
    __unsafe_unretained NSString *minDuration;
} ANLAllValuesCardKey;



@interface ANLAllValuesCardView : ANLCardView

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data;

@end
