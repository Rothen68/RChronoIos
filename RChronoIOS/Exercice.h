//
//  Exercice.h
//  RChronoIOS
//
//  Description :
//
//  Classe métier, stocke les données relatives à un exercice
//
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exercice : NSObject

// Nom de l'exercice
@property NSString *mNom;
// Description de l'exercice
@property NSString *mDescription;
// Durée de l'exercice en seconde
@property int mDuree;
// Booléen : énnoncé du nom de l'exercice par la synthèse vocale
@property BOOL mSynthNom;
// Booléen : énnoncé de la durée de l'exercice par la synthèse vocale
@property BOOL mSynthDuree;
// Booléen : utilisation du vibreur à la fin de l'exercice
@property BOOL mNotifVibreur;
// Booléen : affichage d'une popup à la fin de l'exercice
@property BOOL mNotifPopup;

@end
