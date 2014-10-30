//
//  ViewController.m
//  Child
//
//  Created by Steven Shatz on 10/29/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //NSLog(@"In viewDidLoad:");
    
    _childUserIDTextField.delegate = self;
    
    // ***************************
    // * Set up Location Tracker *
    // ***************************
    
    self.myLocationTracker = [[LocationTracker alloc] init];
    
    self.myLocationTracker.vc = self;
    
    [self.myLocationTracker prepareLocationTrackerForUse];
    
    [self.myLocationTracker runLocationTracker];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
