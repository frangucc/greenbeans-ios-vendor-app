//
// BeanCountViewController.h
// GreenBeansMerch
//
// Created by Burchfield, Neil on 1/12/13.
// Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "SearchPrinterViewController.h"

@implementation SearchPrinterViewController
@synthesize lastSelectedPortName;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = NO;
    
    lastSelectedPortName = @"";

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.detailsLabelText = @"Searching Printers...";
    HUD.square = YES;
    
    [HUD showWhileExecuting:@selector(fillArray) onTarget:self withObject:nil animated:YES];
    
    [self addCustomBackButton];
    
} /* viewDidLoad */

- (void) fillArray
{
    printerArray = [SMPort searchPrinter];
    [self.tableView reloadData];
    
    if (printerArray.count == 0)
    {
        blurTitle = @"No Printers";
        blurMessage = @"Please re-connect printer and connect again";
        [self performSelectorOnMainThread:@selector(displayBlurViewMessage) withObject:nil waitUntilDone:NO];
    }
}
- (BOOL) shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
} /* shouldAutorotate */


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
} /* numberOfSectionsInTableView */


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return printerArray.count + 1;
} /* tableView */


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row < printerArray.count) {
        PortInfo *port = [printerArray objectAtIndex:indexPath.row];
        cell.textLabel.text = port.modelName;
        
        NSString *detailText = [NSString stringWithFormat:@"%@(%@)", port.portName, port.macAddress];
        cell.detailTextLabel.text = detailText;
    } 

    return cell;
} /* tableView */


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < printerArray.count) {
        PortInfo *portInfo = [printerArray objectAtIndex:indexPath.row];
        lastSelectedPortName = portInfo.portName;
        [AppDelegate setPortName:lastSelectedPortName];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
} /* tableView */

/*
 DisplayBlurViewMessage
 --------
 Purpose:        General Blur Modal Object
 Parameters:     -- title
 -- message
 Returns:        none
 Notes:          --
 Author:         Neil Burchfield
 */
- (void) displayBlurViewMessage {
    blurModalView = [[RNBlurModalView alloc] initWithViewController:self title:blurTitle message:blurMessage];
    [blurModalView show];
} /* displayBlurViewMessage */

/*
   AddCustomBackButton
   --------
   Purpose:        Adds Custom Back Button to View
   Parameters:     animated
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) addCustomBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 53, 32);
    [backButton setImage:[UIImage imageNamed:@"back_withText"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBackButton:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
       self.navigationItem.leftBarButtonItem = backBarButtonItem; // Hide Nav Back Button Implementation

    self.navigationItem.hidesBackButton   = YES;
} /* addCustomBackButton */


/*
   PushBackButton
   --------
   Purpose:        Custom Back Button Implementation
   Parameters:     id
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) pushBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
} /* pushBackButton */


@end
