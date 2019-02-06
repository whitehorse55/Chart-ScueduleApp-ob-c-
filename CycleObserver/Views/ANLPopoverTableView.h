//
//  ANLpopoverTableView.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 08/10/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ANLPopoverTableView : UITableView <UITableViewDataSource>

+(CGFloat)heightCells;

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataArray:(NSArray *)data;

@end
