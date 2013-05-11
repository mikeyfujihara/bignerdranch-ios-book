//
//  RSSItem.h
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface RSSItem : NSObject <NSXMLParserDelegate, JSONSerializable, NSCoding>
{
    NSMutableString *currentString;
}
@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSDate *publicationDate;

@end
