//
//  CacheTokenSets.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/18/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "CachedTokenSets.h"

static NSMutableArray *singleSet = nil;
static NSMutableArray *twoSet = nil;
static NSMutableArray *threeSet = nil;
static NSMutableArray *fourSet = nil;
static NSMutableArray *fiveSet = nil;
static NSMutableArray *sixSet = nil;
static NSMutableArray *sevenSet = nil;
static NSMutableArray *eightSet = nil;
static NSMutableArray *nineSet = nil;
static NSMutableArray *tenSet = nil;

@implementation CachedTokenSets

/*
   SetSets
   --------
   Purpose:        Sets Token Arrays
   Parameters:     - set: number of set to fill
                 - token: token retrieved
   Returns:        none
   Notes:          Set Sets via Switch Statement
   Author:         Neil Burchfield
 */
- (void) setSets :(int)set :(NSString *)token {
    switch (set) {
        case 1:
            [self setSingleTokenSet:token];
            break;
        case 2:
            [self setTwoTokenSet:token];
            break;
        case 3:
            [self setThreeTokenSet:token];
            break;
        case 4:
            [self setFourTokenSet:token];
            break;
        case 5:
            [self setFiveTokenSet:token];
            break;
        case 6:
            [self setSixTokenSet:token];
            break;
        case 7:
            [self setSevenTokenSet:token];
            break;
        case 8:
            [self setEightTokenSet:token];
            break;
        case 9:
            [self setNineTokenSet:token];
            break;
        case 10:
            [self setTenTokenSet:token];
            break;

        default:
            break;
    } /* switch */
} /* setSets */


/*
   GetSet
   --------
   Purpose:        Sets Token Arrays
   Parameters:     - set: number of set to get
   Returns:        none
   Notes:          Fetches tokens via Switch Statement
   Author:         Neil Burchfield
 */
- (NSString *) getSet :(int)set {
    NSString *token = nil;
    switch (set) {
        case 1:
            token = [self getSingleTokenSet];
            break;
        case 2:
            token = [self getTwoTokenSet];
            break;
        case 3:
            token = [self getThreeTokenSet];
            break;
        case 4:
            token = [self getFourTokenSet];
            break;
        case 5:
            token = [self getFiveTokenSet];
            break;
        case 6:
            token = [self getSixTokenSet];
            break;
        case 7:
            token = [self getSevenTokenSet];
            break;
        case 8:
            token = [self getEightTokenSet];
            break;
        case 9:
            token = [self getNineTokenSet];
            break;
        case 10:
            token = [self getTenTokenSet];
            break;
        default:
            token = nil;
            break;
    } /* switch */
    return token;
} /* getSet */


- (void) iterateThroughTokens {
    NSLog(@"getSet 1: %@", [self getSingleTokenSet]);
    NSLog(@"getSet 2: %@", [self getTwoTokenSet]);
    NSLog(@"getSet 3: %@", [self getThreeTokenSet]);
    NSLog(@"getSet 4: %@", [self getFourTokenSet]);
    NSLog(@"getSet 5: %@", [self getFiveTokenSet]);
    NSLog(@"getSet 6: %@", [self getSixTokenSet]);
    NSLog(@"getSet 7: %@", [self getSevenTokenSet]);
    NSLog(@"getSet 8: %@", [self getEightTokenSet]);
    NSLog(@"getSet 9: %@", [self getNineTokenSet]);
    NSLog(@"getSet 10: %@", [self getTenTokenSet]);
} /* iterateThroughTokens */


/* Single Set */
- (void) setSingleTokenSet:(NSString *)token {
    if (singleSet == nil)
        singleSet = [[NSMutableArray alloc] init];

    [singleSet addObject:token];
} /* setSingleTokenSet */


- (NSString *) getSingleTokenSet {
    return [singleSet lastObject];
} /* getSingleTokenSet */


/* Sets of Two */
- (void) setTwoTokenSet:(NSString *)token {
    if (twoSet == nil)
        twoSet = [[NSMutableArray alloc] init];

    [twoSet addObject:token];
} /* setTwoTokenSet */


- (NSString *) getTwoTokenSet {
    return [twoSet lastObject];
} /* getTwoTokenSet */


/* Sets of Three */
- (void) setThreeTokenSet:(NSString *)token {
    if (threeSet == nil)
        threeSet = [[NSMutableArray alloc] init];

    [threeSet addObject:token];
} /* setThreeTokenSet */


- (NSString *) getThreeTokenSet {
    return [threeSet lastObject];
} /* getThreeTokenSet */


/* Sets of Four */
- (void) setFourTokenSet:(NSString *)token {
    if (fourSet == nil)
        fourSet = [[NSMutableArray alloc] init];

    [fourSet addObject:token];
} /* setFourTokenSet */


- (NSString *) getFourTokenSet {
    return [fourSet lastObject];
} /* getFourTokenSet */


/* Sets of Five */
- (void) setFiveTokenSet:(NSString *)token {
    if (fiveSet == nil)
        fiveSet = [[NSMutableArray alloc] init];

    [fiveSet addObject:token];
} /* setFiveTokenSet */


- (NSString *) getFiveTokenSet {
    return [fiveSet lastObject];
} /* getFiveTokenSet */


/* Sets of Six */
- (void) setSixTokenSet:(NSString *)token {
    if (sixSet == nil)
        sixSet = [[NSMutableArray alloc] init];

    [sixSet addObject:token];
} /* setSixTokenSet */


- (NSString *) getSixTokenSet {
    return [sixSet lastObject];
} /* getSixTokenSet */


/* Sets of Seven */
- (void) setSevenTokenSet:(NSString *)token {
    if (sevenSet == nil)
        sevenSet = [[NSMutableArray alloc] init];

    [sevenSet addObject:token];
} /* setSevenTokenSet */


- (NSString *) getSevenTokenSet {
    return [sevenSet lastObject];
} /* getSevenTokenSet */


/* Sets of Eight */
- (void) setEightTokenSet:(NSString *)token {
    if (eightSet == nil)
        eightSet = [[NSMutableArray alloc] init];

    [eightSet addObject:token];
} /* setEightTokenSet */


- (NSString *) getEightTokenSet {
    return [eightSet lastObject];
} /* getEightTokenSet */


/* Sets of Nine */
- (void) setNineTokenSet:(NSString *)token {
    if (nineSet == nil)
        nineSet = [[NSMutableArray alloc] init];

    [nineSet addObject:token];
} /* setNineTokenSet */


- (NSString *) getNineTokenSet {
    return [nineSet lastObject];
} /* getNineTokenSet */


/* Sets of Ten */
- (void) setTenTokenSet:(NSString *)token {
    if (tenSet == nil)
        tenSet = [[NSMutableArray alloc] init];

    [tenSet addObject:token];
} /* setTenTokenSet */


- (NSString *) getTenTokenSet {
    return [tenSet lastObject];
} /* getTenTokenSet */


@end
























