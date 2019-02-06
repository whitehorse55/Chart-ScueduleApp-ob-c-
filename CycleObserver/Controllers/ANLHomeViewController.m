//
//  ANLHomeViewController.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 31/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLHomeViewController.h"
#import "ANLHomeDetailViewController.h"
#import "ANLLabelViewController.h"
#import "ANLSummaryViewController.h"
#import "AGTCoreDataStack.h"
#import "ANLMeasureLabelView.h"
#import "ANLModel.h"
#import "ANLTabBar.h"
#import <objc/message.h>
#import "ANLHomePopupController.h"



@interface ANLHomeViewController ()

@property (strong, nonatomic) ANLOrganizationTableView *organizationTableViewData;
@property (strong, nonatomic) UIView *emptyDataView;
@property (strong, nonatomic) UILabel *foundLabel;

@property (weak, nonatomic) IBOutlet ANLMeasureLabelView *addMeasureView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addMeasureButtonVerticalConstraint;
@property (weak, nonatomic) IBOutlet UILabel *lastMeasureLabel;

@property (nonatomic) CGFloat YLayoutConstant;
@property (nonatomic) BOOL emptyData;

@end



@implementation ANLHomeViewController

#pragma mark - constants

+(NSInteger)organizationTableViewRows {
    
    return 4;
}



#pragma mark - lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    ANLMeasureLabelView *background = [[ANLMeasureLabelView alloc] initWithFrame:[[self operationTableView] frame]];
    [[self operationTableView] setBackgroundView:background];
    
    [self SearchBar].placeholder = @"Search";
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [(ANLTabBar *)[[self tabBarController] tabBar] hideTabBarAnimated:NO];
    [self hideTableViewsWhenDoNotHaveData];
    
    [[self addButton] setTitle:[Language stringForKey:@"home.newMeasure.title"] forState:UIControlStateNormal];
    [[self lastMeasureLabel] setText:[Language stringForKey:@"home.measureLabel.title"]];
    
    [self organizationTableViewData];
    [[self operationTableView] reloadData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillAppear:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillDisappear:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self setFetchedResultsControllerWithPredicate:[self predicatesForText:@""]];
    
    if ([self emptyData]) {
        
        CGRect frame = [[self operationTableView] frame];
        frame.size.height += [[self measuresTableView] height];
        
        UIView *background = [[UIView alloc] initWithFrame:frame];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_LeanGlobalNetwork"]];
        [logo setCenter:CGPointMake([background centerX], [background centerY] - [background y])];
        [background addSubview:logo];
        [[self view] addSubview:background];
        [self setEmptyDataView:background];
    }
}

-(void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    [[self emptyDataView] removeFromSuperview];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    NSError *error = nil;
    [[self moc] save:&error];
    if (error) {
        
        NSLog(@"Error saving model in %s with error:%@", __PRETTY_FUNCTION__, error);
    }
}



#pragma mark - setters and getters

-(NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[ANLMeasure entityName]];
    
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
    [request setFetchBatchSize:20];
    
    NSString *cacheName = [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"] ? nil
                                                                                                 : @"HomeViewCache";
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                              managedObjectContext:[self moc]
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:cacheName];
    [fetched setDelegate:self];
    [self setFetchedResultsController:fetched];
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        
        NSLog(@"Error performFetch:%@", error);
    }
    return _fetchedResultsController;
}

-(ANLOrganizationTableView *)organizationTableViewData {
    
    if (_organizationTableViewData != nil) {
        
        return _organizationTableViewData;
    }
    
    ANLOrganizationTableView *otv = nil;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:[ANLOrganizationTableView entityName]];
    NSError *error = nil;
    NSArray *results = [[self moc] executeFetchRequest:fetch error:&error];
    
    if (!results) {
        
        NSLog(@"error buscando organizationTableView:%@ - %@", [error localizedDescription], [error userInfo]);
    }
    
    if ([results count] == 0) {
        
        otv = [ANLOrganizationTableView organizationTableViewInManagedObjectContext:[self moc]];
    } else {
        otv = [results firstObject];
    }
    [self setOrganizationTableViewData:otv];
    return otv;
}

