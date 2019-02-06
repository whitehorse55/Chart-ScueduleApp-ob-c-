//
//  ANLHomePopupController.h
//  CycleObserver
//
//  Created by John on 1/2/19.
//  Copyright © 2019 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANLOrganizationTableView;
NS_ASSUME_NONNULL_BEGIN

@interface ANLHomePopupController : UIViewController<UITableViewDelegate, UITableViewDataSource,
UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) ANLOrganizationTableView *orgTableView;
@property (strong, nonatomic) UITableView *tableView;


@end

NS_ASSUME_NONNULL_END
