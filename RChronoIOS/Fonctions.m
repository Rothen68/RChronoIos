//
//  Functions.m
//  RChronoIOS
//
//  Created by rcdsm2014 on 15/04/2015.
//  Copyright (c) 2015 rcdsm2014. All rights reserved.
//

#import "Fonctions.h"

@implementation Fonctions



+(NSString *) convertIntToHHMMSS:(int) valeur
{
    NSString * heure;
    NSString * minute;
    NSString * seconde;
    int h = (int)valeur/3600;
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

@end
