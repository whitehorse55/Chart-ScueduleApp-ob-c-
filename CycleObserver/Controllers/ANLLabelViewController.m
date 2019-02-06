//
//  ANLLabelViewController.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/message.h>

#import "ANLLabelViewController.h"
#import "ANLPopoverTableView.h"
#import "ANLModel.h"
#import "AGTCoreDataStack.h"
#import "ANLTabBar.h"
#import <STPopup/STPopup.h>
#import "ANLLabelViewPopupController.h"


@interface ANLLabelViewController ()

@property (strong, nonatomic) PopoverView *popover;
@property (strong, nonatomic) UIView *resingView;
@property (strong, nonatomic) ANLLabelTextField *activeField;
@property (strong, nonatomic) NSArray *popoverFetchResults;
@property (strong, nonatomic) ANLCurrentMeasure *currentMeasure;

@property (nonatomic) CGPoint mainCenter;
@property (nonatomic, getter = isDisplacedView) BOOL displacedView;

@end



@implementation ANLLabelViewController

#pragma mark - lifecycle

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [(ANLTabBar *)[[self tabBarController] tabBar] showTabBarAnimated:NO];
    [self setCurrentMeasure:[ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]]];
    ANLMeasure *measure = [[self currentMeasure] measure];
    [measure addObserver:self forKeyPath:@"place"
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillAppear:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillDisappear:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    [self setDisplacedView:NO];
    [self fillLabelTextFields];
    
    [[self locateLabel] setText:[Language stringForKey:@"measureView.locationLabel.Title"]];
    [[self organizationLabel] setText:[Language stringForKey:@"measureView.organizationLabel.Title"]];
    [[self processLabel] setText:[Language stringForKey:@"measureView.processLabel.Title"]];
    [[self operationLabel] setText:[Language stringForKey:@"measureView.operationLabel.Title"]];
    [[self operatorLabel] setText:[Language stringForKey:@"measureView.operatorLabel.Title"]];
    [[self notesLabel] setText:[Language stringForKey:@"measureView.notesLabel.Title"]];
    
    
    
    [[self organizationLabel] setUserInteractionEnabled:YES];
    [[self processLabel] setUserInteractionEnabled:YES];
    [[self operationLabel] setUserInteractionEnabled:YES];
    [[self operatorLabel] setUserInteractionEnabled:YES];
    
    [[self organizationLabel] addGestureRecognizer:[self setRecognizer]];
    [[self processLabel] addGestureRecognizer:[self setRecognizer]];
    [[self operationLabel] addGestureRecognizer:[self setRecognizer]];
    [[self operatorLabel] addGestureRecognizer:[self setRecognizer]];
}

-(UITapGestureRecognizer*)setRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    return tapGestureRecognizer;
}

- (void)handleTapGesture:(UITapGestureRecognizer *) gesture {
    
    UILabel *label = (UILabel *)gesture.view;
    
    NSArray *popoverText;
    if (label == [self organizationLabel]) {
        popoverText = [self arrayWithNamesInLabel:[self organizationField]];
    } else if (label == [self processLabel]) {
        popoverText = [self arrayWithNamesInLabel:[self processField]];
    } else if (label == [self operationLabel]) {
        popoverText = [self arrayWithNamesInLabel:[self operationField]];
    } else if (label == [self operatorLabel]) {
        popoverText = [self arrayWithNamesInLabel:[self operatorField]];
    }
    
    if ([popoverText count] > 0) {
        ANLLabelViewPopupController *destination = [[ANLLabelViewPopupController alloc] init];
        
        [destination setDataSource:popoverText];
        [destination setDelegate:self];
        
        STPopupController *sTPopupController = [[STPopupController alloc] initWithRootViewController:destination];
        [sTPopupController presentInViewController:self];
    }
}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self setMainCenter:[[self view] center]];
}

-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[self currentMeasure] measure] removeObserver:self forKeyPath:@"place"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

    NSError *error = nil;
    [[self moc] save:&error];
    if (error) {
        
        NSLog(@"Error saving model in %s with error:%@", __PRETTY_FUNCTION__, error);
    }
}



#pragma mark - Notifications

-(void)keyboardWillAppear:(NSNotification *)notification {

    if ([[self locationField] isFirstResponder] || [self isDisplacedView]) {
        
        return;
    }
    
    CGFloat heightDif = 0;
    CGPoint viewCenter = [[self view] center];
    
    [self setDisplacedView:([[self textView] isFirstResponder] || [[self taktTime] isFirstResponder])];
    
    if ([[self textView] isFirstResponder]) {
        
        [self setResingView:[[UIView alloc] initWithFrame:[[self view] bounds]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(resingTextView)];
        [[self resingView] addGestureRecognizer:tap];
        [[self view] addSubview:[self resingView]];
    }
    
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect kbFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    heightDif = kbFrame.size.height - 20;

    if ([self activeField]) {

        heightDif = [[self activeField] frame].origin.y - 20;
    }
    
    viewCenter.y -= heightDif;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] setCenter:viewCenter];
    } completion:NULL];
}

