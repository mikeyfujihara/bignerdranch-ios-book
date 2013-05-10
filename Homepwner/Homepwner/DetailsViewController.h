//
//  DetailsViewController.h
//  Homepwner
//
//  Created by Mikey Fujihara on 5/9/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailsViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
{
    
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    
    UIPopoverController *imagePickerPopover;
}
@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

-(id)initForNewItem:(BOOL)isNew;
- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;

@end
