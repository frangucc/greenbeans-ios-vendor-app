//
//  IOS_SDKViewControllerMobile.m
//  IOS_SDK
//
//  Created by Tzvi on 8/2/11.
//  Copyright 2011 STAR MICRONICS CO., LTD. All rights reserved.
//

#import "AppDelegate.h"

#import "IOS_SDKViewControllerMobile.h"
#import "StarIO/SMPort.h"
#import "PrinterFunctions.h"
#import "CheckConnectionViewController.h"
#import "rasterPrinting.h"
#import "StandardHelp.h"
#import "PrintBeansViewController.h"

@implementation IOS_SDKViewControllerMobile

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (IBAction)pushButtonSearch:(id)sender {
    searchView = [[SearchPrinterViewController alloc] initWithNibName:@"SearchPrinterViewController" bundle:nil];
    
    searchView.delegate = self;
    [self presentModalViewController:searchView animated:YES];
}

- (IBAction)pushButtonBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                
        arrayFunction = [[NSMutableArray alloc] init];
        [arrayFunction addObject:@"Get Status"];
        [arrayFunction addObject:@"Check Connection"];
        [arrayFunction addObject:@"Sample Receipt"];
        [arrayFunction addObject:@"JP Sample Receipt"];
        [arrayFunction addObject:@"Begin/End Checked Block"];
        [arrayFunction addObject:@"1D Barcodes"];
        [arrayFunction addObject:@"2D Barcodes"];
        [arrayFunction addObject:@"Text Formatting"];
        [arrayFunction addObject:@"JP Kanji Text Formatting"];
        [arrayFunction addObject:@"Raster Graphics Text Printing"];
        [arrayFunction addObject:@"MSR"];
    }
    return self;
}

+ (void)setPortName:(NSString *)m_portName
{
    [AppDelegate setPortName:m_portName];
}

+ (void)setPortSettings:(NSString *)m_portSettings
{
    [AppDelegate setPortSettings:m_portSettings];
}

- (void)SetPortInfo
{
    NSString *localPortName = [NSString stringWithString: uitextfield_portname.text];
    [IOS_SDKViewControllerMobile setPortName:localPortName];
    
    NSString *localPortSettings = @"mini";

    [IOS_SDKViewControllerMobile setPortSettings:localPortSettings];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [uitextfield_portname setDelegate:self];
    
    miniPrinterFunctions = [[MiniPrinterFunctions alloc]init];
    
    tableviewFunction.dataSource = self;
    tableviewFunction.delegate   = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayFunction count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    int index = indexPath.row;
    [cell.textLabel setText: [arrayFunction objectAtIndex:index]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectIndex = indexPath.row;
    
    UIActionSheet *actionsheetSampleReceipt = nil;
    
    [uitextfield_portname resignFirstResponder];
    
    [self SetPortInfo];
    
    NSString *portName = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    
    switch (selectIndex)
    {
        case 0:
            [PrinterFunctions CheckStatusWithPortname:portName portSettings:portSettings];
            break;
            
        case 1:
        {
            CheckConnectionViewController *viewController = [[CheckConnectionViewController alloc] initWithNibName:@"CheckConnectionViewController" bundle:[NSBundle mainBundle]];
            
            [self.navigationController pushViewController:viewController animated:YES];
            [self presentModalViewController:viewController animated:YES];
            
            
            break;
        }
        
        case 2:
        {
            
            PrintBeansViewController *pbc = [[PrintBeansViewController alloc] initWithNibName:@"PrintBeansViewController" bundle:[NSBundle mainBundle]];
            
            [self presentModalViewController:pbc animated:YES];
            
            break;
        }
        case 3:
            actionsheetSampleReceipt = [[UIActionSheet alloc] initWithTitle:@"Printer Width" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"2 inch", @"3 inch"/*, @"4 inch"*/, nil];
            
            [actionsheetSampleReceipt showInView:self.view];

            break;
            
        case 4:
            [MiniPrinterFunctions PrintCheckedBlockWithPortName:portName portSettings:portSettings widthInch:2];
            
            break;
            
        case 5:
        {
                       break;
        }
            
        case 6:
        {
                        
            break;
        }
            
        case 7:
        {
                        break;
        }
            
        case 8:
        {

            
            break;
        }
            
        case 9:
        {
            rasterPrinting *rasterPrintingVar = [[rasterPrinting alloc] initWithNibName:@"rasterPrinting" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:rasterPrintingVar animated:YES];
            [self presentModalViewController:rasterPrintingVar animated:YES];
            
            break;
        }
            
        case 10:
            [miniPrinterFunctions MCRStartWithPortName:portName portSettings:portSettings];
            
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [uitextfield_portname resignFirstResponder];
    
    [self SetPortInfo];
    
    NSString *portName = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    
    switch (buttonIndex)
    {
        case 0:
            switch (selectIndex)
            {
                case 2:
                    [MiniPrinterFunctions PrintSampleReceiptWithPortname:portName
                                                            portSettings:portSettings
                                                               widthInch:2];
                    break;
                    
                case 3:
                    [MiniPrinterFunctions PrintKanjiSampleReceiptWithPortName:portName
                                                                 portSettings:portSettings
                                                                    widthInch:2];
                    break;
            }
            
            break;
            
        case 1:
            switch (selectIndex)
            {
                case 2:
                    [MiniPrinterFunctions PrintSampleReceiptWithPortname:portName
                                                            portSettings:portSettings
                                                               widthInch:3];
                    break;
                    
                case 3:
                    [MiniPrinterFunctions PrintKanjiSampleReceiptWithPortName:portName
                                                                 portSettings:portSettings
                                                                    widthInch:3];
                    break;
            }
            
            break;
        /*
        case 2:
            switch (selectIndex)
            {
                case 2:
                    [MiniPrinterFunctions PrintSampleReceiptWithPortname:portName
                                                            portSettings:portSettings
                                                               widthInch:4];
                    break;
                    
                case 3:
                    [MiniPrinterFunctions PrintKanjiSampleReceiptWithPortName:portName
                                                                 portSettings:portSettings
                                                                    widthInch:4];
                    break;
            }
            
            break;
         */
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)DismissActionSheet:(id)unusedID
{
    [tableviewFunction reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"] == true)
    {
        [uitextfield_portname resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)showHelp
{

}

- (void)returnSelectedCellText
{
    NSString *selectedPortName = [searchView lastSelectedPortName];
    
    if ((selectedPortName != nil) && (selectedPortName != @""))
    {
        uitextfield_portname.text = selectedPortName;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