-(void)setFetchedResultsControllerWithPredicate:(NSPredicate *)predicate {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[ANLMeasure entityName]];
    
    [request setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
    [request setPredicate:predicate];
    [request setFetchBatchSize:20];
    
    NSString *cacheName = [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"] ? nil
                                                                                                 : @"PerfectNameCache";
    [NSFetchedResultsController deleteCacheWithName:cacheName];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                              managedObjectContext:[self moc]
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:cacheName];
    [fetched setDelegate:self];
    [self setFetchedResultsController:fetched];
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        
        NSLog(@"Error performFetch:%@", error);
    }
    [[self measuresTableView] reloadData];
}



#pragma mark - dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = [ANLHomeViewController organizationTableViewRows];
    if ([[tableView restorationIdentifier] isEqualToString:@"measuresTableView"]) {
        
        id<NSFetchedResultsSectionInfo> info = [[[self fetchedResultsController] sections] objectAtIndex:section];
        rows = [info numberOfObjects];
            
        [self matchFounds:(rows > 0)];
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL isEqual = [[tableView restorationIdentifier] isEqualToString:@"organizationTableView"];
    NSString *identifier = isEqual ? @"OrganizationCell" : @"MeasureCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (isEqual) {
        
        cell = [self configureOrganizationCell:cell atIndexPath:indexPath];
    } else {
        
        cell = [self configureMeasureCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

-(UITableViewCell *)configureOrganizationCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    NSArray *icons = @[@"OrganizationIcon", @"ProcessIcon", @"OperationIcon", @"PersonIcon"];
    UIImage *icon = [UIImage imageNamed:[icons objectAtIndex:[indexPath row]]];
    [[cell imageView] setImage:icon];
    
    NSString *text = [[self organizationTableViewData] titleForRow:[indexPath row]];
    text = [text isEqualToString:@""] ? [ANLMeasure unknown] : text;
    text = [[Language stringForKey:@"archive.operationTableView.Filter"] stringByAppendingString:text];
    [[cell textLabel] setText:text];
    [[cell textLabel] setFont:[UIFont spaghettiFontWithSize:14]];
    
    return cell;
}

-(UITableViewCell *)configureMeasureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    ANLMeasure *measure = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    NSDictionary *dic = [self compactTitleOfMeasure:measure];
    
    [[cell textLabel] setText:[dic objectForKey:@"title"]];
    [[cell textLabel] setFont:[UIFont spaghettiFontLightWithSize:10]];
    [[cell textLabel] setTextColor:[UIColor colorForBlueText]];
    
    [[cell detailTextLabel] setText:[dic objectForKey:@"subtitle"]];
    [[cell detailTextLabel] setFont:[UIFont spaghettiFontWithSize:12]];
    [[cell detailTextLabel] setTextColor:[UIColor colorForBlueText]];

    return cell;
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[tableView restorationIdentifier] isEqualToString:@"measuresTableView"]) {
        
        ANLCurrentMeasure *current = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];
        [current setMeasure:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
//        NSLog(@"measure:%@", [current measure]);
        [[self tabBarController] setSelectedIndex:3];
    } else {
        ANLHomePopupController *destination = [[ANLHomePopupController alloc] init];
        [destination setMoc:[self moc]];
        [destination setOrgTableView:[self organizationTableViewData]];
        [destination setDataSource:[self dataSourceForIndex:[indexPath row]]];
        
        STPopupController *sTPopupController = [[STPopupController alloc] initWithRootViewController:destination];
        [sTPopupController presentInViewController:self];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleDelete;
    if ([[tableView restorationIdentifier] isEqualToString:@"organizationTableView"]) {
        
        style = UITableViewCellEditingStyleNone;
    }
    return style;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                           forRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([[tableView restorationIdentifier] isEqualToString:@"measuresTableView"] &&
        editingStyle == UITableViewCellEditingStyleDelete) {
            
        [[self moc] deleteObject:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    }
}



#pragma mark - UIFetchedResultsControllerDelegate

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {

    [[self measuresTableView] beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {

    if (type == NSFetchedResultsChangeDelete) {

        [[self measuresTableView] deleteRowsAtIndexPaths:@[indexPath]
                                         withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeInsert) {
        
        [[self measuresTableView] insertRowsAtIndexPaths:@[newIndexPath]
                                        withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

    [[self measuresTableView] endUpdates];
}



#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    [self setFetchedResultsControllerWithPredicate:[self predicatesForText:@""]];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                                                      replacementString:(NSString *)string {

    NSString *finalText = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    if (range.length == 1 || [[[self fetchedResultsController] fetchedObjects] count] > 0) {

        NSPredicate *predicate = [self predicatesForText:finalText];
        
        [self setFetchedResultsControllerWithPredicate:predicate];
    }
    return YES;
}



#pragma mark - notifications

-(void)keyboardWillAppear:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self setYLayoutConstant:[[self addMeasureButtonVerticalConstraint] constant]];

    [[self view] layoutIfNeeded];
    CGFloat constant = -([[self measuresTableView] y] - [[self addMeasureView] y]);
    [[self addMeasureButtonVerticalConstraint] setConstant:constant];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] layoutIfNeeded];
    } completion:NULL];
}

