//
//  ANLVACardView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCardView.h"
#import "ANLVAContentView.h"



extern const struct ANLVACardKey {
    
    __unsafe_unretained NSString *taktTime;
    __unsafe_unretained NSString *totalCycles;
    __unsafe_unretained NSString *completeData;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *value;
    __unsafe_unretained NSString *type;
    __unsafe_unretained NSString *nCycles;
    __unsafe_unretained NSString *percentageVA;
    __unsafe_unretained NSString *percentageNVAi;
    __unsafe_unretained NSString *percentageNVA;
    __unsafe_unretained NSString *tasksVA;
    __unsafe_unretained NSString *tasksNVAi;
    __unsafe_unretained NSString *tasksNVA;
}ANLVACardKey;



@interface ANLVACardView : ANLCardView

-(id)initWithY:(CGFloat)y data:(NSDictionary *)data;

@end
