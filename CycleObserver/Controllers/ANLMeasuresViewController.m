//
//  ANLMeasureViewController.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLMeasuresViewController.h"
#import "ANLSettingCycleButtonVC.h"
#import "ANLMeasuresScrollView.h"
#import "ANLHeadScrollView.h"
#import "ANLMeasureButton.h"
#import "ANLTabBar.h"
#import "ANLModel.h"



@interface ANLMeasuresViewController ()

@property (strong, nonatomic) ANLMeasure *currentMeasure;
@property (strong, nonatomic) ANLCycle *currentCycle;
@property (strong, nonatomic) ANLSegment *currentSegment;

@property (strong, nonatomic) ANLHeadScrollView *head;
@property (strong, nonatomic) ANLMeasureButton *selectedButton;

@property (weak, nonatomic) IBOutlet ANLMeasuresScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ANLButtonContentView *buttonView;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *cycleButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonContentView;


@property (nonatomic) anlCycleButtonType cycleType;
@property (nonatomic, getter = isRunning) BOOL running;
@property (nonatomic) CGPoint centerMain;
@property (nonatomic) CGPoint centerButtonContent;

@end



NSString *const cycleObserverSegmentControlIndexPrefKey = @"cycleObserverSegmentControlIndexPrefKey";
NSString *const cycleObserverActiveSegmentIndexPrefKey  = @"cycleObserverActiveSegmentIndexPrefKey";

@implementation ANLMeasuresViewController

#pragma mark - constants

+(NSString *)goButtonTitleForState:(BOOL)running {
    
    NSString *title = running ? [Language stringForKey:@"measuresView.goButton.title.PAUSE"] :
                                [Language stringForKey:@"measuresView.goButton.title.GO"];
    return title;
}

+(NSString *)segmentControlTitleAtIndex:(NSInteger)index {
    
    NSArray *titles = @[[Language stringForKey:@"measureView.segmentControl.title.segment"],
                        [Language stringForKey:@"measureView.segmentControl.title.times"]];
    
    return [titles objectAtIndex:index];
}

+(void)initialize {
    
    NSDictionary *defaultSegment = @{cycleObserverSegmentControlIndexPrefKey : @(anlMeasuresViewsTypeSegments)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultSegment];
}



#pragma mark - lifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setCenterMain:[[self view] center]];
    [self setCenterButtonContent:[[self buttonView] center]];
    
    ANLCurrentMeasure *current = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];
    [self setCurrentSegment:[current segment]];
    [self setCurrentMeasure:([self currentSegment]) ? [[[self currentSegment] cycle] measure] : [current measure]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self setRunning:[self currentSegment] != nil];
    [self setCurrentCycle:[[self currentSegment] cycle]];
    [[self buttonView] selectButton:[[self currentSegment] button]];
    
    [[self cycleButton] setTitle:[Language stringForKey:@"measuresView.cycleButton.title"]
                        forState:UIControlStateNormal];
    
    NSString *buttonTitle = [ANLMeasuresViewController goButtonTitleForState:[self isRunning]];
    [[self goButton] setTitle:buttonTitle forState:UIControlStateNormal];
    [[self goButton] setEnabled:[self selectedButton] != nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self setCycleType:[defaults integerForKey:cycleObserverCycleButtonTypePrefKey]];
    
//    NSString *title = [ANLMeasuresViewController segmentControlTitleAtIndex:segmentIndex];
    [[self segmentControl] setTitle:[Language stringForKey:@"measureView.segmentControl.title.segment"]
                  forSegmentAtIndex:0];
    [[self segmentControl] setTitle:[Language stringForKey:@"measureView.segmentControl.title.times"]
                  forSegmentAtIndex:1];
    
    NSUInteger segmentIndex = [defaults integerForKey:cycleObserverSegmentControlIndexPrefKey];
    [[self segmentControl] setSelectedSegmentIndex:segmentIndex];
    
    [self start];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[self view] insertSubview:[self logoImage] atIndex:0];
    
    anlMeasuresViewsType type = [[self segmentControl] selectedSegmentIndex];
    CGRect navFrame = [[[self navigationController] navigationBar] frame];
    CGRect headFrame = CGRectMake(0, navFrame.origin.y + navFrame.size.height, [[self view] frame].size.width, 20);
    
    ANLHeadScrollView *headView = [[ANLHeadScrollView alloc] initWithFrame:headFrame
                                                                      type:type
                                                                  taktTime:[[self currentMeasure] taktTime]];
    [self setHead:headView];
    [[self view] addSubview:headView];
    
    [[self scrollView] poblateContentViewWithMeasure:[self currentMeasure] type:type
                                 segmentViewDelegate:self headHeight:headFrame.origin.y + headFrame.size.height];
    
    [[self scrollView] setTaktTimeView:[headView taktTimeView]];
    
    [[self buttonView] setDelegate:self];
    [[self buttonView] poblateWithButtons:[[self currentMeasure] arrayWithSortedButtons]];
    [[self buttonView] selectButton:[[self currentSegment] button]];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[self scrollView] removeObservers];
    [[self head] removeFromSuperview];
    [self setHead:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    NSError *error = nil;
    [[self moc] save:&error];
    
    if (error) {
        
        NSLog(@"error grabando moc:%@", error);
    }
}



