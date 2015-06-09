//
//  MasterViewController.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

// Objet fesant l'interface avec Core Data
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

