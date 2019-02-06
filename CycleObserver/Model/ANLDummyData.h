//
//  ANLDummyData.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 07/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>




@class AGTCoreDataStack;

@interface ANLDummyData : NSObject

@property (strong, nonatomic) AGTCoreDataStack *model;

-(id)initWithModel:(AGTCoreDataStack *)model;
-(void)generateMeasuresForTotalOrganizations:(NSInteger)orgNumber processInOrganizations:(NSInteger)proNumber
                         operationsInProcess:(NSInteger)opeNumber operatorsInOperation:(NSInteger)torNumber
                                   inContext:(NSManagedObjectContext *)context;

@end
