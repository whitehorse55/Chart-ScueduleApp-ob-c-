//
//  ANLCycleButtonView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 25/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCycleButtonView.h"



@interface ANLCycleButtonView ()

@property (strong, nonatomic) UIImageView *checkImage;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end



@implementation ANLCycleButtonView

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupGesture];
        [[self layer] setBorderColor:[[UIColor colorWithRed:.059 green:.153 blue:.843 alpha:1] CGColor]];
        [[self layer] setBorderWidth:1];
    }
    return self;
}

-(void)dealloc {
    
    [self tearDownGesture];
}

-(void)setSelect:(BOOL)select {
    
    if (_select != select) {
        
        _select = select;
        if (select) {

            [self addSubview:[self checkImage]];
        } else {

            [[self checkImage] removeFromSuperview];
        }
    }
}

-(UIImageView *)checkImage {
    
    if (!_checkImage) {
        
        _checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkIconBlue"]];

        [_checkImage setCenter:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
    }
    return _checkImage;
}

-(void)userTap {

    [[self delegate] selectCycleButton:self];
}

-(void)setupGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTap)];
    [self setTap:tap];
    [self addGestureRecognizer:tap];
}

-(void)tearDownGesture {
    
    [self removeGestureRecognizer:[self tap]];
    [self setTap:nil];
}

@end
