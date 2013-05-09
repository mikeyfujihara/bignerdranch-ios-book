//
//  BNRContainer.m
//  RandomPossesions
//
//  Created by Mikey Fujihara on 5/8/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

@synthesize subItems;

- (id)initWithItems:(NSArray *)items name:(NSString *)name serialNumber:(NSString *)sNumber
{
    int value = 0;
    for (BNRItem *item in items) {
        value += [item valueInDollars];
    }
    self = [super initWithItemName:name valueInDollars:value serialNumber:sNumber];
    if (self) {
        [self setSubItems:items];
    }
    return self;
}

-(id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    BNRItem *item = [[BNRItem alloc] initWithItemName:name valueInDollars:value serialNumber:sNumber];
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    self = [self initWithItems:array name:name serialNumber:sNumber];
    return self;
}
- (id)initWithSerialNumber:(NSString *)sNumber itemName:(NSString *)name
{
    BNRItem *item = [[BNRItem alloc] initWithItemName:name valueInDollars:0 serialNumber:sNumber];
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    self = [self initWithItems:array name:name serialNumber:sNumber];
    return self;
}

- (NSString *)description
{
    NSString *descriptionStr = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, record on %@ with the items %@",[self itemName],[self serialNumber],[self valueInDollars],[self dateCreated], [self subItems]];
    return descriptionStr;
}
@end
