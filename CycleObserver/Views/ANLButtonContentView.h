//
//  ANLbuttonContentView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 23/04/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ANLMeasureButton, ANLButton;

@protocol ANLButtonDelegate <NSObject>
/*! Pass the button pressed to the delegate
 \param button  The button pressed
 */
-(void)buttonPressed:(ANLMeasureButton *)button;
/*! The button has change the name, the delegate receive the button and the new name.
 \param button  The button
 \param name    The new name
 */
-(void)button:(ANLMeasureButton *)button didChangeName:(NSString *)name;
/*! The button has change the color, the delegate receive the button and the new color.
 \param button  The button
 \param color   The new color.
 */
-(void)button:(ANLMeasureButton *)button didChangeColor:(ANLButtonColor)color;

@end



@interface ANLButtonContentView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) id<ANLButtonDelegate> delegate;

-(void)poblateWithButtons:(NSArray *)buttons;
-(void)animateCenterToPoint:(CGPoint)newCenter;
-(void)selectButton:(ANLButton *)button;

@end
