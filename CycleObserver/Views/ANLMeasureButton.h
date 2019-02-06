//
//  ANLMeasureButton.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ANLButton;

@interface ANLMeasureButton : UIButton

//@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) ANLButton *data;
@property (nonatomic) ANLButtonColor colorAtribute;



+(CGSize)buttonSize;
+(instancetype)buttomWithFrame:(CGRect)frame Color:(ANLButtonColor)buttonColor andText:(NSString *)title;
+(instancetype)buttomWithFrame:(CGRect)frame;

-(void)setData:(ANLButton *)data;
-(void)setTitle:(NSString *)title;

@end
