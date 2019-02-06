//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLOrganizationTableView.h"



@interface ANLOrganizationTableView : _ANLOrganizationTableView

+(NSString *)defaultNameForClass:(Class)class;
+(instancetype)organizationTableViewInManagedObjectContext:(NSManagedObjectContext *)moc;

-(NSString *)titleForRow:(NSInteger)row;
-(NSArray *)relatedEntities;

@end
