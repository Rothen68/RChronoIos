//
//  EditionSequenceView.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditionSequenceView : UIViewController

//déclaration des composants de l'interface
@property (weak, nonatomic) IBOutlet UITextField *txtNomSeq;
@property (weak, nonatomic) IBOutlet UITextField *txtNbreRepSeq;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthDureeSeq;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthNomSeq;
@property (weak, nonatomic) IBOutlet UITableView *lstExercices;

@end
