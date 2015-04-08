//
//  Exercice.h
//  RChronoIOS
//
//  Created by rcdsm2014 on 08/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exercice : NSObject

@property NSString *mNom;
@property NSString *mDescription;
@property int mDuree;
@property BOOL mSynthNom;
@property BOOL mSynthDuree;
@property BOOL mNotifVibreur;
@property BOOL mNotifPopup;

@end
