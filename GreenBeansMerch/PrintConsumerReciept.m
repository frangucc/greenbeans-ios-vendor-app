/* Imports */
#import "PrintConsumerReciept.h"

/* Definitions */
#define TEST_EMAIL @"fran@greenbean.com"
#define TEST_PASS  @"password"

@implementation PrintConsumerReciept


/*
   SendOptionsToPrint
   --------
   Purpose:        Send Recieved token to Printer
   Author:         Neil Burchfield
 */
- (BOOL) sendOptionsToPrint {
    
    cachedTokens = [[CachedTokenSets alloc] init];
    
    int selectedButton = [AppDelegate getQuantity];
    int total_height = 870;
    if ((selectedButton > 4) && (selectedButton <= 8))
        total_height = 945;
    else if (selectedButton > 8)
        total_height = 1020;

    NSString *portName = [AppDelegate getPortName];

    CGSize messuredSize = CGSizeMake(389.0, total_height);
    UIGraphicsBeginImageContext(messuredSize);

    CGContextRef ctr = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor whiteColor];
    [color set];

    CGRect rect = CGRectMake(0, 0, messuredSize.width, total_height);
    CGContextFillRect(ctr, rect);

    color = [UIColor blackColor];
    [color set];
    UIImage *header = [UIImage imageNamed:@"gb_reciept_header"];
    [header drawInRect:CGRectMake(0, 0, 400, 135)];

    NSString *plural = @"Beans";
    if (selectedButton == 1)
        plural = @"Bean";

    NSString *beansCountString = [NSString stringWithFormat:@"Here's %d lucky Green %@!", selectedButton, plural];

    [beansCountString drawInRect:CGRectMake(35, 142, 340, 135) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] lineBreakMode:NSLineBreakByWordWrapping];

    int x = 0, y = 182;

    if (selectedButton == 1)
        x = 160;
    if ((selectedButton == 4) || (selectedButton == 8) || (selectedButton == 6) || (selectedButton == 7) || (selectedButton == 10))
        x = 50;
    else if (selectedButton == 2)
        x = 120;
    else if ((selectedButton == 3) || (selectedButton == 5) || (selectedButton == 9))
        x = 80;

    int line_break = 270;
    for (int count = 0; count < selectedButton; count++) {
        UIImage *bean = [UIImage imageNamed:@"bean"];
        [bean drawInRect:CGRectMake(x, y, 70, 85)];

        x += 76;

        switch (selectedButton) {
            case 5:
                if (count == 2) {
                    x = 120;
                    y += 95;
                    line_break = 365;
                }
                break;
            case 6:
                if (count == 3) {
                    x = 120;
                    y += 95;
                    line_break = 365;
                }
                break;
            case 7:
                if (count == 3) {
                    x = 86;
                    y += 95;
                    line_break = 365;
                }
                break;
            case 8:
                if (count == 3) {
                    x = 50;
                    y += 95;
                    line_break += 95;
                    line_break = 365;
                }
                break;
            case 9:
                if ((count + 1) % 3 == 0) {
                    x = 80;
                    y += 95;
                    line_break += 95;
                    line_break = 460;
                }
                break;
            case 10:
                if ((count + 1) % 4 == 0) {
                    x = 50;
                    if (count == 7)
                        x = 120;

                    y += 95;
                    line_break = 460;
                }
                break;
            default:
                break;
        } /* switch */
    }

    NSLog(@"line_break: %d", line_break);
    UIImage *dash = [UIImage imageNamed:@"line-dashed"];
    [dash drawInRect:CGRectMake(16, line_break, 365, 37)];
    NSString *tok = [cachedTokens getSet:selectedButton];

    [@"YOUR CODE" drawInRect : CGRectMake(146, line_break += 36, 340, 40) withFont :[UIFont fontWithName:@"HelveticaNeue-Medium" size:17] lineBreakMode : NSLineBreakByWordWrapping];
    [tok drawInRect:CGRectMake(20, line_break += 28, 340, 103) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:100] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];

    [dash drawInRect:CGRectMake(16, line_break += 110, 365, 37)];

    NSString *whyClaim = [NSString stringWithFormat:@"Claim them and get free entry in %@ raffles, gifts, cash prizes, and freebies.", @"Giordanio's"];
    [whyClaim drawInRect:CGRectMake(20, line_break += 44, 340, 100) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    NSString *howToClaim = [NSString stringWithFormat:@"To claim your beans, go to greenbeans.com from your mobile browser or text \"beans\" to 8372"];
    [howToClaim drawInRect:CGRectMake(20, line_break += 100, 340, 120) withFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    [dash drawInRect:CGRectMake(16, line_break += 85, 365, 37)];

    NSString *use = @"Use your beans for:";
    [use drawInRect:CGRectMake(20, line_break += 43, 340, 30) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    UIImage *bean = [UIImage imageNamed:@"bean"];

    [bean drawInRect:CGRectMake(297, line_break + 45, 13, 15)];
    NSString *prize_one = @"$250 Raffle Entry Cost = 1";
    [prize_one drawInRect:CGRectMake(20, line_break += 43, 340, 30) withFont:[UIFont fontWithName:@"HelveticaNeue" size:18] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    [bean drawInRect:CGRectMake(287, line_break + 31, 13, 15)];
    NSString *prize_two = @"$10 in FREE food = 15";
    [prize_two drawInRect:CGRectMake(20, line_break += 27, 340, 30) withFont:[UIFont fontWithName:@"HelveticaNeue" size:18] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    [bean drawInRect:CGRectMake(295, line_break + 31, 13, 15)];
    NSString *prize_three = @"$25 iTunes Gift Card = 25";
    [prize_three drawInRect:CGRectMake(20, line_break += 27, 340, 30) withFont:[UIFont fontWithName:@"HelveticaNeue" size:18] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    NSString *end = @"Plus 20 other games and prizes!";
    [end drawInRect:CGRectMake(20, line_break += 38, 340, 30) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];

    UIImage *imageToPrint = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    if ([portName isEqualToString:@""] || portName != nil)
    {
        BOOL printSuccess = [MiniPrinterFunctions PrintBitmapWithPortName:portName portSettings:@"mini" imageSource:imageToPrint printerWidth:576];
        return printSuccess;
    }
    
    return NO;
} /* sendOptionsToPrint */


@end
