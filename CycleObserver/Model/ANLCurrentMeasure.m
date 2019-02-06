//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCurrentMeasure.h"



@implementation ANLCurrentMeasure

+(instancetype)currentMeasureInManageObjectContext:(NSManagedObjectContext *)context {
    
    static ANLCurrentMeasure *currentMeasure = nil;
    
    if (!currentMeasure) {
        
        NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:[ANLCurrentMeasure entityName]];
        
        NSError *error = nil;
        NSArray *current = [context executeFetchRequest:fetch error:&error];
        if (error) {
            
            NSLog(@"error fetched currentMeasure: %@", error);
        } else {
            
            if ([current count] == 0) {
                
                currentMeasure = [ANLCurrentMeasure insertInManagedObjectContext:context];
            } else if ([current count] > 1) {
                
                NSLog(@"Multiple currentMeasures: %@", current);
                currentMeasure = [current lastObject];
            } else {
                
                currentMeasure = [current firstObject];
            }
        }
    }
    return currentMeasure;
}

@end
