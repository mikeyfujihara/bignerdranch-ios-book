//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Mikey Fujihara on 5/8/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

@implementation WhereamiViewController

-(void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    BNRMapPoint *p = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    [worldView addAnnotation:p];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord,250, 250);
    [worldView setRegion:region];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDistanceFilter:50];
        
        [locationManager setDelegate:self];
        
        [control addTarget:self action:@selector(didChangeSegmentControl:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)didChangeSegmentControl:(UISegmentedControl *)c
{
    NSLog(@"Change selector");
    switch ([control selectedSegmentIndex]) {
        case 0:
            [worldView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [worldView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [worldView setMapType:MKMapTypeHybrid];
            break;
        default:
            break;
    }
}
         
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@",newLocation);
    
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    if (t < -180) {
        return;
    }
    [self foundLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Change heading to: %@",newHeading);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
}

- (void)dealloc
{
    [locationManager setDelegate:nil];
}
@end
