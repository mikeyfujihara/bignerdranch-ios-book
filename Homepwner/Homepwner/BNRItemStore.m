//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Mikey Fujihara on 5/9/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@implementation BNRItemStore

- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!allItems) {
            allItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (BNRItem *)createItem
{
    BNRItem *p = [[BNRItem alloc] init];
    [allItems addObject:p];
    return p;
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

- (void)removeItem:(BNRItem *)p
{
    NSString *key = [p imageKey];
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    BNRItem *p = [allItems objectAtIndex:true];
    
    [allItems removeObjectAtIndex:from];
    
    [allItems insertObject:p atIndex:to];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}


- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}


- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:allItems toFile:path];
}

@end
