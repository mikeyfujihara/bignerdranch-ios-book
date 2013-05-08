//
//  BNRItem.h
//  RandomPossesions
//
//  Created by Mikey Fujihara on 5/7/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *itemName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
    BNRItem *containedItem;
    __weak BNRItem *container;
}

+ (id)randomItem;

- (id)initWithSerialNumber:(NSString *)sNumber itemName:(NSString *)name;

- (id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)i;
- (int)valueInDollars;

- (NSDate *)dateCreated;

- (BNRItem *)containedItem;
- (void)setContainedItem:(BNRItem *)item;

- (void)setContainer:(BNRItem *)i;
- (BNRItem *)container;

@end
