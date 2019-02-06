//
//  ANLAccesoryButton.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 01/05/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLAccesoryButton : UIButton

@property (nonatomic) ANLButtonColor colorAttribute;

+(instancetype)accesoryButtonWithFrame:(CGRect)frame color:(ANLButtonColor)color;

@end
