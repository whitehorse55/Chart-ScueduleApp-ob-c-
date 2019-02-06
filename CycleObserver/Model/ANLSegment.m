//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSegment.h"



@implementation ANLSegment

+(instancetype)segmentWithIndex:(NSInteger)idx inManagedObjectContext:(NSManagedObjectContext *)context {
 
    ANLSegment *segment = [ANLSegment insertInManagedObjectContext:context];
    [segment setIndexValue:idx];
    
    return segment;
}

+(instancetype)segmentWithIndex:(NSInteger)idx duration:(NSInteger)duration
         inManagedObjectContext:(NSManagedObjectContext *)context {
    
    ANLSegment *segment = [ANLSegment segmentWithIndex:idx inManagedObjectContext:context];
    [segment setDurationValue:duration];
    
    return segment;
}

+(instancetype)segmentWithIndex:(NSInteger)idx duration:(NSInteger)duration button:(ANLButton *)button
         inManagedObjectContext:(NSManagedObjectContext *)context {
    
    ANLSegment *segment = [ANLSegment segmentWithIndex:idx duration:duration inManagedObjectContext:context];
    [segment setButton:button];
    
    return segment;
}

@end
