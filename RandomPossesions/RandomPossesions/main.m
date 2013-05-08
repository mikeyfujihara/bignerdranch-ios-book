//
//  main.m
//  RandomPossesions
//
//  Created by Mikey Fujihara on 5/7/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
#import "BNRContainer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            BNRItem *p = [BNRItem randomItem];
            [items addObject:p];
        }
        BNRContainer *container = [[BNRContainer alloc] initWithItems:items name:@"Container" serialNumber:@"12345"];
        NSLog(@"%@",container);
        
        container = nil;
        items = nil;
        
    }
    return 0;
}