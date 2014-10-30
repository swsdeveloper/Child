//
//  LocationTracker.h
//  Child
//
//  Created by Steven Shatz on 10/29/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@class ViewController;

@interface LocationTracker : NSObject <CLLocationManagerDelegate>

@property (retain, nonatomic) NSString *latitude;
@property (retain, nonatomic) NSString *longitude;

@property (retain, nonatomic) CLLocationManager *locationManager;

@property (retain, nonatomic) ViewController *vc;


-(void)prepareLocationTrackerForUse;

-(void)runLocationTracker;


-(NSString *)latitude;
-(void)setLatitude:(NSString *)newLatitude;

-(NSString *)longitude;
-(void)setLongitude:(NSString *)newLongitude;

-(CLLocationManager *)locationManager;
-(void)setLocationManager:(CLLocationManager *)newLocationManager;

-(ViewController *)vc;
-(void)setVc:(ViewController *)newVC;

@end


