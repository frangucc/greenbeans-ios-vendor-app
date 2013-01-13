//
//  PickerPopup.h
//  IOS_SDK
//
//  Created by Tzvi on 8/3/11.
//  Copyright 2011 STAR MICRONICS CO., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrinterFunctions.h"


@interface PickerPopup : NSObject <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate> {
    SEL listener;
    NSObject *listenerObject;
    NSMutableArray *my_DataSource;
    UIPickerView *dataPicker;
    UIActionSheet *actionSheet;
    int selectedIndex;
    UITableViewCell *cell;
}

- (void)setListener:(SEL)selector :(NSObject*)object;
- (id)init;
- (void)setDataSource:(NSMutableArray *)dataSource;
- (void)showPicker;
- (void)dismissActionSheet:(id)sender;
- (int)getSelectedIndex;


@end
