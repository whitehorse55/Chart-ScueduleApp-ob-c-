//
//  ANLCycleButtonView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 25/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ANLCycleButtonViewDelegate;

@interface ANLCycleButtonView : UIView

@property (weak, nonatomic) IBOutlet id<ANLCycleButtonViewDelegate> delegate;
@property (nonatomic, getter = isSelect) BOOL select;

@end



@protocol ANLCycleButtonViewDelegate <NSObject>

-(void)selectCycleButton:(ANLCycleButtonView *)button;

@end
