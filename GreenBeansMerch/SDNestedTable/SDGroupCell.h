//
//  SDGroupCell.h
//  SDNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDSubCell.h"
#import "SDSelectableCell.h"

typedef enum {
    AllSubCellsCommandChecked,
    AllSubCellsCommandUnchecked,
    AllSubCellsCommandNone,
} AllSubCellsCommand;

static const int height = 50;
static const int subCellHeight = 40;

@interface SDGroupCell : SDSelectableCell <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIButton *expandBtn;
    AllSubCellsCommand subCellsCommand;
}

@property (assign) BOOL isExpanded;
@property (assign) IBOutlet UITableView *subTable;
@property (assign) IBOutlet SDSubCell *subCell;
@property (nonatomic) int subCellsAmt;
@property (assign) int selectedSubCellsAmt;
@property (nonatomic, strong) NSMutableDictionary *selectableSubCellsState;
@property (strong) NSIndexPath *cellIndexPath;

- (void) subCellsToggleCheck;
- (void) rotateExpandBtn:(id)sender;
- (void) rotateExpandBtnToExpanded;
- (void) rotateExpandBtnToCollapsed;

- (void) toggleCell:(SDSubCell *)cell atIndexPath: (NSIndexPath *) pathToToggle;

+ (int) getHeight;
+ (int) getsubCellHeight;

@end
