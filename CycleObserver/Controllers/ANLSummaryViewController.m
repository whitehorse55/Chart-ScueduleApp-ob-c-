//
//  ANLSummaryViewController.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLSummaryViewController.h"
#import "ANLAllValuesCardView.h"
#import "ANLStepsCardView.h"
#import "ANLVACardView.h"
#import "ANLModel.h"
#import "ANLTabBar.h"
#import "ANLMailGenerator.h"



@interface ANLSummaryViewController ()

@property (strong, nonatomic) ANLAllValuesCardView *allCard;
@property (strong, nonatomic) ANLStepsCardView *stepsCard;
@property (strong, nonatomic) ANLVACardView *vaCard;

@property (strong, nonatomic) NSDictionary *allValuesData;
@property (strong, nonatomic) NSDictionary *stepsData;
@property (strong, nonatomic) NSDictionary *vaData;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *savePictureButton;

@end



@implementation ANLSummaryViewController

+(NSUInteger)numberOfCards {
    
    return 3;
}



#pragma mark - lifeCycle

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [(ANLTabBar *)[[self tabBarController] tabBar] showTabBarAnimated:NO];
    
    [self setMeasure:[[ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]] measure]];
    [[self savePictureButton] setTitle:[Language stringForKey:@"summary.saveButton.title"]];
    [self poblateCards];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[self allCard] removeFromSuperview];
    [[self stepsCard] removeFromSuperview];
    [[self vaCard] removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

    NSError *error = nil;
    [[self moc] save:&error];
    if (error) {
        
        NSLog(@"Error saving model in %s with error:%@", __PRETTY_FUNCTION__, error);
    }
}



#pragma mark - setters

-(void)setMeasure:(ANLMeasure *)measure {
    
    _measure = measure;
    [self generateDataWithMeasure:measure];
}



