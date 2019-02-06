//
//  ANLStepsCardView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCardView.h"



extern const struct ANLStepsCardKey {
    
    __unsafe_unretained NSString *totalCycles;
    __unsafe_unretained NSString *steps;
    __unsafe_unretained NSString *max;
    __unsafe_unretained NSString *avg;
    __unsafe_unretained NSString *min;
    __unsafe_unretained NSString *nCycles;
    __unsafe_unretained NSString *name;
}ANLStepsCardKey;



@interface ANLStepsCardView : ANLCardView

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data;

@end
