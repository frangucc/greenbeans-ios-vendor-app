//
//  MiniPrinterFunctions.m
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import "MiniPrinterFunctions.h"
#import "StarBitmap.h"
#import <sys/time.h>


@implementation MiniPrinterFunctions


/**
 * This function prints pdf417 bar codes for portable printers
 * portName - Port name to use for communication. This should be (TCP:<IPAddress>)
 * portSettings - Should be mini, the port settings mini is used for portable printers
 * width - This is the width of the pdf417 to print.  This is the same width used by the 1d bar codes.  See pg 34 of the command manual.
 * columnNumber - This is the column number of the pdf417.  The value of this should be between 1 and 30.
 * securityLevel - The represents how well the bar code can be restored of damaged.  The value should be between 0 and 8.
 * ratio - The value representing the horizontal and vertical ratio of the bar code.  This value should between 2 and 5.
 * barcodeData - The characters that will be in the bar code
 * barcodeDataSize - This is the number of characters that will be in the pdf417 code.  This is the size of the preceding parameter
 */
+ (void) PrintPDF417WithPortname:(NSString *)portName portSettings:(NSString *)portSettings width:(BarcodeWidth)width columnNumber:(unsigned char)columnNumber securityLevel:(unsigned char)securityLevel ratio:(unsigned char)ratio barcodeData:(unsigned char *)barcodeData barcodeDataSize:(unsigned char)barcodeDataSize {
    NSMutableData *commands = [[NSMutableData alloc]init];

    unsigned char initial[] = { 0x1b, 0x40 };
    [commands appendBytes:initial length:2];

    unsigned char barcodeWidthCommand[] = { 0x1d, 'w', 0x00 };
    switch (width) {
        case BarcodeWidth_125:
            barcodeWidthCommand[2] = 1;
            break;
        case BarcodeWidth_250:
            barcodeWidthCommand[2] = 2;
            break;
        case BarcodeWidth_375:
            barcodeWidthCommand[2] = 3;
            break;
        case BarcodeWidth_500:
            barcodeWidthCommand[2] = 4;
            break;
        case BarcodeWidth_625:
            barcodeWidthCommand[2] = 5;
            break;
        case BarcodeWidth_750:
            barcodeWidthCommand[2] = 6;
            break;
        case BarcodeWidth_875:
            barcodeWidthCommand[2] = 7;
            break;
        case BarcodeWidth_1_0:
            barcodeWidthCommand[2] = 8;
            break;
    } /* switch */
    [commands appendBytes:barcodeWidthCommand length:3];

    unsigned char setBarcodePDF[] = { 0x1d, 0x5a, 0x00 };
    [commands appendBytes:setBarcodePDF length:3];

    unsigned char *barcodeCommand = (unsigned char *)malloc(7 + barcodeDataSize);
    barcodeCommand[0] = 0x1b;
    barcodeCommand[1] = 0x5a;
    barcodeCommand[2] = columnNumber;
    barcodeCommand[3] = securityLevel;
    barcodeCommand[4] = ratio;
    barcodeCommand[5] = barcodeDataSize % 256;
    barcodeCommand[6] = barcodeDataSize / 256;
    memcpy(barcodeCommand + 7, barcodeData, barcodeDataSize);


    [commands appendBytes:barcodeCommand length:7 + barcodeDataSize];
    free(barcodeCommand);

    unsigned char LF4[] = { 10, 10, 10, 10 };
    [commands appendBytes:LF4 length:4];

    unsigned char *commandsToSendToPrinter = (unsigned char *)malloc([commands length]);
    [commands getBytes:commandsToSendToPrinter];
    unsigned int commandSize = [commands length];

    SMPort *starPort = NULL;
    @try
    {
        starPort = [SMPort getPort:portName:portSettings:10000];
        if (starPort == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to Open Port"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            return;
        }

        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;

        int totalAmountWritten = 0;
        while (totalAmountWritten < commandSize) {
            int remaining = commandSize - totalAmountWritten;

            int blockSize = (remaining > 1024) ? 1024 : remaining;

            int amountWritten = [starPort writePort:commandsToSendToPrinter:totalAmountWritten:blockSize];
            totalAmountWritten += amountWritten;

            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec) {
                break;
            }
        }

        if (totalAmountWritten < commandSize) {
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
    @finally
    {
        [SMPort releasePort:starPort];
    }

    free(commandsToSendToPrinter);

} /* PrintPDF417WithPortname */


/**
 * This function is used to print a uiimage directly to a portable printer.
 * portName - Port name to use for communication. This should be (TCP:<IPAddress>)
 * portSettings - Should be mini, the port settings mini is used for portable printers
 * source - the uiimage to convert to star printer data for portable printers
 * maxWidth - the maximum with the image to print.  This is usually the page with of the printer.  If the image exceeds the maximum width then the image is scaled down.  The ratio is maintained.
 */
+ (BOOL) PrintBitmapWithPortName:(NSString *)portName portSettings:(NSString *)portSettings imageSource:(UIImage *)source printerWidth:(int)maxWidth {

    StarBitmap *starbitmap = [[StarBitmap alloc] initWithUIImage:source:maxWidth:false];

    SMPort *starPort = nil;
    @try
    {
        starPort = [SMPort getPort:portName:portSettings:10000];
        if (starPort == nil) {
            return NO;
        }

        NSData *commands = [starbitmap getImageEscPosDataForPrinting];
        unsigned char *commandsToSendToPrinter = (unsigned char *)malloc([commands length]);
        [commands getBytes:commandsToSendToPrinter];
        int commandSize = [commands length];

        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;

        int totalAmountWritten = 0;
        while (totalAmountWritten < commandSize) {
            int remaining = commandSize - totalAmountWritten;

            int blockSize = (remaining > 1024) ? 1024 : remaining;

            int amountWritten = [starPort writePort:commandsToSendToPrinter:totalAmountWritten:blockSize];
            totalAmountWritten += amountWritten;

            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec) {
                break;
            }

            usleep(200 * 1000);
        }

        if (totalAmountWritten < commandSize) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                            message:@"Write port timed out"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }

        free(commandsToSendToPrinter);
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
    @finally
    {
        [SMPort releasePort:starPort];
    }
    
    return YES;

} /* PrintBitmapWithPortName */