-(void)keyboardWillDisappear:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [[self view] layoutIfNeeded];
    [[self addMeasureButtonVerticalConstraint] setConstant:[self YLayoutConstant]];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [[self view] layoutIfNeeded];
    } completion:NULL];
}



#pragma mark - actions

- (IBAction)addNewMeasure:(id)sender {

    ANLCurrentMeasure *current = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];
    [current setMeasure:[self newMeasure]];
    
    [[self tabBarController] setSelectedIndex:1];
}



#pragma mark - navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"organizationSegue"]) {
        
        NSIndexPath *indexPath = [[self operationTableView] indexPathForCell:sender];
        ANLHomeDetailViewController *destination = [segue destinationViewController];
        [destination setMoc:[self moc]];
        [destination setOrgTableView:[self organizationTableViewData]];
        [destination setDataSource:[self dataSourceForIndex:[indexPath row]]];
    }
}



#pragma mark - custom methods

-(void)matchFounds:(BOOL)found {

    [[self foundLabel] removeFromSuperview];
    [self setFoundLabel:nil];
    
    if (!found && ![self emptyData]) {
        
        CGRect frame = [[self measuresTableView] bounds];
        frame.size.height = 50.0f;
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor colorForBackGroundsViews]];
        [label setText:[Language stringForKey:@"Home.measureCell.NoMatch"]];
        [label setFont:[UIFont spaghettiFontWithSize:30]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [[self measuresTableView] addSubview:label];
        [self setFoundLabel:label];
    }
}

-(void)hideTableViewsWhenDoNotHaveData {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:[ANLMeasure entityName]];
    [fetch setFetchLimit:5];
    [fetch setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ANLMeasureAttributes.date ascending:YES]]];
    
    [self setEmptyData:[[[self moc] executeFetchRequest:fetch error:nil] count] == 0];
    CGFloat alpha = [self emptyData] ? 0 : 1;
    
    [[self measuresTableView] setAlpha:alpha];
    [[self operationTableView] setAlpha:alpha];
}

-(NSDictionary *)compactTitleOfMeasure:(ANLMeasure *)measure {
    
    ANLOperation *ope = [[measure operator] operation];
    ANLProcess *pro = [ope process];
    ANLOrganization *org = [pro organization];
    
    
    NSString *subTitle = [NSString stringWithFormat:@"%@ %@ %@ %@", [org name], [pro name],
                                                                    [ope name], [[measure operator] name]];
    
    return @{@"title" : [measure dateDescriptionForHomeView], @"subtitle" : subTitle};
}

