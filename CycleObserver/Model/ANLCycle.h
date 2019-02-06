//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLCycle.h"



@interface ANLCycle : _ANLCycle

+(instancetype)cycleWithIndex:(NSInteger)idx inManagedObjectContext:(NSManagedObjectContext *)context;

-(ANLSegment *)activeSegment;
-(NSNumber *)cycleDuration;
-(NSArray *)sortedSegments;
-(BOOL)lessTwoSecondsFromStart;

@end
