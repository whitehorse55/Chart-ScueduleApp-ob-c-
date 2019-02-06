//
//  ANLMailGenerator.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 20/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLMailGenerator.h"
#import "ANLModel.h"
#import "ANLVACardView.h"
#import "ANLStepsCardView.h"



@interface ANLMailGenerator ()

@property (strong, nonatomic) ANLMeasure *measure;

@end



@implementation ANLMailGenerator

-(id)initWithMeasure:(ANLMeasure *)measure {
    
    if (self = [super init]) {
        
        [self setMeasure:measure];
    }
    return self;
}

-(NSString *)subject {
    
    return [Language stringForKey:@"ANLMailGenerator.subject"];
}

-(NSString *)body {
    
    NSString *title = [Language stringForKey:@"ANLMailGenerator.body.title"];
    title = [NSString stringWithFormat:@"<ins><b>%@</b></ins>", title];
    
    NSString *headDescription = [self headDescription];
    NSString *averageData = [self averageData];
    
    NSString *steps = [Language stringForKey:@"ANLMailGenerator.body.stepsHead"];
    steps = [NSString stringWithFormat:@"<b>%@</b>", steps];
    
    NSString *stepsData = [self stepsTable];
    
    NSString *cycles = [Language stringForKey:@"ANLMailGenerator.body.cyclesHead"];
    cycles = [NSString stringWithFormat:@"<b>%@</b>", cycles];
    
    NSString *cyclesData = [self cyclesTable];
    
    NSString *message = [NSString stringWithFormat:@"%@<br><br>%@<br>%@<br><br>%@<br><br>%@<br><br>%@<br><br>%@",
                         title, headDescription, averageData, steps, stepsData, cycles, cyclesData];
    return message;
}

-(NSData *)csvData {
    
    return nil;
}



#pragma mark - internal Methods

-(NSString *)headDescription {
    
    NSMutableString *head = [[NSMutableString alloc] init];
    NSString *organization = [Language stringForKey:@"ANLMailGenerator.headDescription.organization"];
    NSString *process = [Language stringForKey:@"ANLMailGenerator.headDescription.process"];
    NSString *operation = [Language stringForKey:@"ANLMailGenerator.headDescription.operation"];
    NSString *operator = [Language stringForKey:@"ANLMailGenerator.headDescription.operator"];
    NSString *place = [Language stringForKey:@"ANLMailGenerator.headDescription.place"];
    
    ANLMeasure *measure = [self measure];
    ANLProcess *pro = [[[measure operator] operation] process];
    if (![[[pro organization] name] isEqual:@""]) {
        
        [head appendFormat:@"%@ %@<br>", organization, [[pro organization] name]];
    }
    if (![[pro name] isEqual:@""]) {
        
        [head appendFormat:@"%@ %@<br>", process, [pro name]];
    }
    if (![[[[measure operator] operation] name] isEqual:@""]) {
        
        [head appendFormat:@"%@ %@<br>", operation, [[[measure operator] operation] name]];
    }
    if (![[[measure operator] name] isEqual:@""]) {
        
        [head appendFormat:@"%@ %@<br>", operator, [[measure operator] name]];
    }
    if (![[measure place] isEqual:@""]) {
        
        [head appendFormat:@"%@ %@<br>", place, [measure place]];
    }
    return head;
}

