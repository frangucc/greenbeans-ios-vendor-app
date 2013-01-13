//
//  CheckConnectionViewController.m
//  IOS_SDK
//
//  Created by u3237 on 12/10/25.
//
//

#import "CheckConnectionViewController.h"
#import "StarIO/SMPort.h"
#import "AppDelegate.h"
#import "MiniPrinterFunctions.h"

@interface CheckConnectionViewController ()

@end

@implementation CheckConnectionViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [self connect];
}

- (void)connect
{
    NSString *portName = [AppDelegate getPortName];
    NSString *portSettings = [AppDelegate getPortSettings];
    
    portNameInfo.text = portName;
    
    if ([[portName uppercaseString] hasPrefix:@"BT:"] == NO) {
        message.text = @"This function is supported only on Bluetooth I/F.";
        return;
    }
    
    starPort = [[SMPort alloc] init:portName :portSettings :10000];
    if (starPort == nil) {
        enableCheckLoop = NO;
        
        statusInfo.text = @"NO";
        message.text = @"Please do pairing with the printer again and tap connect button.";
        
        connectButton.hidden = NO;
        sampleReceiptButton.hidden = YES;
        getStatusButton.hidden = YES;
        
        if (starPort != nil) {
            [SMPort releasePort:starPort];
            starPort = nil;
        }
    }
    
    enableCheckLoop = YES;
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        BOOL connected = NO;
        
        while (enableCheckLoop) {
            if (connected != starPort.connected) {
                connected = starPort.connected;
                    
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (connected == YES) {
                        statusInfo.text = @"YES";
                        message.text = @"";
                            
                        connectButton.hidden = YES;
                        sampleReceiptButton.hidden = NO;
                        getStatusButton.hidden = NO;
                    }
                    else {
                        enableCheckLoop = NO;
                        
                        statusInfo.text = @"NO";
                        message.text = @"Please do pairing with the printer again and tap connect button.";

                        connectButton.hidden = NO;
                        sampleReceiptButton.hidden = YES;
                        getStatusButton.hidden = YES;

                        if (starPort != nil) {
                            [SMPort releasePort:starPort];
                            starPort = nil;
                        }
                    }
                });
            }
            
            usleep(5000 * 1000); //Interval : 5sec
        }

        if (queue != nil) {
            queue = nil;
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtonSampleReceipt:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Paper Width" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"2 inch", @"3 inch", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self printSampleReceipt2inch];
            break;
            
        case 1:
            [self printSampleReceipt3inch];
            break;
            
        case 2:
            break;
    }
}

- (void)printSampleReceipt2inch
{
    NSData *commands = [MiniPrinterFunctions create2InchReceipt];
    
    unsigned char *commandsToSendToPrinter = (unsigned char*)malloc([commands length]);
    [commands getBytes:commandsToSendToPrinter];
    int commandSize = [commands length];

    @try
    {
        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;
        
        int totalAmountWritten = 0;
        while (totalAmountWritten < commandSize)
        {
            int remaining = commandSize - totalAmountWritten;
            
            int blockSize = (remaining > 1024) ? 1024 : remaining;
            
            int amountWritten = [starPort writePort:commandsToSendToPrinter :totalAmountWritten :blockSize];
            totalAmountWritten += amountWritten;
            
            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec)
            {
                break;
            }
        }
        
        if (totalAmountWritten < commandSize)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                            message:@"Write port timed out"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
    @catch (PortException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                        message:@"Write port timed out"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    free(commandsToSendToPrinter);
}

- (void)printSampleReceipt3inch
{
    NSData *commands = [MiniPrinterFunctions create3InchReceipt];
 
    unsigned char *commandsToSendToPrinter = (unsigned char*)malloc([commands length]);
    [commands getBytes:commandsToSendToPrinter];
    int commandSize = [commands length];

    @try
    {
        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;
        
        int totalAmountWritten = 0;
        while (totalAmountWritten < commandSize)
        {
            int remaining = commandSize - totalAmountWritten;
            
            int blockSize = (remaining > 1024) ? 1024 : remaining;
            
            int amountWritten = [starPort writePort:commandsToSendToPrinter :totalAmountWritten :blockSize];
            totalAmountWritten += amountWritten;
            
            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec)
            {
                break;
            }
        }
        
        if (totalAmountWritten < commandSize)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                            message:@"Write port timed out"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
    @catch (PortException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                        message:@"Write port timed out"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    free(commandsToSendToPrinter);
}

- (IBAction)pushButtonGetStatus:(id)sender {
    @try {
        StarPrinterStatus_2 status;
        [starPort getParsedStatus:&status :2];
    
        NSString *statusMessage = @"";
        if (status.offline == SM_TRUE)
        {
            statusMessage = @"The printer is offline";
            if (status.coverOpen == SM_TRUE)
            {
                statusMessage = [statusMessage stringByAppendingString:@"\nCover is Open"];
            }
            else if (status.receiptPaperEmpty == SM_TRUE)
            {
                statusMessage = [statusMessage stringByAppendingString:@"\nOut of Paper"];
            }
        }
        else
        {
            statusMessage = @"The Printer is online";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Status"
                                                        message:statusMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    @catch (PortException *e)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                        message:@"Get status failed"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

- (IBAction)pushButtonConnect:(id)sender {
    [self connect];
}

- (IBAction)pushButtonBack:(id)sender {
    enableCheckLoop = NO;
    
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
