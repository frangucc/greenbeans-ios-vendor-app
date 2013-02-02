//
//  QueueViewController.m
//  Part of the ASIHTTPRequest sample project - see http://allseeing-i.com/ASIHTTPRequest for details
//
//  Created by Ben Copsey on 07/11/2008.
//  Copyright 2008 All-Seeing Interactive. All rights reserved.
//

#import "QueueViewController.h"


#define TOKEN_URL @"http://greenbean.herokuapp.com/api/tokens.json"


@implementation QueueViewController
@synthesize cached = _cached;

- (IBAction) fetchThreeImages:(id)sender {
//    cache = [[CachedTokenSets alloc] init];
//
//    if (!networkQueue) {
//        networkQueue = [[ASINetworkQueue alloc] init];
//    }
//    failed = NO;
//    [networkQueue reset];
//    [networkQueue setRequestDidFinishSelector:@selector(fetchAuthTokenComplete:)];
//    [networkQueue setRequestDidFailSelector:@selector(fetchAuthTokenFailed:)];
//    [networkQueue setDelegate:self];
//
//    ASIHTTPRequest *request;
//    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://greenbean.herokuapp.com/api/sessions.json"]];
//    [request addRequestHeader:@"email" value:@"fran@greenbean.com"];
//    NSString *json = @"merchant[email]=fran@greenbean.com&merchant[password]=password";
//    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    [request setPostBody:(NSMutableData *)data];
//    [networkQueue addOperation:request];
//    [networkQueue go];
    
    self.cached = [[CachedTokenSets alloc] init];    
    NSLog(@"fetchThreeImages: %@", [self.cached getSet:1]);
    
} /* fetchThreeImages */


- (void) fetchAuthTokenComplete:(ASIHTTPRequest *)request {
    NSLog(@"Response %d\n\n", request.responseStatusCode);
    NSString *responseString = [request responseString];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];

    NSDictionary *merchant_body = [JSON valueForKey:@"merchant"];
    authenticationToken = [merchant_body valueForKey:@"authentication_token"];

    NSLog(@"authenticationToken: %@\n\n", authenticationToken);
//    [self fetchToken];
} /* fetchAuthTokenComplete */

- (void) fetchAuthTokenFailed:(ASIHTTPRequest *)request {
    NSLog(@"Response %d ==> %@", request.responseStatusCode, [request responseString]);
} /* fetchAuthTokenFailed */


- (void) dealloc {
    [networkQueue reset];
} /* dealloc */


/*
   Most of the code below here relates to the table view, and isn't that interesting
 */

- (void) viewDidLoad {
    [super viewDidLoad];
} /* viewDidLoad */


/*
   ViewWillAppear
   --------
   Purpose:        Delegate ~ Set/Hide Navigation Bar
   Parameters:     none
   Returns:        none
   Notes:          --
   Author:         Neil Burchfield
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
} /* viewWillAppear */


static NSString *intro = @"Demonstrates a fetching 3 items at once, using an ASINetworkQueue to track progress.\r\nEach request has its own downloadProgressDelegate, and the queue has an additional downloadProgressDelegate to track overall progress.";

- (UIView *) tableView:(UITableView *)theTableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        int tablePadding = 40;
        int tableWidth = [tableView frame].size.width;
        if (tableWidth > 480) {         // iPad
            tablePadding = 110;
        }

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableWidth - (tablePadding / 2), 30)];
        UIButton *goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [goButton setTitle:@"Go!" forState:UIControlStateNormal];
        [goButton sizeToFit];
        [goButton setFrame:CGRectMake([view frame].size.width - [goButton frame].size.width + 10, 7, [goButton frame].size.width, [goButton frame].size.height)];

        [goButton addTarget:self action:@selector(fetchThreeImages:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:goButton];

        if (!progressIndicator) {
            progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake((tablePadding / 2) - 10, 20, 200, 10)];
        } else {
            [progressIndicator setFrame:CGRectMake((tablePadding / 2) - 10, 20, 200, 10)];
        }
        [view addSubview:progressIndicator];

        return view;
    }
    return nil;
} /* tableView */