#pragma mark - MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error {
    
    switch (result)
    {
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - ANLCardViewDelegate

-(void)tappedCardView:(ANLCardView *)cardView {
    
    switch ([cardView cardType]) {
            
        case anlCardTypeAllCycles: {
            
            BOOL showed = [cardView cardState] == anlCardStateShowed;
            [cardView setCardState:showed ? anlCardStateRest : anlCardStateShowed];
            [[self stepsCard] setCardState:anlCardStateRest];
            [[self vaCard] setCardState:anlCardStateRest];
            break;
        }
        case anlCardTypeSteps: {
            
            BOOL showed = [cardView cardState] == anlCardStateShowed;
            [cardView setCardState:showed ? anlCardStateRest : anlCardStateShowed];
            [[self allCard] setCardState:showed ? anlCardStateRest : anlCardStateDown];
            [[self vaCard] setCardState:anlCardStateRest];
            break;
        }
        case anlCardTypeVa_nva: {
            
            BOOL showed = [cardView cardState] == anlCardStateShowed;
            [cardView setCardState:showed ? anlCardStateRest : anlCardStateShowed];
            [[self allCard] setCardState:showed ? anlCardStateRest : anlCardStateDown];
            [[self stepsCard] setCardState:showed ? anlCardStateRest : anlCardStateDown];
            break;
        }
    }
}



#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}



#pragma mark - actions

- (IBAction)sendReport:(id)sender {
    
    if (![MFMailComposeViewController canSendMail]) {
        
        [self canNotSendMail];
        return;
    }
    ANLMeasure *measure = [self measure];
    ANLMailGenerator *mailGenerator = [[ANLMailGenerator alloc] initWithMeasure:measure];
    [mailGenerator setVaData:[self vaData]];
    [mailGenerator setSteps:[[self stepsData] objectForKey:ANLStepsCardKey.steps]];
    
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    [[mail navigationBar] setBarStyle:UIBarStyleBlack];
    [[mail navigationBar] setTintColor:[UIColor colorWithHue:0 saturation:0 brightness:.95 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [mail setMailComposeDelegate:self];
    [mail setMessageBody:[mailGenerator body] isHTML:YES];
    [mail setSubject:[mailGenerator subject]];
    
    NSString *mimeType = @"image/jpeg";
    [[[measure photos] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *fileName = [NSString stringWithFormat:@"image%li", (long)idx];
        [mail addAttachmentData:[obj data] mimeType:mimeType fileName:fileName];
    }];
    [self presentViewController:mail animated:YES completion:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

- (IBAction)takeSnapshot:(id)sender {

    [UIView animateWithDuration:0.10f animations:^{
        
        [[self view] setAlpha:0.2f];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.10f animations:^{
            
            [[self view] setAlpha:1];
        } completion:^(BOOL finished) {
            
            NSArray *pictures = @[[self allCard], [self stepsCard], [self vaCard]];
            [pictures enumerateObjectsUsingBlock:^(ANLCardView *card, NSUInteger idx, BOOL *stop) {
                
                UIImage *snapshot = [card takeSnapshot];
                NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(snapshot, 1.0f)];
                ANLPhoto *photo = [ANLPhoto photoWithData:data inManagedObjectContext:[self moc]];
                [[self measure] addPhotosObject:photo];
            }];

            NSError *error = nil;
            [[self moc] save:&error];
            
            if (error) {
                
                NSLog(@"error taken snapshot:%@", error);
            }
        }];
    }];
}



#pragma mark - custom Methods

-(void)poblateCards {
    
    CGFloat restY, showedY, downY;
    restY = [[[self tabBarController] tabBar] frame].origin.y - [ANLCardView headHeight];
    ANLVACardView *vaCard = [[ANLVACardView alloc] initWithY:restY data:[self vaData]];
    [vaCard setDelegate:self];
    [self setVaCard:vaCard];
    [[self view] addSubview:[self vaCard]];
    
    downY = restY;
    showedY = restY - [ANLCardView headHeight] - [vaCard bounds].size.height;
    [vaCard setYOriginForStateRest:restY showed:showedY down:downY];
    
    restY -= [ANLCardView headHeight];
    ANLStepsCardView *stepsCard = [[ANLStepsCardView alloc] initWithY:restY data:[self stepsData]];
    [stepsCard setDelegate:self];
    [self setStepsCard:stepsCard];
    [[self view] insertSubview:stepsCard belowSubview:vaCard];
    
    downY = restY + [ANLCardView headHeight];
    showedY = restY - [stepsCard bounds].size.height;
    [stepsCard setYOriginForStateRest:restY showed:showedY down:downY];
    
    restY -= [ANLCardView headHeight];
    ANLAllValuesCardView *allCard = [[ANLAllValuesCardView alloc] initWithY:restY data:[self allValuesData]];
    [allCard setDelegate:self];
    [self setAllCard:allCard];
    [[self view] insertSubview:allCard belowSubview:stepsCard];
    
    downY = restY + [ANLCardView headHeight];
    showedY = downY - [allCard bounds].size.height;
    [allCard setYOriginForStateRest:restY showed:showedY down:downY];
}

-(void)generateDataWithMeasure:(ANLMeasure *)measure {

    //  Init var
    __block NSUInteger maxDuration = 0;
    __block NSUInteger minDuration = INT32_MAX;
    __block CGFloat avgTaktTime = 0;
    NSNumber *taktTime = [measure taktTime];
    NSUInteger totalCycles = [[measure cycles] count];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *stepsData = [[NSMutableArray alloc] init];
    NSMutableArray *completeData = [[NSMutableArray alloc] init];
    NSMutableArray *steps = [[NSMutableArray alloc] initWithCapacity:8];
    
    for (NSInteger i = 0; i < 8; i++) {
        
        [steps addObject:[@{ANLStepsCardKey.max : @0, ANLStepsCardKey.avg : [[NSMutableArray alloc] init],
                            ANLStepsCardKey.min : @(minDuration), ANLStepsCardKey.nCycles : [[NSMutableSet alloc] init],
                            ANLVACardKey.name : @"", ANLVACardKey.type : @(minDuration)} mutableCopy]];
    }
    //  Proccess data
    [[measure cycles] enumerateObjectsUsingBlock:^(ANLCycle *cycle, BOOL *stop) {
        
        __block CGFloat stepDuration = 0;
        [[cycle segments] enumerateObjectsUsingBlock:^(ANLSegment *segment, BOOL *stop) {
            
            CGFloat duration = [segment durationValue];
            stepDuration += duration;
            ANLButton *button = [segment button];
            
            NSMutableDictionary *step = [steps objectAtIndex:(NSUInteger)[button indexValue]];
            CGFloat max = MAX([step[ANLStepsCardKey.max] floatValue], duration);
            CGFloat min = MIN([step[ANLStepsCardKey.min] floatValue], duration);
            NSMutableSet *nCycles = step[ANLStepsCardKey.nCycles];
            [nCycles addObject:cycle];
            
            [step setObject:@(max) forKey:ANLStepsCardKey.max];
            [step[ANLStepsCardKey.avg] addObject:@(duration)];
            [step setObject:@(min) forKey:ANLStepsCardKey.min];
            [step setObject:nCycles forKey:ANLStepsCardKey.nCycles];
            [step setObject:[button name] forKey:ANLVACardKey.name];
            [step setObject:[button color] forKey:ANLVACardKey.type];
        }];
        avgTaktTime += stepDuration;
        maxDuration = MAX(maxDuration, stepDuration);
        minDuration = MIN(minDuration, stepDuration);
        [data addObject:@(stepDuration)];
    }];
    minDuration = (minDuration != INT32_MAX) ? minDuration : 0;
    avgTaktTime /= totalCycles;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:ANLVACardKey.type ascending:YES];
    NSArray *stepsSort = [steps sortedArrayUsingDescriptors:@[sort]];
    //  Save data and generate dictionaries
    __block CGFloat totalVA = 0;
    __block CGFloat totalNVAi = 0;
    __block CGFloat totalNVA = 0;
    __block NSUInteger tasksVA = 0;
    __block NSUInteger tasksNVAi = 0;
    __block NSUInteger tasksNVA = 0;
    [stepsSort enumerateObjectsUsingBlock:^(NSMutableDictionary *step, NSUInteger idx, BOOL *stop) {
        
        if ([step[ANLStepsCardKey.max] floatValue] > 0) {
            
            NSNumber *avg = [step[ANLStepsCardKey.avg] valueForKeyPath:@"@avg.self"];
            [step setObject:avg forKey:ANLStepsCardKey.avg];
            
            NSUInteger nCycles = [step[ANLStepsCardKey.nCycles] count];
            [step setObject:@(nCycles) forKey:ANLStepsCardKey.nCycles];
            
            anlStepType type = [step[ANLVACardKey.type] integerValue] + 1;
            type = (type < 2 && nCycles == totalCycles) ? anlStepTypeVA_cyclical : type;
            [step setObject:@(type) forKey:ANLVACardKey.type];
            CGFloat duration = [avg floatValue] * nCycles;
            totalVA += (type < anlStepTypeNVAi) ? duration : 0;
            totalNVAi += (type == anlStepTypeNVAi) ? duration : 0;
            totalNVA += (type == anlStepTypeNVA) ? duration : 0;

            tasksVA += (type < anlStepTypeNVAi) ? 1 : 0;
            tasksNVAi += (type == anlStepTypeNVAi) ? 1 : 0;
            tasksNVA += (type == anlStepTypeNVA) ? 1 : 0;
            
            [stepsData addObject:@{ANLStepsCardKey.max     : step[ANLStepsCardKey.max],
                                   ANLStepsCardKey.avg     : avg,
                                   ANLStepsCardKey.min     : step[ANLStepsCardKey.min],
                                   ANLStepsCardKey.nCycles : @(nCycles),
                                   ANLStepsCardKey.name    : step[ANLVACardKey.name]}];
            
            NSDictionary *dic = @{ANLVACardKey.name    : step[ANLVACardKey.name],
                                  ANLVACardKey.value   : avg,
                                  ANLVACardKey.type    : @(type),
                                  ANLVACardKey.nCycles : @(nCycles)};
            
            [completeData addObject:dic];
        }
    }];

    [self setAllValuesData:@{ANLAllValuesCardKey.taktTime    : taktTime,
                             ANLAllValuesCardKey.avgTaktTime : @((NSUInteger)avgTaktTime),
                             ANLAllValuesCardKey.data        : [data copy],
                             ANLAllValuesCardKey.maxDuration : @(maxDuration),
                             ANLAllValuesCardKey.minDuration : @(minDuration)}];
    
    [self setStepsData:@{ANLStepsCardKey.totalCycles : @(totalCycles),
                         ANLStepsCardKey.steps       : [stepsData copy]}];
    
    CGFloat percentage = (totalVA + totalNVAi + totalNVA) / 100;
    [self setVaData:@{ANLVACardKey.taktTime       : taktTime,
                      ANLVACardKey.totalCycles    : @(totalCycles),
                      ANLVACardKey.completeData   : [completeData copy],
                      ANLVACardKey.percentageVA   : @((NSInteger)(totalVA / percentage)),
                      ANLVACardKey.tasksVA        : @(tasksVA),
                      ANLVACardKey.percentageNVAi : @((NSInteger)(totalNVAi / percentage)),
                      ANLVACardKey.tasksNVAi      : @(tasksNVAi),
                      ANLVACardKey.percentageNVA  : @((NSInteger)(totalNVA / percentage)),
                      ANLVACardKey.tasksNVA       : @(tasksNVA)}];
}

-(void)canNotSendMail {
    
    NSString *title = [Language stringForKey:@"summary.caNotSendMail.title"];
    NSString *text = [Language stringForKey:@"summary.canNotSendMail.text"];
    if ([UIAlertController class]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil ? @"" : title
                                                                       message:text
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
            
                                                    [self dismissViewControllerAnimated:YES completion:NULL];
        }]];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
