//
//  ANLSummaryViewController.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "ANLCardView.h"



@class ANLMeasure;

@interface ANLSummaryViewController : UIViewController<MFMailComposeViewControllerDelegate, ANLCardViewDelegate>

@property (strong, nonatomic) ANLMeasure *measure;
@property (strong, nonatomic) NSManagedObjectContext *moc;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
