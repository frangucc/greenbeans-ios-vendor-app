//
//  SettingsViewController.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/17/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self drawRootToolbar];
    [self drawSettingsTableview];
    [self alloc];
} /* viewDidLoad */

- (void) alloc
{
    avc = [[AboutViewController alloc] init]; viewCount = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [settingsTableView reloadData];
}

- (BOOL) drawSettingsTableview
{
    settingsTableView = [[UITableView alloc] initWithFrame:
                         CGRectMake(0, 35, self.view.bounds.size.width, self.view.bounds.size.height - 35*2/*Toolbar*/ - self.tabBarController.tabBar.bounds.size.height - 20/*Padding*/) style:UITableViewStyleGrouped];
    [settingsTableView setBackgroundColor:[UIColor clearColor]];
    [settingsTableView setDelegate:self];
    [settingsTableView setDataSource:self];
    
    UIView *groupedBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                         settingsTableView.bounds.size.width,
                                                                         settingsTableView.bounds.size.height)];
    [groupedBackground setBackgroundColor:[UIColor clearColor]];
    
    [settingsTableView setBackgroundView:groupedBackground];
    [settingsTableView setBackgroundColor:groupedBackground.backgroundColor];
    
    UIView *windowFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImage *targetImage = [UIImage imageNamed:@"background-hatched-texture"];
    
    UIGraphicsBeginImageContextWithOptions(windowFrame.frame.size, NO, 0.f);
    [targetImage drawInRect:CGRectMake(0.f, 0.f, windowFrame.frame.size.width, windowFrame.frame.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
    [self.view addSubview:settingsTableView];
    
    return (settingsTableView != nil);
}

/*
   NumberOfRowsInSection
   --------
   Purpose:        Tableview Delegate
   Parameters:     none
   Returns:        none
   Notes:          Number of Tableview Rows
   Author:         Neil Burchfield
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 2;
    else if (section == 1)
        return 1;
    else if (section == 2)
        return 1;
    else if (section == 3)
        return 1;
    else
        return 0;
} /* tableView */


/*
   CellForRowAtIndexPath
   --------
   Purpose:        Tableview Cell Delegate
   Parameters:     none
   Returns:        none
   Notes:          View for Cell
   Author:         Neil Burchfield
 */
- (UITableViewCell *) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%ld_%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell *cell = [settingsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell.contentView removeFromSuperview];
    cell = nil;
    if (cell == nil) {
        if ( [indexPath section] == 0 ) {
            if ( [indexPath row] == 0 )
                cell = [self getCellContentViewForLogin:CellIdentifier];
            else
                cell = [self getCellContentViewForPassword:CellIdentifier];
        } else if ( [indexPath section] == 1 ) {
            if ( [indexPath row] == 0 )
                cell = [self getCellContentViewForUISwitch:CellIdentifier];
        } else if ( [indexPath section] == 2 ) {
            if ( [indexPath row] == 0 ) {
                cell = [self getCellContentViewForSearchingPrinter:CellIdentifier];
                UILabel *mainContentValueLabel = (UILabel *)[cell viewWithTag:3];
                NSString *printer = [AppDelegate getPortName];
                if ( !printer ) {
                    [mainContentValueLabel setText:@"none"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                } else {
                    [mainContentValueLabel setText:printer];
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        } else {
            cell = [self getCellContentView:CellIdentifier];
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
            UILabel *mainContentLabel = (UILabel *)[cell viewWithTag:1];
            UILabel *mainContentValueLabel = (UILabel *)[cell viewWithTag:2];
            mainContentLabel.text = @"Version";
            mainContentValueLabel.text = [NSString stringWithFormat:@"0.%ld.%ld", (long)[components month], (long)[components day]];
        }
    }

    return cell;
} /* tableView */


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ( [indexPath section] == 2 ) {
        if ( [indexPath row] == 0 ) {
                [self pushSearchPrinterViewController];
        }
    }

} /* tableView */


- (void) pushSearchPrinterViewController {
    SearchPrinterViewController *searchPrinterViewController = [[SearchPrinterViewController alloc] init];
    [self.navigationController pushViewController:searchPrinterViewController animated:YES];
} /* pushSearchPrinterViewController */


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
} /* textFieldShouldReturn */


// RootViewController.m
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {

    CGRect CellFrame = CGRectMake(0, 0, 300, 60);

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setFrame:CellFrame];

    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 140, 20)];
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.tag = 1;
    [cell.contentView addSubview:mainCellTitle];

    UILabel *cellTitleValue = [[UILabel alloc] initWithFrame:CGRectMake(165, 12, 125, 20)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [cellTitleValue setFrame:CGRectMake(300, 12, 325, 20)]; }
    cellTitleValue.textColor = [UIColor colorWithRed:56.0f / 255.0f green:84.0f / 255.0f blue:135.0f / 255.0f alpha:1.0f];
    cellTitleValue.backgroundColor = [UIColor clearColor];
    cellTitleValue.textAlignment = NSTextAlignmentRight;
    cellTitleValue.tag = 2;
    cellTitleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [cell.contentView addSubview:cellTitleValue];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
} /* getCellContentView */


