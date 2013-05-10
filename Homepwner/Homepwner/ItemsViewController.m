//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Mikey Fujihara on 5/9/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i = 0; i < 5; i++){
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[item description]];
    
    return cell;
}

@end
