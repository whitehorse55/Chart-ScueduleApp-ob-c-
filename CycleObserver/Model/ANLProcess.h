//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLProcess.h"



@interface ANLProcess : _ANLProcess

+(instancetype)processInManagedObjectContext:(NSManagedObjectContext *)moc;
+(NSArray *)pathToRoot;

-(NSArray *)pathFromMeasure;
-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary;
-(NSString *)alertMessage;

@end
