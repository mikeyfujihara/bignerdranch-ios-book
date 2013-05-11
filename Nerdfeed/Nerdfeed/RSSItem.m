//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Mikey Fujihara on 5/10/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem
@synthesize title, link, parentParserDelegate;
@synthesize publicationDate;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    } else if ([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
    } else if ([elementName isEqualToString:@"pubDate"]) {
        currentString = [[NSMutableString alloc] init];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"pubDate"]) {
        static NSDateFormatter *dateFormatter = nil;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, dd MMM, yyyy HH:mm:ss z"];
        }
        [self setPublicationDate:[dateFormatter dateFromString:currentString]];
    }
    currentString = nil;
    
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setTitle:[[d objectForKey:@"title"] objectForKey:@"label"]];
    
    NSArray *links = [d objectForKey:@"link"];
    if ([links count] > 1) {
        NSDictionary *sampleDict = [[links objectAtIndex:1] objectForKey:@"attributes"];
        
        [self setLink:[sampleDict objectForKey:@"href"]];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:link forKey:@"link"];
    [aCoder encodeObject:publicationDate forKey:@"publicationDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setLink:[aDecoder decodeObjectForKey:@"link"]];
        [self setPublicationDate:[aDecoder decodeObjectForKey:@"publicationDate"]];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[RSSItem class]]) {
        return NO;
    }
    return [[self link] isEqual:[object link]];
}

@end
