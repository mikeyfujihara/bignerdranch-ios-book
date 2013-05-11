//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;

@interface BNRFeedStore : NSObject

@property (nonatomic, strong) NSDate *topSongsCacheDate;

+ (BNRFeedStore *)sharedStore;

- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (void)fetchTopSongs:(int)count withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

@end
