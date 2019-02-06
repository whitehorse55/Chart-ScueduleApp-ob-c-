//
//  ANLHomeViewController.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <STPopup/STPopup.h>

@class AGTCoreDataStack, ANLMeasureLabelView;

@interface ANLHomeViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource,
UITableViewDelegate, UITextFieldDelegate> 

@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;



@property (weak, nonatomic) IBOutlet UITextField *SearchBar;
@property (weak, nonatomic) IBOutlet UITableView *measuresTableView;
@property (weak, nonatomic) IBOutlet UITableView *operationTableView;
@property (weak, nonatomic) IBOutlet ANLMeasureLabelView *measureView;

@end
