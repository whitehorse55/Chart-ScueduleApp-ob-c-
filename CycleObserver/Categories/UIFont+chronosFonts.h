//
//  UIFont+chronosFonts.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 12/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIFont (chronosFonts)

+(instancetype)spaghettiFontWithSize:(CGFloat)size;
+(instancetype)spaghettiFontLightWithSize:(CGFloat)size;

-(UIFont *)adjustSizeToFitText:(NSString *)text inHeight:(CGFloat)height;
-(UIFont *)adjustSizeToFitText:(NSString *)text inSize:(CGSize)size;

@end
