//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString * const BNRFeedStoreUpdateNotification;

@class RSSChannel;

@class RSSItem;

@interface BNRFeedStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic, strong) NSDate *topSongsCacheDate;

+ (BNRFeedStore *)sharedStore;

- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (void)fetchTopSongs:(int)count withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

- (void)markItemAsRead:(RSSItem *)item;
- (BOOL)hasItemBeenRead:(RSSItem *)item;

@end