-(void)keyboardWillDisappear:(NSNotification *)notification {

    [self setDisplacedView:NO];
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewKeyframeAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] setCenter:[self mainCenter]];
    } completion:NULL];
}

-(void)resingTextView {
    
    [[self resingView] removeFromSuperview];
    [self setResingView:nil];
    
    [[[self currentMeasure] measure] setNotes:[[self textView] text]];
    [[self textView] endEditing:YES];
}


#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                       change:(NSDictionary *)change context:(void *)context {

    [[self locationField] setText:[[[self currentMeasure] measure] place]];
}



#pragma mark - actions

- (IBAction)showPopover:(UIButton *)sender {

    CGFloat height = [sender height] / 2;
    CGPoint point = [[sender titleLabel] convertPoint:[[sender titleLabel] center] toView:[self view]];
    point.y += (point.y > [[self view] height] / 2) ? -height : height;
    
    [self setPopover:[PopoverView showPopoverAtPoint:point
                                              inView:[self view]
                                     withStringArray:[ANLMeasure timeScaleDescriptors]
                                               above:(point.y > [UIDevice anlScreenHeight] / 2)
                                            delegate:self]];
}

- (IBAction)photo:(id)sender {

    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {

        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
        [camera setMediaTypes:@[(NSString *) kUTTypeImage]];
        [camera setAllowsEditing:NO];
        [camera setDelegate:self];

        [self presentViewController:camera animated:YES completion:NULL];
    }
}



#pragma mark - PopoverViewDelegate

-(void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
    [[self timeScale] setTitle:[[ANLMeasure timeScaleDescriptors] objectAtIndex:index] forState:UIControlStateNormal];
    [[[self currentMeasure] measure] setTimeScale:@(index)];

    [popoverView dismiss];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    [self makeChangesForResult:[[self popoverFetchResults] objectAtIndex:index]];
    [[self activeField] dismissTextField];
    [self setActiveField:nil];
}


#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    id editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    id imageToSave = editedImage ? editedImage : [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *data = UIImageJPEGRepresentation(imageToSave, 1.0f);
    ANLPhoto *photo = [ANLPhoto photoWithData:data inManagedObjectContext:[self moc]];
    [[[self currentMeasure] measure] addPhotosObject:photo];
    
    NSError *error = nil;
    [[self moc] save:&error];
    if (error) {
        
        NSLog(@"Error saving model in %s with error:%@", __PRETTY_FUNCTION__, error);
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                                                      replacementString:(NSString *)string {
    if ([self popover]) {
        
        [[self popover] dismiss];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ([self popover]) {
        
        [[self popover] dismiss];
    }
    if ([self activeField]) {
        
        [[self activeField] dismissTextField];
        [self setActiveField:nil];
    } else {
        
        [textField resignFirstResponder];
    }
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {

    ANLMeasure *measure = [[self currentMeasure] measure];
    NSString *text = [textField text];

    switch ([textField tag]) {
            
        case 0:
            
            [[[[[measure operator] operation] process] organization] setName:text];
            [[self organizationField] setText:text];
            break;
            
        case 1:
            
            [[[[measure operator] operation] process] setName:text];
            [[self processField] setText:text];
            break;
            
        case 2:
            
            [[[measure operator] operation] setName:text];
            [[self operationField] setText:text];
            break;
            
        case 3:
            
            [[measure operator] setName:text];
            [[self operatorField] setText:text];
            break;
            
        case 4:
            
            [measure setTaktTime:@([text floatValue])];
            break;
            
        case 5:
            
            [measure setPlace:text];
            break;
            
        default:
            
            NSLog(@"Error in textFieldTag:%li", (long)[textField tag]);
            break;
    }
}



#pragma mark - ANLLabelTextFieldDelegate

-(void)editLabelTextField:(ANLLabelTextField *)label {

    if ([self activeField]) {
        
        CGFloat dif = [[self activeField] frame].origin.y - [label frame].origin.y;
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [[self view] setCenter:CGPointMake([[self view] center].x, [[self view] center].y + dif)];
        } completion:NULL];
    }
    [self setActiveField:label];
    [[label textField] becomeFirstResponder];
    
    /*
    NSArray *popoverText = [self arrayWithNamesInLabel:label];
    if ([popoverText count] > 0) {
        
        ANLLabelViewPopupController *destination = [[ANLLabelViewPopupController alloc] init];
        
        [destination setDataSource:popoverText];
        
        STPopupController *sTPopupController = [[STPopupController alloc] initWithRootViewController:destination];
        [sTPopupController presentInViewController:self];
        
     
        CGRect tableViewFrame = CGRectMake(0, 0, [label frame].size.width, MIN(200.0f, [popoverText count] * 30.0f));
        ANLPopoverTableView *tableView = [[ANLPopoverTableView alloc] initWithFrame:tableViewFrame
                                                                              style:UITableViewStylePlain
                                                                          dataArray:popoverText];
        [tableView setDelegate:self];
        CGPoint point = [label center];
        point.x -= [label width] / 4;
        point.y += [[self topLayoutGuide] length] + [label height] / 2;
        
        [self setPopover:[PopoverView showPopoverAtPoint:point
                                                  inView:[self view]
                                         withContentView:tableView
                                                   above:NO
                                                delegate:self]];
     
    }
*/
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self makeChangesForResult:[[self popoverFetchResults] objectAtIndex:[indexPath row]]];
    [[self activeField] dismissTextField];
    [self setActiveField:nil];
    [[self popover] dismiss];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ANLPopoverTableView heightCells];
}



