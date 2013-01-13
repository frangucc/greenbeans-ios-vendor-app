//
//  rasterPrinting.h
//  IOS_SDK
//
//  Created by Tzvi on 8/17/11.
//  Copyright 2011 STAR MICRONICS CO., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerPopup.h"


@interface rasterPrinting : UIViewController <UITextViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextView *uitextview_texttoprint;
    IBOutlet UIScrollView *uiscrollview_main;
    IBOutlet UITableView *uitableview_font;
    IBOutlet UITableView *uitableview_fontStyle;
    IBOutlet UITextField *uitextfield_textsize;
    IBOutlet UITableView *uitableview_printWidth;
    
    PickerPopup *pickerpopup_font;
    PickerPopup *pickerpopup_fontStyle;
    PickerPopup *pickerpopup_printerSize;
    
    NSMutableArray *array_font;
    NSMutableArray *array_fontStyle;
    NSMutableArray *array_printerSize;
}

- (void)ResetTableView:(id)sender;
- (void)ResetTableViewStyle:(id)sender;
- (void)ResetTableViewPrinterSize:(id)sender;
- (IBAction)backRasterPrinting;
- (IBAction)printRasterText;
- (IBAction)sizeChanged;

@end