// RootViewController.m
- (UITableViewCell *) getCellContentViewForLogin:(NSString *)cellIdentifier {

    CGRect CellFrame = CGRectMake(0, 0, 300, 60);

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setFrame:CellFrame];

    cell.accessoryType = UITableViewCellAccessoryNone;

    UITextField *loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
    loginTextField.adjustsFontSizeToFitWidth = YES;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [loginTextField setFrame:CGRectMake(180, 12, 185, 30)]; }
    loginTextField.textColor = [UIColor blackColor];
    loginTextField.placeholder = @"example@gmail.com";
    loginTextField.keyboardType = UIKeyboardTypeEmailAddress;
    loginTextField.returnKeyType = UIReturnKeyNext;
    loginTextField.backgroundColor = [UIColor clearColor];
    loginTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    loginTextField.textAlignment = NSTextAlignmentLeft;
    if ([AppDelegate getRememberMeState])
        loginTextField.text = [AppDelegate getMerchantEmail];
    else
        loginTextField.text = @"";
    loginTextField.tag = 0;
    loginTextField.delegate = self;

    loginTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
    [loginTextField setEnabled:YES];

    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 140, 20)];
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.text = @"Login";
    [cell.contentView addSubview:mainCellTitle];

    [cell addSubview:loginTextField];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
} /* getCellContentViewForLogin */


// RootViewController.m
- (UITableViewCell *) getCellContentViewForPassword:(NSString *)cellIdentifier {

    CGRect CellFrame = CGRectMake(0, 0, 300, 60);

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setFrame:CellFrame];

    cell.accessoryType = UITableViewCellAccessoryNone;

    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [passwordTextField setFrame:CGRectMake(180, 12, 185, 30)]; }
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.placeholder = @"Required";
    passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.tag = 0;
    if ([AppDelegate getRememberMeState])
        passwordTextField.text = [AppDelegate getMerchantPassword];
    else
        passwordTextField.text = @"";
    passwordTextField.delegate = self;

    passwordTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
    [passwordTextField setEnabled:YES];

    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 140, 20)];
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.text = @"Password";
    [cell.contentView addSubview:mainCellTitle];

    [cell addSubview:passwordTextField];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
} /* getCellContentViewForPassword */


// RootViewController.m
- (UITableViewCell *) getCellContentViewForUISwitch:(NSString *)cellIdentifier {

    CGRect CellFrame = CGRectMake(0, 0, 300, 60);

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setFrame:CellFrame];

    cell.accessoryType = UITableViewCellAccessoryNone;

    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchView setOn:NO animated:NO];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];

    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 140, 20)];
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.text = @"Cache Tokens";
    [cell.contentView addSubview:mainCellTitle];

    cell.accessoryView = switchView;

    [cell addSubview:switchView];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
} /* getCellContentViewForUISwitch */


