//
//  EditionSequenceView.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "EditionSequenceView.h"
#import "Exercice.h"
#import "Fonctions.h"


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface EditionSequenceView () <NSFetchedResultsControllerDelegate>


@end

@implementation EditionSequenceView



//implémentation des accesseurs des composants de l'interface
@synthesize txtNomSeq;
@synthesize txtNbreRepSeq;
@synthesize swSynthNomSeq;
@synthesize swSynthDureeSeq;
@synthesize lstExercices;




//Mise à jour de la valeur de la zone de texte Nombre de répétitions après click sur le stepper
//UIStepper : contrôle stepper dont la valeur a changé
- (IBAction)stepValueChanged:(UIStepper *)sender {
    double v = [sender value];
    txtNbreRepSeq.text = [NSString stringWithFormat:@"%d", (int)v ];
}

//fonction appelée quand la vue à été chargée, permet d'initialiser les composants de l'interface
- (void)viewDidLoad {
    [super viewDidLoad];
    //création du tableau provisoire d'exercices pour peupler la listview
    [lstExercices setDataSource:self];
    [lstExercices setDelegate:self];
    
    //initialisation des zones de texte et des switchs depuis les valeurs contenues dans 
    txtNomSeq.text=[[self.detailItem valueForKey:@"nomSeq"] description];
    txtNbreRepSeq.text=[[self.detailItem valueForKey:@"nombreRepetitionsSeq"] description];

    BOOL etatSynthVocNom =[[[self.detailItem valueForKey:@"synthVocNomSeq"]description] boolValue];
    [swSynthNomSeq setOn:etatSynthVocNom];
    BOOL etatSynthVocDuree =[[[self.detailItem valueForKey:@"synthVocDureeSeq"]description] boolValue];
    [swSynthDureeSeq setOn:etatSynthVocDuree];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showExercice"]) {
        NSIndexPath *indexPath = [self.lstExercices indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsControllerEx] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    }
}




#pragma mark - Table view delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsControllerEx sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemExercice" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsControllerEx managedObjectContext];
        [context deleteObject:[self.fetchedResultsControllerEx objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsControllerEx objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"nomEx"] description];
    int dureeExercice = [[[object valueForKey:@"dureeEx"]description] intValue];
    cell.detailTextLabel.text = [Fonctions convertIntToHHMMSS: dureeExercice];
    
}



//Met à jour les données dans CoreData
- (IBAction)onBtnOkClick:(UIButton *)sender {
    

    //met à jour les données dans self.detailItem

    [self.detailItem setValue:txtNomSeq.text forKey:@"nomSeq"];
    
    long nbreRepetitions =[txtNbreRepSeq.text integerValue] ;
    [self.detailItem setValue:[NSNumber numberWithLong:nbreRepetitions] forKey:@"nombreRepetitionsSeq"];
    
    if(swSynthNomSeq.on)
    {
        [self.detailItem setValue:@true forKey:@"synthVocNomSeq"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"synthVocNomSeq"];
    }
    
    if(swSynthDureeSeq.on)
    {
        [self.detailItem setValue:@true forKey:@"synthVocDureeSeq"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"synthVocDureeSeq"];
    }
    

    
    
    //sauvegarde les données mises à jour
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (IBAction)onBtnAddClick:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsControllerEx managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsControllerEx fetchRequest] entity];
    NSManagedObject *newExercice = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    [newExercice setValue:@"Nouvel exercice" forKey:@"nomEx"];
    [newExercice setValue:@"" forKey:@"descriptionEx"];
    [newExercice setValue:@10 forKey:@"dureeEx"];
    
    //récupération de la position de l'exercice dans la liste d'exercices de la séquence
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsControllerEx sections][0];
    long nbreExercicesDansSequence = [sectionInfo numberOfObjects];
    [newExercice setValue:[NSNumber numberWithLong:nbreExercicesDansSequence] forKey:@"positionDansSequenceEx"];
    
    //mise en place de la relation entre l'exercice créé et la séquence dans detailItem
    [newExercice setValue:self.detailItem forKey:@"sequence"];
    NSMutableSet *exercices = [self.detailItem mutableSetValueForKey:@"exercices"];
    [exercices addObject:newExercice];
    
    //sauvegarde les données mises à jour
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.lstExercices endUpdates];
    
}






#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsControllerSeq
{
    if (_fetchedResultsControllerSeq != nil) {
        return _fetchedResultsControllerSeq;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sequence" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nomSeq" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsControllerSeq = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsControllerSeq performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsControllerSeq;
}


- (NSFetchedResultsController *)fetchedResultsControllerEx
{
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    if (_fetchedResultsControllerEx != nil) {
        return _fetchedResultsControllerEx;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exercice" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate * seqPredicate = [NSPredicate predicateWithFormat:@"sequence ==%@", self.detailItem];
    [fetchRequest setPredicate:seqPredicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionDansSequenceEx" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsControllerEx = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsControllerEx performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsControllerEx;
}

//Gestion de la mise à jour des fetchedResultController

//prépare la listView à la mise à jour
- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.lstExercices beginUpdates];
}

//signale à la listView la fin de la mise à jour
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.lstExercices endUpdates];
}

//Met à jour l'affichage de la listView en fonction de la modification effectuée par le fetchedResultController
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.lstExercices;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}



@end
