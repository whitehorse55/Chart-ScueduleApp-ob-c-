//
//  ANLPhotoCollectionViewController.h
//  Chronos
//
//  Created by Amador Navarro Lucas on 28/09/14.
//  Copyright (c) 2014 Amador Navarro Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface ANLPhotoCollectionViewController : UICollectionViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *moc;

@end
