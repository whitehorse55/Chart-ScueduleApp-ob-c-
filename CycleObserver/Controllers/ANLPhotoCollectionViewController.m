//
//  ANLPhotoCollectionViewController.m
//  Chronos
//
//  Created by Amador Navarro Lucas on 28/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import "ANLPhotoCollectionViewController.h"
#import "ANLCollectionViewCell.h"
#import "ANLModel.h"




@interface ANLPhotoCollectionViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResults;
@property (strong, nonatomic) ANLMeasure *measure;

@end



@implementation ANLPhotoCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {

    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self setMeasure:[[ANLCurrentMeasure currentMeasureInManageObjectContext:[self moc]] measure]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)setMoc:(NSManagedObjectContext *)moc {
    
    _moc = moc;
}

-(NSFetchedResultsController *)fetchedResults {

    if (_fetchedResults != nil) {
        
        return _fetchedResults;
    }
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:[ANLPhoto entityName]];
    [fetch setFetchBatchSize:20];
    [fetch setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"measure == $MEASURE"];
    predicate = [predicate predicateWithSubstitutionVariables:@{@"MEASURE" : [self measure]}];
    [fetch setPredicate:predicate];
    
    NSString *cacheName = [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"] ? nil
                                                                                                 : @"PhotoGalleryCache";
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch
                                                                          managedObjectContext:[self moc]
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:cacheName];
    [frc setDelegate:self];
    [self setFetchedResults:frc];
    
    NSError *error = nil;
    if (![_fetchedResults performFetch:&error]) {
        
        NSLog(@"Error performFetch:%@", error);
    }
    return _fetchedResults;
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [[[self fetchedResults] sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> info = [[[self fetchedResults] sections] objectAtIndex:section];
    return [info numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id c = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ANLCollectionViewCell *cell = c;
    
    UIImage *photo = [UIImage imageWithData:[[[self fetchedResults] objectAtIndexPath:indexPath] data]];
    [[cell photo] setImage:photo];

    return cell;
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
