//
//  BNRExecutor.h
//  Blocky
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRExecutor : NSObject
{
}

@property (nonatomic, copy) int (^equation)(int, int);
- (int)computeWithValue:(int)value1 andValue:(int)value2;

@end
