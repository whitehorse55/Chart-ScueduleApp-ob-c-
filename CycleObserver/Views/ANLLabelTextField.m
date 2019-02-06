//
//  ANLLabelTextField.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 07/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLLabelTextField.h"



@implementation ANLLabelTextField

#pragma mark - lifeCycle

-(id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setType:[self tag]];
        [self addGestures];
    }
    return self;
}

-(void)dealloc {
    
    [self tearDownGestures];
}



#pragma mark - custom methods

-(void)addGestures {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTouch:)];
    [self addGestureRecognizer:tap];
}

-(void)tearDownGestures {
    
    [[self gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self removeGestureRecognizer:obj];
    }];
}

-(void)userTouch:(UIGestureRecognizer *)gesture {
    
    UITextField *tf = [[UITextField alloc] initWithFrame:[self bounds]];
    [tf setBackgroundColor:[UIColor whiteColor]];
    [tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [tf setOpaque:YES];
    [tf setTag:[self tag]];
    [tf setText:[self text]];
    [tf setFont:[self font]];
    [tf setTextAlignment:[self textAlignment]];
    [tf setTextColor:[self textColor]];
    [tf setDelegate:[self delegate]];
    [self addSubview:tf];
    
    [self setTextField:tf];
    [[self delegate] editLabelTextField:self];
}

-(void)dismissTextField {
    
    [[self textField] resignFirstResponder];
    [[self textField] removeFromSuperview];
    [self setTextField:nil];
}

@end
