//
//  Sequence.h
//  RChronoIOS
//
//  Description :
//
//  Classe métier, stocke les données relatives à une séquence
//
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sequence : NSObject

// Nom de la séquence
@property NSString *mNom;
// Nombre de répétitions de la séquence
@property int mNbreRepetitions;
// Booléen : énnoncer le nom de la séquence par la synthèse vocale
@property BOOL mSynthNom;
// Booléen : énnoncer la durée de la séquence par la synthèse vocale
@property BOOL mSynthDuree;

@end