/**
 * This function prints raw text to the portable printer.  It show how the text can be formated.  For example changing its size.
 * portName - Port name to use for communication. This should be (TCP:<IPAddress>)
 * portSettings - Should be mini, the port settings mini is used for portable printers
 * underline - boolean variable that Tells the printer if should underline the text
 * emphasized - boolean variable that tells the printer if it should emphasize the printed text.  This is sort of like bold but not as dark, but darker then regular characters.
 * upsideDown - boolean variable that tells the printer if the text should be printed upside-down
 * invertColor - boolean variable that tells the printer if it should invert the text its printing.  All White space will become black and the characters will be left white
 * heightExpansion - This integer tells the printer what multiple the character height should be, this should be from 0 to 7 representing multiples from 1 to 8
 * widthExpansion - This integer tell the printer what multiple the character width should be, this should be from 0 to 7 representing multiples from 1 to 8
 * eftMargin - The left margin for text on the portable printer.  This number should be be from 0 to 65536 but it should never get that high or the text can be pushed off the page.
 * alignment - The alignment of the text. The printers support left, right, and center justification
 * textToPrint - The text to send to the printer
 * textToPrintSize - The amount of text to send to the printer.  This should be the size of the preceding parameter
 */
+ (void) PrintText:(NSString *)portName PortSettings:(NSString *)portSettings Underline:(bool)underline Emphasized:(bool)emphasized Upsideddown:(bool)upsideddown InvertColor:(bool)invertColor HeightExpansion:(unsigned char)heightExpansion WidthExpansion:(unsigned char)widthExpansion LeftMargin:(int)leftMargin Alignment:(Alignment)alignment TextToPrint:(unsigned char *)textToPrint TextToPrintSize:(unsigned int)textToPrintSize;
{
    NSMutableData *commands = [[NSMutableData alloc]init];

    unsigned char initial[] = { 0x1b, 0x40 };
    [commands appendBytes:initial length:2];

    unsigned char underlineCommand[] = { 0x1b, 0x2d, 0x00 };
    if (underline) {
        underlineCommand[2] = 49;
    } else {
        underlineCommand[2] = 48;
    }
    [commands appendBytes:underlineCommand length:3];

    unsigned char emphasizedCommand[] = { 0x1b, 0x45, 0x00 };
    if (emphasized) {
        emphasizedCommand[2] = 1;
    } else {
        emphasizedCommand[2] = 0;
    }
    [commands appendBytes:emphasizedCommand length:3];

    unsigned char upsidedownCommand[] = { 0x1b, 0x7b, 0x00 };
    if (upsideddown) {
        upsidedownCommand[2] = 1;
    } else {
        upsidedownCommand[2] = 0;
    }
    [commands appendBytes:upsidedownCommand length:3];

    unsigned char invertColorCommand[] = { 0x1d, 0x42, 0x00 };
    if (invertColor) {
        invertColorCommand[2] = 1;
    } else {
        invertColorCommand[2] = 0;
    }
    [commands appendBytes:invertColorCommand length:3];

    unsigned char characterSizeCommand[] = { 0x1d, 0x21, 0x00 };
    characterSizeCommand[2] = heightExpansion | (widthExpansion << 4);
    [commands appendBytes:characterSizeCommand length:3];

    unsigned char leftMarginCommand[] = { 0x1d, 0x4c, 0x00, 0x00 };
    leftMarginCommand[2] = leftMargin % 256;
    leftMarginCommand[3] = leftMargin / 256;
    [commands appendBytes:leftMarginCommand length:4];

    unsigned char justificationCommand[] = { 0x1b, 0x61, 0x00 };
    switch (alignment) {
        case Left:
            justificationCommand[2] = 48;
            break;
        case Center:
            justificationCommand[2] = 49;
            break;
        case Right:
            justificationCommand[2] = 50;
            break;
    } /* switch */
    [commands appendBytes:justificationCommand length:3];

    [commands appendBytes:textToPrint length:textToPrintSize];

    unsigned char LF = 10;
    [commands appendBytes:&LF length:1];
    [commands appendBytes:&LF length:1];

    unsigned char *commandsToSendToPrinter = (unsigned char *)malloc([commands length]);
    [commands getBytes:commandsToSendToPrinter];
    int commandSize = [commands length];

    SMPort *starPort = NULL;
    @try
    {
        starPort = [SMPort getPort:portName:portSettings:10000];
        if (starPort == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to Open Port"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            return;
        }

        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;

        int totalAmountWritten = 0;
        while (totalAmountWritten < commandSize) {
            int remaining = commandSize - totalAmountWritten;

            int blockSize = (remaining > 1024) ? 1024 : remaining;

            int amountWritten = [starPort writePort:commandsToSendToPrinter:totalAmountWritten:blockSize];
            totalAmountWritten += amountWritten;

            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec) {
                break;
            }
        }

        if (totalAmountWritten < commandSize) {
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
    @finally
    {
        [SMPort releasePort:starPort];
    }

    free(commandsToSendToPrinter);

}

/**
 * This function shows how to read the MCR data(credit card) of a portable printer.
 * The function first puts the printer into MCR read mode, then asks the user to swipe a credit card
 * This object then acts as a delegate for the uialertview.  See alert veiw responce for seeing how to read the mcr data one a card has been swiped.
 * The user can cancel the MCR mode or the read the printer
 * portName - Port name to use for communication. This should be (TCP:<IPAddress>)
 * portSettings - Should be mini, the port settings mini is used for portable printers
 */
- (void) MCRStartWithPortName:(NSString *)portName portSettings:(NSString *)portSettings {
    starPort = NULL;
    @try
    {
        starPort = [SMPort getPort:portName:portSettings:10000];
        if (starPort == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to Open Port"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            return;
        }

        struct timeval endTime;
        gettimeofday(&endTime, NULL);
        endTime.tv_sec += 30;

        unsigned char startMCRCommand[] = { 0x1b, 0x4d, 0x45 };
        int commandSize = 3;

        int totalAmountWritten = 0;
        while (totalAmountWritten < 3) {
            int remaining = commandSize - totalAmountWritten;

            int blockSize = (remaining > 1024) ? 1024 : remaining;

            int amountWritten = [starPort writePort:startMCRCommand:totalAmountWritten:blockSize];
            totalAmountWritten += amountWritten;

            struct timeval now;
            gettimeofday(&now, NULL);
            if (now.tv_sec > endTime.tv_sec) {
                break;
            }
        }

        if (totalAmountWritten < commandSize) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                            message:@"Write port timed out"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

            [SMPort releasePort:starPort];
            return;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MCR"
                                                            message:@"Swipe a credit card"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
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
} /* MCRStartWithPortName */


/**
   This is the reponce function for reading micr data.
   This will eather cancel the mcr function or read the data
 */
- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        unsigned char endMcrComman = 4;
        int dataWritten = [starPort writePort:&endMcrComman:0:1];
        if (dataWritten == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printer Error"
                                                            message:@"Write port timed out"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
    } else {
        unsigned char *dataToRead = (unsigned char *)malloc(100);
        memset(dataToRead, 0, 100);
        @try
        {
            [starPort readPort:dataToRead:0:100];
            NSString *MCRData = [NSString stringWithFormat:@"%s", dataToRead];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card Data"
                                                            message:MCRData
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
        @catch (PortException *exception)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card Data"
                                                            message:@"Failed to read port"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }

        free(dataToRead);
    }

    [SMPort releasePort:starPort];
} /* alertView */


@end
