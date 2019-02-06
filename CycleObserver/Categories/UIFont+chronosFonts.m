//
//  UIFont+chronosFonts.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 12/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "UIFont+chronosFonts.h"



@implementation UIFont (chronosFonts)

+(instancetype)spaghettiFontWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:size];
}

+(instancetype)spaghettiFontLightWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

-(UIFont *)adjustSizeToFitText:(NSString *)text inHeight:(CGFloat)height {
    
    UIFont *newFont = nil;
    CGSize size = CGSizeZero;
    CGFloat fontSize = 5;
    do {
        
        fontSize++;
        newFont = [UIFont fontWithName:[self fontName] size:fontSize];
        NSDictionary *dic = @{NSFontAttributeName : newFont};
        size = [text sizeWithAttributes:dic];
    } while (size.height < height);

    return newFont;
}

-(UIFont *)adjustSizeToFitText:(NSString *)text inSize:(CGSize)size {
    
    UIFont *newFont = nil;
    CGSize newSize = CGSizeZero;
    CGFloat fontSize = 5;
    do {
        
        fontSize++;
        newFont = [UIFont fontWithName:[self fontName] size:fontSize];
        NSDictionary *dic = @{NSFontAttributeName : newFont};
        newSize = [text sizeWithAttributes:dic];
    } while (newSize.width < size.width && newSize.height < size.height);
    
    return newFont;
}

@end
