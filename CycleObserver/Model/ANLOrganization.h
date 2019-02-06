//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLOrganization.h"



@interface ANLOrganization : _ANLOrganization

+(instancetype)organizationInManagedObjectContext:(NSManagedObjectContext *)moc;
+(NSArray *)pathToRoot;

-(NSArray *)pathFromMeasure;
-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary;
-(NSString *)alertMessage;

@end
