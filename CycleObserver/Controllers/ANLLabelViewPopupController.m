//
//  ANLLabelViewPopupController.m
//  CycleObserver
//
//  Created by John on 1/2/19.
//  Copyright © 2019 Amador Navarro Lucas. All rights reserved.
//

#import "ANLLabelViewPopupController.h"
#import <STPopup/STPopup.h>

@interface ANLLabelViewPopupController ()

@end

@implementation ANLLabelViewPopupController

@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeInPopup = CGSizeMake(300, 400);
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGRect bounds = CGRectMake(0, 0, [UIDevice anlScreenwidth], [UIDevice anlScreenHeight]);
    UIView *background = [[UIView alloc] initWithFrame:bounds];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_LeanGlobalNetwork"]];
    [logo setCenter:[background center]];
    [background addSubview:logo];
    tableView = [[UITableView alloc] initWithFrame:bounds];
    
    [self.view addSubview:[self tableView]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"labelCell"];
    
    [self tableView].delegate = self;
    [self tableView].dataSource = self;
    [[self tableView] reloadData];
    
    [[self tableView] setBackgroundView:background];
    [[self tableView]setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //    CGFloat height = [[[self navigationController] navigationBar] frame].size.height +
    //    [[[self tabBarController] tabBar] frame].size.height;
    //
    //    [[self tableView] setContentSize:CGSizeMake([[self tableView] frame].size.width, height)];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



#pragma mark - dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self dataSource] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"labelCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSString *data = [[self dataSource] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:data];
    return cell;
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[self delegate] didSelectItemAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

