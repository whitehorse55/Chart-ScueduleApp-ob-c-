
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLOrganizationTableView.h"
#import "ANLModel.h"



@implementation ANLOrganizationTableView

+(NSString *)defaultNameForClass:(Class)class {
    
    NSDictionary *dic = @{@"ANLOrganization" : [Language stringForKey:@"All organizations"],
                          @"ANLProcess"      : [Language stringForKey:@"All processes"],
                          @"ANLOperation"    : [Language stringForKey:@"All operations"],
                          @"ANLOperator"     : [Language stringForKey:@"All operators"]};
    
    return [dic objectForKey:NSStringFromClass(class)];
}

+(instancetype)organizationTableViewInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    return [ANLOrganizationTableView insertInManagedObjectContext:moc];
}



-(NSString *)titleForRow:(NSInteger)row {
    
    NSString *title;
    switch (row) {
            
        case 0:
            
            title = [self organization] ? [[self organization] name]
                                        : [ANLOrganizationTableView defaultNameForClass:[ANLOrganization class]];
            break;
        
        case 1:
            
            title = [self process] ? [[self process] name]
                                   : [ANLOrganizationTableView defaultNameForClass:[ANLProcess class]];
            break;
            
        case 2:
            
            title = [self operation] ? [[self operation] name]
                                     : [ANLOrganizationTableView defaultNameForClass:[ANLOperation class]];
            break;
            
        case 3:
            
            title = [self operator] ? [[self operator] name]
                                     : [ANLOrganizationTableView defaultNameForClass:[ANLOperator class]];
            break;
            
        default:
            
            title = [NSString stringWithFormat:@"Error in configureOrganizationCellAtIndex:%li", (long)row];
            break;
    }
    return title;
}

-(NSArray *)relatedEntities {
    
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    NSNull *nul = [NSNull null];
    
    [entities addObject:[self organization] ? [self organization] : nul];
    [entities addObject:[self process] ? [self process] : nul];
    [entities addObject:[self operation] ? [self operation] : nul];
    [entities addObject:[self operator] ? [self operator] : nul];
    
    return entities;
}

@end
