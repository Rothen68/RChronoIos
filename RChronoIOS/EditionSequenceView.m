//
//  EditionSequenceView.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "EditionSequenceView.h"

@interface EditionSequenceView ()

@end

@implementation EditionSequenceView



//implémentation des accesseurs des composants de l'interface
@synthesize txtNomSeq;
@synthesize txtNbreRepSeq;
@synthesize swSynthNomSeq;
@synthesize swSynthDureeSeq;
@synthesize lstExercices;


//Mise à jour de la valeur de la zone de texte Nombre de répétitions après click sur le stepper
- (IBAction)stepValueChanged:(UIStepper *)sender {
    double v = [sender value];
    txtNbreRepSeq.text = [NSString stringWithFormat:@"%d", (int)v ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
