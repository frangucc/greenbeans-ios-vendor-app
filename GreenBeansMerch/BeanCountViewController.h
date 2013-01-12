//
//  BeanCountViewController.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BeanCountViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSMutableArray *pickerObjects;
    
}

@property (nonatomic, retain) IBOutlet UIPickerView *beanCountPicker;

@end
