//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Mikey Fujihara on 5/9/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title, date, formatter;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
        date = [[NSDate alloc] init];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setLocale:usLocale];
    }
    return self;
}

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}

- (NSString *)title
{
    NSString *str = [[NSString alloc]initWithFormat:@"%@, %@", title,[formatter stringFromDate:date]];
    return str;
}

@end
