//
//  TimeViewController.h
//  HypnoTime
//
//  Created by Mikey Fujihara on 5/9/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController
{
    __weak IBOutlet UILabel *timeLabel;
}
- (void)spinTimeLabel;
- (void)bounceTimeLabel;
-(IBAction)showCurrentTime:(id)sender;

@end
