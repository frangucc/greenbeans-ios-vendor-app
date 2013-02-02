//
//  CacheTokenSets.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/18/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CachedTokenSets : NSObject

/* Fill/Load Sets */
- (void) setSets :(int)set :(NSString *)token;

/* Get/Retrieve Set */
- (NSString *) getSet :(int)set;

/* Iterate Through Tokens for Testing */
- (void) iterateThroughTokens;

@end