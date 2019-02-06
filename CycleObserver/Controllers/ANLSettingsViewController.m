//
//  ANLSettingsViewController.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 13/3/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSettingsViewController.h"
#import "ANLSettingCycleButtonVC.h"
#import "ANLSettingsCellView.h"
#import "ANLCycleButtonDataSource.h"
#import "ANLPopoverTableView.h"
#import "ANLAppDelegate.h"



@interface ANLSettingsViewController ()

@property (strong, nonatomic) PopoverView *popover;
@property (weak, nonatomic) IBOutlet UIView *cycleButtonView;
@property (weak, nonatomic) IBOutlet ANLSettingsCellView *languageView;
@property (weak, nonatomic) IBOutlet UIImageView *languajeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *versionIcon;
@property (weak, nonatomic) IBOutlet UIImageView *creditsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *settingsImage;
@property (weak, nonatomic) IBOutlet UIImageView *cycleIconImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingsVerticalConstraint;
@property (weak, nonatomic) IBOutlet UILabel *languageTitle;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

@property (weak, nonatomic) IBOutlet UILabel *versionTitle;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property (weak, nonatomic) IBOutlet UILabel *creditsTitle;
@property (weak, nonatomic) IBOutlet UILabel *developTitle;
@property (weak, nonatomic) IBOutlet UILabel *ideaTitle;

@property (weak, nonatomic) IBOutlet UILabel *cycleButtonTitle;
@property (weak, nonatomic) IBOutlet UILabel *cycleButtonBody;


@property (strong, nonatomic) UITapGestureRecognizer *languageTap;

@end



@implementation ANLSettingsViewController

+(NSDictionary *)data {
    
    return @{@"English" : @"en", @"Español" : @"es"};
}

#pragma mark - lifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[[self cycleButtonView] layer] setCornerRadius:8];
    [[[self languajeIcon] layer] setCornerRadius:8];
    [[[self versionIcon] layer] setCornerRadius:8];
    [[[self creditsIcon] layer] setCornerRadius:8];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [[self versionLabel] setText:version];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setTitle:[Language stringForKey:@"settings"]];
    anlCycleButtonType type = [[NSUserDefaults standardUserDefaults] integerForKey:cycleObserverCycleButtonTypePrefKey];
    
    [[self languageTitle] setText:[Language stringForKey:@"settings.language.title"]];
    [[self languageLabel] setText:[Language stringForKey:@"settings.language.description"]];
    
    [[self cycleButtonTitle] setText:[ANLCycleButtonDataSource titleForType:type]];
    [[self cycleButtonBody] setText:[ANLCycleButtonDataSource bodyForType:type]];

    [[self versionTitle] setText:[Language stringForKey:@"settings.version.title"]];
    
    [[self creditsTitle] setText:[Language stringForKey:@"settings.credits.title"]];
    [[self developTitle] setText:[Language stringForKey:@"settings.credits.develop"]];
    [[self ideaTitle] setText:[Language stringForKey:@"settings.credits.idea"]];
//    [[self cycleButtonView] setBackgroundColor:[ANLCycleButtonDataSource colorForType:type]];
//    
//    NSString *cycleIconColor = (type == anlCycleButtonTypeTwoSeconds) ? @"" : @"White";
//    UIImage *cycleIcon = [UIImage imageNamed:[NSString stringWithFormat:@"cycleButtonIcon%@", cycleIconColor]];
//    [[self cycleIconImage] setImage:cycleIcon];
    
    [self showSettingsImage];
    [self setUpGestures];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



#pragma mark - geastures

-(void)setUpGestures {
    
    if (![self languageTap]) {
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(languageViewPushed)];
        [self setLanguageTap:gesture];
    }
    [[self languageView] addGestureRecognizer:[self languageTap]];
}

-(void)tearDownGestures {
    
    UITapGestureRecognizer *tap = [self languageTap];
    if (tap) {
        
        [[self languageView] removeGestureRecognizer:tap];
    }
}



#pragma mark - PopoverViewDelegate


-(void)popoverViewDidDismiss:(PopoverView *)popoverView {
    
    [self setUpGestures];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ANLPopoverTableView heightCells];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *key = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [Language setLanguage:[[ANLSettingsViewController data] objectForKey:key]];
    
    [[self popover] dismiss];
    [self setPopover:nil];
    
    ANLAppDelegate *delegate = (ANLAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate updateTabBarTitles:[self tabBarController]];
    [[[[self navigationController] viewControllers] firstObject] setTitle:[Language stringForKey:@"tabBarTitle.Home"]];
    
    [self viewWillAppear:YES];
}



#pragma mark - customMethods

-(void)languageViewPushed {
    
    [self tearDownGestures];
    //  Create the tableView
    SEL selector = @selector(caseInsensitiveCompare:);
    NSArray *list = [[[ANLSettingsViewController data] allKeys] sortedArrayUsingSelector:selector];
    CGFloat height = MIN([list count] * 30.0f, 100.0f);
    CGRect tableFrame = CGRectMake(0, 0, 120, height);
    ANLPopoverTableView *tableView = [[ANLPopoverTableView alloc] initWithFrame:tableFrame
                                                                          style:UITableViewStylePlain
                                                                      dataArray:list];
    [tableView setDelegate:self];
    CGPoint center = CGPointMake([UIDevice anlScreenwidth] / 3, [[self languageView] y] + [[self languageView] height]);
    [self setPopover:[PopoverView showPopoverAtPoint:center
                                                    inView:[self view]
                                           withContentView:tableView
                                                     above:NO
                                                  delegate:nil]];
}

-(void)showSettingsImage {
    
    UIImageView *settingsView = [self settingsImage];
    if ([[self view] height] < 568.0f) {
        
        [settingsView setAlpha:0];
    } else {
        
        [settingsView setAlpha:1];
        
        CGFloat settingsSpace = [settingsView y] + [settingsView height];
        CGFloat constant = ([[self view] height] - 0 - settingsSpace) / 2;
        [[self settingsVerticalConstraint] setConstant:constant];
        
        [settingsView layoutIfNeeded];
    }
}

@end
