//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLOrganization.h"



@implementation ANLOrganization

+(instancetype)organizationInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLOrganization *organization = [ANLOrganization insertInManagedObjectContext:moc];
    [organization setName:@""];
    
    return organization;
}

+(NSArray *)pathToRoot {
    
    return [[NSArray alloc] init];
}



-(NSArray *)pathFromMeasure {
    
    return @[@"operator", @"operation", @"process", @"setOrganization:"];
}

-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary {
    
    NSString *key = ANLOrganizationRelationships.processes;
    NSNumber *sum = [dictionary objectForKey:key];
    NSUInteger total = [[self processes] count];
    total += sum ? [sum integerValue] : 0;
    [dictionary setObject:@(total) forKey:key];
    
    __block NSMutableDictionary *dic = dictionary;
    [[self processes] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
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
    operations = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"operations"], operations];
    
    NSString *processes = [Language stringForKey:@"processes,"];
    processes = [NSString stringWithFormat:@"%li %@", (long)[[self processes] count], processes];
    
    NSString *organizations = [Language stringForKey:@"organizations,"];
    organizations = [@"1 " stringByAppendingString:organizations];
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@", organizations, processes, operations, operators, measures];
}
@end
