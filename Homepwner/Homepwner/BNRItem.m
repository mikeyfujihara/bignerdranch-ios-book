//
//  BNRItem.m
//  RandomPossesions
//
//  Created by Mikey Fujihara on 5/7/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem
@synthesize thumbnail, thumbnailData;
@synthesize imageKey;
@synthesize itemName;
@synthesize containedItem, container, serialNumber, valueInDollars, dateCreated;

- (id)init
{
    return [self initWithItemName:@"Item" valueInDollars:0 serialNumber:@""];
}

- (id)initWithSerialNumber:(NSString *)sNumber itemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}

- (id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    
    if (self){
        [self setItemName:name];
        [self setSerialNumber:sNumber];
        [self setValueInDollars:value];
        dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, record on %@", itemName, serialNumber, valueInDollars, dateCreated];
    return descriptionString;
}

+ (id)randomItem
{
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shiny", nil];
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear", @"Spork", @"Mac", nil];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0'+ rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
                                    
    return newItem;
}

- (void)setContainedItem:(BNRItem *)item
{
    containedItem = item;
    [item setContainer:self];
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setItemName:[aDecoder decodeObjectForKey:@"itemName"]];
        [self setSerialNumber:[aDecoder decodeObjectForKey:@"serialNumber"]];
        [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
        [self setValueInDollars:[aDecoder decodeIntForKey:@"valueInDollars"]];
        thumbnailData = [aDecoder decodeObjectForKey:@"thumbnailData"];
        
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:itemName forKey:@"itemName"];
    [aCoder encodeObject:serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    [aCoder encodeObject:thumbnailData forKey:@"thumbnailData"];
    
    [aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
}

- (UIImage *)thumbnail
{
    if (!thumbnailData) {
        return nil;
    }
    if (!thumbnail) {
        thumbnail = [UIImage imageWithData:thumbnailData];
    }
    return thumbnail;
}

- (void)setThumbnailDataFromImage:(UIImage *)image
{
    CGSize origImageSize = [image size];
    
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    float ratio = MAX(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:smallImage];
    
    NSData *data = UIImagePNGRepresentation(smallImage);
    [self setThumbnailData:data];
    
    UIGraphicsEndImageContext();
}

@end
