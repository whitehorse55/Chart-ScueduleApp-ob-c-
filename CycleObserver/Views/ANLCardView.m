//
//  ANLCardView.m
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import "ANLCardView.h"



@interface ANLCardView ()

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (nonatomic) anlCardType cardType;
@property (nonatomic) CGFloat restStateYOrigin;
@property (nonatomic) CGFloat showedStateYOrigin;
@property (nonatomic) CGFloat downStateYOrigin;

@end



@implementation ANLCardView

+(CGFloat)headHeight {
    
    return 40.0f;
}

+(CGFloat)gap {
    
    return 15.0f;
}

+(CGFloat)heightForType:(anlCardType)type {
    
    CGFloat width = [ANLCardView cardWidth];
    CGFloat height = (type == anlCardTypeVa_nva) ? width : width * 0.5818f;

    return height;
}

+(CGFloat)cardWidth {
    
    return [UIDevice anlScreenwidth] - [ANLCardView gap] * 2;
}

+(instancetype)cardWithOriginY:(CGFloat)y type:(anlCardType)type {
    
    return [[ANLCardView alloc] initWithOriginY:y type:type];
}



#pragma mark - lifeCyle

-(id)initWithOriginY:(CGFloat)y type:(anlCardType)type {
    
    CGRect frame = CGRectMake([ANLCardView gap], y, [ANLCardView cardWidth], [ANLCardView heightForType:type]);
    return [self initWithFrame:frame type:type];
}

-(id)initWithFrame:(CGRect)frame type:(anlCardType)type {
    
    if (self = [super initWithFrame:frame]) {

        [self setBackgroundColor:[UIColor clearColor]];
        [self setCardType:type];
        [self setCardState:anlCardStateRest];
        [self setUpGestures];
    }
    return self;
}

-(void)dealloc {
    
    [self tearDownGestures];
}

-(void)setYOriginForStateRest:(CGFloat)restOrigin showed:(CGFloat)showedOrigin down:(CGFloat)downOrigin {
    
    [self setRestStateYOrigin:restOrigin];
    [self setShowedStateYOrigin:showedOrigin - 2];
    [self setDownStateYOrigin:downOrigin];
}

-(void)drawRect:(CGRect)rect {
    //  Redondeamos el area a dibujar.
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(10, 10)];
    [path addClip];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //  Dibujamos el fondo en gradient
    CGGradientRef gradient;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.3, 1.0};
    
    switch ([self cardType]) {
        case anlCardTypeAllCycles: {
            
            CGFloat components[8] = {0.769, 0.169, 0.184, 1, 0.988, 0.309, 0.031, 1};
            gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
        }
            break;
        case anlCardTypeSteps: {
            
            CGFloat components[8] = {0.059, 0.153, 0.843, 1, 0, 0, 1, 1};
            gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
        }
            break;
        case anlCardTypeVa_nva: {
            
            CGFloat components[8] = {0.251, 0.322, 0.122, 1, 0.396, 0.514, 0.180, 1};
            gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
        }
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.size.height), CGPointZero, 0);
    CGGradientRelease(gradient);
    
    //  Dibujamos la linea de la cabecera
    CGFloat y = [ANLCardView headHeight] + 1;
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, [ANLCardView gap], y);
    CGContextAddLineToPoint(context, rect.size.width - [ANLCardView gap], y);
    CGContextStrokePath(context);
}



#pragma mark - setters & getters

-(void)setCardState:(anlCardState)cardState {
    
    if (_cardState != cardState) {
        
        _cardState = cardState;
        [self animateToStatePosition:cardState];
    }
}



#pragma mark - actions

-(void)userTap {

    [[self delegate] tappedCardView:self];
}



#pragma mark - custom Methods

-(UIImage *)takeSnapshot {
    
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0);
    [self drawViewHierarchyInRect:[self bounds] afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

-(void)animateToStatePosition:(anlCardState)state {
    
    CGFloat newYOrigin = 0;
    __block CGPoint newCenter = [self center];
    switch (state) {
            
        case anlCardStateRest:
            newYOrigin = [self restStateYOrigin];
            break;
            
        case anlCardStateDown:
            newYOrigin = [self downStateYOrigin];
            break;
            
        case anlCardStateShowed:
            newYOrigin = [self showedStateYOrigin];
            break;
    }
    CGFloat bounce = 4 * ([self frame].origin.y > newYOrigin ? -1 : 1);
    newCenter.y = newYOrigin + [self bounds].size.height / 2 + bounce;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self setCenter:newCenter];
    } completion:^(BOOL finished) {
        
        newCenter.y -= bounce + bounce / 2;
        [UIView animateWithDuration:0.2 animations:^{
            
            [self setCenter:newCenter];
        } completion:^(BOOL finished) {
            
            newCenter.y += bounce *.75;
            [UIView animateWithDuration:0.2 animations:^{
                
                [self setCenter:newCenter];
            } completion:^(BOOL finished) {
                
                newCenter.y -= bounce / 4;
                [UIView animateWithDuration:0.2 animations:^{
                    
                    [self setCenter:newCenter];
                }];
            }];
        }];
    }];
}

-(void)setUpGestures {
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(userTap)];
    [self setTap:gesture];
    [self addGestureRecognizer:gesture];
}

-(void)tearDownGestures {
    
    [[self gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self removeGestureRecognizer:obj];
    }];
}

@end
