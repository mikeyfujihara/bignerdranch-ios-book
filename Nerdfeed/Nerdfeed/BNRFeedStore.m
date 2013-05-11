//
//  BNRFeedStore.m
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRFeedStore.h"
#import "RSSChannel.h"
#import "BNRConnection.h"

@implementation BNRFeedStore

+ (BNRFeedStore *)sharedStore
{
    static BNRFeedStore *feedStore = nil;
    if (!feedStore) {
        feedStore = [[BNRFeedStore alloc] init];
    }
    return feedStore;
}
- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *, NSError *))block
{
    NSURL *url = [NSURL URLWithString:@"http://forums.bignerdranch.com/" @"smartfeed.php?limit=1_DAY&sort_by=standard" @"&feed_type=RSS2.0&feed_style=COMPACT"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    RSSChannel *channel = [[RSSChannel alloc] init];
    
    BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachePath = [cachePath stringByAppendingString:@"nerd.archive"];
    
    RSSChannel *cachedChannel = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    
    if (!cachedChannel) {
        cachedChannel = [[RSSChannel alloc] init];
    }
    RSSChannel *channelCopy = [cachedChannel copy];
    
    [connection setCompletionBlock:^(RSSChannel *obj, NSError *err) {
        if (!err) {
            [channelCopy addItemsFromChannel:obj];
            [NSKeyedArchiver archiveRootObject:channelCopy toFile:cachePath];
        }
        block(channelCopy, err);
    }];
    
    [connection setXmlRootObject:channel];
    
    [connection start];
    return cachedChannel;
}

- (void)fetchTopSongs:(int)count withCompletion:(void (^)(RSSChannel *, NSError *))block
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    cachePath = [cachePath stringByAppendingPathComponent:@"apple.archive"];
    
    NSDate *tscDate = [self topSongsCacheDate];
    if (tscDate) {
        NSTimeInterval cacheAge = [tscDate timeIntervalSinceNow];
        
        if (cacheAge > -300.0) {
            NSLog(@"Reading cache!");
            RSSChannel *cachedChannel = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
            if (cachedChannel) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    block(cachedChannel, nil);
                }];
                
                return;
            }
        }
    }
    
    NSString *requestString = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/topsongs/limit=%d/json", count];
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    RSSChannel *channel = [[RSSChannel alloc] init];
    BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
    [connection setCompletionBlock:^(RSSChannel *obj, NSError *err){
        if (!err) {
            [self setTopSongsCacheDate:[NSDate date]];
            [NSKeyedArchiver archiveRootObject:obj toFile:cachePath];
        }
        block(obj, err);
    }];
    [connection setJsonRootObject:channel];
    
    [connection start];
}

- (void)setTopSongsCacheDate:(NSDate *)topSongsCacheDate
{
    [[NSUserDefaults standardUserDefaults] setObject:topSongsCacheDate forKey:@"topSongsCacheDate"];
}

- (NSDate *)topSongsCacheDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"topSongsCacheDate"];
}

@end
