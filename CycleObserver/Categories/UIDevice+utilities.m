//
//  UIDevice+utilities.m
//  Spaguetti
//
//  Created by Amador Navarro Lucas on 22/11/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "UIDevice+utilities.h"



@implementation UIDevice (utilities)

+(CGFloat)anlIOSVersion {
    
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(CGFloat)anlScreenHeight {
    
    return [[UIScreen mainScreen] bounds].size.height;
}

+(CGFloat)anlScreenwidth {

    return [[UIScreen mainScreen] bounds].size.width;
}

@end
