//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "WebViewController.h"
#import "RSSItem.h"

@implementation WebViewController

- (void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    [wv setScalesPageToFit:YES];
    
    [self setView:wv];
}

- (UIWebView *)webView
{
    return (UIWebView *)[self view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return io == UIInterfaceOrientationPortrait;
}

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object
{
    RSSItem *entry = object;
    
    if (![entry isKindOfClass:[RSSItem class]]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:[entry link]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[self webView] loadRequest:req];
    
    [[self navigationItem] setTitle:[entry title]];
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    [barButtonItem setTitle:@"List"];
    
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (barButtonItem == [[self navigationItem] leftBarButtonItem]) {
        [[self navigationItem] setLeftBarButtonItem:nil];
    }
}

@end
