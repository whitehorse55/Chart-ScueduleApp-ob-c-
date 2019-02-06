//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLProcess.h"
//#import "ANLOperation.h"



@implementation ANLProcess

+(instancetype)processInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLProcess *process = [ANLProcess insertInManagedObjectContext:moc];
    [process setName:@""];
    
    return process;
}

+(NSArray *)pathToRoot {
    
    return @[@"organization"];
}



-(NSArray *)pathFromMeasure {
    
    return @[@"operator", @"operation", @"setProcess:"];
}

-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary {
    
    NSString *key = ANLProcessRelationships.operations;
    NSNumber *sum = [dictionary objectForKey:key];
    NSUInteger total = [[self operations] count];
    total += sum ? [sum integerValue] : 0;
    [dictionary setObject:@(total) forKey:key];
    
    __block NSMutableDictionary *dic = dictionary;
    [[self operations] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        dic = [obj relationShipsCounter:dic];
    }];
    return dictionary;
}

-(NSString *)alertMessage {
    
    NSMutableDictionary *dic = [self relationShipsCounter:[[NSMutableDictionary alloc] init]];
    NSString *measures = [Language stringForKey:@"measures."];
    measures = [NSString stringWithFormat:@"%@ %@", [dic objectForKeyedSubscript:@"measures"], measures];
    
    NSString *operators = [Language stringForKey:@"operators,"];
    operators = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"operators"], operators];
    
    NSString *operations = [Language stringForKey:@"operations,"];
    operations = [NSString stringWithFormat:@"%li %@", (long)[[self operations] count], operations];
    
    NSString *processes = [Language stringForKey:@"processes,"];
    processes = [@"1 " stringByAppendingString:processes];
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@", processes, operations, operators, measures];
}

@end
