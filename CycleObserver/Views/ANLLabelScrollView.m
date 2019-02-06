//
//  ANLLabelScrollView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 24/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLLabelScrollView.h"



@implementation ANLLabelScrollView

+(CGFloat)heightCell {
    
    return 50.0f;
}

-(id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self checkScreenHeight];
    }
    return self;
}

-(void)checkScreenHeight {
    
    if ([[UIScreen mainScreen] bounds].size.width < [self bounds].size.height) {
        
        [self setScrollEnabled:YES];
        [self setBounces:YES];
        [self setShowsVerticalScrollIndicator:YES];
    }
}

@end