-(NSString *)averageData {
    
    NSMutableString *averageText = [[NSMutableString alloc] init];
    ANLMeasure *measure = [self measure];
    NSUInteger timeScale = [[measure timeScale] integerValue];
    NSSet *cycles = [measure cycles];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    
    CGFloat averageCycleDuration = [[cycles valueForKeyPath:@"@avg.cycleDuration"] floatValue];
    CGFloat timeScaleEquivalence = [[[ANLMeasure timeScaleEquivalencies] objectAtIndex:timeScale] floatValue];
    CGFloat avgCycle = averageCycleDuration * timeScaleEquivalence;
    
    NSString *avgText = [formatter stringFromNumber:@(avgCycle)];
    [averageText appendFormat:@"%@ %@<br>", [Language stringForKey:@"ANLMailGenerator.averageData.avgCycle"], avgText];
    
    NSString *avgVaNvaDesc = [Language stringForKey:@"ANLMailGenerator.averageData.avgVA/NVA"];
    NSLog(@"vaPercentage:%f", [[[self vaData] objectForKey:ANLVACardKey.percentageVA] floatValue]);
    CGFloat vaDuration = [[[self vaData] objectForKey:ANLVACardKey.percentageVA] floatValue] * avgCycle / 100;
    CGFloat nvaiDuration = [[[self vaData] objectForKey:ANLVACardKey.percentageNVAi] floatValue] * avgCycle / 100;
    CGFloat nvaDuration = [[[self vaData] objectForKey:ANLVACardKey.percentageNVA] floatValue] * avgCycle / 100;
    NSString *vaTxt = [formatter stringFromNumber:@(vaDuration)];
    NSString *nvaiTxt = [formatter stringFromNumber:@(nvaiDuration)];
    NSString *nvaTxt = [formatter stringFromNumber:@(nvaDuration)];
    
    NSString *avgVaNvaValue = [NSString stringWithFormat:@"%@ VA + %@ NVAi + %@ NVA<br>", vaTxt, nvaiTxt, nvaTxt];
    [averageText appendFormat:@"%@ %@ = %@", avgVaNvaDesc, avgText, avgVaNvaValue];
    
    NSString *totalCycles = [Language stringForKey:@"ANLMailGenerator.averageData.numberCycles"];
    [averageText appendFormat:@"%@ %@<br>", totalCycles, [@([[measure cycles] count]) stringValue]];
    
    return averageText;
}

-(NSString *)stepsTable {
    
    NSArray *types = @[@"VA", @"NVAi", @"NVA"];
    NSArray *steps = [self steps];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    NSArray *buttons = [[[[self measure] buttons] allObjects] sortedArrayUsingDescriptors:@[sort]];
    NSMutableString *table = [[NSMutableString alloc] init];
    [buttons enumerateObjectsUsingBlock:^(ANLButton *button, NSUInteger idx, BOOL *stop) {
        
        ANLButtonColor value = [[button color] integerValue];
        if (value != anlButtonColorGrey) {
        
            NSNumber *avgDuration = [[button segments] valueForKeyPath:@"@avg.duration"];
            NSString *duration = [ANLMeasure stringFormatForDuration:avgDuration withScale:2];
            NSString *name = [[button name] isEqual:@""] ? @"" : [button name];
            
            NSString *step = @"";
            if (idx < [steps count]) {
                
                NSDictionary *stepDic = [steps objectAtIndex:idx];
                step = [[stepDic objectForKey:ANLStepsCardKey.nCycles] stringValue];
                step = [step stringByAppendingFormat:@"/%@", [@([[[self measure] cycles] count]) stringValue]];
            }
            [table appendFormat:@"%@- %@ @ %@ - %@ - %@<br>", [[button index] stringValue], types[value], name,
                                                              step, duration];
        }
    }];
    return [table copy];
}

-(NSString *)cyclesTable {
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    NSArray *cycles = [[[[self measure] cycles] allObjects] sortedArrayUsingDescriptors:@[sort]];
    NSMutableString *table = [[NSMutableString alloc] init];
    [cycles enumerateObjectsUsingBlock:^(ANLCycle *cycle, NSUInteger idx, BOOL *stop) {
        
        NSMutableString *cycleDescr = [NSMutableString stringWithFormat:@"Cycle %@: ", [cycle index]];
        NSArray *segments = [[[cycle segments] allObjects] sortedArrayUsingDescriptors:@[sort]];
        [segments enumerateObjectsUsingBlock:^(ANLSegment *segment, NSUInteger idx, BOOL *stop) {
            
            if (idx > 0) {
                
                [cycleDescr appendString:@" -> "];
            }
            NSString *duration = [ANLMeasure stringFormatForDuration:[segment duration] withScale:2];
            [cycleDescr appendFormat:@"%@ (%@)", [[segment button] name], duration];
        }];
        [table appendFormat:@"%@<br>", cycleDescr];
    }];
    return [table copy];
}

@end
