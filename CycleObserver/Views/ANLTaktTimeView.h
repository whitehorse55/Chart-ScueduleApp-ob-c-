//
//  ANLTacktTimeView.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 13/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLTaktTimeView : UIView

+(CGFloat)sizeFont;
+(CGSize)sizeForText:(NSString *)text;
//+(CGFloat)verticalEdges;
+(instancetype)taktViewWithFrame:(CGRect)frame taktTime:(NSString *)taktTime;

@end
