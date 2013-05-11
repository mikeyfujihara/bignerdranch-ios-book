//
//  JSONSerializable.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/11/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readFromJSONDictionary:(NSDictionary *)d;

@end
