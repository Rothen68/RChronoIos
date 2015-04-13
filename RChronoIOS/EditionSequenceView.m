//
//  EditionSequenceView.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "EditionSequenceView.h"
#import "Exercice.h"


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface EditionSequenceView ()


@end

@implementation EditionSequenceView

-(NSString *) convertIntToHHMMSS:(int) valeur
{
    NSString * heure;
    NSString * minute;
    NSString * seconde;
    int h = (int)valeur/360;
    int reste = valeur - h*3600;
    int m = (int) reste/60;
    int s = reste - m*60;
    
    if (h>0)
    {
        heure = [NSString stringWithFormat:@"%d:",h];
    }
    else
    {
        heure = @"";
    }
    
    if(m>0)
    {
        if(h>0)
        {
            minute =[NSString stringWithFormat:@"%2d:",m];
        }
        else
        {
            minute = [NSString stringWithFormat:@"%d:",m];
        }
    }
    else
    {
        if(h>0)
        {
            minute = @"00:";
        }
        else
        {
            minute = @"";
        }
    }
    
    if(s>0)
    {
        if ((m>0)||(h>0))
        {
            seconde = [NSString stringWithFormat:@"%2d",s];
        }
        else
        {
            seconde = [NSString stringWithFormat:@"%d",s];
        }
    }
    else
    {
        if ((m>0)||(h>0))
        {
            seconde = @"00";
        }
        else
        {
            seconde = @"0";
        }
    }
    
    NSString * retour = [heure stringByAppendingString:[minute stringByAppendingString:[seconde stringByAppendingString:@" s"]]];
    return retour;
}


//implémentation des accesseurs des composants de l'interface
@synthesize txtNomSeq;
@synthesize txtNbreRepSeq;
@synthesize swSynthNomSeq;
@synthesize swSynthDureeSeq;
@synthesize lstExercices;

@synthesize mTabExercice;


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
    self.mTabExercice = [[NSMutableArray alloc] init];
    [self loadInitialData];
    [lstExercices setDataSource:self];
    [lstExercices setDelegate:self];
    
    //initialisation des zones de texte et des switchs depuis les valeurs contenues dans 
    txtNomSeq.text=[[self.detailSequence valueForKey:@"nomSeq"] description];
    txtNbreRepSeq.text=[[self.detailSequence valueForKey:@"nombreRepetitionsSeq"] description];

    BOOL etatSynthVocNom =[[[self.detailSequence valueForKey:@"synthVocNomSeq"]description] boolValue];
    [swSynthNomSeq setOn:etatSynthVocNom];
    BOOL etatSynthVocDuree =[[[self.detailSequence valueForKey:@"synthVocDureeSeq"]description] boolValue];
    [swSynthDureeSeq setOn:etatSynthVocDuree];
}


//charge du contenu test dans le tableau des exercices
- (void) loadInitialData{

    
    
    Exercice *ex1 = [[Exercice alloc] init];
    ex1.mNom = @"Exercice 1";
    ex1.mDescription = @"Desc Exercice 1";
    ex1.mDuree = 60;
    [self.mTabExercice addObject:ex1];
    Exercice *ex2 = [[Exercice alloc] init];
    ex2.mNom = @"Exercice 2";
    ex2.mDescription = @"Desc Exercice 2";
    ex2.mDuree = 120;
    [self.mTabExercice addObject:ex2];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Renvois le nombre de section, cad 1 vu qu'il n'y a qu'une section
- (NSInteger) numberOfSectionsIntTableView:(UITableView * ) tableView{
    return 1;
}

//Renvois le nombre de lignes dans la section courante
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mTabExercice count];
}


//Envois une cellule du listView initialisé à partir de la position passée dans indexPath
//(NSIndexPath *) indexPath : position de la cellule à initialiser dans la listView
//(UITableViewCell *) : cellule initialisée
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemExercice" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"itemExercice"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Exercice * ex = [self.mTabExercice objectAtIndex:indexPath.row];
    cell.textLabel.text = ex.mNom;
    cell.detailTextLabel.text = [self convertIntToHHMMSS:ex.mDuree];
    return cell;
    
}







#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    double d = 2;
}



//Met à jour les données dans CoreData
- (IBAction)onBtnOkClick:(UIButton *)sender {
    

    //met à jour les données dans self.detailSequence

    [self.detailSequence setValue:txtNomSeq.text forKey:@"nomSeq"];
    
    long nbreRepetitions =[txtNbreRepSeq.text integerValue] ;
    [self.detailSequence setValue:[NSNumber numberWithLong:nbreRepetitions] forKey:@"nombreRepetitionsSeq"];
    
    if(swSynthNomSeq.on)
    {
        [self.detailSequence setValue:@true forKey:@"synthVocNomSeq"];
    }
    else
    {
        [self.detailSequence setValue:@false forKey:@"synthVocNomSeq"];
    }
    
    if(swSynthDureeSeq.on)
    {
        [self.detailSequence setValue:@true forKey:@"synthVocDureeSeq"];
    }
    else
    {
        [self.detailSequence setValue:@false forKey:@"synthVocDureeSeq"];
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



#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
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
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}






@end