-(NSArray *)dataSourceForIndex:(NSInteger)index {
    
    NSArray *entities = @[[ANLOrganization entityName], [ANLProcess entityName],
                          [ANLOperation entityName], [ANLOperator entityName]];
    
    NSString *entity = [entities objectAtIndex:index];
    NSPredicate *noUnknown = [NSPredicate predicateWithFormat:@"%K != %@", @"name", @""];
    NSPredicate *relationsPredicate = [self predicateForRelationsShips:[NSClassFromString(entity) pathToRoot]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[noUnknown, relationsPredicate]];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:entity];
    [fetch setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    [fetch setPredicate:predicate];
    [fetch setFetchBatchSize:20];
    
    NSError *error = nil;
    NSArray *result = [[self moc] executeFetchRequest:fetch error:&error];
    if (!result) {
        
        NSLog(@"error executing fetch in %s", __PRETTY_FUNCTION__);
    }
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    [dataSource addObject:entity];
    [dataSource addObjectsFromArray:result];
    
    return [NSArray arrayWithArray:dataSource];
}

-(NSPredicate *)predicatesForText:(NSString *)finalText {
    
    NSPredicate *andPredicate = [self predicateForRelationsShips:@[@"operator.operation.process.organization",
                                                                   @"operator.operation.process",
                                                                   @"operator.operation", @"operator"]];
    if ([finalText isEqual:@""]) {
        
        return andPredicate;
    }
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    NSMutableArray *auxArray = [[NSMutableArray alloc] init];
    
    // Add all time Scales whose text matches with the finalText
    [[ANLMeasure timeScaleDescriptors] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *timeScale = obj;
        if ([timeScale rangeOfString:finalText].location != NSNotFound) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeScale == %li", (long)idx];
            [auxArray addObject:predicate];
        }
    }];
    if ([auxArray count] > 0) {
        
        [predicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:auxArray]];
        [auxArray removeAllObjects];
    }
    
    // tacktTime must be greater than 0
    if ([finalText integerValue] > 0) {
        
        NSInteger tt = [finalText integerValue];
        NSPredicate *taktTimePredicate = [NSPredicate predicateWithFormat:@"taktTime == %li", (long)tt];
        [predicates addObject:taktTimePredicate];
    }
    
    NSArray *paths = @[@"operator.operation.process.organization.name", @"operator.operation.process.name",
                       @"operator.operation.name", @"operator.name", @"dateText", @"place"];
    
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", obj, finalText];
        [auxArray addObject:predicate];
    }];
    [predicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:auxArray]];
    [auxArray removeAllObjects];
    
    NSString *format = @"(SUBQUERY(buttons, $x, $x.name CONTAINS[cd] %@).@count != 0)";
    NSPredicate *buttonsPredicate = [NSPredicate predicateWithFormat:format, finalText];
    [predicates addObject:buttonsPredicate];
    
    NSArray *subpredicates = @[andPredicate, [NSCompoundPredicate orPredicateWithSubpredicates:predicates]];
    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

-(NSPredicate *)predicateForRelationsShips:(NSArray *)entities {
    
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    
    if ([entities count] > 0) {
        
        NSArray *related = [[self organizationTableViewData] relatedEntities];
        [related enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            *stop = (([entities count] - 1) <= idx) ? YES : NO;
            if (obj != [NSNull null]) {
                
                id entitie = [entities objectAtIndex:idx];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == $RELATED_ENTITY", entitie];
                [predicates addObject:[predicate predicateWithSubstitutionVariables:@{@"RELATED_ENTITY" : obj}]];
            }
        }];
    }
    return [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
}

-(ANLCurrentMeasure *)prepareCurrentMeasure {

    ANLCurrentMeasure *currentMeasure = [ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]];
    if (![currentMeasure measure]) {
        
        [currentMeasure setMeasure:[self newMeasure]];
    }
    return currentMeasure;
}

-(ANLMeasure *)newMeasure {

    ANLMeasure *measure = [ANLMeasure measureInManagedObjectContext:[self moc]];
    ANLOrganizationTableView *data = [self organizationTableViewData];
    
    if ([data operator]) {
        
        [measure setOperator:[data operator]];
    } else if ([data operation]) {
        
        [[measure operator] setOperation:[data operation]];
    } else if ([data process]) {
        
        [[[measure operator] operation] setProcess:[data process]];
    } else if ([data organization]) {
        
        [[[[measure operator] operation] process] setOrganization:[data organization]];
    }
    return measure;
}

@end
