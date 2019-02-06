//
//  ANLTacktTimeView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 13/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLTaktTimeView.h"
#import "ANLDurationLabel.h"



@interface ANLTaktTimeView ()

//@property (strong, nonatomic) NSString *taktTime;

//@property (nonatomic) CGPoint initial;
//@property (nonatomic) CGPoint final;

@end



@implementation ANLTaktTimeView

#pragma mark - constants

+(CGFloat)sizeFont {
    
    return 13.0f;
}

+(CGSize)sizeForText:(NSString *)text {
    
    return [text sizeWithAttributes:@{NSFontAttributeName : [UIFont spaghettiFontWithSize:[ANLTaktTimeView sizeFont]]}];
}
//+(CGFloat)verticalEdges {
//    
//    return 2.0;
//}



#pragma mark - class method

+(instancetype)taktViewWithFrame:(CGRect)frame taktTime:(NSString *)taktTime {
    
    ANLTaktTimeView *taktView = [[ANLTaktTimeView alloc] initWithFrame:frame];
//    [taktView setTaktTime:taktTime];
    [taktView addLabelWithText:taktTime];
    return taktView;
}



#pragma mark - lifeCycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
//    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    [path removeAllPoints];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {1, 0.15, 0, 1, .88, .03, 0, 1};
    CGFloat locations[2] = {1, 0};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width / 2, rect.size.height),
                                                   CGPointMake(rect.size.width / 2, 0), 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

-(void)addLabelWithText:(NSString *)title {
    
    ANLDurationLabel *label = [ANLDurationLabel durationWithFrame:[self bounds]
                                                         textSize:[ANLTaktTimeView sizeFont] text:title];
    [label setTextColor:[UIColor whiteColor]];
    [label setCenter:CGPointMake([self center].x, [self center].y)];
    [self addSubview:label];
}

//- (void)drawRect:(CGRect)rect {
//
//    BOOL vertical = (rect.size.width < rect.size.height);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGFloat yTaktLine = vertical ? 0 : (rect.size.height) / 2;
//    NSDictionary *taktDic = @{NSFontAttributeName : [UIFont chronosFontWithSize:[ANLTaktTimeView sizeFont]],
//                            NSForegroundColorAttributeName : [UIColor whiteColor]};
//    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setMaximumFractionDigits:1];
//    [formatter setRoundingMode:NSNumberFormatterRoundDown];
//    
//    NSString *taktText = [formatter stringFromNumber:[self taktTime]];
//    CGSize textSize = [taktText sizeWithAttributes:taktDic];
//    textSize.height += [ANLTaktTimeView verticalEdges] * 2;
//    textSize.width += textSize.height;
//    CGFloat radius = textSize.height / 2;
//    CGPoint center = CGPointMake(textSize.width - radius, rect.size.height - radius);
//    CGPoint point = CGPointMake(radius, rect.size.height - textSize.height);
//    
//    CGContextSetFillColorWithColor(context, [[UIColor colorWithNormalStateButtonColor:anlButtonColorRed] CGColor]);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, point.x, point.y);
//    CGContextAddLineToPoint(context, center.x, point.y);
//    CGContextAddArcToPoint(context, center.x + textSize.width, center.y, center.x, rect.size.height, radius);
//    point = CGPointMake(rect.origin.x + radius, rect.size.height);
//    CGContextAddLineToPoint(context, point.x, point.y);
//    CGContextAddArcToPoint(context, point.x - textSize.width, center.y,
//                                    radius, rect.size.height - textSize.height, radius);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//    
//    CGFloat y = rect.size.height - textSize.height + [ANLTaktTimeView verticalEdges];
//    [taktText drawAtPoint:CGPointMake(radius, y) withAttributes:taktDic];
//    
//    CGFloat xTaktLine = vertical ? (rect.size.width - 4) / 2 : textSize.width;
//    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
//    
//    NSInteger l1 = vertical ? 4 : 2;
//    NSInteger l2 = vertical ? 16 : 8;
//    const CGFloat lengths[] = {l1, l2};
//    
//    CGContextSetLineDash(context, 0, lengths, 2);
//    CGContextSetLineWidth(context, l1);
//    CGContextMoveToPoint(context, xTaktLine, yTaktLine);
//    if (vertical) {
//        
//        yTaktLine = rect.size.height - textSize.height - 2;
//    } else {
//        
//        xTaktLine = rect.size.width;
//    }
//    
//    CGContextAddLineToPoint(context, xTaktLine, yTaktLine);
//}

@end
