//
//  ANLHomeDetailViewController.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ANLOrganizationTableView;

@interface ANLHomeDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,
                                                          UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) ANLOrganizationTableView *orgTableView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
