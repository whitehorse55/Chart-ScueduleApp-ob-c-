//
//  ANLAppDelegate.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 30/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "_ANLMeasure.h"
#import <CoreLocation/CoreLocation.h>



@interface ANLMeasure : _ANLMeasure <CLLocationManagerDelegate>

+(NSString *)unknown;
+(NSArray *)timeScaleDescriptors;
+(NSArray *)timeScaleEquivalencies;
+(instancetype)measureInManagedObjectContext:(NSManagedObjectContext *)moc;
+(NSString *)stringFormatForDuration:(NSNumber *)number withScale:(NSInteger)scale;

-(NSString *)dateDescriptionForHomeView;
-(NSString *)dateDescriptionForPlaceLabel;
-(NSArray *)arrayWithSortedCycles;
-(NSArray *)arrayWithSortedButtons;

@end
