//
//  Functions.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 15/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classe statique Fonctions contenant les fonctions utilitaires
//de l'application

@interface Fonctions : NSObject
// Nom : convertIntToHHMMSS
//
// Description :
//
// Convertis un entier au format  heure, minute seconde HH:MM:SS
//
// Entrée
//   int  valeur : valeur à convertir
//
// Sortie
//   NSString : chaîne de caractère contenant la valeur convertie
//              retourne : 1:00:00 s pour 3600 en entrée
//              retourne : 1:00 s pour 60 en entrée
//              retourne : 10 s pour 10 en entrée
//
+(NSString *) convertIntToHHMMSS:(int) valeur;
@end