- (void) switchChanged:(id)sender {
    UISwitch *switchControl = sender;
    NSLog(@"Switch State: %@", switchControl.on ? @"ON" : @"OFF");
} /* switchChanged */


// RootViewController.m
- (UITableViewCell *) getCellContentViewForSearchingPrinter:(NSString *)cellIdentifier {

    CGRect CellFrame = CGRectMake(0, 0, 300, 60);

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setFrame:CellFrame];

    cell.accessoryType = UITableViewCellAccessoryNone;

    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 140, 20)];
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.text = @"Current Printer";
    [cell.contentView addSubview:mainCellTitle];

    UILabel *cellTitleValue = [[UILabel alloc] initWithFrame:CGRectMake(148, 12, 125, 20)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [cellTitleValue setFrame:CGRectMake(300, 12, 325, 20)]; }
    cellTitleValue.textColor = [UIColor colorWithRed:56.0f / 255.0f green:84.0f / 255.0f blue:135.0f / 255.0f alpha:1.0f];
    cellTitleValue.backgroundColor = [UIColor clearColor];
    cellTitleValue.textAlignment = NSTextAlignmentRight;
    cellTitleValue.tag = 3;
    cellTitleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [cell.contentView addSubview:cellTitleValue];

    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
} /* getCellContentViewForSearchingPrinter */


/* Display Root Toolbar at Bottom of View */
- (BOOL) drawRootToolbar {
    /*    Remove previously instantiated toolbar to prevent an overabundance of UIToolbars */
    SVSegmentedControl * segmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:
                                            [NSArray arrayWithObjects:@"Application", @"About us", nil]];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
    segmentedControl.crossFadeLabelsOnDrag = YES;
    segmentedControl.thumb.tintColor = [UIColor colorWithRed:107.0f / 255.0f green:216.0f / 255.0f blue:77.0f / 255.0f alpha:1.0f]; 
    segmentedControl.selectedIndex = 0;
    [self.view addSubview:segmentedControl];

    return (segmentedControl != nil);
} /* drawRootToolbar */


#pragma mark SPSegmentedControl

- (void) segmentedControlChangedValue:(SVSegmentedControl *)segmentedControl {
//    NSLog(@"segmentedControl %i did select index %i (via UIControl method)",
//          cntl.tag, cntl.selectedIndex);
    
    if (segmentedControl.selectedIndex == 1)
    {
        for ( ; viewCount == 0; viewCount++)
        {
            NSLog(@"Adding Subview");
            [self.view addSubview:avc.view];
        }
        
        [avc.view setHidden:NO];
    }
    else if (segmentedControl.selectedIndex == 0)
    {
        [avc.view setHidden:YES];
    }

} /* segmentedControlChangedValue */


/*
   NumberOfSectionsInTableView
   --------
   Purpose:        Tableview Sections Delegate
   Parameters:     none
   Returns:        none
   Notes:          Number of sections
   Author:         Neil Burchfield
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
} /* numberOfSectionsInTableView */


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"";

} /* tableView */


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 35.0f;
} /* tableView */


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, 280, 20)];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
    [headerLabel setTextColor:[UIColor colorWithRed:132.0f / 255.0f green:189.0f / 255.0f blue:107.0f / 255.0f alpha:1.0f]];
    [headerLabel setShadowColor:[UIColor whiteColor]];
    [headerLabel setShadowOffset:CGSizeMake(0, -1)];

    if (section == 0)
        [headerLabel setText:@"GreenBeans.com"];
    else if (section == 1)
        [headerLabel setText:@"Offline"];
    else if (section == 2)
        [headerLabel setText:@"Printing"];
    else if (section == 3)
        [headerLabel setText:@"App Info"];

    [headerView addSubview:headerLabel];

    return headerView;
} /* tableView */


@end
