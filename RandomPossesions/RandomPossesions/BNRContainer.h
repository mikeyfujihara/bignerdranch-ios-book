//
//  BNRContainer.h
//  RandomPossesions
//
//  Created by Mikey Fujihara on 5/8/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem

- (id)initWithItems:(NSArray *)items name:(NSString *)name serialNumber:(NSString *)sNumber;
@property (nonatomic, copy) NSArray *subItems;

@end
