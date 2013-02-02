//
//  QueueViewController.h
//  Part of the ASIHTTPRequest sample project - see http://allseeing-i.com/ASIHTTPRequest for details
//
//  Created by Ben Copsey on 07/11/2008.
//  Copyright 2008 All-Seeing Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleViewController.h"
#import "CachedTokenSets.h"
#import "ConnectServer.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "InfoCell.h"
#import "ToggleCell.h"
#import "AppDelegate.h"
#import "CacheTokenObjects.h"

@class ASINetworkQueue;

@interface QueueViewController : SampleViewController {
	ASINetworkQueue *networkQueue;
    NSString *authenticationToken;

	UIImageView *imageView1;
	UIImageView *imageView2;
	UIImageView *imageView3;
	UIProgressView *progressIndicator;
	UISwitch *accurateProgress;
	UIProgressView *imageProgressIndicator1;
	UIProgressView *imageProgressIndicator2;
	UIProgressView *imageProgressIndicator3;
	UILabel *imageLabel1;
	UILabel *imageLabel2;
	UILabel *imageLabel3;
	BOOL failed;
    
    CachedTokenSets *cache;

}

@property (nonatomic, retain) CachedTokenSets *cached;


- (IBAction)fetchThreeImages:(id)sender;

@end
