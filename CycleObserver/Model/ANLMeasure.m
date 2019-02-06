#import "ANLMeasure.h"
#import "ANLModel.h"
#import "UIColor+ANLButtonColor.h"
#import <AddressBookUI/AddressBookUI.h>



@interface ANLMeasure ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end



@implementation ANLMeasure

@synthesize locationManager;

#pragma mark - constants and class methods.

+(NSArray *)keys {
    
    return @[@"current", @"date", @"place", @"taktTime", @"timeScale"];
}

+(NSArray *)timeScaleDescriptors {
    
    return @[[Language stringForKey:@"Hours"],   [Language stringForKey:@"Minutes"],
             [Language stringForKey:@"seconds"], [Language stringForKey:@"centesimalSecs"]];
}

+(NSArray *)timeScaleEquivalencies {
    
    return @[@3600, @60, @1, @.6];
}

+(NSString *)unknown {
    
    return [Language stringForKey:@"Unknown"];
}

+(instancetype)measureInManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLMeasure *measure = [ANLMeasure insertInManagedObjectContext:moc];
    
    [measure setDate:[NSDate date]];
    [measure setTaktTimeValue:10];
    [measure setTimeScaleValue:2];
    [measure setPlace:@""];
    
    [measure makeRelationShipsWithManagedObjectContext:moc];
    return measure;
}

+(NSString *)stringFormatForDuration:(NSNumber *)number withScale:(NSInteger)scale {

    if (scale == 3) {
        
        NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
        [format setMaximumFractionDigits:1];
        return [format stringFromNumber:number];
    }
    NSInteger duration = [number floatValue] * [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:scale] integerValue];
    NSInteger minutes = (duration / 60) % 60;
    NSInteger hours = minutes / 60;
    NSInteger seconds = duration % 60;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"00"];
    NSString *left = nil;
    NSString *right = nil;
    
    switch (scale) {
        case 0:
        case 1:
            
            left = [formatter stringFromNumber:@(hours)];
            right = [formatter stringFromNumber:@(minutes)];
            break;
            
        case 2:
            
            left = [formatter stringFromNumber:@(minutes)];
            right = [formatter stringFromNumber:@(seconds)];
            break;
            
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@:%@", left, right];
}



#pragma mark - lifeCycle

-(void)awakeFromInsert {
    
    [super awakeFromInsert];
    
    if (CREATE_DUMMY_DATA) {
        
        return;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status != kCLAuthorizationStatusDenied && status != kCLAuthorizationStatusRestricted) {
        
        CLLocationManager *lm = [[CLLocationManager alloc] init];
        if ([lm respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [lm requestWhenInUseAuthorization];
        }
        [self setLocationManager:lm];
        [[self locationManager] setDelegate:self];
        [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [[self locationManager] setDistanceFilter:10];
        [[self locationManager] startUpdatingLocation];
    }
}



#pragma mark - setters && getters

-(void)setDate:(NSDate *)date {
    
    if ([self primitiveDate] != date) {
        
        [self setPrimitiveDate:date];
    }
    [self setDateText:[self dateDescriptionForHomeView]];
}

-(void)setPlace:(NSString *)place {

    [self willChangeValueForKey:@"place"];
    [self setPrimitivePlace:place];
    [self didChangeValueForKey:@"place"];
}



#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSDictionary *dic = [placemark addressDictionary];

        NSString *street = [dic objectForKey:@"Street"];

        if (street) {
            
            [self setPlace:[NSString stringWithFormat:@"%@\n%@", street, [dic objectForKey:@"City"]]];
        } else {

            [self setPlace:ABCreateStringWithAddressDictionary([placemark addressDictionary], YES)];
        }
        
        if (error) {
            
            [self setPlace:[ANLMeasure unknown]];
            NSLog(@"Error to read the location");
        }
    }];
    [[self locationManager] stopUpdatingLocation];
}



#pragma mark - custom methods

-(NSArray *)arrayWithSortedCycles {
    
    NSArray *cycles = [[self cycles] allObjects];
    
    return [cycles sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]]];
}

-(NSArray *)arrayWithSortedButtons {
    
    NSArray *buttons = [[self buttons] allObjects];
    return [buttons sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]]];
}

-(void)makeRelationShipsWithManagedObjectContext:(NSManagedObjectContext *)moc {
    
    ANLOperator *operator = [ANLOperator operatorInManagedObjectContext:moc];
    [operator setName:@""];
    [self setOperator:operator];
    
    ANLOperation *operation = [ANLOperation operationInManagedObjectContext:moc];
    [operation setName:@""];
    [operator setOperation:operation];
    
    ANLProcess *process = [ANLProcess processInManagedObjectContext:moc];
    [process setName:@""];
    [operation setProcess:process];
    
    ANLOrganization *organization = [ANLOrganization organizationInManagedObjectContext:moc];
    [organization setName:@""];
    [process setOrganization:organization];
    
    for (NSInteger idx = 0; idx < 8; idx++) {
        
        ANLButtonColor color = (NSInteger)idx / 2;
        ANLButton *button = [ANLButton buttonWithIndex:idx + 1 andColor:color inManagedObjectContext:moc];
        [button setMeasure:self];
    }
}

-(NSString *)dateDescriptionForHomeView {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString *dayOfWeek = [[formatter stringFromDate:[self date]] substringToIndex:3];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    return [NSString stringWithFormat:@"%@ %@", dayOfWeek, [formatter stringFromDate:[self date]]];
}

-(NSString *)dateDescriptionForPlaceLabel {
    
    return [[self dateDescriptionForHomeView] substringFromIndex:4];
}

@end
