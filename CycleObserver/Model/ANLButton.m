//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLButton.h"



@implementation ANLButton

+(instancetype)buttonWithIndex:(NSInteger)index andColor:(ANLButtonColor)color
        inManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLButton *button = [ANLButton insertInManagedObjectContext:moc];
    [button setName:@""];
    [button setIndexValue:index];
    [button setColorValue:color];
    
    return button;
}

-(void)setName:(NSString *)name {
    
    if (![[self primitiveName] isEqualToString:name]) {
        
        [self setPrimitiveName:name];
        if ([name isEqualToString:@""]) {
            
            [self setColorValue:anlButtonColorGrey];
        }
    }
}

@end
