//
//  ANLDummyData.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 07/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLDummyData.h"
#import "AGTCoreDataStack.h"
#import "ANLModel.h"



@interface ANLDummyData ()

@property (strong, nonatomic) NSArray *organizationsNames;
@property (strong, nonatomic) NSArray *processesNames;
@property (strong, nonatomic) NSArray *operationsNames;
@property (strong, nonatomic) NSArray *operatorsNames;

@end



@implementation ANLDummyData

-(id)initWithModel:(AGTCoreDataStack *)model {

    self = [super init];
    if (self) {
        
        [self generateDataNames];
        [self setModel:model];
    }
    return self;
}

-(id)init {
    
    AGTCoreDataStack *model = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    return [self initWithModel:model];
}

-(void)generateDataNames {
    
    [self setOrganizationsNames:@[@"Fiat", @"Mercedes", @"Apple", @"Bayer", @"Nokia", @"Ford",
                                  @"General Motors", @"Kia", @"Yves Roche", @"Volkswagen",
                                  @"Abbot Laboratories", @"Actelion", @"Basilea Medical"]];
    
    [self setProcessesNames:@[@"Design", @"Assemblage", @"checkout", @"Construction", @"Structuring",
                              @"drying", @"Analysis", @"packing"]];
    
    [self setOperationsNames:@[@"op1", @"op2", @"op3", @"op4", @"op5", @"op6", @"op7", @"op8", @"op9",
                               @"op10", @"op11", @"op12", @"op13", @"op14", @"op15", @"op16", @"op17",
                               @"op18", @"op19", @"op20", @"op21"]];
    
    [self setOperatorsNames:@[@"Luke", @"Anakin", @"Obi Wan", @"Yoda", @"Qui-Gon", @"Ki-Adi"]];
}

-(void)generateMeasuresForTotalOrganizations:(NSInteger)orgNumber processInOrganizations:(NSInteger)proNumber
                         operationsInProcess:(NSInteger)opeNumber operatorsInOperation:(NSInteger)torNumber
                                   inContext:(NSManagedObjectContext *)context {
    
    NSInteger totalOrg = orgNumber > 0 ? orgNumber : (arc4random_uniform(4) + 2);
    for (NSInteger org = 0; org < totalOrg; org++) {
        
        ANLOrganization *organization = [ANLOrganization organizationInManagedObjectContext:context];
        NSInteger idx = arc4random_uniform((u_int32_t)[[self organizationsNames] count]);
        NSString *name = [NSString stringWithFormat:@"%@:%li",[[self organizationsNames] objectAtIndex:idx], (long)org];
        [organization setName:name];
        
        NSInteger totalPro = proNumber > 0 ? proNumber : (arc4random_uniform(3) + 1);
        for (NSInteger pro = 0; pro < totalPro; pro++) {
            
            ANLProcess *process = [ANLProcess processInManagedObjectContext:context];
            NSInteger idx = arc4random_uniform((u_int32_t)[[self processesNames] count]);
            NSString *name = [NSString stringWithFormat:@"%@:%li",[[self processesNames] objectAtIndex:idx], (long)pro];
            [process setName:name];
            [organization addProcessesObject:process];
            
            NSInteger totalOpe = opeNumber > 0 ? opeNumber : (arc4random_uniform(2) + 2);
            for (NSInteger ope = 0; ope < totalOpe; ope++) {
                
                ANLOperation *operation = [ANLOperation operationInManagedObjectContext:context];
                NSInteger idx = arc4random_uniform((u_int32_t)[[self operationsNames] count]);
                NSString *name = [NSString stringWithFormat:@"%@:%li", [[self operationsNames] objectAtIndex:idx],
                                                                       (long)ope];
                [operation setName:name];
                [process addOperationsObject:operation];
                
                NSInteger totalTor = torNumber > 0 ? torNumber : (arc4random_uniform(4) + 2);
                for (NSInteger tor = 0; tor < totalTor; tor++) {
                    
                    ANLOperator *operator = [ANLOperator operatorInManagedObjectContext:context];
                    NSInteger idx = arc4random_uniform((u_int32_t)[[self operatorsNames] count]);
                    NSString *name = [NSString stringWithFormat:@"%@:%li",[[self operatorsNames] objectAtIndex:idx],
                                                                          (long)tor];
                    [operator setName:name];
                    [operation addOperatorsObject:operator];
                    
                    NSInteger totalMes = (arc4random_uniform(4));
                    for (NSInteger mes = 0; mes < totalMes; mes++) {

                        ANLMeasure *measure = [ANLMeasure measureInManagedObjectContext:context];
                        [context deleteObject:[[[[measure operator] operation] process] organization]];
                        [context deleteObject:[[[measure operator] operation] process]];
                        [context deleteObject:[[measure operator] operation]];
                        [context deleteObject:[measure operator]];
                        
                        NSInteger time = arc4random_uniform(20000000);
                        [measure setDate:[NSDate dateWithTimeIntervalSinceNow:-time]];
                        [measure setOperator:operator];
                        [measure setTimeScaleValue:2];
                        
                        __block NSMutableArray *titles = [@[@"remove", @"pause", @"screw", @"assemble",
                                                            @"inspect", @"move", @"repair", @"change",
                                                            @"clip", @"cut out"] mutableCopy];
                        
                        [[measure buttons] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                            
                            NSUInteger idx = arc4random_uniform((u_int32_t)[titles count]);
                            [obj setName:[titles objectAtIndex:idx]];
                            [titles removeObjectAtIndex:idx];
                        }];
                        CGFloat totalCycles = 0;
                        CGFloat totalDuration = 0;
                        for (NSUInteger cycleIdx = 0; cycleIdx < arc4random_uniform(15) + 5; cycleIdx++) {
                            
                            ANLCycle *cycle = [ANLCycle cycleWithIndex:cycleIdx inManagedObjectContext:context];
                            NSInteger totalSeg = arc4random_uniform(6) + 2;

                            for (NSInteger segmentIdx = 0; segmentIdx < totalSeg; segmentIdx++) {
                                
                                NSInteger duration = arc4random_uniform(15) + 1;
                                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index"
                                                                                       ascending:YES];
                                
                                NSArray *buttons = [[[measure buttons] allObjects] sortedArrayUsingDescriptors:@[sort]];
                                
                                NSInteger idx = arc4random_uniform(6);
                                ANLSegment *segment = [ANLSegment segmentWithIndex:segmentIdx
                                                                          duration:duration
                                                                            button:[buttons objectAtIndex:idx]
                                                            inManagedObjectContext:context];
                                
                                [cycle addSegmentsObject:segment];
                                
                                totalDuration += duration;
                            }
                            [measure addCyclesObject:cycle];
                            totalCycles++;
                        }
                        NSInteger tt = totalDuration / totalCycles * 0.8f;
                        [measure setTaktTime:@(tt)];
                    }
                }
            }
        }
    }

    [[self model] saveWithErrorBlock:^(NSError *error) {
        
        NSLog(@"Error generateDummyData: %@", error);
    }];
}

-(void)deleteAllData {
    
    [[self model] zapAllData];
}

@end
