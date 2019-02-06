//
//  ANLCardView.h
//  CycleObserver
//
//  Created by Amador Navarro Lucas on 27/03/15.
//  Copyright (c) 2015 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, anlCardType) {
    
    anlCardTypeAllCycles = 0,
    anlCardTypeSteps,
    anlCardTypeVa_nva
};

typedef NS_ENUM(NSUInteger, anlCardState) {
    
    anlCardStateRest = 0,
    anlCardStateShowed,
    anlCardStateDown
};



@protocol ANLCardViewDelegate;

@interface ANLCardView : UIView

@property (weak, nonatomic) id<ANLCardViewDelegate> delegate;

@property (nonatomic) anlCardState cardState;
@property (nonatomic, readonly) anlCardType cardType;
@property (nonatomic, readonly) CGFloat restStateYOrigin;
@property (nonatomic, readonly) CGFloat showedStateYOrigin;
@property (nonatomic, readonly) CGFloat downStateYOrigin;

+(CGFloat)headHeight;
+(CGFloat)gap;
+(instancetype)cardWithOriginY:(CGFloat)y type:(anlCardType)type;

-(id)initWithOriginY:(CGFloat)y type:(anlCardType)type;
-(void)setYOriginForStateRest:(CGFloat)restOrigin showed:(CGFloat)showedOrigin down:(CGFloat)downOrigin;
-(UIImage *)takeSnapshot;

@end



@protocol ANLCardViewDelegate <NSObject>

-(void)tappedCardView:(ANLCardView *)cardView;

@end
