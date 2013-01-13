//
//  PrintBeansViewController.m
//  IOS_SDK
//
//  Created by Burchfield, Neil on 1/11/13.
//
//

#import "PrintBeansViewController.h"
#import "PrinterFunctions.h"
#import "AppDelegate.h"

@implementation PrintBeansViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)push_beans_button:(id)sender {

    NSLog(@"Print Green Beans");
    NSString *portName     = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    
    [PrinterFunctions PrintSampleReceipt3InchWithPortname:portName portSettings:portSettings];
    
    
}

- (IBAction)exit_modal:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];

    
    
}

@end
