//
//  CreateIncentivesViewController
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/17/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableView.h"
#import "SVSegmentedControl.h"

@interface CreateIncentivesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *incentivesTableview;
    NSArray *headers;
}

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl;

@end