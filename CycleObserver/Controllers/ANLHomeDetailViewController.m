//
//  ANLHomeDetailViewController.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLHomeDetailViewController.h"
#import "ANLModel.h"
#import <objc/message.h>



@interface ANLHomeDetailViewController ()

@property (strong, nonatomic) NSIndexPath *indexPathToDelete;

@end



@implementation ANLHomeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    
    [[self tableView] setBackgroundView:background];
    [[self tableView]setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    CGFloat height = [[[self navigationController] navigationBar] frame].size.height +
                     [[[self tabBarController] tabBar] frame].size.height;
    
    [[self tableView] setContentSize:CGSizeMake([[self tableView] frame].size.width, height)];
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
    
    NSString *identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    id data = [[self dataSource] objectAtIndex:[indexPath row]];
    BOOL defaultName = ![data respondsToSelector:@selector(name)];
    NSString *text = defaultName ? [ANLOrganizationTableView defaultNameForClass:NSClassFromString(data)] : [data name];
    
    [[cell textLabel] setText:text];
    return cell;
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setUpOrganizationTableViewAtRow:[indexPath row]];
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                           forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self tryToDeleteRowAtIndexPath:indexPath inTableView:tableView];
    }
}



#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [[self tableView] setEditing:NO animated:YES];
    } else {
        
        [self deleteRowAtIndexPath:[self indexPathToDelete] inTableView:[self tableView]];
    }
    [self setIndexPathToDelete:nil];
}



#pragma mark - custom methods

-(void)tryToDeleteRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {

    id selected = [[self dataSource] objectAtIndex:[indexPath row]];
    NSString *cancel = [Language stringForKey:@"CANCEL"];
    NSString *delete = [Language stringForKey:@"DELETE"];
    NSString *title = [Language stringForKey:@"WATCH OUT!"];
    NSString *alertMsg = [Language stringForKey:@"If you delete this row you will delete too: "];
    
    alertMsg = [alertMsg stringByAppendingString:[selected alertMessage]];
    
    if ([UIAlertController class]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:alertMsg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:cancel
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    [tableView setEditing:NO animated:YES];
                                                    [self dismissViewControllerAnimated:YES completion:NULL];
                                                }]];
                                                    
        [alert addAction:[UIAlertAction actionWithTitle:delete
                                                  style:UIAlertActionStyleDestructive
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    [self deleteRowAtIndexPath:indexPath inTableView:tableView];
                                                    [self dismissViewControllerAnimated:YES completion:NULL];
                                                }]];
        
        [self presentViewController:alert animated:YES completion:NULL];
    } else {
        
        [self setIndexPathToDelete:indexPath];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:alertMsg
                                                       delegate:self
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:delete, nil];
        [alert show];
    }
}

-(void)deleteRowAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    
    id entity = [[self dataSource] objectAtIndex:[indexPath row]];
    [[self moc] deleteObject:entity];
    
    NSError *error = nil;
    if (![[self moc] save:&error]) {
        
        NSLog(@"Error saving context after delete:%@ error:%@ - %@", entity, [error localizedDescription],
              [error userInfo]);
    }
    
    NSMutableArray *data = [NSMutableArray arrayWithArray:[self dataSource]];
    [data removeObjectAtIndex:[indexPath row]];
    [self setDataSource:[NSArray arrayWithArray:data]];
    
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

-(void)setUpOrganizationTableViewAtRow:(NSInteger)row {
    
    BOOL firstLine = row == 0;
    if (!firstLine && [[[self dataSource] objectAtIndex:row] organizationTableView]) {
        
        return;
    }
    Class class = NSClassFromString([[self dataSource] objectAtIndex:0]);
    id entity = firstLine ? nil : [[self dataSource] objectAtIndex:row];
    BOOL find = NO;

    if (class == [ANLOperator class]) {
        
        ANLOperator *operator = entity;
        [[self orgTableView] setOperator:operator];
        entity = [operator operation];
        class = entity ? [entity class] : class;
        find = YES;
    } else {
        
        [[self orgTableView] setOperator:nil];
    }
    
    if (class == [ANLOperation class]) {
        
        ANLOperation *operation = entity;
        [[self orgTableView] setOperation:operation];
        entity = [operation process];
        class = entity ? [entity class] : class;
        find = YES;
    } else if (!find) {
        
        [[self orgTableView] setOperation:nil];
    }
    
    if (class == [ANLProcess class]) {
        
        ANLProcess *process = entity;
        [[self orgTableView] setProcess:process];
        entity = [process organization];
        class = entity ? [entity class] : class;
    } else if (!find) {
        
        [[self orgTableView] setProcess:nil];
    }

    if (class == [ANLOrganization class]) {
        
        ANLOrganization *organization = entity;
        [[self orgTableView] setOrganization:organization];
    }
}

@end
