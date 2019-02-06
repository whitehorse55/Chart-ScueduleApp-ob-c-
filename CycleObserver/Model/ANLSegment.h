//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLSegment.h"



@interface ANLSegment : _ANLSegment

+(instancetype)segmentWithIndex:(NSInteger)idx inManagedObjectContext:(NSManagedObjectContext *)context;

+(instancetype)segmentWithIndex:(NSInteger)idx duration:(NSInteger)duration
         inManagedObjectContext:(NSManagedObjectContext *)context;

+(instancetype)segmentWithIndex:(NSInteger)idx duration:(NSInteger)duration button:(ANLButton *)button
         inManagedObjectContext:(NSManagedObjectContext *)context;

@end