#pragma mark - settings

-(void)setRunning:(BOOL)running {
    
    if (_running != running) {
        
        _running = running;
        if (_running) {
            
            [(ANLTabBar *)[[self tabBarController] tabBar] hideTabBarAnimated:YES];
        } else {
            
            [(ANLTabBar *)[[self tabBarController] tabBar] showTabBarAnimated:YES];
        }
        
        CGFloat height = running ? [[[self tabBarController] tabBar] bounds].size.height : 0.0f;
        UIViewAnimationOptions option = running ? UIViewAnimationOptionCurveEaseIn : UIViewAnimationOptionCurveEaseOut;
        [[self bottomButtonContentView] setConstant:-height];
        [UIView animateWithDuration:0.25f delay:0 options:option animations:^{
            
            [[self buttonView] layoutIfNeeded];
            [[self scrollView] layoutIfNeeded];
        } completion:NULL];
    }
}

-(void)setCurrentSegment:(ANLSegment *)currentSegment {
    
    if (_currentSegment != currentSegment) {
        
        _currentSegment = currentSegment;
        ANLCurrentMeasure *current = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];
        [current setSegment:_currentSegment];
        [[NSUserDefaults standardUserDefaults] setBool:_currentSegment != nil
                                                forKey:cycleObserverActiveSegmentIndexPrefKey];
    }
}

-(void)setSelectedButton:(ANLMeasureButton *)selectedButton {
    
    if (_selectedButton != selectedButton) {
        
        _selectedButton = selectedButton;
        [[self goButton] setEnabled:_selectedButton != nil];
    }
}


#pragma mark - ANLButtonDelegate

-(void)buttonPressed:(ANLMeasureButton *)button {

    if ([button colorAtribute] != anlButtonColorGrey) {
        
        [[self selectedButton] setSelected:NO];
        [button setSelected:YES];
        [self setSelectedButton:button];
        
        if (![self currentCycle]) {
            
            return;
        }
        
        if ([self isRunning]) {
            
            if ([self cycleType] == anlCycleButtonTypeTwoSeconds && [[self currentCycle] lessTwoSecondsFromStart]) {
                        
                [[self currentSegment] setButton:[button data]];
            } else {
                
                [self setCurrentSegment:[self addNewSegment]];
            }
        } else if ([self cycleType] == anlCycleButtonTypeOperation && [[[self currentCycle] segments] count] == 0) {

            [self pushedGoButton:nil];
        }
    }
}

-(void)button:(ANLMeasureButton *)button didChangeColor:(ANLButtonColor)color {
    
    if ([[[button data] color] integerValue] != color) {
        
        [[button data] setColorValue:color];
        [button setColorAtribute:color];
    }
}

-(void)button:(ANLMeasureButton *)button didChangeName:(NSString *)name {
    
    [[button data] setName:name];
    [button setTitle:name];
    if ([name isEqualToString:@""]) {
        
        [button setColorAtribute:anlButtonColorGrey];
    }
}



#pragma mark - ANLSegmentViewDelegate

-(void)removeCycleAtIndex:(NSInteger)index {
    
    // Remove select cycle and renumber the cycles index
    [[[self currentMeasure] cycles] enumerateObjectsUsingBlock:^(ANLCycle *cycle, BOOL *stop) {
        
        NSInteger idx = [[cycle index] integerValue];
        if (idx == index) {
            // If remove the current cycle, stop the timer.
            if ([[cycle index] integerValue] == [[[self currentCycle] index] integerValue]) {

                if ([self isRunning]) {
                    
                    [self pushedGoButton:nil];
                }
                [self setCurrentCycle:nil];
            }
            
            [[self moc] deleteObject:cycle];
            NSError *error = nil;
            
            [[self moc] save:&error];
            
            if (error) {
                
                NSLog(@"Error saving context in:%@ - error:%@", NSStringFromSelector(_cmd), error);
            }
        } else if (idx > index) {
            
            [cycle setIndexValue:--idx];
        }
    }];
    [[self scrollView] cycleDidRemove];
}



#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        
        ANLSegmentView *segment = [[self scrollView] segmentView];
        [segment removeCycleView:[segment currentCycle]];
    }
}



#pragma mark - notifications

-(void)keyboardWillAppear:(NSNotification *)notification {
    
    [[self view] bringSubviewToFront:[self buttonView]];
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat height = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGPoint containerCenter = [[[self tabBarController] view] center];
    containerCenter.y -= height - [[[self tabBarController] tabBar] frame].size.height;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] setCenter:containerCenter];
    } completion:NULL];
}

-(void)keyboardWillDisappear:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] setCenter:[self centerMain]];
    } completion:NULL];
}



#pragma mark - Actions

