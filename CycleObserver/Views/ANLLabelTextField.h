//
//  ANLLabelTextField.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 07/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM (NSUInteger, anlClasificationType) {
    
    anlClasificationTypeOrganization = 0,
    anlClasificationTypeProcess      = 1,
    anlClasificationTypeOperation    = 2,
    anlClasificationTypeOperator     = 3
};



@class ANLLabelTextField;

@protocol ANLLabelTextFieldDelegate <NSObject>

-(void)editLabelTextField:(ANLLabelTextField *)label;

@end



@interface ANLLabelTextField : UILabel

@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) id<ANLLabelTextFieldDelegate, UITextFieldDelegate> delegate;
@property (nonatomic) anlClasificationType type;

-(void)dismissTextField;

@end
