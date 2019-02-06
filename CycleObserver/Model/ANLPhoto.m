//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLPhoto.h"



@implementation ANLPhoto

+(instancetype)photoWithData:(NSData *)data inManagedObjectContext:(NSManagedObjectContext *)context {
    
    ANLPhoto *photo = [ANLPhoto insertInManagedObjectContext:context];
    [photo setData:data];
    [photo setDate:[NSDate date]];
    
    return photo;
}

@end
