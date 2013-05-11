//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel
@synthesize items, title, infoString, parentParserDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    } else if ([elementName isEqual:@"description"]) {
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    } else if ([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]) {
        RSSItem *entry = [[RSSItem alloc] init];
        [entry setParentParserDelegate:self];
        
        [parser setDelegate:entry];
        [items addObject:entry];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString = nil;
    if ([elementName isEqual:@"channel"] || [elementName isEqual:@"entry"]) {
        [parser setDelegate:parentParserDelegate];
        [self trimItemTitles];
    }
}

- (void)trimItemTitles
{
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@".* :: (.*) :: .*" options:0 error:nil];
    
    for (RSSItem *i in items) {
        NSString *itemTitle = [i title];
        
        NSArray *matches = [reg matchesInString:itemTitle options:0 range:NSMakeRange(0, [itemTitle length])];
        if ([matches count] > 0) {
            NSTextCheckingResult *result = [matches objectAtIndex:0];
            NSRange r = [result range];
            NSLog(@"Match at {%d, %d} for %@!", r.location, r.length, itemTitle);
            
            if ([result numberOfRanges] == 2) {
                NSRange r = [result rangeAtIndex:1];
                
                [i setTitle:[itemTitle substringWithRange:r]];
            }
        }
    }
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    NSDictionary *feed = [d objectForKey:@"feed"];
    
    [self setTitle:[[feed objectForKey:@"title"] objectForKey:@"label"]];
    
    NSArray *entries = [feed objectForKey:@"entry"];
    for (NSDictionary *entry in entries) {
        RSSItem *i = [[RSSItem alloc] init];
        [i readFromJSONDictionary:entry];
        
        [items addObject:i];
    }
}

@end
