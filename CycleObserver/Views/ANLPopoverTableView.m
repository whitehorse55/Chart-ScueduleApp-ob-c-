//
//  ANLpopoverTableView.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 08/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLPopoverTableView.h"



@interface ANLPopoverTableView ()

@property (strong, nonatomic) NSArray *data;

@end



@implementation ANLPopoverTableView

#pragma mark - constants

+(CGFloat)heightCells {
    
    return 30.0f;
}

+(NSString *)cellIdentifier {
    
    return @"popoverCell";
}



#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataArray:(NSArray *)data {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self setData:data];
        [self setDataSource:self];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:[ANLPopoverTableView cellIdentifier]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return self;
}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self data] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ANLPopoverTableView cellIdentifier]];
    
    cell = [self configureCell:cell atRow:[indexPath row]];
    return cell;
}

-(UITableViewCell *)configureCell:(UITableViewCell *)cell atRow:(NSInteger)row {

    [[cell textLabel] setText:[[self data] objectAtIndex:row]];
    [[cell textLabel] setFont:[UIFont spaghettiFontLightWithSize:18]];
    
    return cell;
}

@end
