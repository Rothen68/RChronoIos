//
//  EditionExerciceView.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EditionExerciceView : UIViewController


//contient l'item sur lequel l'utilisateur à cliqué sur la masterView
@property (strong, nonatomic) id detailItem;

//stocke le managedObjectContext depuis la classe MasterViewController pour l'acces aux données de coreData
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerEx;

@property (weak, nonatomic) IBOutlet UITextField *txtNomEx;
@property (weak, nonatomic) IBOutlet UITextView *txtDescEx;
@property (weak, nonatomic) IBOutlet UITextField *txtDureeEx;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthVocNomEx;
@property (weak, nonatomic) IBOutlet UISwitch *swSynthVocDureeEx;
@property (weak, nonatomic) IBOutlet UISwitch *swNotifVibreurEx;
@property (weak, nonatomic) IBOutlet UISwitch *swNotifSonnerieEx;
@property (weak, nonatomic) IBOutlet UITextField *txtSonnerieEx;

- (IBAction)onSwVibreurChange:(UISwitch *)sender;

- (IBAction)onBtnOkClick:(id)sender;

@end
