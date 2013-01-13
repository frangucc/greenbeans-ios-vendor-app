//
//  SearchPrinterViewController.m
//  IOS_SDK
//
//  Created by satsuki on 12/08/17.
//
//

#import "SearchPrinterViewController.h"
#import "StarIO/SMPort.h"

@interface SearchPrinterViewController ()

@end

@implementation SearchPrinterViewController
@synthesize lastSelectedPortName;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
   }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    uitableview_printerList.dataSource = self;
    uitableview_printerList.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    lastSelectedPortName = @"";
    
    printerArray = [SMPort searchPrinter];
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return printerArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row < printerArray.count) {
        PortInfo *port = [printerArray objectAtIndex:indexPath.row];
        cell.textLabel.text = port.modelName;
        NSString *detailText = [NSString stringWithFormat:@"%@(%@)", port.portName, port.macAddress];
        cell.detailTextLabel.text = detailText;
    }
    else if (indexPath.row == printerArray.count) {
        cell.textLabel.text = @"Back";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < printerArray.count) {
        PortInfo *portInfo = [printerArray objectAtIndex:indexPath.row];
        lastSelectedPortName = portInfo.portName;
    }

    [self.delegate returnSelectedCellText];
}

@end
