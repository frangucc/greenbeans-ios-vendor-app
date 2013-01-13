//
//  SearchPrinters.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StarIO/SMPort.h"

@interface SearchPrinters : NSObject {
    
    NSArray *printerArray;
    NSString *lastSelectedPortName;
    
}

- (BOOL)searchConnections;

@end
