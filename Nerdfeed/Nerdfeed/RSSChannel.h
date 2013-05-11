//
//  RSSChannel.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface RSSChannel : NSObject <NSXMLParserDelegate, JSONSerializable>
{
    NSMutableString *currentString;
}

@property (nonatomic, weak) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, readonly, strong) NSMutableArray *items;

- (void)trimItemTitles;

@end
