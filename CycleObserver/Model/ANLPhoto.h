//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLPhoto.h"



@interface ANLPhoto : _ANLPhoto

+(instancetype)photoWithData:(NSData *)data inManagedObjectContext:(NSManagedObjectContext *)context;

@end
