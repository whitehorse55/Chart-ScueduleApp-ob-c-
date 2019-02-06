//
//  ANLMeasureButton.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLMeasureButton.h"
#import "ANLButton.h"



@interface ANLMeasureButton ()



@end



@implementation ANLMeasureButton

#pragma mark - constants

+(CGSize)buttonSize {
    
    return CGSizeMake(54, 54);
}

+(instancetype)buttomWithFrame:(CGRect)frame Color:(ANLButtonColor)buttonColor andText:(NSString *)title {
    
    ANLMeasureButton *button = [ANLMeasureButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setColorAtribute:buttonColor];
    [button setTitle:title];
    [[button titleLabel] setFont:[UIFont spaghettiFontWithSize:9]];
    [[button titleLabel] setLineBreakMode:NSLineBreakByClipping];
    
    return button;
}

+(instancetype)buttomWithFrame:(CGRect)frame {
    
    return [ANLMeasureButton buttomWithFrame:frame Color:anlButtonColorGrey andText:@""];
}



#pragma mark - setters

-(void)setData:(ANLButton *)data {
    
    if (_data != data) {
        
        _data = data;
        [self setColorAtribute:[[_data color] integerValue]];
        [self setTitle:[_data name]];
    }
}

-(void)setColorAtribute:(ANLButtonColor)colorAtribute {
    
    if (_colorAtribute != colorAtribute) {
        
        _colorAtribute = colorAtribute;
//        NSString *title = colorAtribute != anlButtonColorGrey ? [self titleForState:UIControlStateNormal] : @"";
        [self setTitle:[self titleForState:UIControlStateNormal]];
        [self setNeedsDisplay];
    }
}

-(void)setTitle:(NSString *)title {
    
    if ([self colorAtribute] == anlButtonColorGrey) {
        
        title = @"";
    }
//    if ([title isEqualToString:@""] && [self colorAtribute] != anlButtonColorGrey) {
//        
//        [self setColorAtribute:anlButtonColorGrey];
//        return;
//    }
    
    UIColor *textColor;
    if ([self colorAtribute] == anlButtonColorYellow) {
        
        textColor = [UIColor blackColor];
    } else {
        
        textColor = [UIColor whiteColor];
    }
    
    NSString *text = [title length] < 7 ? title : [title substringWithRange:NSMakeRange(0, 7)];
    [self setTitle:text forState:UIControlStateSelected];
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateSelected];
}



#pragma mark - draw

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    [path removeAllPoints];
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = NULL;
    CGFloat locs[2] = {1, 0};
    switch ([self colorAtribute]) {
            
        case anlButtonColorGreen: {
            
            CGFloat components[8] = {0, 0.56, 0, 1, 0, 0.44, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        case anlButtonColorYellow: {
            
            CGFloat components[8] = {1, 0.98, 0, 1, .88, .86, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        case anlButtonColorRed: {
            
            CGFloat components[8] = {1, 0.15, 0, 1, .88, .03, 0, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
            
        case anlButtonColorGrey: {
            
            CGFloat components[8] = {.565, 0.565, 0.565, 1, .445, .445, 0.445, 1};
            gradient = CGGradientCreateWithColorComponents(space, components, locs, 2);
        }
            break;
    }
    
    CGFloat originY = rect.size.height;
    CGFloat finalY = 0;
    
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(rect.size.width / 2.0, originY),
                                CGPointMake(rect.size.width / 2.0, finalY), 0);
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    NSString *tag = [NSString stringWithFormat:@"%li", (long)[self tag]];
    NSDictionary *tagDic = @{NSFontAttributeName : [UIFont spaghettiFontWithSize:12],
                             NSForegroundColorAttributeName : [self titleColorForState:UIControlStateNormal]};
    
    CGSize tagSize = [tag sizeWithAttributes:tagDic];
    CGPoint tagPoint = CGPointMake(rect.origin.x + (rect.size.width - tagSize.width) / 2,
                                   rect.size.height / 3 - tagSize.height);
    
    [tag drawAtPoint: tagPoint withAttributes:tagDic];
    
    if ([self isSelected]) {

        CGContextSetLineWidth(context, 4.0f);
        CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
        CGRect circleBorder = CGRectMake(rect.origin.x + 2, rect.origin.y + 2,
                                         rect.size.width - 4, rect.size.height - 4);
        
        CGContextAddEllipseInRect(context, circleBorder);
        CGContextStrokePath(context);
    }
}

@end
