//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCycle.h"
#import "ANLSegment.h"



@implementation ANLCycle

+(instancetype)cycleWithIndex:(NSInteger)idx inManagedObjectContext:(NSManagedObjectContext *)context {
    
    ANLCycle *cycle = [ANLCycle insertInManagedObjectContext:context];
    [cycle setIndexValue:idx];
    
    return cycle;
}

-(ANLSegment *)activeSegment {
    
    __block ANLSegment *segment = nil;
    [[self segments] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        if ([obj initialTime]) {
            
            segment = obj;
            *stop = YES;
        }
    }];
    return segment;
}

-(NSArray *)sortedSegments {
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    return [[[self segments] allObjects] sortedArrayUsingDescriptors:@[descriptor]];
}

-(NSNumber *)cycleDuration {
    
    return [[self segments] valueForKeyPath:@"@sum.duration"];
}

-(BOOL)lessTwoSecondsFromStart {
    
    BOOL result = NO;
    result = [[self segments] count] == 1;
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:[[self activeSegment] initialTime]];

    return (result && interval < 2);
}

@end
