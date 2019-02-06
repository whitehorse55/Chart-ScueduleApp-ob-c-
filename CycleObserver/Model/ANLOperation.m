//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLOperation.h"
//#import "ANLOperator.h"



@implementation ANLOperation

+(instancetype)operationInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLOperation *operation = [ANLOperation insertInManagedObjectContext:moc];
    [operation setName:@""];
    
    return operation;   
}

+(NSArray *)pathToRoot {
    
    return @[@"process.organization", @"process"];
}



-(NSArray *)pathFromMeasure {
    
    return @[@"operator", @"setOperation:"];
}

-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary {
    
    NSString *key = ANLOperationRelationships.operators;
    NSNumber *sum = [dictionary objectForKey:key];
    NSUInteger total = [[self operators] count];
    total += sum ? [sum integerValue] : 0;
    [dictionary setObject:@(total) forKey:key];
    
    __block NSMutableDictionary *dic = dictionary;
    [[self operators] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        dic = [obj relationShipsCounter:dic];
    }];
    return dictionary;
}

-(NSString *)alertMessage {
    
    NSMutableDictionary *dic = [self relationShipsCounter:[[NSMutableDictionary alloc] init]];
    NSString *measures = [Language stringForKey:@"measures."];
    measures = [NSString stringWithFormat:@"%@ %@", [dic objectForKeyedSubscript:@"measures"], measures];
    
    NSString *operators = [Language stringForKey:@"operators,"];
    operators = [NSString stringWithFormat:@"%li %@", (long)[[self operators] count], operators];
    
    NSString *operations = [Language stringForKey:@"operations,"];
    operations = [@"1 " stringByAppendingString:operations];
    
    return [NSString stringWithFormat:@"%@ %@ %@", operations, operators, measures];
}

@end
