//
//  ANLCSVProcessor.m
//  Spaghetti
//
//  Created by Amador Navarro Lucas on 9/1/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCSVProcessor.h"



@implementation ANLCSVProcessor

+(NSString *)separator {
    
    return @",";
}

+(NSArray *)specialCharSet {
    
    return @[@" ", @"\"", @"\n", [ANLCSVProcessor separator]];
}

+(NSString *)stringCSVFormatWithData:(NSArray *)data {
    
    ANLCSVProcessor *processor = [[ANLCSVProcessor alloc] init];
    
    return [processor generateStringWithData:data];
}

-(NSString *)generateStringWithData:(NSArray *)data {
    
    __block NSString *csvString = [[NSString alloc] init];
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            csvString = [csvString stringByAppendingString:[self csvForRow:obj]];
        }
    }];
    return [csvString copy];
}

-(NSString *)csvForRow:(NSDictionary *)dic {
    
    __block NSString *row = @"";
    [[dic allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id value = [dic objectForKey:obj];
        if ([value isKindOfClass:[NSString class]]) {
            
            NSString *prefix = (idx > 0) ? @"," : @"";
            NSString *stringToAppend = [self containSpecialChar:value] ? [self insertDoubleQuotes:value] : value;
            
            row = [row stringByAppendingString:[prefix stringByAppendingString:stringToAppend]];
        }
    }];
    row = [row stringByAppendingString:@"\n"];
    return row;
}

-(BOOL)containSpecialChar:(NSString *)aString {

    __block bool contain = NO;
    [[ANLCSVProcessor specialCharSet] enumerateObjectsUsingBlock:^(NSString *chr, NSUInteger idx, BOOL *stop) {

        NSUInteger location = [aString rangeOfString:chr].location;
        if (location != NSNotFound) {

            if (!([chr isEqualToString:@" "] && location > 0 && location < [aString length] - 1)) {
                
                contain = YES;
                *stop = YES;
            }
        }
    }];
    return contain;
}

-(NSString *)insertDoubleQuotes:(NSString *)aString {
    
    NSString *string = @"";
    NSInteger length = [aString length];
    for (NSInteger idx = 0; idx < length; idx++) {
        
        NSString *nextChar = [aString substringWithRange:NSMakeRange(idx, 1)];
        string = [string stringByAppendingString:nextChar];
        if ([nextChar isEqual:@"\""]) {

            string = [string stringByAppendingString:@"\""];
        }
    }
    return [NSString stringWithFormat:@"\"%@\"", string];
}

@end
