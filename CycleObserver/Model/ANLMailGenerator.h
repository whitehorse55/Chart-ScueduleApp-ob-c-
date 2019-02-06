//
//  ANLMailGenerator.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 20/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>



@class ANLMeasure;

@interface ANLMailGenerator : NSObject

@property (strong, nonatomic) NSDictionary *vaData;
@property (strong, nonatomic) NSArray *steps;

-(id)initWithMeasure:(ANLMeasure *)measure;
-(NSString *)subject;
-(NSString *)body;
-(NSData *)csvData;

@end
