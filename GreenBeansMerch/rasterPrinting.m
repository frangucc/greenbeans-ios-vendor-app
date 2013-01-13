//
//  rasterPrinting.m
//  IOS_SDK
//
//  Created by Tzvi on 8/17/11.
//  Copyright 2011 STAR MICRONICS CO., LTD. All rights reserved.
//

#import "AppDelegate.h"

#import "rasterPrinting.h"
#import <QuartzCore/QuartzCore.h>
#import "StandardHelp.h"

#import "MiniPrinterFunctions.h"

@interface rasterPrinting (hidden)

- (UIFont*)getSelectedFont:(int)multiple;

@end

@implementation rasterPrinting

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *fonts = [UIFont familyNames];
        
        array_font = [[NSMutableArray alloc] init];
        [array_font addObjectsFromArray:fonts];
        
        array_fontStyle = [[NSMutableArray alloc] init];
        NSArray *fondSytlesArray = [UIFont fontNamesForFamilyName:[array_font objectAtIndex:0]];
        [array_fontStyle addObjectsFromArray:fondSytlesArray];
        
        array_printerSize = [[NSMutableArray alloc] init];

        NSString *portSettings = [AppDelegate getPortSettings];
        
        if ([portSettings compare:@"mini" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
//          [array_printerSize addObject:@"2 inch"];
            [array_printerSize addObject:@"3 inch"];
//          [array_printerSize addObject:@"4 inch"];
        }
        else
        {
            [array_printerSize addObject:@"3 inch"];
            [array_printerSize addObject:@"4 inch"];
        }
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerpopup_font = [[PickerPopup alloc] init];
    [pickerpopup_font setDataSource:array_font];
    [pickerpopup_font setListener:@selector(ResetTableView:) :self];
    [uitableview_font setDataSource:pickerpopup_font];
    [uitableview_font setDelegate:pickerpopup_font];
    uitableview_font.layer.borderWidth = 1;
    
    pickerpopup_fontStyle = [[PickerPopup alloc] init];
    [pickerpopup_fontStyle setDataSource:array_fontStyle];
    [pickerpopup_fontStyle setListener:@selector(ResetTableViewStyle:) :self];
    [uitableview_fontStyle setDataSource:pickerpopup_fontStyle];
    [uitableview_fontStyle setDelegate:pickerpopup_fontStyle];
    uitableview_fontStyle.layer.borderWidth = 1;
    
    pickerpopup_printerSize = [[PickerPopup alloc] init];
    [pickerpopup_printerSize setDataSource:array_printerSize];
    [pickerpopup_printerSize setListener:@selector(ResetTableViewPrinterSize:) :self];
    [uitableview_printWidth setDataSource:pickerpopup_printerSize];
    [uitableview_printWidth setDelegate:pickerpopup_printerSize];
    uitableview_printWidth.layer.borderWidth = 1;
    
    uitextview_texttoprint.layer.borderWidth = 1;
    UIFont *font = uitextview_texttoprint.font;
    UIFont *font2 = [UIFont fontWithName:font.familyName size:[UIFont labelFontSize]];
    [uitextview_texttoprint setFont:font2];
    double f = [UIFont labelFontSize];
    NSString *fontSize = [NSString stringWithFormat:@"%02.2f", f];
    [uitextfield_textsize setText:fontSize];
    
    
    uiscrollview_main.contentSize = CGSizeMake(320, 470);
    [uiscrollview_main setScrollEnabled:FALSE];
    
    [uitextfield_textsize setDelegate:self];
    [uitextview_texttoprint setDelegate:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)ResetTableView:(id)sender
{
    [uitableview_font reloadData];
    
    NSArray *fondSytlesArray = [UIFont fontNamesForFamilyName:[array_font objectAtIndex:[pickerpopup_font getSelectedIndex]]];
    [array_fontStyle removeAllObjects];
    [array_fontStyle addObjectsFromArray:fondSytlesArray];
    [pickerpopup_fontStyle setDataSource:array_fontStyle];
    [uitableview_fontStyle reloadData];
    
    UIFont *font = [self getSelectedFont:1];
    [uitextview_texttoprint setFont:font];
}

- (void)ResetTableViewStyle:(id)sender
{
    [uitableview_fontStyle reloadData];
    
    UIFont *font = [self getSelectedFont:1];
    [uitextview_texttoprint setFont:font];
}
     
- (void)ResetTableViewPrinterSize:(id)sender
{
    [uitableview_printWidth reloadData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [uiscrollview_main setFrame:CGRectMake(0, 0, 320, 240)];
    [uiscrollview_main setScrollEnabled:true];
    
    CGPoint point = CGPointMake(0, 240);
    [uiscrollview_main setContentOffset:point animated:TRUE];
}

- (IBAction)sizeChanged
{
    UIFont *font = [self getSelectedFont:1];
    [uitextview_texttoprint setFont:font];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{   
    if ([string length] == 0)
    {
        return YES;
    }
    
    if (([string characterAtIndex:0] >= '0') && ([string characterAtIndex:0] <= '9'))
    {
        return YES;
    }
    
    if ([string characterAtIndex:0] == '.')
    {
        NSRange range = [uitextfield_textsize.text rangeOfString:@"."];
        if (range.length == 0)
        {
            return YES;
        }
    }
    
    if ([string characterAtIndex:0] == '\n')
    {
        [uitextfield_textsize resignFirstResponder];
        [uiscrollview_main setFrame:CGRectMake(0, 0, 320, 460)];
        [uiscrollview_main setScrollEnabled:FALSE];
        return YES;
    }
    
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [uiscrollview_main setFrame:CGRectMake(0, 0, 320, 240)];
    [uiscrollview_main setScrollEnabled:TRUE];
}

- (IBAction)backRasterPrinting
{
    [self dismissModalViewControllerAnimated:true];
}

- (IBAction)printRasterText
{
    NSString *textToPrint = @"   Tim's Bar and Grill\r\n"
                             "  1212 W. State Street\r\n"
                             "    Chicago, IL 60606\r\n\n"
                             " ------------------------\n\n"
                             "   You recieved 7 beans! \n\n\n\n\n\n"
                             "      --   X43254 -- \n"
                             " ------------------------\n\n"
                             "   You may claim your code \n"
                             "     at www.gotbeans.com \n";
    
    
    NSString *portName = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    
    int width = 576;
    
    if ([portSettings compare:@"mini" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
    }
    else
    {
        switch ([pickerpopup_printerSize getSelectedIndex])
        {
            default : width = 576; break;
            case 1  : width = 832; break;
        }
    }

    
    NSString *fontName = @"Courier";
    
    double fontSize = 12.0;
    
    //  fontSize *= multiple;
    fontSize *= 2;
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    CGSize size = CGSizeMake(width, 10000);
    CGSize messuredSize = [textToPrint sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		if ([[UIScreen mainScreen] scale] == 2.0) {
			UIGraphicsBeginImageContextWithOptions(messuredSize, NO, 1.0);
		} else {
			UIGraphicsBeginImageContext(messuredSize);
		}
	} else {
		UIGraphicsBeginImageContext(messuredSize);
	}
	     
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor whiteColor];
    [color set];
    
    CGRect rect = CGRectMake(0, 0, messuredSize.width, messuredSize.height);
    CGContextFillRect(ctr, rect);
    
    color = [UIColor blackColor];
    [color set];
    UIImage *header = [UIImage imageNamed:@"gb_header"];
    [header drawInRect:CGRectMake(62, 10, 260, 113)];
    
    UIImage *footer = [UIImage imageNamed:@"enter"];
    [footer drawInRect:CGRectMake(98, 295, 195, 60)];
    
    int num_of_beans = 7;
    int num1 = 2;
    int num2 = 5;
    int num3 = 4;
    int num4 = 1;
    int num5 = 2;
    
    [[NSString stringWithFormat:@"%d",num_of_beans] drawInRect:CGRectMake(165, 79, 7, 7) withFont:[UIFont fontWithName:@"arial" size:18] lineBreakMode:UILineBreakModeWordWrap];
    [@"X" drawInRect:CGRectMake(147, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];
    [[NSString stringWithFormat:@"%d",num1] drawInRect:CGRectMake(164, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];
    [[NSString stringWithFormat:@"%d",num2] drawInRect:CGRectMake(180, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];
    [[NSString stringWithFormat:@"%d",num3] drawInRect:CGRectMake(196, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];
    [[NSString stringWithFormat:@"%d",num4] drawInRect:CGRectMake(212, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];
    [[NSString stringWithFormat:@"%d",num5] drawInRect:CGRectMake(228, 274, 14, 16) withFont:[UIFont fontWithName:@"arial" size:16] lineBreakMode:UILineBreakModeWordWrap];

    UIImage *bean = [UIImage imageNamed:@"bean"];

    [bean drawInRect:CGRectMake(149, 150, 36, 43)];
    [bean drawInRect:CGRectMake(99, 150, 36, 43)];
    [bean drawInRect:CGRectMake(249, 150, 36, 43)];
    [bean drawInRect:CGRectMake(199, 150, 36, 43)];
    
    [bean drawInRect:CGRectMake(122, 205, 36, 43)];
    [bean drawInRect:CGRectMake(172, 205, 36, 43)];
    [bean drawInRect:CGRectMake(222, 205, 36, 43)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGRect rectangle = CGRectMake(65,130,256,135);
    
    CGContextAddRect(context, rectangle);
    
    CGContextStrokePath(context);
    
//    [textToPrint drawInRect:rect withFont:font lineBreakMode:UILineBreakModeWordWrap];
    
    
    UIImage *imageToPrint = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSLog(@"portName: %@", portName);
    NSLog(@"portSettings: %@", portSettings);
    
    portSettings = @"mini";
    
    if ([portSettings compare:@"mini" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        [MiniPrinterFunctions PrintBitmapWithPortName:portName portSettings:portSettings imageSource:imageToPrint printerWidth:width];
    }
    else
    {
        [PrinterFunctions PrintImageWithPortname:portName portSettings:portSettings imageToPrint:imageToPrint maxWidth:width];
    }
//    UIImageView *iv = [[UIImageView alloc] initWithImage:imageToPrint];
//    iv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    [self.view addSubview:iv];
    
}

- (UIFont*)getSelectedFont:(int)multiple;
{
    int fontIndex = [pickerpopup_fontStyle getSelectedIndex];
    NSString *fontName = [array_fontStyle objectAtIndex:fontIndex];
    
    double fontSize = [uitextfield_textsize.text floatValue];
    fontSize *= multiple;
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    return font;
}
@end
