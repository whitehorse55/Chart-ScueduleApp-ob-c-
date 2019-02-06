#import "ANLOperator.h"



@implementation ANLOperator

+(instancetype)operatorInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLOperator *operator = [ANLOperator insertInManagedObjectContext:moc];
    [operator setName:@""];
    
    return operator;
}

+(NSArray *)pathToRoot {
    
    return @[@"operation.process.organization", @"operation.process", @"operation"];
}



-(NSArray *)pathFromMeasure {
    
    return @[@"setOperator:"];
}

-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary {
    
    NSString *key = ANLOperatorRelationships.measures;
    NSNumber *sum = [dictionary objectForKey:key];
    NSUInteger total = [[self measures] count];
    total += sum ? [sum integerValue] : 0;
    
    [dictionary setObject:@(total) forKey:key];
    return dictionary;
}

-(NSString *)alertMessage {
    
    NSString *measures = [Language stringForKey:@"measures."];
    measures = [NSString stringWithFormat:@"%li %@", (long)[[self measures] count], measures];
    
    NSString *operators = [Language stringForKey:@"operators,"];
    operators = [@"1 " stringByAppendingString:operators];
    
    return [NSString stringWithFormat:@"%@ %@", operators, measures];
}

@end
