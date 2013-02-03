//
//  AboutViewController.m
//  DocSets
//
//  Created by Ole Zorn on 11.03.12.
//  Copyright (c) 2012 omz:software. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize webView=_webView;

- (void)loadView
{
	[super loadView];
	self.title = NSLocalizedString(@"About Green Beans", nil);
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 14,
                                                               self.view.bounds.size.width, self.view.bounds.size.height - 130)];
	self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIView *windowFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImage *targetImage = [UIImage imageNamed:@"background-hatched-texture"];
    UIGraphicsBeginImageContextWithOptions(windowFrame.frame.size, NO, 0.f);
    [targetImage drawInRect:CGRectMake(0.f, 0.f, windowFrame.frame.size.width, windowFrame.frame.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.webView setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
    self.webView.delegate = self;
    
	self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
	[self.view addSubview:self.webView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSURL *aboutPageURL = [[NSBundle mainBundle] URLForResource:@"About" withExtension:@"html"];
	[self.webView loadRequest:[NSURLRequest requestWithURL:aboutPageURL]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:request.URL];
		return NO;
	}
	return YES;
}

- (BOOL)shouldAutorotate :(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		return YES;
	}
	return UIInterfaceOrientationIsLandscape(interfaceOrientation) || (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
	_webView.delegate = nil;
}

@end
