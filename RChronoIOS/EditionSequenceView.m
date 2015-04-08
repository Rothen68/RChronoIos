//
//  EditionSequenceView.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "EditionSequenceView.h"
#import "Exercice.h"


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
- (IBAction)stepValueChanged:(UIStepper *)sender {
    double v = [sender value];
    txtNbreRepSeq.text = [NSString stringWithFormat:@"%d", (int)v ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mTabExercice = [[NSMutableArray alloc] init];
    [self loadInitialData];
    [lstExercices setDataSource:self];
    [lstExercices setDelegate:self];
    
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


- (NSInteger) numberOfSectionsIntTableView:(UITableView * ) tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mTabExercice count];
}

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




@end