#pragma mark - custom methods

-(void)fillLabelTextFields {
    
    ANLMeasure *measure = [[self currentMeasure] measure];

    [[self locationField] setText:[self stringForTitleWithContent:[measure place]]];
    [[self taktTime] setText:[[measure taktTime] stringValue]];
    [[self timeScale] setTitle:[[ANLMeasure timeScaleDescriptors] objectAtIndex:(NSInteger)[measure timeScaleValue]]
                      forState:UIControlStateNormal];
    
    [[self textView] setText:[measure notes]];
    
    ANLOperator *operator = [measure operator];
    [[self operatorField] setText:[self stringForTitleWithContent:[operator name]]];
    [[self operatorField] setDelegate:self];
    
    ANLOperation *operation = [operator operation];
    [[self operationField] setText:[self stringForTitleWithContent:[operation name]]];
    [[self operationField] setDelegate:self];
    
    ANLProcess *process = [operation process];
    [[self processField] setText:[self stringForTitleWithContent:[process name]]];
    [[self processField] setDelegate:self];
    
    [[self organizationField] setText:[self stringForTitleWithContent:[[process organization] name]]];
    [[self organizationField] setDelegate:self];
}

-(NSString *)stringForTitleWithContent:(NSString *)text {
    
    return [text isEqualToString:@""] ? [ANLMeasure unknown] : text;
}

-(void)updateNames {
    
    ANLOperator *operator = [[[self currentMeasure] measure] operator];
    [[self operatorField] setText:[operator name]];
    [[self operationField] setText:[[operator operation] name]];
    
    ANLProcess *process = [[operator operation] process];
    [[self processField] setText:[process name]];
    [[self organizationField] setText:[[process organization] name]];
}

-(NSArray *)arrayWithNamesInLabel:(ANLLabelTextField *)label {
    
    NSArray *entities = @[[ANLOrganization entityName], [ANLProcess entityName],
                          [ANLOperation entityName], [ANLOperator entityName]];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:[entities objectAtIndex:[label type]]];
    [fetch setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"%K != %@", @"name", @""]];
    
    NSError *error = nil;
    [self setPopoverFetchResults:[[self moc] executeFetchRequest:fetch error:&error]];
    
    if (error) {
        
        NSLog(@"error in execute fetch:%@ - error:%@", fetch, error);
    }
    
    __block NSMutableArray *namesArray = [[NSMutableArray alloc] init];
    [[self popoverFetchResults] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [namesArray addObject:[obj name]];

    }];
    return [NSArray arrayWithArray:namesArray];
}

-(void)makeChangesForResult:(id)result {

    [[[self activeField] textField] setText:[result name]];
    ANLMeasure *measure = [[self currentMeasure] measure];
    if ([result class] == [ANLOperator class]) {
        
        [measure setOperator:result];
    } else if ([result class] == [ANLOperation class]) {
        
        [[measure operator] setOperation:result];
    } else if ([result class] == [ANLProcess class]) {
        
        [[[measure operator] operation] setProcess:result];
    } else if ([result class] == [ANLOrganization class]) {
        
        [[[[measure operator] operation] process] setOrganization:result];
    } else {
        
        NSLog(@"result es de una clase erronea:%@", [result class]);
    }

    NSError *error = nil;
    
    [[self moc] save:&error];
    
    if (error) {
        
        NSLog(@"Error saving context in:%s - error:%@", __PRETTY_FUNCTION__, error);
    }
    [self updateNames];
}

@end
