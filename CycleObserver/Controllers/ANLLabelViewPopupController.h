//
//  ANLLabelViewPopupController.h
//  CycleObserver
//
//  Created by John on 1/2/19.
//  Copyright © 2019 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PopupViewDelegate <NSObject>

@optional

//Delegate receives this call as soon as the item has been selected
- (void)didSelectItemAtIndex:(NSInteger)index;


@end

@interface ANLLabelViewPopupController : UIViewController<UITableViewDelegate, UITableViewDataSource,
UIAlertViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, assign) id<PopupViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
