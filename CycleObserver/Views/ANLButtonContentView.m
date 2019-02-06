//
//  ANLbuttonContentView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 23/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLButtonContentView.h"
#import "ANLMeasureButton.h"
#import "ANLCycleView.h"
#import "ANLAccesoryButton.h"
#import "ANLButton.h"



@interface ANLButtonContentView ()

@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIView *accesoryView;

@end



@implementation ANLButtonContentView

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setButtons:[self loadShellButtons]];
    }
    return self;
}

-(void)poblateWithButtons:(NSArray *)buttons {
    
    NSArray *buttonViews = [self buttons];
    [buttons enumerateObjectsUsingBlock:^(ANLButton *button, NSUInteger idx, BOOL *stop) {
        
        ANLMeasureButton *buttonView = [buttonViews objectAtIndex:idx];
        [buttonView setData:button];
    }];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width, 4)];
    [path addClip];
    [path removeAllPoints];
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, rect.size.width, 8));
    CGContextClip(context);
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {0, 0, 0, 0.5, 0, 0, 0, 0};
    CGFloat locs[2] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
    
    CGFloat originY = 4;
    CGFloat finalY = 0;
    
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(rect.size.width / 2.0, originY),
                                CGPointMake(rect.size.width / 2.0, finalY), 0);
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}



#pragma mark - setters & getters

-(UIView *)accesoryView {
    
    if (_accesoryView) {
        
        return _accesoryView;
    }
    
    CGFloat height = 40.0f;
    CGFloat width = [self frame].size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [view setBackgroundColor:[UIColor colorForBottonsFrame]];
    
    CGRect buttonFrame = CGRectMake(0, 0, 80, height);
    CGPoint center = CGPointMake(width / 6, height / 2);
    
    for (NSInteger idx = 0; idx < 3; idx++) {
        
        ANLAccesoryButton *button = [ANLAccesoryButton accesoryButtonWithFrame:buttonFrame color:idx];
        [button addTarget:self action:@selector(changeButtonColor:) forControlEvents:UIControlEventTouchUpInside];
        [button setCenter:center];
        [view addSubview:button];
        
        center.x += width / 3;
    }
    _accesoryView = view;
    return view;
}




#pragma mark - actions

-(void)pushButton:(id)sender {

    [[self delegate] buttonPressed:sender];
}

-(void)changeButtonName:(UIGestureRecognizer *)gesture {
    
    if ([self textField]) {
        
        return;
    }
    //  Localize the pressed button
    __block ANLMeasureButton *button = nil;
    CGPoint point = [gesture locationInView:self];
    [[self buttons] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if (CGRectContainsPoint([obj frame], point)) {
            
            button = obj;
            *stop = YES;
        }
    }];

    NSString *title = [button titleForState:UIControlStateNormal];
    CGRect frame = [button frame];
    CGSize size = CGSizeMake(80, 25);
    frame.origin.x -= (size.width - frame.size.width) / 2;
    frame.origin.y += (frame.size.height - size.height) / 2;
    frame.size = size;
    
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    [field setTag:[[self buttons] indexOfObject:button]];
    [field setText:title];
    [field setBorderStyle:UITextBorderStyleRoundedRect];
    [field setFont:[UIFont spaghettiFontWithSize:10]];
    [field setTextAlignment:NSTextAlignmentRight];
    [field setTextColor:[UIColor blackColor]];
    [field setClearButtonMode:UITextFieldViewModeWhileEditing];
    [field setDelegate:self];
    
    [self setTextField:field];
    [self addSubview:field];
    
    [field becomeFirstResponder];
}



#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [textField setInputAccessoryView:[self accesoryView]];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [[self delegate] button:[[self buttons] objectAtIndex:[textField tag]] didChangeName:[textField text]];

    [textField resignFirstResponder];
    [textField removeFromSuperview];
    [self setTextField:nil];
    
    return YES;
}



#pragma mark - custom Methods

-(void)selectButton:(ANLButton *)button {
    
    if (button) {
        
        [self pushButton:[[self buttons] objectAtIndex:[[button index] integerValue]]];
    }
}

-(void)animateCenterToPoint:(CGPoint)newCenter {
    
    UIViewAnimationOptions option = (newCenter.y > [self center].y) ? UIViewAnimationOptionCurveEaseIn :
                                                                      UIViewAnimationOptionCurveEaseOut;

    [UIView animateWithDuration:0.25f delay:0 options:option animations:^{
        
        [self setCenter:newCenter];
    } completion:NULL];
}

-(void)changeButtonColor:(id)sender {
    
    [[self delegate] button:[[self buttons] objectAtIndex:[[self textField] tag]] didChangeColor:[sender tag]];
}

-(NSArray *)loadShellButtons {
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    CGSize btnSize = [ANLMeasureButton buttonSize];
    CGSize containerSize = CGSizeMake([UIDevice anlScreenwidth], [self bounds].size.height);
    containerSize.height -= 4;
    CGFloat pad = (containerSize.height - btnSize.height * 2) / 4 ;
    CGFloat width = (containerSize.width - [ANLCycleView barXOrigin] - [ANLCycleView rightPad]) / 8;
    CGFloat centerX = [ANLCycleView barXOrigin] + width / 2;
    CGFloat y = containerSize.height / 2;
    
    for (NSInteger index = 0; index < 8; index++) {
        
        CGRect btnFrame = CGRectMake(centerX - btnSize.width / 2, pad + y * (index % 2) + 4,
                                     btnSize.width, btnSize.height);
        
        ANLMeasureButton *btn = [ANLMeasureButton buttomWithFrame:btnFrame];
        
        [btn addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:index + 1];
        
        SEL selector = @selector(changeButtonName:);
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                action:selector];
        [btn addGestureRecognizer:longPress];
        
        [self addSubview:btn];
        [btnArray addObject:btn];
        centerX += width;
    }
    return [NSArray arrayWithArray:btnArray];
}

@end
