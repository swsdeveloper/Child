//
//  LocationTracker.m
//  Child
//
//  Created by Steven Shatz on 10/29/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import "LocationTracker.h"
#import "ViewController.h"


@implementation LocationTracker

@synthesize latitude;
@synthesize longitude;
@synthesize locationManager;
@synthesize vc;

NSString *workstr;


-(void)prepareLocationTrackerForUse {
    //NSLog(@"In prepareLocationTrackerForUse");
    
    self.locationManager = [[CLLocationManager alloc] init];     // create a Location Manager
    
    self.locationManager.delegate = self;                        // Designate this Location class as the Loc Mgr's Delegate
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Define Loc Mgr's accuracy:
    // --------------------------
    // kCLLocationAccuracyBestForNavigation: device must be plugged in at all times
    // kCLLocationAccuracyBest
    // kCLLocationAccuracyNearestTenMeters
    // kCLLocationAccuracyHundredMeters
    // kCLLocationAccuracyKilometer
    // kCLLocationAccuracyThreeKilometers
    
    self.locationManager.distanceFilter = 100;  // Device must move at least 100 meters horizontally before update event is generated
    
    workstr = [NSString stringWithFormat:@"About to call requestAlwaysAuthorization\n"];
    [self displayWorkstr:workstr];
    
    [self.locationManager requestAlwaysAuthorization];
    
    workstr = [NSString stringWithFormat:@"After requestAlwaysAuthorization\n"];
    [self displayWorkstr:workstr];
    
    // When current authorization status is kCLAuthorizationStatusNotDetermined, this method runs asynchronously and prompts the user to grant permission to the app to use location services. The user prompt contains the text from the NSLocationAlwaysUsageDescription key in your app’s Info.plist file, and the presence of that key is required when calling this method. After the status is determined, the location manager delivers the results to the delegate’s locationManager:didChangeAuthorizationStatus: method. If the current authorization status is anything other than kCLAuthorizationStatusNotDetermined, this method does nothing.
    
    
    //    workstr = [NSString stringWithFormat:@"About to call requestWhenInUseAuthorization\n"];
    //    [self displayWorkstr:workstr];
    //
    //    [self.locationManager requestWhenInUseAuthorization];
    //
    //    workstr = [NSString stringWithFormat:@"After requestWhenInUseAuthorization\n"];
    //    [self displayWorkstr:workstr];
    
    // Requires corresponding plist entry: NSLocationWhenInUseUsageDescription (and explanatory description)
    
    
    NSString *error = @"";
    if (![CLLocationManager locationServicesEnabled]) {
        error = @"Error: Location Services are NOT Enabled!";
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusRestricted) {    // This application is not authorized to use location services.
                                                         // Due to active restrictions on location services, the user cannot change this status, and may not have personally denied authorization
        error = @"Error: kCLAuthorizationStatusRestricted - Location Services are Restricted!";
    }
    
    
    if (status == kCLAuthorizationStatusDenied) {        //User has explicitly denied authorization for this application, or location services are disabled in Settings
        error = @"Error: kCLAuthorizationStatusDenied - Location Services have been Denied!";
    }
    
    if (status == kCLAuthorizationStatusNotDetermined) { // User has not yet made a choice with regards to this application
        error = @"Error: kCLAuthorizationStatusNotDetermined - User was never asked whether it is OK for this app to use Location Services!";
    }
    
    if ( [error isEqualToString:@""] == false ) {
        workstr = [NSString stringWithFormat:@"\n%@\n", error];
        [self displayWorkstr:workstr];
        
    } else {
        status = [CLLocationManager authorizationStatus];
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        
        workstr = [NSString stringWithFormat:@"Location Manager has been initialized without error!\n"];
        [self displayWorkstr:workstr];
    }
}

-(void)runLocationTracker {
    //NSLog(@"In runLocationTracker");
    
    [self.locationManager startUpdatingLocation];
    
    workstr = [NSString stringWithFormat:@"\nStarted Updating Locations\n"];
    [self displayWorkstr:workstr];
    
    workstr = [NSString stringWithFormat:@"Initial Location is %@\n", self.locationManager.location];
    [self displayWorkstr:workstr];
    
}


#pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSString *status$;
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:               // 0
            status$ = @"kCLAuthorizationStatusNotDetermined";
            break;
        case kCLAuthorizationStatusRestricted:                  // 1
            status$ = @"kCLAuthorizationStatusRestricted";
            break;
        case kCLAuthorizationStatusDenied:                      // 2
            status$ = @"kCLAuthorizationStatusDenied";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:            // 3
            status$ = @"kCLAuthorizationStatusAuthorizedAlways";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:         // 4
            status$ = @"kCLAuthorizationStatusAuthorizedWhenInUse";
            break;
        default:
            break;
    }
    workstr = [NSString stringWithFormat:@"\nChange in authorization status. New status is: %@\n\n", status$];
    [self displayWorkstr:workstr];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *cllocation = [locations lastObject];  // get most recent location from passed in locations array
    CLLocationCoordinate2D coordinate = [cllocation coordinate];    // extract coordinate from that location
    
    /* numberWithDouble: is an NSNumber class method that converts an int, float, long, etc. into a double.
     // The resulting double is an NSNumber object.
     // stringValue is an NSNumber instance method that converts an NSNumber object into its NSString equivalent
     // Thus, the combination of these 2 methods produce NSString printable versions of latititude and longitude.
     */
    
    self.latitude  = [[NSNumber numberWithDouble:coordinate.latitude]  stringValue];
    self.longitude = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
    
    workstr = [NSString stringWithFormat:@"latitude: %@,  longitude: %@\n", self.latitude, self.longitude];
    [self displayWorkstr:workstr];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    workstr = [NSString stringWithFormat:@"locationManager:didFailWithError: %@", [error localizedDescription]];
    [self displayWorkstr:workstr];
    
    /*
     Tells delegate that location manager was unable to retrieve a location value.
     If location service is unable to retrieve a location right away, it reports a kCLErrorLocationUnknown error and keeps trying. You can ignore this error and keep trying.
     If a heading could not be determined because of strong interference from nearby magnetic fields, this method returns kCLErrorHeadingFailure.
     If user denies your application’s use of the location service, this method reports a kCLErrorDenied error. Upon receiving such an error, you should stop the location service.
     */
}

-(void)displayWorkstr:(NSString *)str {
    NSLog(@"%@", str);
    vc.childLatitudeLabel.text = self.latitude;
    vc.childLongitudeLabel.text = self.longitude;
}

@end


