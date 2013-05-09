//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Mikey Fujihara on 5/8/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    IBOutlet UISegmentedControl *control;
}

- (void)findLocation;

- (void)foundLocation:(CLLocation *)loc;

- (IBAction)didChangeSegmentControl:(UISegmentedControl *)control;

@end
