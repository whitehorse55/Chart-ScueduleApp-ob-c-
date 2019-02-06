//
//  ANLSettingCycleButtonVC.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 25/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSettingCycleButtonVC.h"
#import "ANLCycleButtonDataSource.h"



@interface ANLSettingCycleButtonVC ()

@property (strong, nonatomic) NSArray *cycleButtons;
@property (weak, nonatomic) IBOutlet ANLCycleButtonView *addCycleButton;
@property (weak, nonatomic) IBOutlet UILabel *addTitle;
@property (weak, nonatomic) IBOutlet UILabel *addDescription;

@property (weak, nonatomic) IBOutlet ANLCycleButtonView *chooseCycleButton;
@property (weak, nonatomic) IBOutlet UILabel *chooseTitle;
@property (weak, nonatomic) IBOutlet UILabel *chooseDescription;

@property (weak, nonatomic) IBOutlet ANLCycleButtonView *operationCycleButton;
@property (weak, nonatomic) IBOutlet UILabel *operationTitle;
@property (weak, nonatomic) IBOutlet UILabel *operationDescription;

@property (strong, nonatomic) ANLCycleButtonView *selectedCycleButton;

@end



NSString *const cycleObserverCycleButtonTypePrefKey = @"cycleObserverCycleButtonTypePrefKey";

@implementation ANLSettingCycleButtonVC

+(void)initialize {
    
    NSDictionary *defaults = @{cycleObserverCycleButtonTypePrefKey : @0};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setTitle:[Language stringForKey:@"cycleButton.title"]];
    [[self addTitle] setText:[ANLCycleButtonDataSource titleForType:anlCycleButtonTypeNewCycle]];
    [[self addDescription] setText:[ANLCycleButtonDataSource bodyForType:anlCycleButtonTypeNewCycle]];
    
    [[self chooseTitle] setText:[ANLCycleButtonDataSource titleForType:anlCycleButtonTypeTwoSeconds]];
    [[self chooseDescription] setText:[ANLCycleButtonDataSource bodyForType:anlCycleButtonTypeTwoSeconds]];
    
    [[self operationTitle] setText:[ANLCycleButtonDataSource titleForType:anlCycleButtonTypeOperationButton]];
    [[self operationDescription] setText:[ANLCycleButtonDataSource bodyForType:anlCycleButtonTypeOperationButton]];
    
    [self setCycleButtons:@[[self addCycleButton], [self chooseCycleButton], [self operationCycleButton]]];
    NSUInteger select = [[NSUserDefaults standardUserDefaults] integerForKey:cycleObserverCycleButtonTypePrefKey];
    
    [self selectCycleButton:[[self cycleButtons] objectAtIndex:select]];
}

-(void)selectCycleButton:(ANLCycleButtonView *)button {

    if ([self selectedCycleButton] != button) {
        
        [[self selectedCycleButton] setSelect:NO];
        [button setSelect:YES];
        
        [self setSelectedCycleButton:button];
        [[NSUserDefaults standardUserDefaults] setInteger:[button tag] forKey:cycleObserverCycleButtonTypePrefKey];
    }
}

@end
