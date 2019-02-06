//
//  ANLLabelViewController.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import "ANLLabelTextField.h"
#import "ANLLabelViewPopupController.h"



@class ANLCurrentMeasure, AGTCoreDataStack;

@interface ANLLabelViewController : UIViewController<PopoverViewDelegate, UITextViewDelegate, UITextFieldDelegate,
                                                     UIImagePickerControllerDelegate, UINavigationControllerDelegate,
                                                     ANLLabelTextFieldDelegate, UITableViewDelegate, PopupViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *locateLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *processLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet ANLLabelTextField *organizationField;
@property (weak, nonatomic) IBOutlet ANLLabelTextField *processField;
@property (weak, nonatomic) IBOutlet ANLLabelTextField *operationField;
@property (weak, nonatomic) IBOutlet ANLLabelTextField *operatorField;
@property (weak, nonatomic) IBOutlet UIButton *timeScale;
@property (weak, nonatomic) IBOutlet UITextField *taktTime;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSManagedObjectContext *moc;

- (IBAction)showPopover:(UIButton *)sender;
- (IBAction)photo:(id)sender;

@end