- (UITableViewCell *) tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int tablePadding = 40;
    int tableWidth = [tableView frame].size.width;
    if (tableWidth > 480) {     // iPad
        tablePadding = 110;
    }

    UITableViewCell *cell;
    if ([indexPath section] == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
        if (!cell) {
            cell = [InfoCell cell];
        }
        [[cell textLabel] setText:intro];
        [cell layoutSubviews];

    } else if ([indexPath section] == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ToggleCell"];
        if (!cell) {
            cell = [ToggleCell cell];
        }
        [[cell textLabel] setText:@"Show Accurate Progress"];
        accurateProgress = [(ToggleCell *)cell toggle];

    } else {

        cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesCell"];


        if (!cell) {

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImagesCell"];

            imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
            [imageView1 setBackgroundColor:[UIColor grayColor]];
            [cell addSubview:imageView1];

            imageProgressIndicator1 = [[UIProgressView alloc] initWithFrame:CGRectZero];
            [cell addSubview:imageProgressIndicator1];

            imageLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
            if (tableWidth > 480) {
                [imageLabel1 setText:@"This image is 15KB in size"];
            } else {
                [imageLabel1 setText:@"Img size: 15KB"];
            }
            [imageLabel1 setTextAlignment:NSTextAlignmentCenter];
            [imageLabel1 setFont:[UIFont systemFontOfSize:11]];
            [imageLabel1 setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:imageLabel1];

            imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
            [imageView2 setBackgroundColor:[UIColor grayColor]];
            [cell addSubview:imageView2];

            imageProgressIndicator2 = [[UIProgressView alloc] initWithFrame:CGRectZero];
            [cell addSubview:imageProgressIndicator2];

            imageLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
            if (tableWidth > 480) {
                [imageLabel2 setText:@"This image is 176KB in size"];
            } else {
                [imageLabel2 setText:@"Img size: 176KB"];
            }
            [imageLabel2 setTextAlignment:NSTextAlignmentCenter];
            [imageLabel2 setFont:[UIFont systemFontOfSize:11]];
            [imageLabel2 setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:imageLabel2];

            imageView3 = [[UIImageView alloc] initWithFrame:CGRectZero];
            [imageView3 setBackgroundColor:[UIColor grayColor]];
            [cell addSubview:imageView3];

            imageProgressIndicator3 = [[UIProgressView alloc] initWithFrame:CGRectZero];
            [cell addSubview:imageProgressIndicator3];

            imageLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
            if (tableWidth > 480) {
                [imageLabel3 setText:@"This image is 1.4MB in size"];
            } else {
                [imageLabel3 setText:@"Img size: 1.4MB"];
            }
            [imageLabel3 setTextAlignment:NSTextAlignmentCenter];
            [imageLabel3 setFont:[UIFont systemFontOfSize:11]];
            [imageLabel3 setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:imageLabel3];

        }
        NSUInteger imageWidth = (tableWidth - tablePadding - 20) / 3;
        NSUInteger imageHeight = imageWidth * 0.66f;


        [imageView1 setFrame:CGRectMake(tablePadding / 2, 10, imageWidth, imageHeight)];
        [imageProgressIndicator1 setFrame:CGRectMake(tablePadding / 2, 15 + imageHeight, imageWidth, 20)];
        [imageLabel1 setFrame:CGRectMake(tablePadding / 2, 25 + imageHeight, imageWidth, 20)];

        [imageView2 setFrame:CGRectMake((tablePadding / 2) + imageWidth + 10, 10, imageWidth, imageHeight)];
        [imageProgressIndicator2 setFrame:CGRectMake((tablePadding / 2) + imageWidth + 10, 15 + imageHeight, imageWidth, 20)];
        [imageLabel2 setFrame:CGRectMake(tablePadding / 2 + imageWidth + 10, 25 + imageHeight, imageWidth, 20)];

        [imageView3 setFrame:CGRectMake((tablePadding / 2) + (imageWidth * 2) + 20, 10, imageWidth, imageHeight)];
        [imageProgressIndicator3 setFrame:CGRectMake((tablePadding / 2) + (imageWidth * 2) + 20, 15 + imageHeight, imageWidth, 20)];
        [imageLabel3 setFrame:CGRectMake(tablePadding / 2 + (imageWidth * 2) + 20, 25 + imageHeight, imageWidth, 20)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
} /* tableView */


- (NSInteger) tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return 1;
} /* tableView */


- (CGFloat) tableView:(UITableView *)theTableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 34;
} /* tableView */


- (CGFloat) tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return [InfoCell neededHeightForDescription:intro withTableWidth:[tableView frame].size.width] + 20;
    } else if ([indexPath section] == 2) {
        int tablePadding = 40;
        int tableWidth = [tableView frame].size.width;
        if (tableWidth > 480) {         // iPad
            tablePadding = 110;
        }
        NSUInteger imageWidth = (tableWidth - tablePadding - 20) / 3;
        NSUInteger imageHeight = imageWidth * 0.66f;
        return imageHeight + 50;
    } else {
        return 42;
    }
} /* tableView */


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
} /* numberOfSectionsInTableView */


@end