- (IBAction)pushedCycleButton:(id)sender {
    
    if ([self cycleType] == anlCycleButtonTypeOperation) {
        
        if ([self currentSegment]) {
            
            [self addNewCycle];
            [self pushedGoButton:nil];
        }
    } else {
        
        [self addNewCycle];
        if ([self isRunning]) {
            
            [self setCurrentSegment:[self addNewSegment]];
        }
    }
}

- (IBAction)pushedGoButton:(id)sender {

    BOOL running = ![self isRunning];
    [self setRunning:running];
    [[self goButton] setTitle:[ANLMeasuresViewController goButtonTitleForState:running] forState:UIControlStateNormal];
    
    if (running) {
        
        if (![self currentCycle]) {
            
            [self addNewCycle];
        }
        
        [self setCurrentSegment:[self addNewSegment]];
        [self start];
    } else {
        
        [self stopMeasures];
        [self setCurrentSegment:nil];
    }
}

- (IBAction)pushedSegmentControl:(id)sender {

    anlMeasuresViewsType type = [sender selectedSegmentIndex];
    [[self scrollView] setTypeView:type];
    [[self head] setType:type];
}



#pragma mark - customMethods

-(void)start {
    
    if ([self isRunning]) {
        
        [[self scrollView] updateCurrentCycle];
        [self performSelector:@selector(start) withObject:nil afterDelay:0.04f];
    }
}

-(void)stopMeasures {
    
    if (![self isRunning]) {
        
        [self closeCurrentSegment];
    }
}

-(void)addNewCycle {
    
    [self closeCurrentCycle];
    
    NSUInteger index = [[[self currentMeasure] cycles] count];
    ANLCycle *cycle = [ANLCycle cycleWithIndex:index inManagedObjectContext:[self moc]];
    [cycle setMeasure:[self currentMeasure]];
    [self setCurrentCycle:cycle];
    
    [[self scrollView] addNewCycle:cycle];
}

-(ANLSegment *)addNewSegment {
    
    ANLCycle *cycle = [self currentCycle];
    if (!cycle) {
        
        NSLog(@"Don't exist currentCycle");
        return nil;
    }
    [self closeCurrentSegment];
    
    ANLSegment *segment = [ANLSegment segmentWithIndex:[[cycle segments] count]
                                              duration:0
                                                button:[[self selectedButton] data]
                                inManagedObjectContext:[self moc]];
    [segment setCycle:cycle];
    [segment setInitialTime:[NSDate date]];
    
    [[self scrollView] addNewSegment:segment];
    
    return segment;
}

-(void)closeCurrentCycle {
    
    if ([self currentCycle]) {
        
        [self closeCurrentSegment];
    }
}

-(void)closeCurrentSegment {
    
    ANLSegment *segment = [self currentSegment];
    if (segment) {
        
        NSTimeInterval interval = ABS([[segment initialTime] timeIntervalSinceNow]);
        NSInteger timeScale = [[[self currentMeasure] timeScale] integerValue];
        CGFloat duration = interval / [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:timeScale] floatValue];
        
        [segment setDurationValue:duration];
        [segment setInitialTime:nil];
        
        [self setCurrentSegment:nil];
    }
}

-(void)tooMuchLongCycle {
    
    ANLCurrentMeasure *current = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];

    CGFloat duration = [[[[current segment] cycle] cycleDuration] floatValue];
    NSTimeInterval interval = ABS([[[current segment] initialTime] timeIntervalSinceNow]);
    NSInteger timeScale = [[[self currentMeasure] timeScale] integerValue];
    duration += interval / [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:timeScale] floatValue];

    if (duration > [[self currentMeasure] taktTimeValue] * 5) {
        
        [self alertMessageForLongCycle];
    }
}

-(void)alertMessageForLongCycle {
    
    NSString *title = [Language stringForKey:@"measures.longCycle.title"];
    NSString *text = [Language stringForKey:@"measures.longCycle.text"];
    NSString *correct = [Language stringForKey:@"measures.longCycle.correct"];
    NSString *delete = [Language stringForKey:@"measures.longCycle.delete"];
    
    if ([UIAlertController class]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil ? @"" : title
                                                                       message:text
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:correct
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    [self dismissViewControllerAnimated:YES completion:NULL];
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:delete
                                                  style:UIAlertActionStyleDestructive
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    ANLSegmentView *segment = [[self scrollView] segmentView];
                                                    [segment removeCycleView:[segment currentCycle]];
                                                    [self dismissViewControllerAnimated:YES completion:NULL];
                                                }]];
        [self presentViewController:alert animated:YES completion:NULL];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:text
                                                       delegate:self
                                              cancelButtonTitle:correct
                                              otherButtonTitles:delete, nil];
        [alert show];
    }
}

-(UIImageView *)logoImage {
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_LeanGlobalNetwork"]];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    
    CGRect frame = [[self scrollView] frame];
    frame.size.width = [UIDevice anlScreenwidth];
    frame.size.height -= [[[self navigationController] navigationBar] bounds].size.height;
    frame.origin.y = [[self topLayoutGuide] length];
    [img setFrame:frame];
    
    return img;
}

@end
