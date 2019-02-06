//
//  Language.m
//  TownCenterProject
//
//  Created by ASAL on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Language.h"



@implementation Language

static NSBundle *bundle = nil;

+(void)initialize {
    //  Seleccionamos de todos lenguajes disponibles si hay alguno preferido por el usuario, si no, inglés.
    NSBundle *mainBundle = [NSBundle mainBundle];
    __block NSString *current = @"en";
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([mainBundle pathForResource:obj ofType:@"lproj"]) {
            
            current = obj;
            *stop = YES;
        }
    }];
    
    [self setLanguage:current];
}

+(void)setLanguage:(NSString *)language {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
}

+(NSString *)get:(NSString *)key alter:(NSString *)alternate {

    return [bundle localizedStringForKey:key value:alternate table:nil];
}

+(NSString *)stringForKey:(NSString *)key {
    
    return [Language get:key alter:nil];
}

@end
