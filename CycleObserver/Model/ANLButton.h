//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLButton.h"



@interface ANLButton : _ANLButton

+(instancetype)buttonWithIndex:(NSInteger)index andColor:(ANLButtonColor)color
        inManagedObjectContext:(NSManagedObjectContext *)moc;

@end
