//
//  EditionExerciceView.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "EditionExerciceView.h"

#import <AudioToolbox/AudioServices.h>

@interface EditionExerciceView ()

@end

@implementation EditionExerciceView

@synthesize txtNomEx;
@synthesize txtDescEx;
@synthesize txtDureeEx;
@synthesize txtSonnerieEx;
@synthesize swSynthVocNomEx;
@synthesize swSynthVocDureeEx;
@synthesize swNotifVibreurEx;
@synthesize swNotifSonnerieEx;


// Nom : viewDidLoad
//
// Description :
//  Fonction appelée après le chargement de la View, permet
//  l'initialisation des contrôles
//
- (void)viewDidLoad {
    [super viewDidLoad];
    txtNomEx.text = [[self.detailItem valueForKey:@"nomEx"]description];
    txtDescEx.text = [[self.detailItem valueForKey:@"descriptionEx"] description];
    txtDureeEx.text = [[self.detailItem valueForKey:@"dureeEx"]description];
    
    BOOL etatSynthVocNom =[[[self.detailItem valueForKey:@"synthVocNomEx"]description] boolValue];
    [swSynthVocNomEx setOn:etatSynthVocNom];
    BOOL etatSynthVocDuree =[[[self.detailItem valueForKey:@"synthVocDureeEx"]description] boolValue];
    [swSynthVocDureeEx setOn:etatSynthVocDuree];
    
    BOOL etatNotifVibreur =[[[self.detailItem valueForKey:@"notifVibreurEx"]description] boolValue];
    [swNotifVibreurEx setOn:etatNotifVibreur];
    BOOL etatNotifSonnerie =[[[self.detailItem valueForKey:@"notifSonnerieEx"]description] boolValue];
    [swNotifSonnerieEx setOn:etatSynthVocDuree];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Nom : fetchedResultsControllerEx
//
// Description :
//  Récupère les données de CoreData en fonction de l'exercice à afficher
//
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
    NSPredicate * seqPredicate = [NSPredicate predicateWithFormat:@"ANY sequence ==%@", self.detailItem];
    [fetchRequest setPredicate:seqPredicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"positionDansSeqenceEx" ascending:NO];
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


// Nom : onSwVibreurChange
//
// Description :
//  Fait vibrer le téléphone lors du changement de l'état de la notification Vibreur
//
- (IBAction)onSwVibreurChange:(id)sender {
    if(swNotifVibreurEx.on)
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}


// Nom : onBtnOkClick
//
// Description :
//  Met à jour les données dans self.detailItem
//
- (IBAction)onBtnOkClick:(id)sender {
    [self.detailItem setValue:txtNomEx.text forKey:@"nomEx"];
    [self.detailItem setValue:txtDescEx.text forKey:@"descriptionEx"];
    [self.detailItem setValue:[NSNumber numberWithLong:[txtDureeEx.text integerValue]] forKey:@"dureeEx"];
    
    if(swSynthVocNomEx.on)
    {
        [self.detailItem setValue:@true forKey:@"synthVocNomEx"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"synthVocNomEx"];
    }
    if(swSynthVocDureeEx.on)
    {
        [self.detailItem setValue:@true forKey:@"synthVocDureeEx"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"synthVocDureeEx"];
    }
    if(swNotifVibreurEx.on)
    {
        [self.detailItem setValue:@true forKey:@"notifVibreurEx"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"notifVibreurEx"];
    }
    if(swNotifSonnerieEx.on)
    {
        [self.detailItem setValue:@true forKey:@"notifSonnerieEx"];
    }
    else
    {
        [self.detailItem setValue:@false forKey:@"notifSonnerieEx"];
    }
    
    [self.detailItem setValue:txtSonnerieEx.text forKey:@"nomSonnerieEx"];
    
    //sauvegarde les données mises à jour
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
@end
