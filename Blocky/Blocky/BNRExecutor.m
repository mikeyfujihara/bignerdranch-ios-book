//
//  BNRExecutor.m
//  Blocky
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRExecutor.h"

@implementation BNRExecutor
@synthesize equation;

-(int)computeWithValue:(int)value1 andValue:(int)value2
{
    if (!equation) {
        return 0;
    }
    
    return equation(value1, value2);
}

- (void)dealloc
{
    NSLog(@"Executor is being destroyed.");
}

@end
