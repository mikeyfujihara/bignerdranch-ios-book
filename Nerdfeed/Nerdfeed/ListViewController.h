//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

typedef enum {
    ListViewControllerRSSTypeBNR,
    ListViewControllerRSSTypeApple
} ListViewControllerRSSType;

@interface ListViewController : UITableViewController
{
    RSSChannel *channel;
    ListViewControllerRSSType rssType;
}
@property (nonatomic, strong) WebViewController *webViewController;
- (void)fetchEntries;

@end

@protocol ListViewControllerDelegate

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;

@end
