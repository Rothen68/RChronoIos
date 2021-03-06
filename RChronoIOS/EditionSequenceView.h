//
//  EditionSequenceView.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface EditionSequenceView : UIViewController <UITableViewDataSource>


// Déclaration des composants de l'interface
@property (weak, nonatomic) IBOutlet UITextField *txtNomSeq;
@property (weak, nonatomic) IBOutlet UITextField *txtNbreRepSeq;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthDureeSeq;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthNomSeq;
@property (weak, nonatomic) IBOutlet UITableView *lstExercices;

// Gestion des actions sur les contrôles
- (IBAction)onBtnOkClick:(UIButton *)sender;
- (IBAction)onBtnAddClick:(id)sender;

// Contient l'item sur lequel l'utilisateur à cliqué sur la masterView
@property (strong, nonatomic) id detailItem;

// Stocke le managedObjectContext depuis la classe MasterViewController pour l'acces aux données de coreData
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerSeq;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerEx;

+(NSString *) convertIntToHHMMSS:(int) valeur;

@end
